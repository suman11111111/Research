import socket
import threading
import logging
import time
import json
import random

# Constants
SERVER_PORT = 8000
HEARTBEAT_INTERVAL = 0.1
ELECTION_TIMEOUT_MIN = 1.0
ELECTION_TIMEOUT_MAX = 2.0

# Helper functions
def current_time():
    return time.monotonic()

def random_timeout():
    return current_time() + random.uniform(ELECTION_TIMEOUT_MIN, ELECTION_TIMEOUT_MAX)

# Logger configuration
logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s', level=logging.INFO)

class Server:
    def __init__(self, id, peers):
        self.id = id
        self.peers = peers
        self.state = "follower"
        self.current_term = 0
        self.voted_for = None
        self.log = []

        # Volatile state
        self.commit_index = 0
        self.last_applied = 0

        # Leader state
        self.next_index = {peer: len(self.log) + 1 for peer in self.peers}
        self.match_index = {peer: 0 for peer in self.peers}

        # Election state
        self.election_timeout = random_timeout()
        self.votes_received = set()

        # Socket
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.bind(("localhost", SERVER_PORT))
        self.sock.listen(1)

        # Threading
        self.stop_event = threading.Event()
        self.thread = threading.Thread(target=self.run)
        self.thread.start()

    def stop(self):
        self.stop_event.set()
        self.sock.close()
        self.thread.join()

    def handle_message(self, conn, message):
        message = json.loads(message.decode())

        if message["type"] == "append_entries":
            self.handle_append_entries(conn, message)
        elif message["type"] == "append_entries_response":
            self.handle_append_entries_response(conn, message)
        elif message["type"] == "request_vote":
            self.handle_request_vote(conn, message)
        elif message["type"] == "request_vote_response":
            self.handle_request_vote_response(conn, message)
        elif message["type"] == "client_request":
            self.handle_client_request(conn, message)

    def send_message(self, conn, message):
        message = json.dumps(message).encode()
        conn.sendall(message)

    def run(self):
        while not self.stop_event.is_set():
            try:
                conn, addr = self.sock.accept()
                logging.info(f"Accepted connection from {addr}")
                data = conn.recv(1024)
                self.handle_message(conn, data)
                conn.close()
            except socket.timeout:
                pass

            if self.state == "follower":
                if current_time() >= self.election_timeout:
                    self.state = "candidate"
                    self.current_term += 1
                    self.voted_for = self.id
                    self.votes_received = set()
                    self.send_request_vote()
                    self.election_timeout = random_timeout()
            elif self.state == "candidate":
                if current_time() >= self.election_timeout:
                    self.election_timeout = random_timeout()
                    self.send_request_vote()
            elif self.state == "leader":










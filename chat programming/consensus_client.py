import socket
import json

# Constants
SERVER_PORT = 8000

# Helper functions
def send_request(server_id, message):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect(("localhost", SERVER_PORT))
    message = json.dumps(message).encode()
    sock.sendall(message)
    data = sock.recv(1024)
    sock.close()
    return json.loads(data.decode())

# Example usage
message = {"type": "client_request", "data": "Hello, world!"}
response = send_request(1, message)
print(response)



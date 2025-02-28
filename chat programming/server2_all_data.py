import select
import socket
import sys

server_socket= socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((socket.gethostname(),5289))

# Listen for incoming connections
server_socket.listen(2)

# List of sockets to monitor for input
inputs = [server_socket]

# Dictionary to keep track of connected clients and their sockets
clients = {}

while True:
    # Wait for at least one socket to become ready for processing
    read_sockets, _, _ = select.select(inputs, [], [])

    for sock in read_sockets:
        if sock == server_socket:
            # Handle new incoming connection
            print("waiting for connection....")
            client_socket, client_address = server_socket.accept()
            print(f"New connection from {client_address}")

            # Add new client socket to list of sockets to monitor for input
            inputs.append(client_socket)

            # Add new client to dictionary of clients
            clients[client_socket] = client_address
        else:
            # Handle incoming data from existing client
            data = sock.recv(1024)

            if data:
                # Send data to all other connected clients
                for client_socket in clients:
                    if client_socket != server_socket and client_socket != sock:
                        client_socket.send(data)
            else:
                # Handle disconnection of an existing client
                print(f"Disconnected from {clients[sock]}")
                inputs.remove(sock)
                del clients[sock]
                sock.close()
    
        







import socket
from threading import Thread

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((socket.gethostname(),5289))


s.listen()
all_client={}



def client_thread(client):
    while True:
        data=client.recv(1024)
        for c in all_client:
            c.send(data)
        



while True:
    print("waiting for connection....")
    client, addr=s.accept()
    print("connection established")
    name=client.recv(1024).decode()
    all_client[client]=name
    thread=Thread(target=(client_thread),args=(client,))
    
    thread.start()
    
        


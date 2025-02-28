import socket
from threading import Thread
# numpy as np
#import math as m


# print_lock=Thread.Lock()

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((socket.gethostname(),5289))


s.listen()



all_client={}



def client_thread(client):
        while True:
            try:
                data=client.recv(1024)
                for c in all_client:
                    if c != client:
                        c.send(data)
            except:
                del all_client[client]
                client.close()
                break
        



while True:
    print("waiting for connection....")
    client,addr=s.accept()
    print("connection established")
    name=client.recv(1024).decode()
    all_client[client]=name
    
    # for c in all_client:
    #     if c != client:
    #         c.send(bytes(name).encode(),'utf-8')
    
    thread=Thread(target=(client_thread),args=(client,))
    
    thread.start()
    
        




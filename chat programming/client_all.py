import socket
from threading import Thread

name=input("enter your name")

client=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((socket.gethostname(),5289))



client.send(name.encode())

def send(client):
    while True:
        data=f'{name}:{input("")}'
        client.send(data.encode())
   


def receive(client):
    while True:
        try:
            data=client.recv(1024).decode()
            print(data)
        except:
            client.close()
            break
        



thread1=Thread(target=send, args=(client,))
thread1.start()

thread2=Thread(target=receive, args=(client,))
thread2.start()

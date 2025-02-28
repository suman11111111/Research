import socket
from threading import Thread
import numpy as np
import math as m
import time


name=input("enter your name")

client=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((socket.gethostname(),5289))



client.send(name.encode())








def send_recv(client):
    x1=np.array([1])
    #x1=2
    x1_bytes=bytes(x1)
    client.sendall(x1_bytes)
    time.sleep(2)
    while True:
        data=client.recv(1024)
        buffer_size=len(data)
        print(buffer_size)
        # if buffer_size % 4!=0:
        #    raise ValueError("Buffer size must be a multiple of 4 (size of int32)")
        x2=np.frombuffer(data)
        print(x2)
        x1=x1+0.01*(x2-x1)
        arr_bytes=x1.tobytes()
        client.sendall(arr_bytes)
        time.sleep(2)
        print(x1)


thread2=Thread(target=send_recv, args=(client,))
thread2.start()

# thread2=Thread(target=receive, args=(client,))
# thread2.start()

import socket
from threading import Thread
#import numpy as np
#import math as m
#import time


name=input("enter your name")

client=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((socket.gethostname(),5289))



client.send(name.encode())








def send_recv(client):
    x1=1
    flag=1
    itr=0
    client.sendall(bytes(str(x1), 'utf-8'))
    # time.sleep(2)
    while flag==1:
        itr=itr+1
        data=client.recv(1024)
        data_str=str(data, 'utf-8')
        #buffer_size=len(data)
        #print(buffer_size)
        # if buffer_size % 4!=0:
        #    raise ValueError("Buffer size must be a multiple of 4 (size of int32)")
        # x2=np.frombuffer(data)
        # print(x2)
        x2=float(data_str)
        x1=x1+0.001*(x2-x1)
        if (abs(x1-x2)<0.001):
            flag=0
        #arr_bytes=x1.tobytes()
        client.sendall(bytes(str(x1), 'utf-8'))
        #time.sleep(0.05)
        print(x2)
        print(itr)


thread2=Thread(target=send_recv, args=(client,))
thread2.start()

# thread2=Thread(target=receive, args=(client,))
# thread2.start()


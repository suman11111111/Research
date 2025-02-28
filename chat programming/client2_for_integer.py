import socket
from threading import Thread
import numpy as np
import math as m
import time


name=input("enter your name")

global x2

client=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((socket.gethostname(),5289))



client.send(name.encode())




#def send_recv_int(client):
 #   x2=np.array([3,2])
  #  x2_bytes=x2.tobytes()
   # client.sendall(x2_bytes)


def send_recv(client):
    x2=5
    flag=1
    itr=0
    client.sendall(bytes(str(x2), 'utf-8'))
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
        x1=float(data_str)
        x2=x2+0.001*(x1-x2)
        if abs(x1-x2)<0.001:
            flag=0
       # arr_bytes=x1.tobytes()
        client.sendall(bytes(str(x2), 'utf-8'))
        #time.sleep(0.05)
        print(x1)
        print(itr)
        
    
        
        

# thread1=Thread(target=send_recv_int, args=(client,))
# thread1.start()
# time.sleep(10)

thread2=Thread(target=send_recv, args=(client,))
thread2.start()

# thread2=Thread(target=receive, args=(client,))
# thread2.start()






clc,clear all;close all;

N=8000; %Total number of Iterations
dt=0.001;%Step Length

a=10;  %Amplitude of attack signal
k=270;

x1(1)=1;
x2(1)=2;
x3(1)=3;

w1(1)=1;
w2(1)=2;
w3(1)=3;

for i=1:N
    
%     if i>=3000 & i<5000
%         x3(i)=x3(i)+a*sin(i);
%     end

    if i>=6000 
        x3(i)=x3(i)+a;
    end
    
%     if i==3143
%         x3(i)=x3(i)+a*tan(i);
%     end

    x1(i+1)=x1(i)+dt*((-1)*(x1(i)-x2(i))-k*(x1(i)-w1(i)));
    x2(i+1)=x2(i)+dt*((-1)*(2*x2(i)-x1(i)-x2(i))-k*(x2(i)-w2(i)));
    x3(i+1)=x3(i)+dt*((-1)*(x3(i)-x2(i))-k*(x3(i)-w3(i)));
    
    
    w1(i+1)=w1(i)+dt*((-1)*(w1(i)-w2(i)));
    w2(i+1)=w2(i)+dt*((-1)*(2*w2(i)-w1(i)-w2(i)));
    w3(i+1)=w3(i)+dt*((-1)*(w3(i)-w2(i)));
  
end

plot(x1);hold on;plot(x2);plot(x3)
legend('Node 1','Node 2','Node 3')


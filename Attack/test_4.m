clc,clear all;close all;

N=8000; %Total number of Iterations
dt=0.001;%Step Length

a=10;  %Amplitude of attack signal
b=5;


x1(1)=1;
x2(1)=2;
x3(1)=3;

x_act=0;


for i=1:N
    
%     if i==2000 
%         x_act=a*exp(i*dt);
%     else
%         x_act=0;
%     end

%     if i>=2000 
%         x_act=b+a*sin(5*i*dt);
%     else 
%         x_act=0;
%     end

%     if i>=2000
%         x1(i)=x1(i)+b+a*exp(i*dt);
%     end

%     if i==500 
%         x1(i)=x1(i)+b+a*exp(i*dt);
%     end
    
    x1(i+1)=x1(i)+dt*((-1)*(x1(i)-x2(i))+x_act);
    x2(i+1)=x2(i)+dt*((-1)*(2*x2(i)-x1(i)-x3(i)));
    x3(i+1)=x3(i)+dt*((-1)*(x3(i)-x2(i)));
    
end

plot(x1);hold on;plot(x2);plot(x3)
legend('Node 1','Node 2','Node 3')


clc,clear all;close all;

N=30000; %Total number of Iterations
dt=0.001;%Step Length

a=100;  %Amplitude of attack signal
b=500;
s=1;
k=800;

x1(1)=1;
x2(1)=2;
x3(1)=3;

x_act=0;

w1(1)=1;
w2(1)=2;
w3(1)=3;

for i=1:N
    
    if i>=2000 && i<7000
        x_act=a*cos(i*dt);
    else
        x_act=0;
    end

%     if i>=1000 
%         x_act=b-a*sin(5*i*dt);
%     else
%         x_act=0;
%     end

%     if i==3000 
%         x_act=a;
%     else
%         x_act=0;
%     end

%     if i>=3000 
%         x_act=a;
%     else
%         x_act=0;
%     end
%     if i>=3000 
%         x1(i)=x1(i)+a*sin(i*dt);
%     end

%     if i==2000 
%         x2(i)=x2(i)+(i*dt);
%     end

    e1(i)=x1(i)-w1(i);
    e2(i)=x2(i)-w2(i);
    e3(i)=x3(i)-w3(i);

    x1(i+1)=x1(i)+dt*((-1)*(x1(i)-x2(i))+x_act);
    x2(i+1)=x2(i)+dt*((-1)*(2*x2(i)-x1(i)-x3(i)));
    x3(i+1)=x3(i)+dt*((-1)*(x3(i)-x2(i)));
    
    
    w1(i+1)=w1(i)+dt*((-1)*(w1(i)-w2(i)));
    w2(i+1)=w2(i)+dt*((-1)*(2*w2(i)-w1(i)-w3(i)));
    w3(i+1)=w3(i)+dt*((-1)*(w3(i)-w2(i)));  
    
    e1(i+1)=e1(i)+dt*(-e1(i));
    e2(i+1)=e2(i)+dt*(-e2(i));
    e3(i+1)=e3(i)+dt*(-e3(i));
end

figure()
plot(x1);hold on;plot(x2);plot(x3)
legend('Node 1','Node 2','Node 3')
title('States')

figure()
plot(e1);hold on;plot(e2);plot(e3)
legend('Node 1','Node 2','Node 3')
title('Errors')

fprintf("x1=%d,x2=%d,x3=%d\n",x1(end),x2(end),x3(end))
fprintf("e1=%d,e2=%d,e3=%d",e1(end),e2(end),e3(end))


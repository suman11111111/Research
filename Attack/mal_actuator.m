clc,clear all;close all;

N=10000; %Total number of Iterations
dt=0.001;%Step Length

a=100;  %Amplitude of attack signal
x3_act=0;

x1(1)=0;
x2(1)=6;
x3(1)=-2;
x4(1)=4;

a12=1;
a14=1;
a23=1;
a24=1;
a31=1;
a34=1;
a41=1;
a42=1;
a43=1;

for i=1:N

    if i>=300 & i<4000
        x3_act=a*tan(i);
    else
        x3_act=0;
    end
    
%     if i==3000
%         x3_act=a*tan(pi/2);
%     else
%         x3_act=0;
%     end

%     if i==3000
%         x3_act=a*tan(i);
%     else
%         x3_act=0;
%     end

    x1(i+1)=x1(i)+dt*((-1)*((a12+a14)*x1(i)-a12*x2(i)-a14*x4(i)));
    x2(i+1)=x2(i)+dt*((-1)*((a23+a24)*x2(i)-a23*x3(i)-a24*x4(i)));
    x3(i+1)=x3(i)+dt*((-1)*((a31+a34)*x3(i)-a31*x1(i)-a34*x4(i))+x3_act);
    x4(i+1)=x4(i)+dt*((-1)*((a41+a42+a43)*x4(i)-a41*x1(i)-a42*x2(i)-a43*x3(i)));
end

t=(1:N+1)*dt;
plot(t,x1);hold on;plot(t,x2);plot(t,x3);plot(t,x4)
legend('Node 1','Node 2','Node 3','Node 4')
title('')
xlabel({'t','(in seconds)'})
ylabel('x')

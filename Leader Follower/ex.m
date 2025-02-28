clc,clear all;close all;

N=15000;
dt=0.001;

alpha1=1;
alpha2=0;
alpha3=1;

w0=4;
w1(1)=1;
w2(1)=2;
w3(1)=3;

for i=1:N
    w1(i+1)=w1(i)+dt*((-1)*(2*w1(i)-w2(i)-w3(i))+alpha1*(w0-w1(i)));
    w2(i+1)=w2(i)+dt*((-1)*(2*w2(i)-w1(i)-w3(i)));
    w3(i+1)=w3(i)+dt*((-1)*(2*w3(i)-w1(i)-w2(i))+alpha3*(w0-w3(i)));
end

plot(w1);hold on;plot(w2);plot(w3);
ylim([0 5])
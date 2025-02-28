clc,clear all;close all;

N=15000; %Total number of Iterations
dt=0.001;%Step Length

alpha1=1;%Leader to Node 1 edge weight
alpha2=0;%Leader to Node 2 edge weight
alpha3=1;%Leader to Node 3 edge weight

sigma1=-1;%Gauge Transformation for Node 1
sigma2=-1;%Gauge Transformation for Node 2
sigma3=1;%Gauge Transformation for Node 3

w0=4;%Leader State
w1(1)=sigma1*1;%Node Initialisation
w2(1)=sigma2*2;%Node Initialisation
w3(1)=sigma3*3;%Node Initialisation

for i=1:N
    w1(i+1)=w1(i)+dt*((-1)*(3*w1(i)-w2(i)+2*w3(i))+alpha1*(sigma1*w0-w1(i)));
    w2(i+1)=w2(i)+dt*((-1)*(5*w2(i)-w1(i)+4*w3(i)));
    w3(i+1)=w3(i)+dt*((-1)*(6*w3(i)+2*w1(i)+4*w2(i))+alpha3*(sigma3*w0-w3(i)));
end

plot(w1);hold on;plot(w2);plot(w3);
ylim([-5 5])

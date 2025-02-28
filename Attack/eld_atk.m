clc,clear all;close all;

theta=0.005;

N=500000;
dt=0.001;
k=0.089;


alpha1(1)=0;
alpha2(1)=0;
alpha3(1)=0;
alpha4(1)=0;
alpha5(1)=0;
alpha6(1)=0;

beta1(1)=0;
beta2(1)=0;
beta3(1)=0;
beta4(1)=0;
beta5(1)=0;
beta6(1)=0;

b1=2;
b2=1.75;
b3=1;
b4=3.25;
b5=3;
b6=3;

c1=0.00375;
c2=0.00175;
c3=0.0625;
c4=0.008324;
c5=0.025;
c6=0.025;

Pmin1=50;
Pmin2=100;
Pmin3=15;
Pmin4=10;
Pmin5=10;
Pmin6=12;

Pmax1=200;
Pmax2=400;
Pmax3=50;
Pmax4=35;
Pmax5=30;
Pmax6=40;

P1(1)=133.36;
P2(1)=287.98;
P3(1)=40;
P4(1)=20;
P5(1)=15;
P6(1)=17;

P1_0=125.5232;
P2_0=340.1967;
P3_0=15.5931;
P4_0=10.0105;
P5_0=10.0089;
P6_0=12.0076;

for i=1:N
    
    if i>10000 && i<30000
        act=100*sin(i*dt);
    else
        act=0;
    end

    w1(i)=b1+2*c1*P1(i)-theta*(1/(P1(i)-Pmin1)-1/(Pmax1-P1(i)));
    w2(i)=b2+2*c2*P2(i)-theta*(1/(P2(i)-Pmin2)-1/(Pmax2-P2(i)));
    w3(i)=b3+2*c3*P3(i)-theta*(1/(P3(i)-Pmin3)-1/(Pmax3-P3(i)));
    w4(i)=b4+2*c4*P4(i)-theta*(1/(P4(i)-Pmin4)-1/(Pmax4-P4(i)));
    w5(i)=b5+2*c5*P5(i)-theta*(1/(P5(i)-Pmin5)-1/(Pmax5-P5(i)));
    w6(i)=b6+2*c6*P6(i)-theta*(1/(P6(i)-Pmin6)-1/(Pmax6-P6(i)));
    
    P1(i+1)=P1(i)+dt*((-1)*(2*w1(i)-w2(i)-w6(i)-k*(w1(i)-2.94)));
    P2(i+1)=P2(i)+dt*((-1)*(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i))+act-k*(w2(i)-2.94));
    P3(i+1)=P3(i)+dt*((-1)*(3*w3(i)-w2(i)-w4(i)-w6(i)-k*(w3(i)-2.94)));
    P4(i+1)=P4(i)+dt*((-1)*(2*w4(i)-w3(i)-w5(i)-k*(w4(i)-2.94)));
    P5(i+1)=P5(i)+dt*((-1)*(3*w5(i)-w4(i)-w6(i)-w2(i)-k*(w5(i)-2.94)));
    P6(i+1)=P6(i)+dt*((-1)*(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-k*(w6(i)-2.94)));
end

figure();
plot(P1);hold on;plot(P2);hold on;plot(P3);hold on;plot(P4);hold on;plot(P5);hold on;plot(P6);
xlim([0 N])
xlabel('Number of Iterations')
ylabel('Active Power Output')

figure();
plot(w1);hold on;plot(w2);hold on;plot(w3);hold on;plot(w4);hold on;plot(w5);hold on;plot(w6);
xlim([0 N])
xlabel('Number of Iterations')
ylabel('Incremental Cost(I.C.)')

OptP=[P1(end),P2(end),P3(end),P4(end),P5(end),P6(end)]
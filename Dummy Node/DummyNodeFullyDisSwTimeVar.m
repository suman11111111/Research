clc,clear all;close all;

theta=0.005;

N=120000;
dt=0.001;

alpha1(1)=0;
alpha2(1)=0;
alpha3(1)=0;
alpha4(1)=0;
alpha5(1)=0;
alpha6(1)=0;
alpha1d(1)=0;
alpha2d(1)=0;
alpha3d(1)=0;
alpha4d(1)=0;
alpha5d(1)=0;
alpha6d(1)=0;

beta1(1)=0;
beta2(1)=0;
beta3(1)=0;
beta4(1)=0;
beta5(1)=0;
beta6(1)=0;
beta1d(1)=0;
beta2d(1)=0;
beta3d(1)=0;
beta4d(1)=0;
beta5d(1)=0;
beta6d(1)=0;

b1=2;
b2=1.75;
b3=1;
b4=3.25;
b5=3;
b6=3;
b1d=0;
b2d=0;
b3d=0;
b4d=0;
b5d=0;
b6d=0;

c1=0.00375;
c2=0.00175;
c3=0.0625;
c4=0.008324;
c5=0.025;
c6=0.025;
c1d=1;
c2d=1;
c3d=1;
c4d=1;
c5d=1;
c6d=1;

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
P1d(1)=0;
P2d(1)=0;
P3d(1)=0;
P4d(1)=0;
P5d(1)=0;
P6d(1)=0;

D=50;
M=6;
n=rand(1,M);
TOT=sum(n);
D1=(n/TOT)*D;

for i=1:N
%     if i==N/2
%       P1d(i)=D1(1);
%       P2d(i)=D1(2);
%       P3d(i)=D1(3);
%       P4d(i)=D1(4);
%       P5d(i)=D1(5);
%       P6d(i)=D1(6);
%     end
    if mod(i,30)<10 && mod(i,30)>=0
    w1(i)=b1+2*c1*P1(i)-theta*(1/(P1(i)-Pmin1)-1/(Pmax1-P1(i)));
    w2(i)=b2+2*c2*P2(i)-theta*(1/(P2(i)-Pmin2)-1/(Pmax2-P2(i)));
    w3(i)=b3+2*c3*P3(i)-theta*(1/(P3(i)-Pmin3)-1/(Pmax3-P3(i)));
    w4(i)=b4+2*c4*P4(i)-theta*(1/(P4(i)-Pmin4)-1/(Pmax4-P4(i)));
    w5(i)=b5+2*c5*P5(i)-theta*(1/(P5(i)-Pmin5)-1/(Pmax5-P5(i)));
    w6(i)=b6+2*c6*P6(i)-theta*(1/(P6(i)-Pmin6)-1/(Pmax6-P6(i)));
    w1d(i)=b1d+2*c1d*P1d(i);
    w2d(i)=b2d+2*c2d*P2d(i);
    w3d(i)=b3d+2*c3d*P3d(i);
    w4d(i)=b4d+2*c4d*P4d(i);
    w5d(i)=b5d+2*c5d*P5d(i);
    w6d(i)=b6d+2*c6d*P6d(i);
    
    alpha1(i+1)=alpha1(i)+dt*(3*w1(i)-w1d(i)-w2(i)-w6(i))'*(3*w1(i)-w1d(i)-w2(i)-w6(i));
    alpha2(i+1)=alpha2(i)+dt*(5*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)-w2d(i))'*(5*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)-w2d(i));
    alpha3(i+1)=alpha3(i)+dt*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i))'*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i));
    alpha4(i+1)=alpha4(i)+dt*(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    alpha5(i+1)=alpha5(i)+dt*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i))'*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i));
    alpha6(i+1)=alpha6(i)+dt*(5*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-w6d(i))'*(5*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-w6d(i));
    alpha1d(i+1)=alpha1d(i)+dt*(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    alpha2d(i+1)=alpha2d(i)+dt*(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    alpha3d(i+1)=alpha3d(i)+dt*(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    alpha4d(i+1)=alpha4d(i)+dt*(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    alpha5d(i+1)=alpha5d(i)+dt*(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    alpha6d(i+1)=alpha6d(i)+dt*(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    beta1(i+1)=(3*w1(i)-w1d(i)-w2(i)-w6(i))'*(3*w1(i)-w1d(i)-w2(i)-w6(i));
    beta2(i+1)=(5*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)-w2d(i))'*(5*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)-w2d(i));
    beta3(i+1)=(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i))'*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i));
    beta4(i+1)=(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    beta5(i+1)=(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i))'*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i));
    beta6(i+1)=(5*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-w6d(i))'*(5*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-w6d(i));
    beta1d(i+1)=(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    beta2d(i+1)=(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    beta3d(i+1)=(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    beta4d(i+1)=(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    beta5d(i+1)=(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    beta6d(i+1)=(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    P1(i+1)=P1(i)+dt*((alpha1(i)+beta1(i))*(-1)*(3*w1(i)-w1d(i)-w2(i)-w6(i)));
    P2(i+1)=P2(i)+dt*((alpha2(i)+beta2(i))*(-1)*(5*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)-w2d(i)));
    P3(i+1)=P3(i)+dt*((alpha3(i)+beta3(i))*(-1)*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i)));
    P4(i+1)=P4(i)+dt*((alpha4(i)+beta4(i))*(-1)*(3*w4(i)-w3(i)-w5(i)-w4d(i)));
    P5(i+1)=P5(i)+dt*((alpha5(i)+beta5(i))*(-1)*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i)));
    P6(i+1)=P6(i)+dt*((alpha6(i)+beta6(i))*(-1)*(5*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)-w6d(i)));
    P1d(i+1)=P1d(i)+dt*((alpha1d(i)+beta1d(i))*(-1)*(w1d(i)-w1(i)));
    P2d(i+1)=P2d(i)+dt*((alpha2d(i)+beta2d(i))*(-1)*(w2d(i)-w2(i)));
    P3d(i+1)=P3d(i)+dt*((alpha3d(i)+beta3d(i))*(-1)*(w3d(i)-w3(i)));
    P4d(i+1)=P4d(i)+dt*((alpha4d(i)+beta4d(i))*(-1)*(w4d(i)-w4(i)));
    P5d(i+1)=P5d(i)+dt*((alpha5d(i)+beta5d(i))*(-1)*(w5d(i)-w5(i)));
    P6d(i+1)=P6d(i)+dt*((alpha6d(i)+beta6d(i))*(-1)*(w6d(i)-w6(i)));
    
    elseif mod(i,30)<20 && mod(i,30)>=10
    w1(i)=b1+2*c1*P1(i)-theta*(1/(P1(i)-Pmin1)-1/(Pmax1-P1(i)));
    w2(i)=b2+2*c2*P2(i)-theta*(1/(P2(i)-Pmin2)-1/(Pmax2-P2(i)));
    w3(i)=b3+2*c3*P3(i)-theta*(1/(P3(i)-Pmin3)-1/(Pmax3-P3(i)));
    w4(i)=b4+2*c4*P4(i)-theta*(1/(P4(i)-Pmin4)-1/(Pmax4-P4(i)));
    w5(i)=b5+2*c5*P5(i)-theta*(1/(P5(i)-Pmin5)-1/(Pmax5-P5(i)));
    w6(i)=b6+2*c6*P6(i)-theta*(1/(P6(i)-Pmin6)-1/(Pmax6-P6(i)));
    w1d(i)=b1d+2*c1d*P1d(i);
    w2d(i)=b2d+2*c2d*P2d(i);
    w3d(i)=b3d+2*c3d*P3d(i);
    w4d(i)=b4d+2*c4d*P4d(i);
    w5d(i)=b5d+2*c5d*P5d(i);
    w6d(i)=b6d+2*c6d*P6d(i);
    
    alpha1(i+1)=alpha1(i)+dt*(2*w1(i)-w1d(i)-w6(i))'*(2*w1(i)-w1d(i)-w6(i));
    alpha2(i+1)=alpha2(i);
    alpha3(i+1)=alpha3(i)+dt*(3*w3(i)-w4(i)-w6(i)-w3d(i))'*(3*w3(i)-w4(i)-w6(i)-w3d(i));
    alpha4(i+1)=alpha4(i)+dt*(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    alpha5(i+1)=alpha5(i)+dt*(3*w5(i)-w4(i)-w6(i)-w5d(i))'*(3*w5(i)-w4(i)-w6(i)-w5d(i));
    alpha6(i+1)=alpha6(i)+dt*(4*w6(i)-w1(i)-w3(i)-w5(i)-w6d(i))'*(4*w6(i)-w1(i)-w3(i)-w5(i)-w6d(i));
    alpha1d(i+1)=alpha1d(i)+dt*(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    alpha2d(i+1)=alpha2d(i)+dt*(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    alpha3d(i+1)=alpha3d(i)+dt*(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    alpha4d(i+1)=alpha4d(i)+dt*(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    alpha5d(i+1)=alpha5d(i)+dt*(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    alpha6d(i+1)=alpha6d(i)+dt*(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    beta1(i+1)=(2*w1(i)-w1d(i)-w6(i))'*(2*w1(i)-w1d(i)-w6(i));
    beta2(i+1)=0;
    beta3(i+1)=(3*w3(i)-w3(i)-w6(i)-w3d(i))'*(3*w3(i)-w3(i)-w6(i)-w3d(i));
    beta4(i+1)=(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    beta5(i+1)=(3*w5(i)-w4(i)-w6(i)-w5d(i))'*(3*w5(i)-w4(i)-w6(i)-w5d(i));
    beta6(i+1)=(4*w6(i)-w1(i)-w3(i)-w5(i)-w6d(i))'*(4*w6(i)-w1(i)-w3(i)-w5(i)-w6d(i));
    beta1d(i+1)=(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    beta2d(i+1)=(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    beta3d(i+1)=(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    beta4d(i+1)=(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    beta5d(i+1)=(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    beta6d(i+1)=(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    P1(i+1)=P1(i)+dt*((alpha1(i)+beta1(i))*(-1)*(2*w1(i)-w1d(i)-w6(i)));
    P2(i+1)=P2(i);
    P3(i+1)=P3(i)+dt*((alpha3(i)+beta3(i))*(-1)*(3*w3(i)-w3(i)-w6(i)-w3d(i)));
    P4(i+1)=P4(i)+dt*((alpha4(i)+beta4(i))*(-1)*(3*w4(i)-w3(i)-w5(i)-w4d(i)));
    P5(i+1)=P5(i)+dt*((alpha5(i)+beta5(i))*(-1)*(3*w5(i)-w4(i)-w6(i)-w5d(i)));
    P6(i+1)=P6(i)+dt*((alpha6(i)+beta6(i))*(-1)*(4*w6(i)-w1(i)-w3(i)-w5(i)-w6d(i)));
    P1d(i+1)=P1d(i)+dt*((alpha1d(i)+beta1d(i))*(-1)*(w1d(i)-w1(i)));
    P2d(i+1)=P2d(i)+dt*((alpha2d(i)+beta2d(i))*(-1)*(w2d(i)-w2(i)));
    P3d(i+1)=P3d(i)+dt*((alpha3d(i)+beta3d(i))*(-1)*(w3d(i)-w3(i)));
    P4d(i+1)=P4d(i)+dt*((alpha4d(i)+beta4d(i))*(-1)*(w4d(i)-w4(i)));
    P5d(i+1)=P5d(i)+dt*((alpha5d(i)+beta5d(i))*(-1)*(w5d(i)-w5(i)));
    P6d(i+1)=P6d(i)+dt*((alpha6d(i)+beta6d(i))*(-1)*(w6d(i)-w6(i)));
    
    elseif mod(i,30)<30 && mod(i,30)>=20
    w1(i)=b1+2*c1*P1(i)-theta*(1/(P1(i)-Pmin1)-1/(Pmax1-P1(i)));
    w2(i)=b2+2*c2*P2(i)-theta*(1/(P2(i)-Pmin2)-1/(Pmax2-P2(i)));
    w3(i)=b3+2*c3*P3(i)-theta*(1/(P3(i)-Pmin3)-1/(Pmax3-P3(i)));
    w4(i)=b4+2*c4*P4(i)-theta*(1/(P4(i)-Pmin4)-1/(Pmax4-P4(i)));
    w5(i)=b5+2*c5*P5(i)-theta*(1/(P5(i)-Pmin5)-1/(Pmax5-P5(i)));
    w6(i)=b6+2*c6*P6(i)-theta*(1/(P6(i)-Pmin6)-1/(Pmax6-P6(i)));
    w1d(i)=b1d+2*c1d*P1d(i);
    w2d(i)=b2d+2*c2d*P2d(i);
    w3d(i)=b3d+2*c3d*P3d(i);
    w4d(i)=b4d+2*c4d*P4d(i);
    w5d(i)=b5d+2*c5d*P5d(i);
    w6d(i)=b6d+2*c6d*P6d(i);
    
    alpha1(i+1)=alpha1(i);
    alpha2(i+1)=alpha2(i)+dt*(4*w2(i)-w3(i)-w5(i)-w6(i)-w2d(i))'*(4*w2(i)-w3(i)-w5(i)-w6(i)-w2d(i));
    alpha3(i+1)=alpha3(i)+dt*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i))'*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i));
    alpha4(i+1)=alpha4(i)+dt*(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    alpha5(i+1)=alpha5(i)+dt*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i))'*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i));
    alpha6(i+1)=alpha6(i)+dt*(4*w6(i)-w2(i)-w3(i)-w5(i)-w6d(i))'*(4*w6(i)-w2(i)-w3(i)-w5(i)-w6d(i));
    alpha1d(i+1)=alpha1d(i)+dt*(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    alpha2d(i+1)=alpha2d(i)+dt*(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    alpha3d(i+1)=alpha3d(i)+dt*(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    alpha4d(i+1)=alpha4d(i)+dt*(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    alpha5d(i+1)=alpha5d(i)+dt*(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    alpha6d(i+1)=alpha6d(i)+dt*(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    beta1(i+1)=0;
    beta2(i+1)=(4*w2(i)-w3(i)-w5(i)-w6(i)-w2d(i))'*(4*w2(i)-w3(i)-w5(i)-w6(i)-w2d(i));
    beta3(i+1)=(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i))'*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i));
    beta4(i+1)=(3*w4(i)-w3(i)-w5(i)-w4d(i))'*(3*w4(i)-w3(i)-w5(i)-w4d(i));
    beta5(i+1)=(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i))'*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i));
    beta6(i+1)=(4*w6(i)-w2(i)-w3(i)-w5(i)-w6d(i))'*(4*w6(i)-w2(i)-w3(i)-w5(i)-w6d(i));
    beta1d(i+1)=(w1d(i)-w1(i))'*(w1d(i)-w1(i));
    beta2d(i+1)=(w2d(i)-w2(i))'*(w2d(i)-w2(i));
    beta3d(i+1)=(w3d(i)-w3(i))'*(w3d(i)-w3(i));
    beta4d(i+1)=(w4d(i)-w4(i))'*(w4d(i)-w4(i));
    beta5d(i+1)=(w5d(i)-w5(i))'*(w5d(i)-w5(i));
    beta6d(i+1)=(w6d(i)-w6(i))'*(w6d(i)-w6(i));
    
    P1(i+1)=P1(i);
    P2(i+1)=P2(i)+dt*((alpha2(i)+beta2(i))*(-1)*(4*w2(i)-w3(i)-w5(i)-w6(i)-w2d(i)));
    P3(i+1)=P3(i)+dt*((alpha3(i)+beta3(i))*(-1)*(4*w3(i)-w2(i)-w4(i)-w6(i)-w3d(i)));
    P4(i+1)=P4(i)+dt*((alpha4(i)+beta4(i))*(-1)*(3*w4(i)-w3(i)-w5(i)-w4d(i)));
    P5(i+1)=P5(i)+dt*((alpha5(i)+beta5(i))*(-1)*(4*w5(i)-w4(i)-w6(i)-w2(i)-w5d(i)));
    P6(i+1)=P6(i)+dt*((alpha6(i)+beta6(i))*(-1)*(4*w6(i)-w2(i)-w3(i)-w5(i)-w6d(i)));
    P1d(i+1)=P1d(i)+dt*((alpha1d(i)+beta1d(i))*(-1)*(w1d(i)-w1(i)));
    P2d(i+1)=P2d(i)+dt*((alpha2d(i)+beta2d(i))*(-1)*(w2d(i)-w2(i)));
    P3d(i+1)=P3d(i)+dt*((alpha3d(i)+beta3d(i))*(-1)*(w3d(i)-w3(i)));
    P4d(i+1)=P4d(i)+dt*((alpha4d(i)+beta4d(i))*(-1)*(w4d(i)-w4(i)));
    P5d(i+1)=P5d(i)+dt*((alpha5d(i)+beta5d(i))*(-1)*(w5d(i)-w5(i)));
    P6d(i+1)=P6d(i)+dt*((alpha6d(i)+beta6d(i))*(-1)*(w6d(i)-w6(i)));
    end
end


figure();
plot(P1);hold on;plot(P2);plot(P3);plot(P4);plot(P5);plot(P6);plot(P1d);plot(P2d);plot(P3d);plot(P4d);plot(P5d);plot(P6d);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('Active Power Output')

figure();
plot(alpha1);hold on;plot(alpha2);plot(alpha3);plot(alpha4);plot(alpha5);plot(alpha6);plot(alpha1d);plot(alpha2d);plot(alpha3d);plot(alpha4d);plot(alpha5d);plot(alpha6d);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('\alpha')

figure();
plot(beta1);hold on;plot(beta2);plot(beta3);plot(beta4);plot(beta5);plot(beta6);plot(beta1d);plot(beta2d);plot(beta3d);plot(beta4d);plot(beta5d);plot(beta6d);
xlim([0 5000])
xlabel('Number of Iterations')
ylabel('\beta')

figure();
plot(w1);hold on;plot(w2);plot(w3);plot(w4);plot(w5);plot(w6);plot(w1d);plot(w2d);plot(w3d);plot(w4d);plot(w5d);plot(w6d);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('Incremental Cost(I.C.)')

OptP=[P1(end),P2(end),P3(end),P4(end),P5(end),P6(end),P1d(end),P2d(end),P3d(end),P4d(end),P5d(end),P6d(end)]
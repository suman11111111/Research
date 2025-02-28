clc,clear all;close all;

theta=0.005;

N=100000;
dt=0.001;


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

P1(1)=133.36;
P2(1)=287.98;
P3(1)=40;
P4(1)=38;
P5(1)=15;
P6(1)=17;


for i=1:N
    

    w1(i)=b1+2*c1*P1(i);
    w2(i)=b2+2*c2*P2(i);
    w3(i)=b3+2*c3*P3(i);
    w4(i)=b4+2*c4*P4(i);
    w5(i)=b5+2*c5*P5(i);
    w6(i)=b6+2*c6*P6(i);
    
    alpha1(i+1)=alpha1(i)+dt*(2*w1(i)-w2(i)-w6(i))'*(2*w1(i)-w2(i)-w6(i));
    alpha2(i+1)=alpha2(i)+dt*(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i))'*(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i));
    alpha3(i+1)=alpha3(i)+dt*(3*w3(i)-w2(i)-w3(i)-w6(i))'*(3*w3(i)-w2(i)-w3(i)-w6(i));
    alpha4(i+1)=alpha4(i)+dt*(2*w4(i)-w3(i)-w5(i))'*(2*w4(i)-w3(i)-w5(i));
    alpha5(i+1)=alpha5(i)+dt*(3*w5(i)-w4(i)-w6(i)-w2(i))'*(3*w5(i)-w4(i)-w6(i)-w2(i));
    alpha6(i+1)=alpha6(i)+dt*(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i))'*(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i));
    
    beta1(i+1)=(2*w1(i)-w2(i)-w6(i))'*(2*w1(i)-w2(i)-w6(i));
    beta2(i+1)=(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i))'*(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i));
    beta3(i+1)=(3*w3(i)-w2(i)-w4(i)-w6(i))'*(3*w3(i)-w2(i)-w4(i)-w6(i));
    beta4(i+1)=(2*w4(i)-w3(i)-w5(i))'*(2*w4(i)-w3(i)-w5(i));
    beta5(i+1)=(3*w5(i)-w4(i)-w6(i)-w2(i))'*(3*w5(i)-w4(i)-w6(i)-w2(i));
    beta6(i+1)=(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i))'*(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i));
    
    P1(i+1)=P1(i)+dt*((alpha1(i)+beta1(i))*(-1)*(2*w1(i)-w2(i)-w6(i)));
    P2(i+1)=P2(i)+dt*((alpha2(i)+beta2(i))*(-1)*(4*w2(i)-w1(i)-w3(i)-w5(i)-w6(i)));
    P3(i+1)=P3(i)+dt*((alpha3(i)+beta3(i))*(-1)*(3*w3(i)-w2(i)-w4(i)-w6(i)));
    P4(i+1)=P4(i)+dt*((alpha4(i)+beta4(i))*(-1)*(2*w4(i)-w3(i)-w5(i)));
    P5(i+1)=P5(i)+dt*((alpha5(i)+beta5(i))*(-1)*(3*w5(i)-w4(i)-w6(i)-w2(i)));
    P6(i+1)=P6(i)+dt*((alpha6(i)+beta6(i))*(-1)*(4*w6(i)-w1(i)-w2(i)-w3(i)-w5(i)));
end


figure();
plot(P1);hold on;plot(P2);hold on;plot(P3);hold on;plot(P4);hold on;plot(P5);hold on;plot(P6);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('Active Power Output')

figure();
plot(alpha1);hold on;plot(alpha2);hold on;plot(alpha3);hold on;plot(alpha4);hold on;plot(alpha5);hold on;plot(alpha6);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('\alpha')

figure();
plot(beta1);hold on;plot(beta2);hold on;plot(beta3);hold on;plot(beta4);hold on;plot(beta5);hold on;plot(beta6);
xlim([0 4500])
xlabel('Number of Iterations')
ylabel('\beta')

figure();
plot(w1);hold on;plot(w2);hold on;plot(w3);hold on;plot(w4);hold on;plot(w5);hold on;plot(w6);
xlim([0 100000])
xlabel('Number of Iterations')
ylabel('Incremental Cost(I.C.)')

OptP=[P1(end),P2(end),P3(end),P4(end),P5(end),P6(end)]
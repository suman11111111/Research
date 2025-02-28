clc,clear, close all;

theta=0.005;
dt=0.001;

N=10000;

PD=513.34;

P1(1)=133.36;
P2(1)=287.98;
P3(1)=40;
P4(1)=20;
P5(1)=15;
P6(1)=17;

P1max=200;
P2max=400;
P3max=50;
P4max=35;
P5max=30;
P6max=40;

P1min=50;
P2min=100;
P3min=15;
P4min=10;
P5min=10;
P6min=12;

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

A=ones(1,6);


for i=1:N
    
    if i==N/4
        PD=PD+50
    end 
    
    
    delf=[b1+2*c1*P1(i)-theta*(1/(P1(i)-P1min)+1/(P1max-P1min));b2+2*c2*P2(i)-theta*(1/(P2(i)-P2min)+1/(P2max-P2min));b3+2*c3*P3(i)-theta*(1/(P3(i)-P3min)+1/(P3max-P3min));b4+2*c4*P4(i)-theta*(1/(P4(i)-P4min)+1/(P4max-P4min));b5+2*c5*P5(i)-theta*(1/(P5(i)-P5min)+1/(P5max-P5min));b6+2*c6*P6(i)-theta*(1/(P6(i)-P6min)+1/(P6max-P6min))];
    del2f=diag([2*c1+theta*(1/(P1(i)-P1min)^2+1/(P1max-P1(i))^2),2*c2+theta*(1/(P2(i)-P2min)^2+1/(P2max-P2(i))^2),2*c3+theta*(1/(P3(i)-P3min)^2+1/(P3max-P3(i))^2),2*c4+theta*(1/(P4(i)-P4min)^2+1/(P4max-P4(i))^2),2*c5+theta*(1/(P5(i)-P5min)^2+1/(P5max-P5(i))^2),2*c6+theta*(1/(P6(i)-P6min)^2+1/(P6max-P6(i))^2)]);
    S=inv([del2f A';A 0])*[-delf;PD-P1(i)-P2(i)-P3(i)-P4(i)-P5(i)-P6(i)];
    
    P1(i+1)=P1(i)+dt*S(1);
    P2(i+1)=P2(i)+dt*S(2);
    P3(i+1)=P3(i)+dt*S(3);
    P4(i+1)=P4(i)+dt*S(4);
    P5(i+1)=P5(i)+dt*S(5);
    P6(i+1)=P6(i)+dt*S(6);
    
    IC1(i)=delf(1);
    IC2(i)=delf(2);
    IC3(i)=delf(3);
    IC4(i)=delf(4);
    IC5(i)=delf(5);
    IC6(i)=delf(6);
    
    CP1(i)=b1*P1(i)+c1*P1(i)*P1(i);
    CP2(i)=b2*P2(i)+c2*P2(i)*P2(i);
    CP3(i)=b3*P3(i)+c3*P3(i)*P3(i);
    CP4(i)=b4*P4(i)+c4*P4(i)*P4(i);
    CP5(i)=b5*P5(i)+c5*P5(i)*P5(i);
    CP6(i)=b6*P6(i)+c6*P6(i)*P6(i);
    
    TCP(i)=CP1(i)+CP2(i)+CP3(i)+CP4(i)+CP5(i)+CP6(i);
end

P1(end),P2(end),P3(end),P4(end),P5(end),P6(end)

figure()
plot(IC1);hold on;plot(IC2);plot(IC3);plot(IC4);plot(IC5);plot(IC6);
xlabel('No. of Iterations')
ylabel('Incremental Costs')

figure()
plot(P1);hold on;plot(P2);plot(P3);plot(P4);plot(P5);plot(P6);
xlabel('No. of Iterations')
ylabel('Active Power Output')

figure()
plot(CP1);hold on;plot(CP2);plot(CP3);plot(CP4);plot(CP5);plot(CP6);plot(TCP);
xlabel('No. of Iterations')
ylabel('Costs.')

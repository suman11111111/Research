theta=0.005;

N=1000;

PD=551.7546;

P1(1)=137.98;
P2(1)=365.4775;
P3(1)=16.2648;
P4(1)=10.0129;
P5(1)=10.0106;
P6(1)=12.0088;

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
    delf=[b1+2*c1*P1(i)-theta*(1/(P1(i)-P1min)+1/(P1max-P1min));b2+2*c2*P2(i)-theta*(1/(P2(i)-P2min)+1/(P2max-P2min));b3+2*c3*P3(i)-theta*(1/(P3(i)-P3min)+1/(P3max-P3min));b4+2*c4*P4(i)-theta*(1/(P4(i)-P4min)+1/(P4max-P4min));b5+2*c5*P5(i)-theta*(1/(P5(i)-P5min)+1/(P5max-P5min));b6+2*c6*P6(i)-theta*(1/(P6(i)-P6min)+1/(P6max-P6min))];
    del2f=diag([2*c1+theta*(1/(P1(i)-P1min)^2+1/(P1max-P1(i))^2),2*c2+theta*(1/(P2(i)-P2min)^2+1/(P2max-P2(i))^2),2*c3+theta*(1/(P3(i)-P3min)^2+1/(P3max-P3(i))^2),2*c4+theta*(1/(P4(i)-P4min)^2+1/(P4max-P4(i))^2),2*c5+theta*(1/(P5(i)-P5min)^2+1/(P5max-P5(i))^2),2*c6+theta*(1/(P6(i)-P6min)^2+1/(P6max-P6(i))^2)]);
    S=inv([del2f A';A 0])*[-delf;PD-P1(i)-P2(i)-P3(i)-P4(i)-P5(i)-P6(i)];
    P1(i+1)=P1(i)+S(1);
    P2(i+1)=P2(i)+S(2);
    P3(i+1)=P3(i)+S(3);
    P4(i+1)=P4(i)+S(4);
    P5(i+1)=P5(i)+S(5);
    P6(i+1)=P6(i)+S(6);
end


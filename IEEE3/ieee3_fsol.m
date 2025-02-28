clc,clear

%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 theta1 V1 
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 theta2 V2
syms theta3 V3

H1=6.4;
H2=3.01;

D1=0.0081;
D2=0.0057;

Rs1=0;
Rs2=0;

Xd1=0.8958;
Xd2=1.3125;

Xq1=0.8645;
Xq2=1.2578;

Xd_dash1=0.1198;
Xd_dash2=0.1813;

Xq_dash1=0.1969;
Xq_dash2=0.25;

Tdo1=6;
Tdo2=5.89;

Tqo1=0.535; 
Tqo2=0.6;

B11=-15.76;
B12=9.784;
B13=5.976;

B22=-15.372;
B21=9.784; 
B23=5.588;

B33=-23.04;
B31=5.976; 
B32=17.0648;

P1=0.05;
P2=0.4;

Q1=0.0468;
Q2=0.0806;

P3=0.45;
Q3=0.15;

Efd1=0;
Efd2=0;

TM1=0;
TM2=0;


%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=omega1;
f1(4)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(5)=Ed1-V1*cos(theta1)*sin(delt1)+V1*sin(theta1)*cos(delt1)-Rs1*Id1+Xq_dash1*Iq1;
f1(6)=Eq1-V1*cos(theta1)*cos(delt1)-V1*sin(theta1)*sin(delt1)-Rs1*Iq1-Xd_dash1*Id1;
f1(7)=Id1*V1*sin(delt1-theta1)+Iq1*V1*cos(delt1-theta1)+P1-B11*V1*V1*sin(theta1-theta1)-B12*V1*V2*sin(theta1-theta2)-B13*V1*V3*sin(theta1-theta3);
f1(8)=Id1*V1*cos(delt1-theta1)-Iq1*V1*sin(delt1-theta1)+Q1-B11*V1*V1*cos(theta1-theta1)-B12*V1*V2*cos(theta1-theta2)-B13*V1*V3*cos(theta1-theta3);

%States for 1st bus
x1=[Eq1 Ed1 delt1 omega1 Iq1 Id1 V1 theta1];

%Differential Equation for 2nd bus
f2(1)=(-Eq2-(Xd2-Xd_dash2)*Id2+Efd2);
f2(2)=(-Ed2-(Xq2-Xq_dash2)*Iq2);
f2(3)=omega2;
f2(4)=TM2-Ed2*Id2-Eq2*Iq2-(Xq_dash2-Xd_dash2)*Id2*Iq2-D2*omega2;

%Algebraic Equation for 2nd bus
f2(5)=Ed2-V2*cos(theta2)*sin(delt2)+V2*sin(theta2)*cos(delt2)-Rs2*Id2+Xq_dash2*Iq2;
f2(6)=Eq2-V2*cos(theta2)*cos(delt2)-V2*sin(theta2)*sin(delt2)-Rs2*Iq2-Xd_dash2*Id2;
f2(7)=Id2*V2*sin(delt2-theta2)+Iq2*V2*cos(delt2-theta2)+P2-B21*V2*V1*sin(theta2-theta1)-B22*V2*V2*sin(theta2-theta2)-B23*V2*V3*sin(theta2-theta3);
f2(8)=Id2*V2*cos(delt2-theta2)-Iq2*V2*sin(delt2-theta2)+Q2-B21*V2*V1*cos(theta2-theta1)-B22*V2*V2*cos(theta2-theta2)-B23*V2*V3*cos(theta2-theta3);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Iq2 Id2 V2 theta2];

%Algebraic Equation for 4th bus
f3(1)=P3-B31*V3*V1*sin(theta3-theta1)-B32*V3*V2*sin(theta3-theta2)-B33*V3*V3*sin(theta3-theta3);
f3(2)=Q3-B31*V3*V1*cos(theta3-theta1)-B32*V3*V2*cos(theta3-theta2)-B33*V3*V3*cos(theta3-theta3);

%States for 4th bus
x3=[V3 theta3];

%Drifts
fd=[f1(1),f2(1),f1(2),f2(2),f1(3),f2(3),f1(4),f2(4)];
xd=[x1(1),x2(1),x1(2),x2(2),x1(3),x2(3),x1(4),x2(4)];

fa=[f1(5),f2(5),f1(6),f2(6),f1(7),f2(7),f3(1),f1(8),f2(8),f3(2)];
xa=[x1(5),x2(5),x1(6),x2(6),x1(7),x2(7),x3(1),x1(8),x2(8),x3(2)];


%States
x=[xd xa];
x=reshape(x,[18 1]);

%Jacobians for A and B
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);

A=[A11,A12;A21,A22];

%Solve
x0=vpasolve(A*x==0,x,[-0.0477;-0.5021;0.0298;-0.0964;-0.0415;-0.4354;1;1;0.466;-0.1046;-0.05189;-0.3966;1;1;1;0;0.0093;-0.0217])




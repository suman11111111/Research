clc,clear
%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B13 
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B22 B23
syms P3 Q3 theta3 V3 B31 B32 B33

%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=omega1;
f1(4)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(5)=Ed1-V1*cos(theta1)*sin(delt1)+V1*sin(theta1)*cos(delt1)-Rs1*Id1+Xq_dash1*Iq1;
f1(6)=Eq1-V1*cos(theta1)*cos(delt1)+V1*sin(theta1)*sin(delt1)-Rs1*Iq1-Xd_dash1*Id1;
f1(7)=-B11*V1*sin(theta1)-B13*V3*sin(theta3);
f1(8)=(Iq1*sin(delt1)-Id1*cos(delt1))+V1\P1*sin(theta1)-V1\Q1*cos(theta1)+B11*V1*cos(theta1)+B13*V3*cos(theta3);

%States for 1st bus
x1=[Eq1 Ed1 delt1 omega1 Iq1 Id1 V1 theta1];

%Input States for 1st bus
u1=[Efd1 TM1];

%Differential Equation for 2nd bus
f2(1)=(-Eq2-(Xd2-Xd_dash2)*Id2+Efd2);
f2(2)=(-Ed2-(Xq2-Xq_dash2)*Iq2);
f2(3)=omega2;
f2(4)=TM2-Ed2*Id2-Eq2*Iq2-(Xq_dash2-Xd_dash2)*Id2*Iq2-D2*omega2;

%Algebraic Equation for 2nd bus
f2(5)=Ed2-V2*cos(theta2)*sin(delt2)+V2*sin(theta2)*cos(delt2)-Rs2*Id2+Xq_dash2*Iq2;
f2(6)=Eq2-V2*cos(theta2)*cos(delt2)+V2*sin(theta2)*sin(delt2)-Rs2*Iq2-Xd_dash2*Id2;
f2(7)=(Id2*sin(delt2)+Iq2*cos(delt2))+V2\P2*cos(theta2)+V2\Q2*sin(theta2)+B22*V2*sin(theta2)+B23*V3*sin(theta3);
f2(8)=(Iq2*sin(delt2)-Id2*cos(delt2))+V2\P2*sin(theta2)-V2\Q2*cos(theta2)+B22*V2*cos(theta2)+B23*V3*cos(theta3);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Iq2 Id2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2];

%Algebraic Equation for 3rd bus
f3(1)=V3\P3*cos(theta3)+V3\Q3*sin(theta3)+B31*V1*sin(theta1)+B31*V1*sin(theta1)+B32*V2*sin(theta2)+B33*V3*sin(theta3);
f3(2)=V3\P3*sin(theta3)-V3\Q3*cos(theta3)+B31*V1*sin(theta1)+B31*V1*sin(theta1)+B32*V2*sin(theta2)+B33*V3*sin(theta3);

%States for 3rd bus
x3=[V3 theta3];

%Drifts
fd=[f1(1),f2(1),f1(2),f2(2),f1(3),f2(3),f1(4),f2(4)];
xd=[x1(1),x2(1),x1(2),x2(2),x1(3),x2(3),x1(4),x2(4)];

fa=[f1(5),f2(5),f1(6),f2(6),f1(7),f2(7),f3(1),f1(8),f2(8),f3(2)];
xa=[x1(5),x2(5),x1(6),x2(6),x1(7),x2(7),x3(1),x1(8),x2(8),x3(2)];

u=[u1(1),u2(1),u1(2),u2(2)];


%Jacobians for A and B
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);
B2=jacobian(fa,u);



%Computation of E
E=zeros(18,18);
E=sym(E);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tqo1;
E(4,4)=Tqo2;
E(5,5)=1;
E(6,6)=1;
E(7,7)=(2*H1)/omega_s;
E(8,8)=(2*H2)/omega_s;


%Computation of E,A,B

A=[A11,A12;A21,A22];
B=[B1;B2];

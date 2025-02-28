clc,clear

%Defining of Symbolic Variables for each bus
syms s
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B14 
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B22 B28
syms Eq3 Ed3 delt3 omega3 Id3 Iq3 P3 Q3 theta3 V3 Efd3 H3 TM3 D3 Tdo3 Tqo3 Rs3 Xq3 Xd3 Xd_dash3 Xq3 Xq_dash3 B33 B36
syms P4 Q4 theta4 V4 B41 B44 B45 B49
syms P5 Q5 theta5 V5 B54 B55 B56
syms P6 Q6 theta6 V6 B63 B65 B66 B67
syms P7 Q7 theta7 V7 B76 B77 B78
syms P8 Q8 theta8 V8 B82 B87 B88 B89
syms P9 Q9 theta9 V9 B94 B98 B99

%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=omega1;
f1(4)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(5)=Ed1-V1*cos(theta1)*sin(delt1)+V1*sin(theta1)*cos(delt1)-Rs1*Id1+Xq_dash1*Iq1;
f1(6)=Eq1-V1*cos(theta1)*cos(delt1)-V1*sin(theta1)*sin(delt1)-Rs1*Iq1-Xd_dash1*Id1;
f1(7)=Id1*V1*sin(delt1-theta1)+Iq1*V1*cos(delt1-theta1)+P1-B11*V1*V1*sin(theta1-theta1)-B14*V1*V4*sin(theta1-theta4);
f1(8)=Id1*V1*cos(delt1-theta1)-Iq1*V1*sin(delt1-theta1)+Q1-B11*V1*V1*cos(theta1-theta1)-B14*V1*V4*cos(theta1-theta4);

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
f2(6)=Eq2-V2*cos(theta2)*cos(delt2)-V2*sin(theta2)*sin(delt2)-Rs2*Iq2-Xd_dash2*Id2;
f2(7)=Id2*V2*sin(delt2-theta2)+Iq2*V2*cos(delt2-theta2)+P2-B22*V2*V2*sin(theta2-theta2)-B28*V2*V8*sin(theta2-theta8);
f2(8)=Id2*V2*cos(delt2-theta2)-Iq2*V2*sin(delt2-theta2)+Q2-B22*V2*V2*cos(theta2-theta2)-B28*V2*V8*cos(theta2-theta8);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Iq2 Id2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2];

%Differential Equation for 3rd bus
f3(1)=(-Eq3-(Xd3-Xd_dash3)*Id3+Efd3);
f3(2)=(-Ed3-(Xq3-Xq_dash3)*Iq3);
f3(3)=omega3;
f3(4)=TM3-Ed3*Id3-Eq3*Iq3-(Xq_dash3-Xd_dash3)*Id3*Iq3-D3*omega3;

%Algebraic Equation for 3rd bus
f3(5)=Ed3-V3*cos(theta3)*sin(delt3)+V3*sin(theta3)*cos(delt3)-Rs3*Id3+Xq_dash3*Iq3;
f3(6)=Eq3-V3*cos(theta3)*cos(delt3)-V3*sin(theta3)*sin(delt3)-Rs3*Iq3-Xd_dash3*Id3;
f3(7)=Id3*V3*sin(delt3-theta3)+Iq3*V3*cos(delt3-theta3)+P3-B33*V3*V3*sin(theta3-theta3)-B36*V3*V6*sin(theta6-theta3);
f3(8)=Id3*V3*cos(delt3-theta3)-Iq3*V3*sin(delt3-theta3)+Q3-B33*V3*V3*cos(theta3-theta3)-B36*V3*V6*cos(theta6-theta3);

%States for 3rd bus
x3=[Eq3 Ed3 delt3 omega3 Iq3 Id3 V3 theta3];

%Input States for 3rd bus
u3=[Efd3 TM3];

%Algebraic Equation for 4th bus
f4(1)=P4-B41*V4*V1*sin(theta4-theta1)-B44*V4*V4*sin(theta4-theta4)-B45*V4*V5*sin(theta4-theta5)-B49*V4*V9*sin(theta4-theta9);
f4(2)=Q4-B41*V4*V1*cos(theta4-theta1)-B44*V4*V4*cos(theta4-theta4)-B45*V4*V5*cos(theta4-theta5)-B49*V4*V9*cos(theta4-theta9);

%States for 4th bus
x4=[V4 theta4];

%Algebraic Equation for 5th bus
f5(1)=P5-B54*V5*V4*sin(theta5-theta4)-B55*V5*V5*sin(theta5-theta5)-B56*V5*V6*sin(theta5-theta6);
f5(2)=Q5-B54*V5*V4*cos(theta5-theta4)-B55*V5*V5*cos(theta5-theta5)-B56*V5*V6*cos(theta5-theta6);

%States for 5th bus
x5=[V5 theta5];

%Algebraic Equation for 6th bus
f6(1)=P6-B63*V6*V3*sin(theta6-theta3)-B65*V6*V5*sin(theta6-theta5)-B66*V6*V6*sin(theta6-theta6)-B67*V6*V7*sin(theta6-theta7);
f6(2)=Q6-B63*V6*V3*cos(theta6-theta3)-B65*V6*V5*cos(theta6-theta5)-B66*V6*V6*cos(theta6-theta6)-B67*V6*V7*cos(theta6-theta7);

%States for 6th bus
x6=[V6 theta6];

%Algebraic Equation for 7th bus
f7(1)=P7-B76*V7*V6*sin(theta7-theta6)-B77*V7*V7*sin(theta7-theta7)-B78*V7*V8*sin(theta7-theta8);
f7(2)=Q7-B76*V7*V6*cos(theta7-theta6)-B77*V7*V7*cos(theta7-theta7)-B78*V7*V8*cos(theta7-theta8);

%States for 7th bus
x7=[V7 theta7];

%Algebraic Equation for 8th bus
f8(1)=P8-B82*V8*V2*sin(theta8-theta2)-B87*V8*V7*sin(theta8-theta7)-B88*V8*V8*sin(theta8-theta8)-B89*V8*V9*sin(theta8-theta9);
f8(2)=Q8-B82*V8*V2*cos(theta8-theta2)-B87*V8*V7*cos(theta8-theta7)-B88*V8*V8*cos(theta8-theta8)-B89*V8*V9*cos(theta8-theta9);

%States for 8th bus
x8=[V8 theta8];

%Algebraic Equation for 9th bus
f9(1)=P9-B94*V9*V4*sin(theta4)+B98*V9*V8*sin(theta8)+B99*V9*V9*sin(theta9);
f9(2)=Q9-B94*V9*V4*cos(theta4)+B98*V9*V8*cos(theta8)+B99*V9*V9*cos(theta9);

%States for 9th bus
x9=[V9 theta9];


%Drifts
fd=[f1(1),f2(1),f3(1),f1(2),f2(2),f3(2),f1(3),f2(3),f3(3),f1(4),f2(4),f3(4)];
xd=[x1(1),x2(1),x3(1),x1(2),x2(2),x3(2),x1(3),x2(3),x3(3),x1(4),x2(4),x3(4)];

fa=[f1(5),f2(5),f3(5),f1(6),f2(6),f3(6),f1(7),f2(7),f3(7),f4(1),f5(1),f6(1),f7(1),f8(1),f9(1),f1(8),f2(8),f3(8),f4(2),f5(2),f6(2),f7(2),f8(2),f9(2)];
xa=[x1(5),x2(5),x3(5),x1(6),x2(6),x3(6),x1(7),x2(7),x3(7),x4(1),x5(1),x6(1),x7(1),x8(1),x9(1),x1(8),x2(8),x3(8),x4(2),x5(2),x6(2),x7(2),x8(2),x9(2)];

u=[u1(1),u2(1),u3(1),u1(2),u2(2),u3(2)];


%Jacobians for A and B
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);
B2=jacobian(fa,u);



%Computation of E
E=zeros(36,36);
E=sym(E);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tdo3;
E(4,4)=Tqo1;
E(5,5)=Tqo2;
E(6,6)=Tqo3;
E(7,7)=1;
E(8,8)=1;
E(9,9)=1;
E(10,10)=(2*H1)/omega_s;
E(11,11)=(2*H2)/omega_s;
E(12,12)=(2*H3)/omega_s;
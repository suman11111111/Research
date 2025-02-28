function [E,A,B]=Pai_Jacobian()

%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B14 
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B22 B27
syms Eq3 Ed3 delt3 omega3 Id3 Iq3 P3 Q3 theta3 V3 Efd3 H3 TM3 D3 Tdo3 Tqo3 Rs3 Xq3 Xd3 Xd_dash3 Xq3 Xq_dash3 B33 B39
syms P4 Q4 theta4 V4 B44 B45 B46
syms P5 Q5 theta5 V5 B54 B55 B57
syms P6 Q6 theta6 V6 B64 B65 B66
syms P7 Q7 theta7 V7 B72 B75 B77 B78
syms P8 Q8 theta8 V8 B87 B88 B89
syms P9 Q9 theta9 V9 B93 B96 B98 B99

%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=omega1;
f1(4)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(5)=Ed1-V1*cosd(theta1)*sind(delt1)+V1*sind(theta1)*cosd(delt1)-Rs1*Id1+Xq_dash1*Iq1;
f1(6)=Eq1-V1*cosd(theta1)*cosd(delt1)+V1*sind(theta1)*sind(delt1)-Rs1*Iq1-Xd_dash1*Id1;
f1(7)=(Id1*sind(delt1)+Iq1*cosd(delt1))+V1\P1*cosd(theta1)+V1\Q1*sind(theta1)+B11*V1*sind(theta1)+B14*V4*sind(theta4);
f1(8)=(Iq1*sind(delt1)-Id1*cosd(delt1))+V1\P1*sind(theta1)-V1\Q1*cosd(theta1)+B11*V1*cosd(theta1)+B14*V4*cosd(theta4);

%States for 1st bus
x1=[Eq1 Ed1 delt1 omega1 Id1 Iq1 V1 theta1];

%Input States for 1st bus
u1=[Efd1 TM1];

%Differential Equation for 2nd bus
f2(1)=Tdo2\(-Eq2-(Xd2-Xd_dash2)*Id2+Efd2);
f2(2)=Tqo2\(-Ed2-(Xq2-Xq_dash2)*Iq2);
f2(3)=omega2;
f2(4)=TM2-Ed2*Id2-Eq2*Iq2-(Xq_dash2-Xd_dash2)*Id2*Iq2-D2*omega2;

%Algebraic Equation for 2nd bus
f2(5)=Ed2-V2*cosd(theta2)*sind(delt2)+V2*sind(theta2)*cosd(delt2)-Rs2*Id2+Xq_dash2*Iq2;
f2(6)=Eq2-V2*cosd(theta2)*cosd(delt2)+V2*sind(theta2)*sind(delt2)-Rs2*Iq2-Xd_dash2*Id2;
f2(7)=(Id2*sind(delt2)+Iq2*cosd(delt2))+V2\P2*cosd(theta2)+V2\Q2*sind(theta2)+B22*V2*sind(theta2)+B27*V7*sind(theta7);
f2(8)=(Iq2*sind(delt2)-Id2*cosd(delt2))+V2\P2*sind(theta2)-V2\Q2*cosd(theta2)+B22*V2*cosd(theta2)+B27*V7*cosd(theta7);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Id2 Iq2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2];

%Differential Equation for 3rd bus
f3(1)=Tdo3\(-Eq3-(Xd3-Xd_dash3)*Id3+Efd3);
f3(2)=Tqo3\(-Ed3-(Xq3-Xq_dash3)*Iq3);
f3(3)=omega3;
f3(4)=TM3-Ed3*Id3-Eq3*Iq3-(Xq_dash3-Xd_dash3)*Id3*Iq3-D3*omega3;

%Algebraic Equation for 3rd bus
f3(5)=Ed3-V3*cosd(theta3)*sind(delt3)+V3*sind(theta3)*cosd(delt3)-Rs3*Id3+Xq_dash3*Iq3;
f3(6)=Eq3-V3*cosd(theta3)*cosd(delt3)+V3*sind(theta3)*sind(delt3)-Rs3*Iq3-Xd_dash3*Id3;
f3(7)=(Id3*sind(delt3)+Iq3*cosd(delt3))+V3\P3*cosd(theta3)+V3\Q3*sind(theta3)+B33*V3*sind(theta3)+B39*V9*sind(theta9);
f3(8)=(Iq3*sind(delt3)-Id3*cosd(delt3))+V3\P3*sind(theta3)-V3\Q3*cosd(theta3)+B33*V3*cosd(theta3)+B39*V9*cosd(theta9);

%States for 3rd bus
x3=[Eq3 Ed3 delt3 omega3 Id3 Iq3 V3 theta3];

%Input States for 3rd bus
u3=[Efd3 TM3];

%Algebraic Equation for 4th bus
f4(1)=V4\P4*cosd(theta4)+V4\Q4*sind(theta4)+B44*V4*sind(theta4)+B45*V5*sind(theta5)+B46*V6*sind(theta6);
f4(2)=V4\P4*sind(theta4)-V4\Q4*cosd(theta4)+B44*V4*cosd(theta4)+B45*V5*cosd(theta5)+B46*V6*cosd(theta6);

%States for 4th bus
x4=[V4 theta4];

%Algebraic Equation for 5th bus
f5(1)=V5\P5*cosd(theta5)+V5\Q5*sind(theta5)+B54*V4*sind(theta4)+B55*V5*sind(theta5)+B57*V7*sind(theta7);
f5(2)=V5\P5*sind(theta5)-V5\Q5*cosd(theta5)+B54*V4*cosd(theta4)+B55*V5*cosd(theta5)+B57*V7*cosd(theta7);

%States for 5th bus
x5=[V5 theta5];

%Algebraic Equation for 6th bus
f6(1)=V6\P6*cosd(theta6)+V6\Q6*sind(theta6)+B64*V4*sind(theta4)+B65*V5*sind(theta5)+B66*V6*sind(theta6);
f6(2)=V6\P6*sind(theta6)-V6\Q6*cosd(theta6)+B64*V4*cosd(theta4)+B65*V5*cosd(theta5)+B66*V6*cosd(theta6);

%States for 6th bus
x6=[V6 theta6];

%Algebraic Equation for 7th bus
f7(1)=V7\P7*cosd(theta7)+V7\Q7*sind(theta7)+B72*V2*sind(theta2)+B75*V5*sind(theta5)+B77*V7*sind(theta7)+B78*V8*sind(theta8);
f7(2)=V7\P7*sind(theta7)-V7\Q7*cosd(theta7)+B72*V2*cosd(theta2)+B75*V5*cosd(theta5)+B77*V7*cosd(theta7)+B78*V8*cosd(theta8);

%States for 7th bus
x7=[V7 theta7];

%Algebraic Equation for 8th bus
f8(1)=V8\P8*cosd(theta8)+V8\Q8*sind(theta8)+B87*V7*sind(theta7)+B88*V8*sind(theta8)+B89*V9*sind(theta9);
f8(2)=V8\P8*sind(theta8)-V8\Q8*cosd(theta8)+B87*V7*cosd(theta7)+B88*V8*cosd(theta8)+B89*V9*cosd(theta9);

%States for 8th bus
x8=[V8 theta8];

%Algebraic Equation for 9th bus
f9(1)=V9\P9*cosd(theta9)+V9\Q9*sind(theta9)+B93*V3*sind(theta3)+B96*V6*sind(theta6)+B98*V8*sind(theta8)+B98*V9*sind(theta9);
f9(2)=V9\P9*sind(theta9)-V9\Q9*cosd(theta9)+B93*V3*cosd(theta3)+B96*V6*cosd(theta6)+B98*V8*cosd(theta8)+B98*V9*cosd(theta9);

%States for 9th bus
x9=[V9 theta9];

%Drifts
f=[f1,f2,f3,f4,f5,f6,f7,f8,f9];
x=[x1,x2,x3,x4,x5,x6,x7,x8,x9];
u=[u1,u2,u3];

%Jacobians for A and B
A=jacobian(f,x);
B=jacobian(f,u);

%Computation of E
E=zeros(36,36);
E=sym(E);
E(1,1)=Tdo1;
E(2,2)=Tqo1;
E(4,4)=(2*H1)/omega_s;
E(9,9)=Tdo2;
E(10,10)=Tqo2;
E(12,12)=(2*H2)/omega_s;
E(17,17)=Tdo3;
E(18,18)=Tqo3;
E(20,20)=(2*H3)/omega_s;
end
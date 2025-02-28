clc,clear

%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B12 B13
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B21 B22 B23
syms P3 Q3 theta3 V3 B31 B32 B33


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
f2(7)=Id2*V2*sin(delt2-theta2)+Iq2*V2*cos(delt2-theta2)+P2-B21*V2*V1*sin(theta2-theta1)-B22*V2*V2*sin(theta2-theta2)-B23*V2*V3*sin(theta2-theta3);
f2(8)=Id2*V2*cos(delt2-theta2)-Iq2*V2*sin(delt2-theta2)+Q2-B21*V2*V1*cos(theta2-theta1)-B22*V2*V2*cos(theta2-theta2)-B23*V2*V3*cos(theta2-theta3);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Iq2 Id2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2];

%Algebraic Equation for 4th bus
f3(1)=P3-B31*V3*V1*sin(theta3-theta1)-B32*V3*V2*sin(theta3-theta2)-B33*V3*V3*sin(theta3-theta3);
f3(2)=Q3-B31*V3*V1*cos(theta3-theta1)-B32*V3*V2*cos(theta3-theta2)-B33*V3*V3*cos(theta3-theta3);

%States for 4th bus
x3=[V3 theta3];

% %Drifts,States,Inputs
% f=[f1,f2,f3];
% x=[x1,x2,x3];
% u=[u1,u2];
% 
% 
% %Jacobians for A and B
% A=jacobian(f,x);
% B=jacobian(f,u);

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

A=[A11,A12;A21,A22];
B=[B1;B2];

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

Hs=[H1 H2];
H=[6.4 3.01];

Eqs=[Eq1 Eq2];
Eq=[-0.0477 -0.5021];

Eds=[Ed1 Ed2];
Ed=[0.0298 -0.0964];

Vs=[V1 V2 V3];
V=[1 1 0.9912];

delts=[delt1 delt2];
delt=[-0.0415 -0.4354];

omegas=[omega1 omega2];
omega=[1 1];

Ds=[D1 D2];
% D=[0.0081 0.0057];
D=[0.15 0.1];

Ids=[Id1 Id2];
Id=[-0.0502 -0.4050];

Iqs=[Iq1 Iq2];
Iq=[0.0446 -0.0495];

Rss=[Rs1 Rs2];
Rs=[0 0];

Xds=[Xd1 Xd2];
Xd=[0.8958 1.3125];

Xqs=[Xq1 Xq2];
Xq=[0.8645 1.2578];

Xd_dashs=[Xd_dash1 Xd_dash2];
Xd_dash=[0.1198 0.1813];

Xq_dashs=[Xq_dash1 Xq_dash2];
Xq_dash=[0.1969 0.25];

Tdos=[Tdo1 Tdo2];
Tdo=[6 5.89];

Tqos=[Tqo1 Tqo2];
Tqo=[0.535 0.6];

Ps=[P1 P2 P3];
P=[0.0500 0.4000 0.4500];

Qs=[Q1 Q2 Q3];
Q=[0.0468 0.0806 0.1500];

thetas=[theta1 theta2 theta3];
theta=[0 0.5334 -1.2409];
theta=deg2rad(theta);

% B1xs=[B11 B12 B13];
% B1x=[-15.7600 9.7840 5.9760];
% 
% B2xs=[B22 B21 B23];
% B2x=[-15.3720 9.7840 5.5880];
% 
% B3s=[B33 B31 B32];
% B3=[-23.0400 5.9760 17.0648];

B1xs=[B11 B12 B13];
B1x=[-0.25 0.1 0.15];

B2xs=[B22 B21 B23];
B2x=[-0.2 0.1 0.1];

B3s=[B33 B31 B32];
B3=[-0.25 0.15 0.1];

E=subs(E,[Tdos Tqos Hs omega_s],[Tdo Tqo H 1]);
E=double(E);
A=subs(A,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1xs B2xs B3s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1x B2x B3]);
A=double(A);
B=double(B);

pol=eig(A,E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end
clc,clear,close all

syms s;

omega=1;

H1=6.4;
H2=3.01;

D1=0.3;
D2=0.3;

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

B11=-0.25;
B12=0.1;
B13=0.15;

B21=0;
B22=0;
B23=0;

B31=0.15;
B32=0.1;
B33=-0.25; 

P1=1.63;
P2=0.85;

Q1=0.0067;
Q2=-0.109;

P3=2.48;
Q3=-0.1023;

Efd1=0;
Efd2=0;

TM1=0;
TM2=0;

%x(1)=Eq1;x(2)=Eq2;x(3)=Ed1;x(4)=Ed2;x(5)=delt2;x(6)=omega1;x(7)=omega2;x(8)=Id1;x(9)=Id2...
%     ...x(10)=Iq1;x(11)=Iq2;x(12)=V1;x(13)=V2;x(14)=V3;x(15)=theta1;x(16)=theta2;x(17)=theta3;


f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(8)+Efd1);
    (-x(2)-(Xd2-Xd_dash2)*x(9)+Efd2);
    (-x(3)-(Xq1-Xq_dash1)*x(10));
    (-x(4)-(Xq2-Xq_dash2)*x(11));
    x(7)-x(6);
    TM1-x(3)*x(8)-x(1)*x(10)-(Xq_dash1-Xd_dash1)*x(8)*x(10)-D1*(x(6)-omega);
    TM2-x(4)*x(9)-x(2)*x(11)-(Xq_dash2-Xd_dash2)*x(9)*x(11)-D2*(x(7)-omega);
    x(3)+x(12)*sin(x(15))-Rs1*x(8)+Xq_dash1*x(10);
    x(4)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs2*x(9)+Xq_dash2*x(11);
    x(1)-x(12)*cos(x(15))-Rs1*x(10)-Xd_dash1*x(8);
    x(2)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs2*x(11)-Xd_dash2*x(9);
    x(8)*x(12)*sin(-x(15))+x(10)*x(12)*cos(-x(15))+P1-B11*x(12)*x(12)*sin(x(15)-x(15))-B12*x(12)*x(13)*sin(x(15)-x(16))-B13*x(12)*x(14)*sin(x(15)-x(17));
    x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+P2-B21*x(13)*x(12)*sin(x(16)-x(15))-B22*x(13)*x(13)*sin(x(16)-x(16))-B23*x(13)*x(14)*sin(x(16)-x(17));
    P3-B31*x(14)*x(12)*sin(x(17)-x(15))-B32*x(14)*x(13)*sin(x(17)-x(16))-B33*x(14)*x(14)*sin(x(17)-x(1));
    x(8)*x(12)*cos(-x(15))-x(10)*x(12)*sin(-x(15))+Q1-B11*x(12)*x(12)*cos(x(15)-x(15))-B12*x(12)*x(13)*cos(x(15)-x(16))-B13*x(12)*x(14)*cos(x(15)-x(17));
    x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(12)*sin(x(5)-x(16))+Q2-B21*x(13)*x(12)*cos(x(16)-x(15))-B22*x(13)*x(13)*cos(x(16)-x(16))-B23*x(13)*x(14)*cos(x(16)-x(17));
    Q3-B31*x(14)*x(12)*cos(x(17)-x(15))-B32*x(14)*x(13)*cos(x(17)-x(16))-B33*x(14)*x(14)*cos(x(17)-x(17));
    x(12)-1;
    x(13)-1;
    x(6)-1;
    x(7)-1];

%Solve
% x0=ones(17,1);
% x0=zeros(17,1);
x0=[-0.0477;-0.5021;0.0298;-0.0964;-0.4354;1;1;0.466;-0.1046;-0.05189;-0.3966;1;1;1;0;0.0093;-0.0217];
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out]=fsolve(f,x0,options);

%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B12 B13
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B21 B22 B23
syms P3 Q3 theta3 V3 B31 B32 B33


%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(4)=Ed1-V1*cos(theta1)*sin(delt1)+V1*sin(theta1)*cos(delt1)-Rs1*Id1+Xq_dash1*Iq1;
f1(5)=Eq1-V1*cos(theta1)*cos(delt1)-V1*sin(theta1)*sin(delt1)-Rs1*Iq1-Xd_dash1*Id1;
f1(6)=Id1*V1*sin(delt1-theta1)+Iq1*V1*cos(delt1-theta1)+P1-B11*V1*V1*sin(theta1-theta1)-B12*V1*V2*sin(theta1-theta2)-B13*V1*V3*sin(theta1-theta3);
f1(7)=Id1*V1*cos(delt1-theta1)-Iq1*V1*sin(delt1-theta1)+Q1-B11*V1*V1*cos(theta1-theta1)-B12*V1*V2*cos(theta1-theta2)-B13*V1*V3*cos(theta1-theta3);

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

%B Matrix
B = [1,0,0,0;0,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,1,0;0,0,0,1;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];

pol=eig(A,E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end

%I-Controllable
i_cont=(rank([E zeros(17,17) zeros(17,4);A E B])==rank(E)+size(A,1));
im_cont=(rank([E A B;zeros(17,17) E zeros(17,4)])==rank(E)+rank([E A B]));

%Admissibility
adm=(rank([s*E-A B E*xeq])==rank([s*E-A B]));
adm_ar=(rank([E A B])==rank([s*E-A B]));


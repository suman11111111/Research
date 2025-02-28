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
x1=[Eq1 Ed1 delt1 omega1 Id1 Iq1 V1 theta1];

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
f2(7)=Id2*V2*sind(delt2-theta2)+Iq2*V2*cos(delt2-theta2)+P2-B22*V2*V2*sin(theta2-theta2)-B28*V2*V8*sin(theta2-theta8);
f2(8)=Id2*V2*cosd(delt2-theta2)-Iq2*V2*sin(delt2-theta2)+Q2-B22*V2*V2*cos(theta2-theta2)-B28*V2*V8*cos(theta2-theta8);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Id2 Iq2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2];

%Differential Equation for 3rd bus
f3(1)=(-Eq3-(Xd3-Xd_dash3)*Id3+Efd3);
f3(2)=(-Ed3-(Xq3-Xq_dash3)*Iq3);
f3(3)=omega3;
f3(4)=TM3-Ed3*Id3-Eq3*Iq3-(Xq_dash3-Xd_dash3)*Id3*Iq3-D3*omega3;

%Algebraic Equation for 3rd bus
f3(5)=Ed3-V3*cos(theta3)*sin(delt3)+V3*sin(theta3)*cosd(delt3)-Rs3*Id3+Xq_dash3*Iq3;
f3(6)=Eq3-V3*cos(theta3)*cos(delt3)-V3*sin(theta3)*sind(delt3)-Rs3*Iq3-Xd_dash3*Id3;
f3(7)=Id3*V3*sin(delt3-theta3)+Iq3*V3*cos(delt3-theta3)+P3-B33*V3*V3*sin(theta3-theta3)-B36*V3*V6*sin(theta6-theta3);
f3(8)=Id3*V3*cos(delt3-theta3)-Iq3*V3*sin(delt3-theta3)+Q3-B33*V3*V3*cos(theta3-theta3)-B36*V3*V6*cos(theta6-theta3);

%States for 3rd bus
x3=[Eq3 Ed3 delt3 omega3 Id3 Iq3 V3 theta3];

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


Hs=[H1 H2 H3];
H=[23.64 6.4 3.01];

Eqs=[Eq1 Eq2 Eq3];
Eq=[-0.1051 -1.0322 -0.9152];

Eds=[Ed1 Ed2 Ed3];
Ed=[0 -0.7946 -0.6569];

Vs=[V1 V2 V3 V4 V5 V6 V7 V8 V9];
V=[1 1 1 0.9934 0.9913 1.0017 0.9877 0.9923 0.9736];

delts=[delt1 delt2 delt3];
delt=[-0.0640 -0.9368 -0.8653];

omegas=[omega1 omega2 omega3];
omega=[1 1 1];

Ds=[D1 D2 D3];
D=[0.1 0.15 0.18];

Ids=[Id1 Id2 Id3];
Id=[-0.6768 -1.1328 -0.5456];

Iqs=[Iq1 Iq2 Iq3];
Iq=[0.0840 -1.1903 -0.6518];

Rss=[Rs1 Rs2 Rs3];
Rs=[0 0 0];

Xds=[Xd1 Xd2 Xd3];
Xd=[0.146 0.8958 1.3125];

Xqs=[Xq1 Xq2 Xq3];
Xq=[0.0969 0.8645 1.2578];

Xd_dashs=[Xd_dash1 Xd_dash2 Xd_dash3];
Xd_dash=[0.0608 0.1198 0.1813];

Xq_dashs=[Xq_dash1 Xq_dash2 Xq_dash3];
Xq_dash=[0.0969 0.1969 0.25];

Tdos=[Tdo1 Tdo2 Tdo3];
Tdo=[8.96 6 5.89];

Tqos=[Tqo1 Tqo2 Tqo3];
Tqo=[0.31 0.535 0.6];

Ps=[P1 P2 P3 P4 P5 P6 P7 P8 P9];
P=[0.6700 1.6300 0.8500 0 0.9000 0 1.0000 0 1.2500];

Qs=[Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9];
Q=[0.1271 0.2075 -0.0073 0 0.3000 0 0.3500 0 0.5000];

thetas=[theta1 theta2 theta3 theta4 theta5 theta6 theta7 theta8 theta9];
theta=[0 10.0225 5.1349 -2.2264 -3.7546 2.2846 0.9099 4.1297 -4.1633];
theta=deg2rad(theta);

B1xs=[B11 B14];
B1x=[-17.3611 17.3611];

B2xs=[B22 B28];
B2x=[-16.0000 16.0000];

B3s=[B33 B36];
B3=[-17.0648 17.0648];

B4s=[B41 B44 B45 B49];
B4=[17.3611 -39.8284 10.8696 11.7647];

B5s=[B54 B55 B56];
B5=[10.8696 -16.4939 5.8824];

B6s=[B63 B65 B66 B67];
B6=[17.0648 5.8824 -32.5843 9.9206];

B7s=[B76 B77 B78];
B7=[9.9206 -23.6305 13.8889];

B8s=[B82 B87 B88 B89];
B8=[16.0000 13.8889 -35.8726 6.2112];

B9s=[B94 B98 B99];
B9=[11.7647 6.2112 -17.7349];

E=subs(E,[Tdos Tqos Hs omega_s],[Tdo Tqo H 1]);
E=double(E);
A11=subs(A11,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1xs B2xs B3s B4s B5s B6s B7s B8s B9s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1x B2x B3 B4 B5 B6 B7 B8 B9]);
A11=double(A11);
A12=subs(A12,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1xs B2xs B3s B4s B5s B6s B7s B8s B9s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1x B2x B3 B4 B5 B6 B7 B8 B9]);
A12=double(A12);
A21=subs(A21,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1xs B2xs B3s B4s B5s B6s B7s B8s B9s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1x B2x B3 B4 B5 B6 B7 B8 B9]);
A21=double(A21);
A22=subs(A22,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1xs B2xs B3s B4s B5s B6s B7s B8s B9s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1x B2x B3 B4 B5 B6 B7 B8 B9]);
A22=double(A22);
B1=double(B1);
B2=double(B2);

A=[A11 A12;A21 A22];
B=[B1;B2];

%Poles of the system
pol=eig(A,E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end

%Impulse free

%im_free=(polynomialDegree(det(s*E-A))==rank(E));

im_free=(rank([E zeros(36,36);A E])==rank(E)+rank(A));

%I-Controllable

i_cont=(rank([E zeros(36,36) zeros(36,6);A E B])==rank(E)+rank(A));

%R-Controllable

r_cont=(rank([s*E-A,B])==36);

% [P,Q]=findPQ(E,blkdiag(eye(12,12),zeros(24,24)));
% 
% E_tilde=P*E*Q;
% A_tilde=P*A*Q;
% B_tilde=Q*B;

% [~,K,~]=icare(A,B,eye(36),1,[],E,-B*B')




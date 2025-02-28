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
[E,A,B]=ieee9_jacobian(); 

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
D=[0.1 0.1 0.1];

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

B1s=[B11 B14];
B1=[-17.3611 17.3611];

B2s=[B22 B28];
B2=[-16.0000 16.0000];

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

E=subs(E,[Tdo1 Tqo1 Tdo2 Tqo2 Tdo3 Tqo3 H1 H2 H3 omega_s],[8.96 0.31 6.0 0.535 5.89 0.6 23.64 6.4 3.01 1]);
E=double(E);
A=subs(A,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos Ps Qs thetas B1s B2s B3s B4s B5s B6s B7s B8s B9s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo P Q theta B1 B2 B3 B4 B5 B6 B7 B8 B9]);
A=double(A);
%det(s*E-A)
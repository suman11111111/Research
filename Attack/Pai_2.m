clc,clear
%Defining of Symbolic Variables for each bus
syms s
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
[E,A,B]=Pai_Jacobian(); 
E=subs(E,[Tdo1 Tqo1 Tdo2 Tqo2 Tdo3 Tqo3 H1 H2 H3 omega_s],[8.96 0.31 6.0 0.535 5.89 0.6 23.64 6.4 3.01 1]);
A=subs(A,[Eq1 Eq2 Eq3 Ed1 Ed2 Ed3 delt1 delt2 delt3 omega1 omega2 omega3 Id1 Id2 Id3 Iq1 Iq2 Iq3 P1 P2 P3 Q1 Q2 Q3 B11 B14 B22 B27 B33 B39 B44 B45 B46 B55 B57 B64 B65 B66 B72 B75 B77 B78 B87 B88 B89 B93 B96 B98 B99],[1.058 0.788 0.768 0 0.622 0.624 3.58 61.1 54.2 1 1 1 0.302 1.29 0.562 0.671 0.931 0.619 0.716 1.63 0.85 0.27 0.067 -0.019 -17.361 17.361 -16 16]);
det(s*E-A)
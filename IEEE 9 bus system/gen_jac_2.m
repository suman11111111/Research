clc,clear all

%Defining of Symbolic Variables for each bus
syms s
syms omega_s
syms Eq Ed delt omega Id Iq Pg Qg theta_g Vg Pl Ql theta_l Vl Efd H TM D Td0 Tq0 Rs Xq Xd Xd_dash Xq Xq_dash Bm Bnm

%Differential Equations
f(1)=(-Eq-(Xd-Xd_dash).*Id+Efd);
f(2)=(-Ed-(Xq-Xq_dash).*Iq);
f(3)=omega;
f(4)=TM-Ed.*Id-Eq.*Iq-(Xq_dash-Xd_dash).*Id.*Iq-D.*omega;

%Algebraic Equations
f(5)=Ed-Vg.*cos(theta_g).*sin(delt)+Vg.*sin(theta_g).*cos(delt)-Rs.*Id+Xq_dash.*Iq;
f(6)=Eq-Vg.*cos(theta_g).*cos(delt)+Vg.*sin(theta_g)*sin(delt)-Rs*Iq-Xd_dash*Id;
f(7)=(Id.*sin(delt)+Iq.*cos(delt))+Vg.\Pg.*cos(theta_g)+Vl.\Pl.*cos(theta_l)+Vg.\Qg.*sin(theta_g)+Vl.\Ql.*sin(theta_l)+Bm.*kron(ones(1,1),(Vg.*sin(theta_g))')+Bnm.*kron(ones(1,1),(Vl.*sin(theta_l))');
f(8)=(Iq.*sin(delt)-Id.*cos(delt))+Vg.\Pg.*sin(theta_g)+Vl.\Pl.*sin(theta_l)-Vg.\Qg.*cos(theta_g)-Vl.\Ql.*cos(theta_l)+Bm.*kron(ones(1,1),(Vg.*cos(theta_g))')+Bnm.*kron(ones(1,1),(Vl.*cos(theta_l))');
f(9)=Vg.\Pg.*cos(theta_g)+Vl.\Pl.*cos(theta_l)+Vg.\Qg.*sin(theta_g)+Vl.\Ql.*sin(theta_l)+Bm.*kron(ones(1,1),(Vg.*sin(theta_g))')+Bnm.*kron(ones(1,1),(Vl.*sin(theta_l))');
f(10)=Vg.\Pg.*sin(theta_g)+Vl.\Pl.*sin(theta_l)-Vg.\Qg.*cos(theta_g)-Vl.\Ql.*cos(theta_l)+Bm.*kron(ones(1,1),(Vg.*cos(theta_g))')+Bnm.*kron(ones(1,1),(Vl.*cos(theta_l))');

fd=[f(1),f(2),f(3),f(4)];
fa=[f(5),f(6),f(7),f(8),f(9),f(10)];

%States
xd=[Eq Ed delt omega];
xa=[Iq Id Vg theta_g Vl theta_l];

%Input
u=[TM Efd];

%Jacobian
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);

A=[A11 A12;A21 A22];
E=diag([Td0;Tq0;ones(1,1);2.*H./omega_s;zeros(1,1);zeros(1,1);zeros(1,1);zeros(1,1);zeros(1,1);zeros(1,1)]);


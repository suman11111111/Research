clc,clear

N=1; %Total number of buses

%Defining of Symbolic Variables for each bus
syms s
syms omega_s
syms Eq Ed delt omega Id Iq P Q theta V Efd H TM D Td0 Tq0 Rs Xq Xd Xd_dash Xq Xq_dash B

%Differential Equations
f(1)=(-Eq-(Xd-Xd_dash).*Id+Efd);
f(2)=(-Ed-(Xq-Xq_dash).*Iq);
f(3)=omega;
f(4)=TM-Ed.*Id-Eq.*Iq-(Xq_dash-Xd_dash).*Id.*Iq-D.*omega;

%Algebraic Equations
f(5)=Ed-V.*cos(theta).*sin(delt)+V.*sin(theta).*cos(delt)-Rs.*Id+Xq_dash.*Iq;
f(6)=Eq-V.*cos(theta).*cos(delt)+V.*sin(theta)*sin(delt)-Rs*Iq-Xd_dash*Id;
f(7)=(Id.*sin(delt)+Iq.*cos(delt))+V.\P.*cos(theta)+V.\Q.*sin(theta)+B.*kron(ones(N,1),(V.*sin(theta))');
f(8)=(Iq.*sin(delt)-Id.*cos(delt))+V.\P.*sin(theta)-V.\Q.*cos(theta)+B.*kron(ones(N,1),(V.*cos(theta))');

fd=[f(1),f(2),f(3),f(4)];
fa=[f(5),f(6),f(7),f(8)];

%States
xd=[Eq Ed delt omega];
xa=[Iq Id V theta];

%Input
u=[TM Efd];

%Jacobian
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);

A=[A11 A12;A21 A22];
E=diag([Td0;Tq0;ones(N,1);2.*H./omega_s;zeros(N,1);zeros(N,1);zeros(N,1);zeros(N,1)]);

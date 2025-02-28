clc,clear

m=3;
n=9;

%Defining of Symbolic Variables
syms s
syms omega_s
syms Eq Ed delt omega Id Iq Pg Qg theta_g Vg Pl Ql theta_l Vl Efd H TM D Td0 Tq0 Rs Xq Xd Xd_dash Xq Xq_dash Bgg Bgl Blg Bll

%Creating array for each parameter

Eq=sym('Eq',[m 1]);
Ed=sym('Ed',[m 1]);
delt=sym('delt',[m 1]);
omega=sym('omega',[m 1]);
Id=sym('Id',[m 1]);
Iq=sym('Iq',[m 1]);
Vg=sym('Vg',[m 1]);
Vl=sym('Vl',[n-m 1]);
theta_g=sym('theta_g',[m 1]);
theta_l=sym('theta_l',[n-m 1]);
Efd=sym('Efd',[m 1]);
H=sym('H',[m 1]);
TM=sym('TM',[m 1]);
D=sym('D',[m 1]);
Tdo=sym('Tdo',[m 1]);
Tqo=sym('Tqo',[m 1]);
Rs=sym('Rs',[m 1]);
Xq=sym('Xq',[m 1]);
Xq_dash=sym('Xq_dash',[m 1]);
Xd=sym('Xd',[m 1]);
Xd_dash=sym('Xd_dash',[m 1]);
Bgg=sym('Bgg',[m m]);
Blg=sym('Blg',[n-m m]);
Bgl=sym('Bgl',[m n-m]);
Bll=sym('Bll',[n-m n-m]);
Pg=sym('Pg',[m 1]);
Qg=sym('Qg',[m 1]);
Pl=sym('Pl',[n-m 1]);
Ql=sym('Ql',[n-m 1]);

%Differential Equations
f1(1:m)=(-Eq-(Xd-Xd_dash).*Id+Efd);
f2(1:m)=(-Ed-(Xq-Xq_dash).*Iq);
f3(1:m)=omega;
f4(1:m)=TM-Ed.*Id-Eq.*Iq-(Xq_dash-Xd_dash).*Id.*Iq-D.*omega;

%Algebraic Equations
f5(1:m)=Ed-Vg.*cos(theta_g).*sin(delt)+Vg.*sin(theta_g).*cos(delt)-Rs.*Id+Xq_dash.*Iq;
f6(1:m)=Eq-Vg.*cos(theta_g).*cos(delt)+Vg.*sin(theta_g).*sin(delt)-Rs.*Iq-Xd_dash.*Id;
f7(1:m)=(Id.*sin(delt)+Iq.*cos(delt))+Vg.\Pg.*cos(theta_g)+Vg.\Qg.*sin(theta_g)+Bgg*(Vg.*sin(theta_g))+Bgl*(Vl.*sin(theta_l));
f8(1:m)=(Iq.*sin(delt)-Id.*cos(delt))+Vg.\Pg.*sin(theta_g)-Vg.\Qg.*cos(theta_g)+Bgg*(Vg.*cos(theta_g))+Bgl*(Vl.*cos(theta_l));
f9(1:n-m)=Vl.\Pl.*cos(theta_l)+Vl.\Ql.*sin(theta_l)+Blg*(Vg.*sin(theta_g))+Bll*(Vl.*sin(theta_l));
f10(1:n-m)=Vl.\Pl.*sin(theta_l)-Vl.\Ql.*cos(theta_l)+Blg*(Vg.*cos(theta_g))+Bll*(Vl.*cos(theta_l));


fd=[f1,f2,f3,f4];
fa=[f5,f6,f7,f8,f9,f10];

%States
xd=[Eq;Ed;delt;omega];
xa=[Iq;Id;Vg;theta_g;Vl;theta_l];

%Input
u=[TM;Efd];

%Jacobian
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);





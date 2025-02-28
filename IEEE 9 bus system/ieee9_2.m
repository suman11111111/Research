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
f5(1:m)=Ed-Vg.*delt+Vg.*theta_g-Rs.*Id+Xq_dash.*Iq;
f6(1:m)=Eq-Vg+Vg.*theta_g.*delt-Rs.*Iq-Xd_dash.*Id;
f7(1:m)=(Id.*delt+Iq)+Vg.\Pg+Vg.\Qg.*theta_g+Bgg*(Vg.*theta_g)+Bgl*(Vl.*theta_l);
f8(1:m)=(Iq.*delt-Id)+Vg.\Pg.*theta_g-Vg.\Qg+Bgg*(Vg.*ones(m,1))+Bgl*(Vl.*ones(n-m,1));
f9(1:n-m)=Vl.\Pl+Vl.\Ql.*theta_l+Blg*(Vg.*theta_g)+Bll*(Vl.*theta_l);
f10(1:n-m)=Vl.\Pl.*theta_l-Vl.\Ql+Blg*(Vg.*ones(m,1))+Bll*(Vl.*ones(n-m,1));


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



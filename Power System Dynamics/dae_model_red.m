clear,clc

m=2;
n=3;

%Defining of Symbolic Variables

syms delt omega Pg theta_g Pl theta_l PM D M Xd Bgg Bgl Blg Bll

%Creating array for each parameter

delt=sym('delt',[m 1]);
omega=sym('omega',[m 1]);
theta_g=sym('theta_g',[m 1]);
theta_l=sym('theta_l',[n-m 1]);
PM=sym('PM',[m 1]);
D=sym('D',[m 1]);
M=sym('M',[m 1]);
Xd=sym('Xd',[m 1]);
Bgg=sym('Bgg',[m m]);
Blg=sym('Blg',[n-m m]);
Bgl=sym('Bgl',[m n-m]);
Bll=sym('Bll',[n-m n-m]);
Pg=sym('Pg',[m 1]);
Pl=sym('Pl',[n-m 1]);

%Differential Equations
f1(1:m-1)=omega(2:m);
f2(1:m)=M.\(PM-(delt-theta_g)./Xd-D.*omega);

%Algebraic Equations
f3(1:m)=Pg-(delt-theta_g)./Xd+Bgg*theta_g+Bgl*theta_l;
f4(1:n-m)=Pl+Blg*theta_g+Bll*theta_l;

fd=[f1,f2];
fa=[f3,f4];

%States
xd=[delt(2:m);omega];
xa=[theta_g;theta_l];

%Input
u=[PM];

%Jacobian
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);

%Substitution
A11=double(subs(A11,{D(1),D(2),M(1),M(2),Xd(2)},{0.0081,0.0057,0.0407,0.0192,0.1813}));
A12=double(subs(A12,{M(1),M(2),Xd(1),Xd(2)},{0.0407,0.0192,0.1198,0.1813}));
A21=double(subs(A21,{Xd(2)},{0.1813}));
A22=double(subs(A22,{Xd(1),Xd(2),Bgg(1,1),Bgg(1,2),Bgg(2,1),Bgg(2,2),Bgl(1),Bgl(2),Blg(1),Blg(2),Bll(1)},{0.1198,0.1813,15.7600,-9.7840,-9.7840,15.3720,-5.9760,-5.5880,-5.9760,-5.5880,11.5640}));
B1=double(subs(B1,{M(1),M(2)},{0.0407,0.0192}));

%Ode Equivalent
A_ode=A11-A12*inv(A22)*A21;
B_ode=B1;

%Feedback Design
p=[-1,-3,-5];
K=place(A_ode,B_ode,p)

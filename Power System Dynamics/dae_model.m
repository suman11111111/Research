clear

m=2;
n=3;

%Defining of Symbolic Variables

syms delt omega Pg theta_g Pl theta_l PM D Xd Bgg Bgl Blg Bll

%Creating array for each parameter

delt=sym('delt',[m 1]);
omega=sym('omega',[m 1]);
theta_g=sym('theta_g',[m 1]);
theta_l=sym('theta_l',[n-m 1]);
PM=sym('PM',[m 1]);
D=sym('D',[m 1]);
Xd=sym('Xd',[m 1]);
Bgg=sym('Bgg',[m m]);
Blg=sym('Blg',[n-m m]);
Bgl=sym('Bgl',[m n-m]);
Bll=sym('Bll',[n-m n-m]);
Pg=sym('Pg',[m 1]);
Pl=sym('Pl',[n-m 1]);

A11

% M=diag([0.0407; 0.0192]);
% D=diag([0.0081; 0.0057]);
% Xd=diag([0.1198; 0.1813]);
% B11=[15.7600 -9.7840;-9.7840 15.3720];
% B12=[-5.9760;-5.5880];
% B21=[-5.9760 -5.5880];
% B22=[11.5640];







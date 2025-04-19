clc,clear,close all

% Initialization of states
eq1_0=0.0021;
eq2_0=0.0903;
ed1_0=1.0188;
ed2_0=1.0982;
delta1_0=0.0021;
delta2_0=0.0820;
omega1_0=1;
omega2_0=1;
id1_0=0.0670;
id2_0=0.3990;
iq1_0=0.0473;
iq2_0=-0.1036;
v1_0=1;
v2_0=1;
v3_0=0.9905;
theta1_0=0;
theta2_0=0.0093;
theta3_0=-0.0217;


% Initial guess vector
x0=[eq1_0;eq2_0;ed1_0;ed2_0;delta1_0;delta2_0;omega1_0;omega2_0;id1_0;id2_0;iq1_0;iq2_0;v1_0;v2_0;v3_0;theta1_0;theta2_0;theta3_0];

% Solving for Equilibrium Points
options = optimset('Algorithm', 'trust-region','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 10000000);

[xeq,fval,flag,out,J]=fsolve(@(x) psdyn(x),x0,options);

% Displaying the equilibrium point using descriptive variable names
eq1_eq = xeq(1);
eq2_eq = xeq(2);
ed1_eq = xeq(3);
ed2_eq = xeq(4);
delta1_eq = xeq(5);
delta2_eq = xeq(6);
omega1_eq = xeq(7);
omega2_eq = xeq(8);
id1_eq = xeq(9);
id2_eq = xeq(10);
iq1_eq = xeq(11);
iq2_eq = xeq(12);
v1_eq = xeq(13);
v2_eq = xeq(14);
v3_eq = xeq(15);
theta1_eq = xeq(16);
theta2_eq = xeq(17);
theta3_eq = xeq(18);

disp('Equilibrium Point:');
fprintf('eq1 = %f\n', eq1_eq);
fprintf('eq2 = %f\n', eq2_eq);
fprintf('ed1 = %f\n', ed1_eq);
fprintf('ed2 = %f\n', ed2_eq);
fprintf('delta1 = %f\n', rad2deg(delta1_eq));
fprintf('delta2 = %f\n', rad2deg(delta2_eq));
fprintf('omega1 = %f\n', omega1_eq);
fprintf('omega2 = %f\n', omega2_eq);
fprintf('id1 = %f\n', id1_eq);
fprintf('id2 = %f\n', id2_eq);
fprintf('iq1 = %f\n', iq1_eq);
fprintf('iq2 = %f\n', iq2_eq);
fprintf('v1 = %f\n', v1_eq);
fprintf('v2 = %f\n', v2_eq);
fprintf('v3 = %f\n', v3_eq);
fprintf('theta1 = %f\n', rad2deg(theta1_eq));
fprintf('theta2 = %f\n', rad2deg(theta2_eq));
fprintf('theta3 = %f\n', rad2deg(theta3_eq));


%Ref Angular Frequency
omega_ref=1;

%Inertia
H1=6.4;
H2=3.01;

H=[H1;H2];

%Time Constant of d-axis
Tdo1=6;
Tdo2=5.89;

Tdo=[Tdo1;Tdo2];

%Time Constant of q-axis
Tqo1=0.535; 
Tqo2=0.6;

Tqo=[Tqo1;Tqo2];

par=[omega_ref;H;Tdo;Tqo];

%E Matrix
E=E(par);

%Finite Poles
fin_pol=fin_pol(J,E);

disp('Finite Poles:');
for i=1:size(fin_pol,1)
    fprintf('%f\n', fin_pol(i));
end
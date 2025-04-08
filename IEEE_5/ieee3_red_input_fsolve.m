clc,clear,close all

%Ref Angular Frequency
omega_ref=1;

%Field Axis Emf
Efd1=0.788;
Efd2=0.74;

%Mechanical Power Input
TM1=0.2;
TM2=0.25;

%Inertia
H1=6.4;
H2=3.01;

%Damping
D1=0.7;
D2=0.5;

%Stator Resistance
Rs1=0;
Rs2=0;

%daxis Stator Reactance
Xd1=0.8958;
Xd2=1.3125;

%qaxis Stator Reactance
Xq1=0.8645;
Xq2=1.2578;

%daxis Stator Transient Reactance
Xd_dash1=0.1198;
Xd_dash2=0.1813;

%qaxis Stator Transient Reactance
Xq_dash1=0.1969;
Xq_dash2=0.25;

%Time Constant of d-axis
Tdo1=6;
Tdo2=5.89;

%Time Constant of q-axis
Tqo1=0.535; 
Tqo2=0.6;

%B-Bus Matrix
B=[-0.25 0.1 0.15;0.1 -0.2 0.1;0.15 0.1 -0.25];

%Active Power Demand
P1=0.2;
P2=0.25;
P3=0.45;

%Reactive Power Demand
Q1=0.0657;
Q2=0.0981;
Q3=0.15;

% Initialization of states

eq1_0=-0.1864;
eq2_0=-0.3179;
ed1_0=0.0217;
ed2_0=0.0273;
delta2_0=-0.0279;
omega1_0=1;
omega2_0=1;
id1_0=-0.2080;
id2_0=-0.2672;
iq1_0=0.0325;
iq2_0=-0.0271;
v1_0=1;
v2_0=1;
v3_0=0.9905;
theta1_0=0;
theta2_0=-0.0014;
theta3_0=-0.0281;
efd1_0=0.788;
efd2_0=0.74;
tm1_0=0.2;
tm2_0=0.25;

% Initial guess vector
x0=[eq1_0;eq2_0;ed1_0;ed2_0;delta2_0;omega1_0;omega2_0;id1_0;id2_0;iq1_0;iq2_0;v1_0;v2_0;v3_0;theta1_0;theta2_0;theta3_0;efd1_0;efd2_0];

%Defining Function with 'states' as the input variable
f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(8)+x(18));
    (-x(2)-(Xd2-Xd_dash2)*x(9)+x(19));
    (-x(3)+(Xq1-Xq_dash1)*x(10));
    (-x(4)+(Xq2-Xq_dash2)*x(11));
    x(7)-x(6);
    TM1-x(3)*x(8)-x(1)*x(10)-(Xq_dash1-Xd_dash1)*x(8)*x(10)-D1*(x(6)-omega_ref);
    TM2-x(4)*x(9)-x(2)*x(11)-(Xq_dash2-Xd_dash2)*x(9)*x(11)-D2*(x(7)-omega_ref);
    x(3)+x(12)*sin(x(15))-Rs1*x(8)+Xq_dash1*x(10);
    x(4)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs2*x(9)+Xq_dash2*x(11);
    x(1)-x(12)*cos(x(15))-Rs1*x(10)-Xd_dash1*x(8);
    x(2)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs2*x(11)-Xd_dash2*x(9);
    x(8)*x(12)*sin(-x(15))+x(10)*x(12)*cos(-x(15))+P1-B(1,1)*x(12)*x(12)*sin(x(15)-x(15))-B(1,2)*x(12)*x(13)*sin(x(15)-x(16))-B(1,3)*x(12)*x(14)*sin(x(15)-x(17));
    x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+P2-B(2,1)*x(13)*x(12)*sin(x(16)-x(15))-B(2,2)*x(13)*x(13)*sin(x(16)-x(16))-B(2,3)*x(13)*x(14)*sin(x(16)-x(17));
    P3-B(3,1)*x(14)*x(12)*sin(x(17)-x(15))-B(3,2)*x(14)*x(13)*sin(x(17)-x(16))-B(3,2)*x(14)*x(14)*sin(x(17)-x(17));
    x(8)*x(12)*cos(-x(15))-x(10)*x(12)*sin(-x(15))+Q1-B(1,1)*x(12)*x(12)*cos(x(15)-x(15))-B(1,2)*x(12)*x(13)*cos(x(15)-x(16))-B(1,3)*x(12)*x(14)*cos(x(15)-x(17));
    x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(12)*sin(x(5)-x(16))+Q2-B(2,1)*x(13)*x(12)*cos(x(16)-x(15))-B(2,2)*x(13)*x(13)*cos(x(16)-x(16))-B(2,3)*x(13)*x(14)*cos(x(16)-x(17));
    Q3-B(3,1)*x(14)*x(12)*cos(x(17)-x(15))-B(3,2)*x(14)*x(13)*cos(x(17)-x(16))-B(3,3)*x(14)*x(14)*cos(x(17)-x(17));
    ];

%Solving for Equilibrium Points
% options = optimset('Algorithm', 'trust-region','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 10000000);
[xeq,fval,flag,out,J]=fsolve(f,x0);

% Displaying the equilibrium point using descriptive variable names
eq1_eq = xeq(1);
eq2_eq = xeq(2);
ed1_eq = xeq(3);
ed2_eq = xeq(4);
delta2_eq = xeq(5);
omega1_eq = xeq(6);
omega2_eq = xeq(7);
id1_eq = xeq(8);
id2_eq = xeq(9);
iq1_eq = xeq(10);
iq2_eq = xeq(11);
v1_eq = xeq(12);
v2_eq = xeq(13);
v3_eq = xeq(14);
theta1_eq = xeq(15);
theta2_eq = xeq(16);
theta3_eq = xeq(17);
efd1_eq = xeq(18);
efd2_eq = xeq(19);

disp('Equilibrium Point:');
fprintf('eq1 = %f\n', eq1_eq);
fprintf('eq2 = %f\n', eq2_eq);
fprintf('ed1 = %f\n', ed1_eq);
fprintf('ed2 = %f\n', ed2_eq);
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
fprintf('efd1 = %f\n', efd1_eq);
fprintf('efd2 = %f\n', efd2_eq);

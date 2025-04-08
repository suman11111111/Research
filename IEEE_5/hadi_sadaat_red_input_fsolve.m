clc,clear,close all

%Ref Angular Frequency
omega_ref=1;

%Field Axis Emf
Efd1=0.788;
Efd2=0.74;

%Mechanical Power Input
TM1=2;
TM2=2;

%Inertia
H1=6.4;
H2=3.01;

%Damping
D1=0.5;
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
P1=2;
P2=2;
P3=4;

%Reactive Power Demand
Q1=2.0845;
Q2=2.0845;
Q3=2.5;

% Initialization of states

eq1_0=-0.8602;
eq2_0=-1.0839;
ed1_0=0.4832;
ed2_0=0.5756;
delta2_0=0;
omega1_0=1;
omega2_0=1;
id1_0=-2.7967;
id2_0=-2.8318;
iq1_0=0.7237;
iq2_0=0.5711;
v1_0=1;
v2_0=1;
v3_0=0.8164;
theta1_0=0;
theta2_0=0;
theta3_0=-0.2475;
efd1_0=3;
efd2_0=3;


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
options = optimset('Algorithm', 'trust-region','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 10000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);
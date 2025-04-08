clc,clear,close all

%Ref Angular Frequency
omega_ref=1;

%Field Axis Emf
Efd1=-0.0880;
Efd2=-0.9411;

%Mechanical Power Input
TM1=0.05;
TM2=0.4;

%Inertia
H1=6.4;
H2=3.01;

%Damping
D1=0.3;
D2=0.3;

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
P1=0.05;
P2=0.4;
P3=0.45;

%Reactive Power Demand
Q1=0.0651;
Q2=0.0999;
Q3=0.15;

%Defining States in Terms of x
eq1=x(1);
eq2=x(2);
ed1=x(3);
ed2=x(4);
delta1=x(5);
delta2=x(6);
omega1=x(7);
omega2=x(8);
id1=x(9);
id2=x(10);
iq1=x(11);
iq2=x(12);
v1=x(13);
v2=x(14);
v3=x(15);
theta1=x(16);
theta2=x(17);
theta3=x(18);

%Machine Voltage
VD1=v1*cos(theta1);
VQ1=v1*sin(theta1);

VD2=v2*cos(theta2);
VQ2=v2*sin(theta2);

%Defining Function
f=@(x)[-eq1-(Xd1-Xd_dash1)*id1+Efd1;
       -eq2-(Xd2-Xd_dash2)*id2+Efd2;
       -ed1+(Xq1-Xq_dash1)*iq1;
       -ed2+(Xq2-Xq_dash2)*iq2;
       omega1-omega_ref;
       omega2-omega_ref;
       TM1-ed1*id1-eq1*iq1-(Xq_dash1-Xd_dash1)*id1*iq1-D1*(omega1-omega_ref);
       TM2-ed2*id2-eq2*iq2-(Xq_dash2-Xd_dash2)*id2*iq2-D2*(omega2-omega_ref);
       ed1-VD1*sin(delta1)+VQ1*cos(delta1)-Rs1*id1+Xq_dash1*iq1;
       ed2-VD2*sin(delta2)+VQ2*cos(delta2)-Rs2*id2+Xq_dash2*iq2;
       eq1-VD1*cos(delta1)-VQ1*sin(delta1)-Rs1*iq1-Xd_dash1*id1;       
       eq2-VD2*cos(delta2)-VQ2*sin(delta2)-Rs2*iq2-Xd_dash2*id2;
       id1*v1*sin(delta1-theta1)+iq1*v1*cos(delta1-theta1)+P1-v1*v1*B(1,1)*sin(theta1-theta1)-v1*v2*B(1,2)*sin(theta1-theta2)-v1*v3*B(1,3)*sin(theta1-theta3);
       id2*v2*sin(delta2-theta2)+iq2*v2*cos(delta2-theta2)+P2-v2*v1*B(2,1)*sin(theta2-theta1)-v2*v2*B(2,2)*sin(theta2-theta2)-v2*v3*B(2,3)*sin(theta2-theta3);
       P3-v3*v1*B(3,1)*sin(theta3-theta1)-v3*v2*B(3,2)*sin(theta3-theta2)-v3*v3*B(3,3)*sin(theta3-theta3);
       id1*v1*cos(delta1-theta1)-iq1*v1*sin(delta1-theta1)+Q1-v1*v1*B(1,1)*cos(theta1-theta1)-v1*v2*B(1,2)*cos(theta1-theta2)-v1*v3*B(1,3)*cos(theta1-theta3);
       id2*v2*cos(delta2-theta2)-iq2*v2*sin(delta2-theta2)+Q2-v2*v1*B(2,1)*cos(theta2-theta1)-v2*v2*B(2,2)*cos(theta2-theta2)-v2*v3*B(2,3)*cos(theta2-theta3);
       Q3-v3*v1*B(3,1)*cos(theta3-theta1)-v3*v2*B(3,2)*cos(theta3-theta2)-v3*v3*B(3,3)*cos(theta3-theta3);
    ];


%Initialization of states
eq1_0=-0.0472;
eq2_0=-0.4819;
ed1_0=0.0421;
ed2_0=-0.0726;
delta1_0=-0.0409;
delta2_0=-0.4204;
omega1_0=1;
omega2_0=1;
id1_0=-0.0526;
id2_0=-0.4059;
iq1_0=0.0630;
iq2_0=-0.0721;
v1_0=1;
v2_0=1;
v3_0=0.9905;
theta1_0=0;
theta2_0=0.0093;
theta3_0=-0.0217;

x0=[eq1_0;eq2_0;ed1_0;ed2_0;delta1_0;delta2_0;omega1_0;omega2_0;id1_0;id2_0;iq1_0;iq2_0;v1_0;v2_0;v3_0;theta1_0;theta2_0;theta3_0];
%Solving for Equilibrium Points
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out,J]=fsolve(f,x0);

eq1_eq=xeq(1)
eq2_eq=xeq(2)
ed1_eq=xeq(3)
ed2_eq=xeq(4)
delta1_eq=xeq(5)
delta2_eq=xeq(6)
omega1_eq=xeq(7)
omega2_eq=xeq(8)
id1_eq=xeq(9)
id2_eq=xeq(10)
iq1_eq=xeq(11)
iq2_eq=xeq(12)
v1_eq=xeq(13)
v2_eq=xeq(14)
v3_eq=xeq(15)
theta1_eq=xeq(16)
theta2_eq=xeq(17)
theta3_eq=xeq(18)


clc,clear,close all

%Ref Angular Frequency
omega_ref=1;

%Field Axis Emf
Efd1=0.8;
Efd2=0.8;

%Mechanical Power Input
TM1=0.2;
TM2=0.25;

%Inertia
H1=6.4;
H2=3.01;

%Damping
D1=0.2;
D2=0.2;

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

% %Active Power Demand
% P1=0.2;
% P2=0.25;
% P3=0.45;

%Reactive Power Demand
Q1=0.1194;
Q2=0.1304;
Q3=0.15;

% Initialization of states

eq1_0=-0.1864;
eq2_0=-0.3179;
ed1_0=0.0217;
ed2_0=0.0273;
delta1_0=-0.1622;
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
efd1_0=0.3478;
efd2_0=0.6202;
tm1_0=0.0111;
tm2_0=-0.0018;

% Consistent Initial Conditions
eq1_0=1.781266;
eq2_0=1.145919;
ed1_0=-0.001078;
ed2_0=0.002425;
delta1_0=-0.0537;
delta2_0=-0.0316;
omega1_0=1;
omega2_0=1;
id1_0=-0.297229;
id2_0=-0.092050;
iq1_0=-0.001615;
iq2_0=0.002406;
v1_0=1.816875;
v2_0=1.162612;
v3_0=0.709778;
theta1_0=-0.0529;
theta2_0=-0.0342;
theta3_0=-0.0473;
efd1_0=1.550617;
efd2_0=1.041792;
tm1_0=1.550617;
tm2_0=1.041792;

% Initial guess vector
x0=[eq1_0;eq2_0;ed1_0;ed2_0;delta1_0;delta2_0;omega1_0;omega2_0;id1_0;id2_0;iq1_0;iq2_0;v1_0;v2_0;v3_0;theta1_0;theta2_0;theta3_0;efd1_0;efd2_0;tm1_0;tm2_0];

%Defining Function with 'states' as the input variable
f=@(x)[%-Eq1-(Xd1-Xd'1)*Id1+Efd1

        -x(1)-(Xd1-Xd_dash1)*x(9)+x(19);

        %-Eq2-(Xd2-Xd'2)*Id2+Efd2

       -x(2)-(Xd2-Xd_dash2)*x(10)+x(20);

       %-Ed1+(Xq1-Xq'1)*Iq1

       -x(3)+(Xq1-Xq_dash1)*x(11);

       %-Ed2+(Xq2-Xq'2)*Iq2

       -x(4)+(Xq2-Xq_dash2)*x(12);

       %omega1-omega_ref

       x(7)-omega_ref;

       %omega2-omega_ref

       x(8)-omega_ref;

       %TM1-Ed1*Id1-Eq1*Iq1-(Xq'1-Xd'1)*Id1*Iq1-D1*(omega1-omega_ref)

       x(21)-x(3)*x(9)-x(1)*x(11)-(Xq_dash1-Xd_dash1)*x(9)*x(11)-D1*(x(7)-omega_ref);

       %TM2-Ed2*Id2-Eq2*Iq2-(Xq'2-Xd'2)*Id2*Iq2-D2*(omega2-omega_ref);

       x(22)-x(4)*x(10)-x(2)*x(12)-(Xq_dash2-Xd_dash2)*x(10)*x(12)-D2*(x(8)-omega_ref);

       %Ed1-V1*cos(theta1)*sin(delta1)+V1*sin(theta1)*cos(delta1)-Rs1*Id1+Xq'1*Iq1

       x(3)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs1*x(9)+Xq_dash1*x(11);

       %Ed2-V2*cos(theta2)*sin(delta2)+V2*sin(theta2)*cos(delta2)-Rs2*Id2+Xq'2*Iq2

       x(4)-x(14)*cos(x(17))*sin(x(6))+x(14)*sin(x(17))*cos(x(6))-Rs2*x(10)+Xq_dash2*x(12);

       %Eq1-V1*cos(theta1)*cos(delta1)-V1*sin(theta1)*sin(delta1)-Rs1*Iq1-Xd'1*Iq1;

       x(1)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs1*x(11)-Xd_dash1*x(9);

       %Eq2-V2*cos(theta2)*cos(delta2)-V2*sin(theta2)*sin(delta2)-Rs2*Iq2-Xd'2*Iq2;

       x(2)-x(14)*cos(x(17))*cos(x(6))-x(14)*sin(x(17))*sin(x(6))-Rs2*x(12)-Xd_dash2*x(10);

       %Id1*V1*sin(delta1-theta1)+Iq1*V1*cos(delta1-theta1)+P1-V1*V1*B11*sin(theta1-theta1)-V1*V2*B12*sin(theta1-theta2)-V1*V3*B13*sin(theta1-theta3);

       x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+x(21)-x(13)*x(13)*B(1,1)*sin(x(16)-x(16))-x(13)*x(14)*B(1,2)*sin(x(16)-x(17))-x(13)*x(15)*B(1,3)*sin(x(16)-x(18));
       
       %Id2*V2*sin(delta2-theta2)+Iq2*V2*cos(delta2-theta2)+P2-V2*V1*B21*sin(theta2-theta1)-V2*V2*B22*sin(theta2-theta2)-V2*V3*B23*sin(theta2-theta3);
       
       x(10)*x(14)*sin(x(6)-x(17))+x(12)*x(14)*cos(x(6)-x(17))+x(22)-x(14)*x(13)*B(2,1)*sin(x(17)-x(16))-x(14)*x(14)*B(2,2)*sin(x(17)-x(17))-x(14)*x(15)*B(2,3)*sin(x(17)-x(18));
       
       %P3-V3*V1*B31*sin(theta3-theta1)-V3*V2*B32*sin(theta3-theta2)-V3*V3*B33*sin(theta3-theta3);
       
       (x(21)+x(22))-x(15)*x(13)*B(3,1)*sin(x(18)-x(16))-x(15)*x(14)*B(3,2)*sin(x(18)-x(17))-x(15)*x(15)*B(3,3)*sin(x(18)-x(18));
       
       %Id1*V1*cos(delta1-theta1)-Iq1*V1*sin(delta1-theta1)+Q1-V1*V1*B11*cos(theta1-theta1)-V1*V2*B12*cos(theta1-theta2)-V1*V3*B13*cos(theta1-theta3);
       
       x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(13)*sin(x(5)-x(16))+Q1-x(13)*x(13)*B(1,1)*cos(x(16)-x(16))-x(13)*x(14)*B(1,2)*cos(x(16)-x(17))-x(13)*x(15)*B(1,3)*cos(x(16)-x(18));
       
       %Id2*V2*cos(delta2-theta2)-Iq2*V2*sin(delta2-theta2)+Q2-V2*V1*B21*cos(theta2-theta1)-V2*V2*B22*cos(theta2-theta2)-V2*V3*B23*cos(theta2-theta3);
      
       x(10)*x(14)*cos(x(6)-x(17))-x(12)*x(14)*sin(x(6)-x(17))+Q2-x(14)*x(13)*B(2,1)*cos(x(17)-x(16))-x(14)*x(14)*B(2,2)*cos(x(17)-x(17))-x(14)*x(15)*B(2,3)*cos(x(17)-x(18));
       
       %Q2-V3*V1*B31*cos(theta3-theta1)-V3*V2*B32*cos(theta3-theta2)-V3*V3*B33*cos(theta3-theta3);
      
       Q3-x(15)*x(13)*B(3,1)*cos(x(18)-x(16))-x(15)*x(14)*B(3,2)*cos(x(18)-x(17))-x(15)*x(15)*B(3,3)*cos(x(18)-x(18));
    ];

% Solving for Equilibrium Points
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-12, 'TolX', 1e-12,'MaxIter', 10000000, 'MaxFunEvals', 10000000);
% options = optimset('MaxIter', 100000000, 'MaxFunEvals', 100000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);

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
efd1_eq = xeq(19);
efd2_eq = xeq(20);
tm1_eq = xeq(19);
tm2_eq = xeq(20);

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
fprintf('efd1 = %f\n', efd1_eq);
fprintf('efd2 = %f\n', efd2_eq);
fprintf('tm1 = %f\n', tm1_eq);
fprintf('tm2 = %f\n', tm2_eq);

%Displaying solution of the system
disp('Function Value at Equillibrium:');
fprintf('%f\n',fval);

%B Matrix
B=[0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1];

%E Matrix
E=zeros(18,18);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tqo1;
E(4,4)=Tqo2;
E(5,5)=1;
E(6,6)=1;
E(7,7)=(2*H1)/omega_ref;
E(8,8)=(2*H2)/omega_ref;

%Finite Poles
pol=eig(J(1:18,1:18),E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end

disp('Finite Poles:');
for i=1:size(fin_pol,1)
    fprintf('%f\n', fin_pol(i));
end

tspan=[0 500];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
x_ini=xeq(1:18);
J=J(1:18,1:18);
[t,x]=ode23t(@(t,x) des(J,x),tspan,x_ini,options);

figure()
plot(t,x(:,1),'r-','LineWidth', 3),hold on,plot(t,x(:,2),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis EMF: E_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{q_1}','\Delta E_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,3),'r-','LineWidth', 3),hold on,plot(t,x(:,4),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis EMF: E_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{d_1}','\Delta E_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,5),'r-','LineWidth', 3),hold on,plot(t,x(:,6),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Angle: \delta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \delta_1','\Delta \delta_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,7),'r-','LineWidth', 3),hold on,plot(t,x(:,8),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Anglular Velocity: \omega(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \omega_1','\Delta \omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,8),'r-','LineWidth', 3),hold on,plot(t,x(:,10),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{d_1}','\Delta I_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,11),'r-','LineWidth', 3),hold on,plot(t,x(:,12),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis Current: I_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{q_1}','\Delta I_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,13),'r-','LineWidth', 3),hold on,plot(t,x(:,14),'k-','LineWidth', 3),plot(t,x(:,15),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage: V(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta V_1','\Delta V_2','\Delta V_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,16),'r-','LineWidth', 3),hold on,plot(t,x(:,17),'k-','LineWidth', 3),plot(t,x(:,18),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage Phase: \theta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \theta_1','\Delta \theta_2','\Delta \theta_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

function dae=des(J,x)
    dae=J*x;
end


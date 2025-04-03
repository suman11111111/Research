clc,clear,close all

omega=1;

H1=6.4;
H2=3.01;

D1=0.3;
D2=0.3;

Rs1=0;
Rs2=0;

Xd1=0.8958;
Xd2=1.3125;

Xq1=0.8645;
Xq2=1.2578;

Xd_dash1=0.1198;
Xd_dash2=0.1813;

Xq_dash1=0.1969;
Xq_dash2=0.25;

Tdo1=6;
Tdo2=5.89;

Tqo1=0.535; 
Tqo2=0.6;

B11=-0.25;
B12=0.1;
B13=0.15;

B21=0.1;
B22=-0.2;
B23=0.1;

B31=0.15;
B32=0.1;
B33=-0.25; 

P1=0.05;
P2=0.4;

Q1=0.0651;
Q2=0.0999;

P3=0.45;
Q3=0.15;

Efd1=0;
Efd2=0;

TM1=0;
TM2=0;

%x(1)=Eq1;x(2)=Eq2;x(3)=Ed1;x(4)=Ed2;x(5)=delt2;x(6)=omega1;x(7)=omega2;x(8)=Id1;x(9)=Id2...
%     ...x(10)=Iq1;x(11)=Iq2;x(12)=V1;x(13)=V2;x(14)=V3;x(15)=theta1;x(16)=theta2;x(17)=theta3;


f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(8)+Efd1);
    (-x(2)-(Xd2-Xd_dash2)*x(9)+Efd2);
    (-x(3)-(Xq1-Xq_dash1)*x(10));
    (-x(4)-(Xq2-Xq_dash2)*x(11));
    x(7)-x(6);
    TM1-x(3)*x(8)-x(1)*x(10)-(Xq_dash1-Xd_dash1)*x(8)*x(10)-D1*(x(6)-omega);
    TM2-x(4)*x(9)-x(2)*x(11)-(Xq_dash2-Xd_dash2)*x(9)*x(11)-D2*(x(7)-omega);
    x(3)+x(12)*sin(x(15))-Rs1*x(8)+Xq_dash1*x(10);
    x(4)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs2*x(9)+Xq_dash2*x(11);
    x(1)-x(12)*cos(x(15))-Rs1*x(10)-Xd_dash1*x(8);
    x(2)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs2*x(11)-Xd_dash2*x(9);
    x(8)*x(12)*sin(-x(15))+x(10)*x(12)*cos(-x(15))+P1-B11*x(12)*x(12)*sin(x(15)-x(15))-B12*x(12)*x(13)*sin(x(15)-x(16))-B13*x(12)*x(14)*sin(x(15)-x(17));
    x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+P2-B21*x(13)*x(12)*sin(x(16)-x(15))-B22*x(13)*x(13)*sin(x(16)-x(16))-B23*x(13)*x(14)*sin(x(16)-x(17));
    P3-B31*x(14)*x(12)*sin(x(17)-x(15))-B32*x(14)*x(13)*sin(x(17)-x(16))-B33*x(14)*x(14)*sin(x(17)-x(17));
    x(8)*x(12)*cos(-x(15))-x(10)*x(12)*sin(-x(15))+Q1-B11*x(12)*x(12)*cos(x(15)-x(15))-B12*x(12)*x(13)*cos(x(15)-x(16))-B13*x(12)*x(14)*cos(x(15)-x(17));
    x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(12)*sin(x(5)-x(16))+Q2-B21*x(13)*x(12)*cos(x(16)-x(15))-B22*x(13)*x(13)*cos(x(16)-x(16))-B23*x(13)*x(14)*cos(x(16)-x(17));
    Q3-B31*x(14)*x(12)*cos(x(17)-x(15))-B32*x(14)*x(13)*cos(x(17)-x(16))-B33*x(14)*x(14)*cos(x(17)-x(17));
    ];

%Solve
% x0=[-0.0477;-0.5021;0.0298;-0.0964;-0.1;1;1;0.466;-0.1046;-0.05189;-0.3966;1;1;0.9905;0;0.0093;-0.0217];
% x0=[0.5578;0.6824;0.1449;0.7732;-0.3199;1.0066;1.0190;-0.3766;-0.5256;-0.2182;-0.7555;0.8593;0.8323;-0.2582;-0.1103;-0.9214;1.1619];
% x0=[0.5317;0.5279;0.1030;0.3444;-0.6823;1.0348;1.0428;-0.4491;-0.4305;-0.1106;-0.2897;0.7993;0.8699;1.3620;-0.1760;-1.1634;0.4228];
% x0=[0.5367;0.5894;0.1054;0.2811;-0.6998;1.0384;1.0575;-0.4599;-0.4783;-0.0563;-0.2478;0.8008;0.8795;0.6597;-0.2416;-1.1153;0.7872];
x0=[0.5376
    0.5996
    0.0842
    0.2628
   -0.6867
    0.72
    0.6993
   -0.4508
   -0.4814
   -0.0408
   -0.2352
    0.7960
    0.8740
    0.5401
   -0.1934
   -1.0919
    0.8442];

options = optimset('Algorithm', 'trust-region-dogleg','TolFun', 1e-1, 'TolX', 1e-3,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);


%E Matrix
E=zeros(17,17);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tqo1;
E(4,4)=Tqo2;
E(5,5)=1;
E(6,6)=(2*H1)/omega;
E(7,7)=(2*H2)/omega;


%B Matrix
B = [1,0,0,0;0,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,1,0;0,0,0,1;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];

J=J(1:17,:);
pol=eig(J,E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end

tspan=[0 1000];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,x]=ode23t(@(t,x) des(J,B,x),tspan,xeq,options);

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
plot(t,x(:,5),'r-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Angle: \delta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \delta_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,6),'r-','LineWidth', 3),hold on,plot(t,x(:,7),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Anglular Velocity: \omega(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \omega_1','\Delta \omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,8),'r-','LineWidth', 3),hold on,plot(t,x(:,9),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{d_1}','\Delta I_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,10),'r-','LineWidth', 3),hold on,plot(t,x(:,11),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis Current: I_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{q_1}','\Delta I_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,12),'r-','LineWidth', 3),hold on,plot(t,x(:,13),'k-','LineWidth', 3),plot(t,x(:,14),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage: V(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta V_1','\Delta V_2','\Delta V_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,15),'r-','LineWidth', 3),hold on,plot(t,x(:,16),'k-','LineWidth', 3),plot(t,x(:,17),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage Phase: \theta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \theta_1','\Delta \theta_2','\Delta \theta_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

function dae=des(J,B,x)
    u=[1;1;0.45;0.15];
    dae=J*x+B*u;
end
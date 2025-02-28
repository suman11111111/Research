clc,clear,close all

omega=1;

H1=6.4;
H2=3.01;

D1=0.1;
D2=0.1;

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

P1=1.63;
P2=0.85;

Q1=0.0067;
Q2=-0.109;

P3=2.48;
Q3=-0.1023;

Efd1=0;
Efd2=0;

TM1=0;
TM2=0;

%x(1)=Eq1;x(2)=Eq2;x(3)=Ed1;x(4)=Ed2;x(5)=delt2;x(6)=omega2;x(7)=Id1;x(8)=Id2...
%     ...x(9)=Iq1;x(10)=Iq2;x(11)=V1;x(12)=V2;x(13)=V3;x(14)=theta1;x(15)=theta2;x(16)=theta3;


f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(7)+Efd1);
    (-x(2)-(Xd2-Xd_dash2)*x(8)+Efd2);
    (-x(3)-(Xq1-Xq_dash1)*x(9));
    (-x(4)-(Xq2-Xq_dash2)*x(10));
    x(6)-omega;
    TM2-x(4)*x(8)-x(2)*x(10)-(Xq_dash2-Xd_dash2)*x(8)*x(10)-D2*(x(6)-omega);
    x(3)+x(11)*sin(x(13))-Rs1*x(7)+Xq_dash1*x(9);
    x(4)-x(12)*cos(x(15))*sin(x(5))+x(12)*sin(x(15))*cos(x(5))-Rs2*x(8)+Xq_dash2*x(10);
    x(1)-x(11)*cos(x(14))-Rs1*x(9)-Xd_dash1*x(7);
    x(2)-x(12)*cos(x(15))*cos(x(5))-x(12)*sin(x(15))*sin(x(5))-Rs2*x(10)-Xd_dash2*x(8);
    x(7)*x(11)*sin(-x(14))+x(9)*x(11)*cos(-x(14))+P1-B11*x(11)*x(11)*sin(x(14)-x(14))-B12*x(11)*x(12)*sin(x(14)-x(15))-B13*x(11)*x(13)*sin(x(14)-x(16));
    x(8)*x(12)*sin(x(5)-x(15))+x(10)*x(12)*cos(x(5)-x(15))+P2-B21*x(12)*x(11)*sin(x(15)-x(14))-B22*x(12)*x(12)*sin(x(15)-x(15))-B23*x(12)*x(13)*sin(x(15)-x(16));
    P3-B31*x(13)*x(11)*sin(x(16)-x(14))-B32*x(13)*x(12)*sin(x(16)-x(15))-B33*x(13)*x(13)*sin(x(16)-x(16));
    x(7)*x(11)*cos(-x(14))-x(9)*x(11)*sin(-x(14))+Q1-B11*x(11)*x(11)*cos(x(14)-x(14))-B12*x(11)*x(12)*cos(x(14)-x(15))-B13*x(11)*x(13)*cos(x(14)-x(16));
    x(8)*x(12)*cos(x(5)-x(15))-x(10)*x(12)*sin(x(5)-x(15))+Q2-B21*x(12)*x(11)*cos(x(15)-x(14))-B22*x(12)*x(12)*cos(x(15)-x(15))-B23*x(12)*x(13)*cos(x(15)-x(16));
    Q3-B31*x(13)*x(11)*cos(x(16)-x(14))-B32*x(13)*x(12)*cos(x(16)-x(15))-B33*x(13)*x(13)*cos(x(16)-x(16));
    x(13)-1;
    x(14)-1];

%Solve

x0=ones(16,1);
% x0=zeros(16,1);
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);

% indices=[5, 6, 16, 17, 18];
% for i=indices
%     xeq(i)=mod(xeq(i) + pi, 2*pi) - pi;
% end


%E Matrix
E=zeros(16,16);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tqo1;
E(4,4)=Tqo2;
E(5,5)=1;
E(6,6)=(2*H2)/omega;

% %B Matrix
% B = [1,0,0,0;0,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,1,0;0,0,0,1;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];

J=J(1:16,:);
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
[t,x]=ode23t(@(t,x) des(J,x),tspan,xeq,options);

function dae=des(J,x)
    dae=J*x;
end

figure()
plot(t,x(:,1),'r-','LineWidth', 3),hold on,plot(t,x(:,2),'k-','LineWidth', 3)
title('\Delta E_q','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis EMF: E_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta E_{q_1}','\Delta E_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,3),'r-','LineWidth', 3),hold on,plot(t,x(:,4),'k-','LineWidth', 3)
title('\Delta E_d','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis EMF: E_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta E_{d_1}','\Delta E_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,5),'r-','LineWidth', 3)
title('\Delta \delta','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Angle: \delta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta \delta_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,6),'r-','LineWidth', 3)
title('\Delta \omega','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Anglular Velocity: \omega(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta \omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,7),'r-','LineWidth', 3),hold on,plot(t,x(:,8),'k-','LineWidth', 3)
title('I_d','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta I_{d_1}','\Delta I_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,9),'r-','LineWidth', 3),hold on,plot(t,x(:,10),'k-','LineWidth', 3)
title('I_q','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta I_{q_1}','\Delta I_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,11),'r-','LineWidth', 3),hold on,plot(t,x(:,12),'k-','LineWidth', 3),plot(t,x(:,13),'b-','LineWidth', 3)
title('Voltage','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage: V(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta V_1','\Delta V_2','\Delta V_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,14),'r-','LineWidth', 3),hold on,plot(t,x(:,15),'k-','LineWidth', 3),plot(t,x(:,16),'b-','LineWidth', 3)
title('\theta','FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage Phase: \theta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta \theta_1','\Delta \theta_2','\Delta \theta_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off
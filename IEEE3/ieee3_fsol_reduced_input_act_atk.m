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

F=[0;1;0;0];

ta_i=500;
ta_f=600;


%x(1)=Eq1;x(2)=Eq2;x(3)=Ed1;x(4)=Ed2;x(5)=delt2;x(6)=omega1;x(7)=omega2;x(8)=Id1;x(9)=Id2...
%     ...x(10)=Iq1;x(11)=Iq2;x(12)=V1;x(13)=V2;x(14)=V3;x(15)=theta1;x(16)=theta2;x(17)=theta3;


f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(9)+Efd1);
    (-x(2)-(Xd2-Xd_dash2)*x(10)+Efd2);
    (-x(3)-(Xq1-Xq_dash1)*x(11));
    (-x(4)-(Xq2-Xq_dash2)*x(12));
    x(7)-x(6);
    TM1-x(3)*x(8)-x(1)*x(10)-(Xq_dash1-Xd_dash1)*x(8)*x(10)-D1*(x(6)-omega);
    TM2-x(4)*x(9)-x(2)*x(11)-(Xq_dash2-Xd_dash2)*x(9)*x(11)-D2*(x(7)-omega);
    x(3)+x(12)*sin(x(15))-Rs1*x(8)+Xq_dash1*x(10);
    x(4)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs2*x(9)+Xq_dash2*x(11);
    x(1)-x(12)*cos(x(15))-Rs1*x(10)-Xd_dash1*x(8);
    x(2)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs2*x(11)-Xd_dash2*x(9);
    x(8)*x(12)*sin(-x(15))+x(10)*x(12)*cos(-x(15))+P1-B11*x(12)*x(12)*sin(x(15)-x(15))-B12*x(12)*x(13)*sin(x(15)-x(16))-B13*x(12)*x(14)*sin(x(15)-x(17));
    x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+P2-B21*x(13)*x(12)*sin(x(16)-x(15))-B22*x(13)*x(13)*sin(x(16)-x(16))-B23*x(13)*x(14)*sin(x(16)-x(17));
    P3-B31*x(14)*x(12)*sin(x(17)-x(15))-B32*x(14)*x(13)*sin(x(17)-x(16))-B33*x(14)*x(14)*sin(x(17)-x(1));
    x(8)*x(12)*cos(-x(15))-x(10)*x(12)*sin(-x(15))+Q1-B11*x(12)*x(12)*cos(x(15)-x(15))-B12*x(12)*x(13)*cos(x(15)-x(16))-B13*x(12)*x(14)*cos(x(15)-x(17));
    x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(12)*sin(x(5)-x(16))+Q2-B21*x(13)*x(12)*cos(x(16)-x(15))-B22*x(13)*x(13)*cos(x(16)-x(16))-B23*x(13)*x(14)*cos(x(16)-x(17));
    Q3-B31*x(14)*x(12)*cos(x(17)-x(15))-B32*x(14)*x(13)*cos(x(17)-x(16))-B33*x(14)*x(14)*cos(x(17)-x(17));
    x(12)-1;
    x(13)-1];

%Solve
% x0=ones(17,1);
% x0=rand(17,1);
x0=zeros(17,1);
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);


% indices=[5, 6, 16, 17, 18];
% for i=indices
%     xeq(i)=mod(xeq(i) + pi, 2*pi) - pi;
% end


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
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes','RelTol',1e-3,'AbsTol',1e-3);
[t,x]=ode23t(@(t,x) des(J,B,x,xeq,F,t,ta_i,ta_f),tspan,xeq,options);

function dae=des(J,B,x,xeq,F,t,ta_i,ta_f)
    % u=[xeq(1)+(0.8958-0.1198)*xeq(7);xeq(2)+(1.3125-0.1813)*xeq(8);1.63;0.85];
    u=0.2*[xeq(1)+(0.8958-0.1198)*xeq(8);xeq(2)+(1.3125-0.1813)*xeq(9); xeq(3)*xeq(8)+xeq(1)*xeq(10)+(0.1969-0.1198)*xeq(8)*xeq(10); xeq(4)*xeq(9)+xeq(2)*xeq(11)+(0.25-0.1813)*xeq(9)*xeq(11)];
    if t>=ta_i && t<ta_f
        f=2*cos(t)-5*sin(2*t);
    else
        f=0;
    end
    u=u+F*f;
    dae=J*x+B*u;
end
figure()
plot(t,x(:,1),'LineWidth', 1),hold on,plot(t,x(:,2),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis EMF: E_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{q_1}','\Delta E_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-0.5, max(x(indexrange))+1.5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.2, 0.62, 0.28, 0.25]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,1:2), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,3),'LineWidth', 1),hold on,plot(t,x(:,4),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis EMF: E_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{d_1}','\Delta E_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-0.5, max(x(indexrange))+1.5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.2, 0.65, 0.28, 0.25]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,3:4), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,5),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Angle: \delta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \delta_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-2, max(x(indexrange))];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.25, 0.2, 0.28, 0.25]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,5), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,6),'LineWidth', 1),hold on,plot(t,x(:,7),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Anglular Velocity: \omega(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \omega_1','\Delta \omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-2, max(x(indexrange))];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.25, 0.62, 0.28, 0.25]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,6:7), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,8),'LineWidth', 1),hold on,plot(t,x(:,9),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{d_1}','\Delta I_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-5, max(x(indexrange))+5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.2, 0.6, 0.28, 0.32]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,8:9), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,10),'LineWidth', 1),hold on,plot(t,x(:,11),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis Current: I_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{q_1}','\Delta I_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i ta_f];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-4, max(x(indexrange))+5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.2, 0.6, 0.28, 0.32]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,10:11), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,12),'LineWidth', 1),hold on,plot(t,x(:,13),'LineWidth', 1),plot(t,x(:,14),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage: V(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta V_1','\Delta V_2','\Delta V_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i+0.5 ta_f+0.5];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-1, max(x(indexrange))+1.5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.2, 0.2, 0.28, 0.26]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,12:14), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off

figure()
plot(t,x(:,15),'LineWidth', 1),hold on,plot(t,x(:,16),'LineWidth', 1),plot(t,x(:,17),'LineWidth', 1)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage Phase: \theta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \theta_1','\Delta \theta_2','\Delta \theta_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold on
zoomX=[ta_i+0.5 ta_f+0.5];
indexrange=(t>=zoomX(1))&(t<=zoomX(2));
zoomY = [min(x(indexrange))-5, max(x(indexrange))+2];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.4, 0.2, 0.28, 0.32]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, t, x(:,15:17), 'LineWidth', 1.5);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
hold off
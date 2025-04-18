clc,clear,close all

syms s;

ta=300;
tf=350;

alpha=deg2rad(20);
gamma=1-(2*alpha)/pi-sin(2*alpha)/pi;

[E,A1,B,xeq1,fin_pol1]=stmat(0,1,gamma);
[~,A2,~,xeq2,fin_pol2]=stmat(2,1,gamma);

%Impulse Free
im_free=(rank([E A2;zeros(17,17) E])==size(A2,1)+rank(E));

%I-Controllable
i_cont=(rank([E zeros(17,17) zeros(17,6);A2 E B])==rank(E)+size(A2,1));
im_cont=(rank([E A2 B;zeros(17,17) E zeros(17,6)])==rank(E)+rank([E A2 B]));

%Admissibility
adm=(rank([s*E-A2 B E*xeq2])==rank([s*E-A2 B]));
adm_ar=(rank([E A2 B])==rank([s*E-A2 B]));

%Detectibility
dec=(rank([s*E'-A2' eye(17)])==size(A2,1));

tspan=[0 1000];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes',RelTol=10e-2);
[t,x]=ode23t(@(t,x) des(A1,A2,B,x,t,ta,tf),tspan,xeq1,options);

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

function dae=des(A1,A2,B,x,t,ta,tf)   
    v=[1;1;0.45;0.15;0;0];
    if t>ta && t<tf
        A=A2;
    else
        A=A1;
    end
    dae=A*x+B*v;
end

function [E,A,B,xeq,fin_pol]=stmat(t,ta,gamma)

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
    
    if t<=ta
        B31=0.15;
        B32=0.1;
        B33=-0.25;
    else
        B31=0.15-gamma;
        B32=0.1-gamma;
        B33=-0.25-gamma;
    end
    
    P1=0.05;
    P2=0.4;
    
    Q1=0.0468;
    Q2=0.0806;
    
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
        x(12)-1;
        x(13)-1;
        x(6)-1;
        x(7)-1];
    
        %Solve
        x0=[-0.0477;-0.5021;0.0298;-0.0964;-0.4354;1;1;0.466;-0.1046;-0.05189;-0.3966;1;1;1;0;0.0093;-0.0217];
        options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e1, 'TolX', 1e1,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
        [xeq,~,~,~,A]=fsolve(f,x0,options);
        A=A(1:17,:);
    
        %B Matrix
        B=[1 0 0 0 0 0;0 1 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 1 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 1];
        
        %E Matrix
        E=zeros(17,17);
        E(1,1)=Tdo1;
        E(2,2)=Tdo2;
        E(3,3)=Tqo1;
        E(4,4)=Tqo2;
        E(5,5)=1;
        E(6,6)=(2*H1)/omega;
        E(7,7)=(2*H2)/omega;
    
        pol=eig(A,E);
        s_pol=size(pol);
        
        fin_pol=[];
        
        for i=1:s_pol(1)
            if pol(i)~=Inf
                fin_pol=[fin_pol;pol(i)];
            end
        end
end

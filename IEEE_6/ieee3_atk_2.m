clc,clear,close all


J=[-1	0	0	0	0	0	0	0	-0.776	0	0	0	0	0	0	0	0	0;
     0	-1	0	0	0	0	0	0	0	-1.1312	0	0	0	0	0	0	0	0;
     0	0	-1	0	0	0	0	0	0	0	0.6676	0	0	0	0	0	0	0;
     0	0	0	-1	0	0	0	0	0	0	0	1.007	0	0	0	0	0	0;
     0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0;
     0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0;
    -0.0029	0	0.2973	0	0	0	-0.2	0	-0.0022	0	-1.7586	0	0	0	0	0	0	0;
     0	0.0043	0	0.0921	0	0	0	-0.2	0	0.0047	0	-1.1395	0	0	0	0	0	0;
     0	0	1	0	-1.8172	0	0	0	0	0	0.1969	0	-0.0014	0	0	1.8172	0	0;
     0	0	0	1	0	-1.1625	0	0	0	0	0	0.25	0	0.0047	0	0	1.1625	0;
     1	0	0	0	0.0025	0	0	0	-0.1198	0	0	0	-1	0	0	-0.0025	0	0;
     0	1	0	0	0	-0.0054	0	0	0	-0.1813	0	0	0	-1	0	0	0.0054	0;
     0	0	0	0	-0.5403	0	0	0	0.0025	0	1.8172	0	-0.0025	-0.0061	-0.0027	0.1358	0.2111	0.1935;
     0	0	0	0	0	-0.1071	0	0	0	-0.0054	0	1.1625	0.0039	0.0039	0.0027	0.2111	-0.1865	0.0825;
     0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
     0	0	0	0	-0.0045	0	0	0	1.8172	0	-0.0025	0	0.3886	-0.1816	-0.2726	0.0136	-0.0071	-0.0019;
     0	0	0	0	0	0.0045	0	0	0	1.1625	0	0.0054	-0.1162	0.1203	-0.1162	0.0071	-0.0136	0.0019;
     0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];

%B Matrix
B=[0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1];

%E Matrix
E=zeros(18,18);
E(1,1)=6;
E(2,2)=5.89;
E(3,3)=0.535;
E(4,4)=0.6;
E(5,5)=1;
E(6,6)=1;
E(7,7)=(2*6.4)/1;
E(8,8)=(2*3.01)/1;


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

%Impulse Free
im_free=(rank([E J;zeros(18,18) E])==size(J,1)+rank(E))


%I-Controllable
i_cont=(rank([E zeros(18,18) zeros(18,6);J E B])==rank(E)+size(J,1))
im_cont=(rank([E J B;zeros(18,18) E zeros(18,6)])==rank(E)+rank([E J B]))

tspan=[0 1000];
xeq=[1.78153784301128
1.14579727448508
0.00193736789901288
-0.00435926536875979
-0.0264249613811206
-0.0661411484871109
1
1
-0.297349018670472
-0.0920828333703100
0.00290198906382996
-0.00432552626390136
1.81716198724948
1.16250462365186
0.709769126304281
-0.0278055594567232
-0.0614610236207752
-0.0378673031596881];

options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,x]=ode23t(@(t,x) des(J,x),tspan,xeq,options);

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
clc,clear all,close all

global u_val u_t

Tch=0.3;
Tg=0.1;
R=0.05;
D=1;
M=10;
beta=21;

A=[-D/M 1/M 0;0 -1/Tch 1/Tch;-1/(R*Tg) 0 -1/Tg];
B=[0; 0; 1/Tg];
C=[beta 0 0];
% F=[-1/M 0 0];
K=place(A,B,[-0.8 -5 -0.5]);

x0 = [0.05;0;0];
tspan=[0 20];
[t,x]=ode45(@(t,x) load_freq(A,B,x,K,t),tspan,x0);

figure()
plot(t, x(:,1), 'r-', 'LineWidth', 3), hold on
plot(t, x(:,2), 'k-', 'LineWidth', 3)
plot(t, x(:,3), 'b-', 'LineWidth', 3)
%title('System Dynamics', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

figure()
plot(u_t, u_val, 'LineWidth', 3)
%title('System Dynamics', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'u'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

function ode=load_freq(A,B,x,K,t)

    global u_val u_t
    
    u=-K*x;
    
    u_val=[u_val u];
    u_t=[u_t t];
    
    ode=A*x+B*u;
end

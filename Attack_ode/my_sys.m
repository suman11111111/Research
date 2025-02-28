clc,clear all,close all

global u_val u_t

A = [0 1 3;2 1 -4;1 -4 3];
B = [0; 1; 0];
K = [-1.8136   12.0000  -18.2034];


x0 = [2;3;1];
tspan=[0 20];
options=odeset('AbsTol',10e-14,'RelTol',10e-14);
[t,x]=ode45(@(t,x) sys(A,B,x,K,t),tspan,x0,options);


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
legendObj2 = legend({'u_1'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

function ode=sys(A,B,x,K,t)

    global u_val u_t
    
    u=-K*x;
    
    u_val=[u_val u];
    u_t=[u_t t];
    
    ode=A*x+B*u;
end


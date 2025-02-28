clear all; 
close all;
clc;
%Laplacian matrix computation
A = [0 1 0 1;0 0 1 1;1 0 0 1;1 1 1 0]; 
D = diag([2, 2, 2, 3]);
L = D - A; 
%Node for attack
N_mal=2;
%Time for attack
t_initial = 0;
t_attack=6;
t_final = 10;
%Initialisation of states
x_initial = [1,2,3,4];
%Solving ODE
[t,x] = ode45(@(t,x) -L*x ,[t_initial t_attack],x_initial);
x1=x;
t1=t;
x(t_attack,N_mal)=x(t_attack,N_mal)+100*sin(t_attack);
[t,x] = ode45(@(t,x) -L*x ,[t_attack t_final],x(t_attack,:));
x1=vertcat(x1,x);
t1=vertcat(t1,t);
%Plotting results
figure()
plot(t1,x1)
legend('Node 1','Node 2','Node 3','Node 4')
title('')
xlabel({'t','(in seconds)'})
ylabel('x')
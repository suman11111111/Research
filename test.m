clear all; 
close all;
A = [0 1 0 1;0 0 1 1;1 0 0 1;1 1 1 0]; 
D = diag([2, 2, 2, 3]);
L = D - A; 
N_mal=2;
t_initial = 0;
t_final = 10;
t_attack_initial = 3;
t_attack_final = 5;
x_initial = [1,2,3,4];
[t,x] = ode45(@(t,x) -L*x ,[t_initial t_attack_initial],x_initial);
x1=x;
t1=t;
[t,x] = ode45(@(t,x) -L*x ,[t_attack_initial t_attack_final],[x(t,1) x(t,2) x(t,3)+100*sin(t) x(t,4)]);
x1=vertcat(x1,x);
t1=vertcat(t1,t);
[t,x] = ode45(@(t,x) -L*x ,[t_attack_final t_final],x(end,:));
x1=vertcat(x1,x);
t1=vertcat(t1,t);
figure()
plot(t1,x1)
legend('Node 1','Node 2','Node 3','Node 4')
title('')
xlim([0 12])
ylim([0 25])
xlabel({'t','(in seconds)'})
ylabel('x')
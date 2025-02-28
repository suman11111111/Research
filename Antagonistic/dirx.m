clear all; 
close all;
A = [0 0 -2;1 0 0;0 -4 0]; %adjacency Matrix
D = diag([2, 1, 4]); %Degree Matrix (Out-Degree)
%S = diag([-1, -1, 1]);
L = D - A; 
%initial and final time
t_initial = 0;
t_final = 10;
x_initial = [-1 -2 3]'; %initial states
%calculating ode45 to compute state x
[t,x] = ode45(@(t,x) -L*x ,[t_initial t_final],x_initial);
% plot figures
figure(2)
plot(t,x)
legend('Node 1','Node 2','Node 3','Node 4')
title('Consensus for Directed Graph')
xlabel({'t','(in seconds)'})
ylabel('x')
axis equal;

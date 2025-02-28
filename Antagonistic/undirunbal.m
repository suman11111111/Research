clear all; 
close all;
A = [0 1 -2;1 0 4;-2 4 0]; %adjacency Matrix
D = diag([3, 5, 6]); %Degree Matrix (Out-Degree)
sigma1=-1;
sigma2=1;
sigma3=1;
L = D - A; 
%initial and final time
t_initial = 0;
t_final = 10;
x_initial = [sigma1*1 sigma2*2 sigma3*3]'; %initial states
%calculating ode45 to compute state x
[t,x] = ode45(@(t,x) -L*x ,[t_initial t_final],x_initial);
% plot figures
figure(2)
plot(t,x)
legend('Node 1','Node 2','Node 3','Node 4')
title('Consensus for Undirected Graph')
xlabel({'t','(in seconds)'})
ylabel('x')
axis equal;

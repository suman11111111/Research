clc;
clear;
close all;
N = 3; %Number of agents
%elements of A1 matrix
a21 =0;
a22 =0;
n = 2; %dimension of the problem 2 for 2D
%feedback gains for the feedback matrix
f1= -10;
f2= -20;
A1 = [0 1;a21 a22]; %Aveh Matrix
Aveh = blkdiag(A1,A1); %Aveh = diag(Av(1), ... ,Av(n)) for 2D n=2
Bveh = kron(eye(n),[0;1]); %Bveh matrix
Fveh = kron(eye(n),[f1 f2]); %Feedback Control Law (f1,f2)
%%%%%%%%%%%%%%%%%%%%%%%%%
%For triangle
%starting at a random position and velocity
P = rand(2*N,1);
V = rand(2*N,1);
%use these points if you don't want a random motion
% P = [1 1,1 2,1 3]';
% V = [1 2,1 2,1 2]';
X = kron(P,[1;0])+kron(V,[0;1]); %position and velocity vector
A = kron(eye(N),Aveh);
B = kron(eye(N),Bveh);
F = kron(eye(N),Fveh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For this section the user can uncomment which ever graph they want to
%study, Undirected K3 or Directed Cycle and observe the differences.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------Undirected-K3-------------------------------%
% D = (N-1)*eye(N);
% Q = ones(N)-eye(N);
%-----------------------------Directed cycle------------------------------%
D = eye(N);
Q = [0 1 0 ;0 0 1 ;1 0 0];
%-------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1)
% %G = digraph(Q); %used to plot directed graph
% G = graph(Q); %used to plot undirected graph
% plot(G)
% title('Undirected-K3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lg = D - Q; %Graph laplacian matrix
L = kron(Lg,eye(2*n));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For Triangle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%triangle formation model
r = 1.0;
hp = [0 r*sin(pi/2),r*cos(pi+pi/4) r*sin(pi+pi/4),r*cos(2*pi-pi/4) r*sin(pi-pi/4)]';
hv = [0 0,0 0,0 0]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = kron(hp,[1;0])+kron(hv,[0;1]); %formation matrix
%solve ode45 for xdot = Ax + Bu
t0 = 0;
tf = 10;
tspan = [t0 tf];
Xinit = X;
C1 = A;
C2 = B*F*L;
[t, y]=ode45(@(t,y) formODE(t,y,h,C1,C2),tspan,Xinit);
%position and velocity matrices
[d1,d2] = size(y);
pos = zeros(d1,2*N);
vel = zeros(d1,2*N);
for i = 1:2*N
pos(:,i) = y(:,2*i-1); %Position
vel(:,i) = y(:,2*i); %Velocity
end
%calculating error between position and the desired formation
for i = 1:d1
e(i,:) = pos(i,:)-hp';
end
%control input matrix
utemp = ((F*L)'*e')';
for i = 1:2*N
u(:,i) = utemp(:,2*i);
end
%for graphing purposes
x1 = pos(:,1);
y1 = pos(:,2);
x2 = pos(:,3);
y2 = pos(:,4);
x3 = pos(:,5);
y3 = pos(:,6);
% Plot results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For Triangle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
h1 = plot(x1(1),y1(1),'x',x2(1),y2(1),'x',x3(1),y3(1),'x');
hold on;
h2 = plot(x1,y1,x2,y2,x3,y3);hold on;
h3 = plot(x1(end),y1(end),'o',x2(end),y2(end),'o',x3(end),y3(end),'o');
hold on
xf = [x1(end) x2(end) x3(end) x1(end)];
yf = [y1(end) y2(end) y3(end) y1(end)];
plot(xf, yf, 'k-', 'LineWidth', 1);
xlabel('x')
ylabel('y')
title('Directed Cycle')
legend(h3,'agent_1','agent_2','agent_3','location','best')
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(t,u);
xlabel('t (sec)')
ylabel('control input, u(t)')
legend('u1_x','u1_y','u2_x','u2_y','u3_x','u3_y','location','best')
title('Control input vs. time')
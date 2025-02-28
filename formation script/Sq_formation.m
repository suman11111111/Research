clc;
clear;
close all;
N = 4; %Number of agents
%elements of A1 matrix
a21 = 0;
a22 = 0;
n = 2; %dimension of the problem 2 for 2D
%feedback gains for the feedback matrix
f1= -1;
f2= -2;
A1 = [0 1;a21 a22]; %Aveh Matrix
Aveh = blkdiag(A1,A1); %Aveh = diag(Av(1), ... ,Av(n)) for 2D n=2
Bveh = kron(eye(n),[0;1]); %Bveh matrix
Fveh = kron(eye(n),[f1 f2]); %Feedback Control Law (f1,f2)
%%%%%%%%%%%%%%%%%%%%%%%%%
%starting at a random position and velocity
P = rand(2*N,1);
V = rand(2*N,1);
%use these points if you don't want a random motion
% P = [1 1,1 2,1 3,1 4]';
% V = [1 2,1 2,1 2,1 2]';
X = kron(P,[1;0])+kron(V,[0;1]); %position and velocity vector
A = kron(eye(N),Aveh);
B = kron(eye(N),Bveh);
F = kron(eye(N),Fveh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For this section the user can uncomment which ever graph they want to
%study, Undirected K4 or Directed Cycle and observe the differences.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------Undirected-K4-------------------------------%
% D = (N-1)*eye(N);
% Q = ones(N)-eye(N);
%-----------------------------Directed cycle------------------------------%
D = eye(N);
Q = [0 1 0 0;0 0 1 0;0 0 0 1;1 0 0 0];
%-------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1)
% G = digraph(Q); %used to plot directed graph
% % G = graph(Q); %used to plot undirected graph
% plot(G)
% title('Directed Cycle')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lg = D - Q; %Graph laplacian matrix
L = kron(Lg,eye(2*n));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For Square%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Square formation model
r = 1.0;
hp = [r*cos(pi/4) r*sin(pi/4),r*cos(pi-pi/4) r*sin(pi-pi/4),r*cos(pi+pi/4) r*sin(pi+pi/4),r*cos(2*pi-pi/4) r*sin(2*pi-pi/4)]';
hv = [0 0,0 0,0 0,0 0]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = kron(hp,[1;0])+kron(hv,[0;1]); %formation matrix
%solve ode45 for xdot = Ax + Bu
t0 = 0;
tf = 15;
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
e(i,:) = pos(i,:)- hp';
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
x4 = pos(:,7);
y4 = pos(:,8);
Vx1 = vel(:,1);
Vy1 = vel(:,2);
Vx2 = vel(:,3);
Vy2 = vel(:,4);
Vx3 = vel(:,5);
Vy3 = vel(:,6);
Vx4 = vel(:,7);
Vy4 = vel(:,8);
% Plot results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For Square%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
h1 = plot(x1(1),y1(1),'x',x2(1),y2(1),'x',x3(1),y3(1),'x',x4(1),y4(1),'x');
hold on
h2 = plot(x1,y1,x2,y2,x3,y3,x4,y4);
hold on
h3 = plot(x1(end),y1(end),'o',x2(end),y2(end),'o',x3(end),y3(end),'o',x4(end),y4(end),'o');
xf = [x1(end) x2(end) x3(end) x4(end) x1(end)];
yf = [y1(end) y2(end) y3(end) y4(end) y1(end)];
plot(xf, yf, 'b-', 'LineWidth', 1);
xlabel('x')
ylabel('y')
title('Directed Cycle')
legend(h3,'agent_1','agent_2','agent_3','agent_4','location','best')
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(t,u);
xlabel('t (sec)')
ylabel('control input, u(t)')
legend('u1_x','u1_y','u2_x','u2_y','u3_x','u3_y','u4_x','u4_y','location','northeast')
title('Control input vs. time')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
h4 = plot(Vx1(1),Vy1(1),'x',Vx2(1),Vy2(1),'x',Vx3(1),Vy3(1),'x',Vx4(1),Vy4(1),'x');
hold on
h5 = plot(Vx1,Vy1,Vx2,Vy2,Vx3,Vy3,Vx4,Vy4);
hold on
h6 = plot(Vx1(end),Vy1(end),'o',Vx2(end),Vy2(end),'o',Vx3(end),Vy3(end),'o',Vx4(end),Vy4(end),'o');
hold off;
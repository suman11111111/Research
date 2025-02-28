radius=3;
%Hexagon formation
hx=[radius radius*cos(pi/3) radius*cos(2*pi/3) radius*cos(pi) radius*cos(4*pi/3) radius*cos(5*pi/3) radius*cos(6*pi/3)];
hy=[0 radius*sin(pi/3) radius*sin(2*pi/3) radius*sin(pi) radius*sin(4*pi/3) radius*sin(5*pi/3) radius*sin(6*pi/3)];
%Vertices of Initial Location for hexagon%
x=randn(1,6);
y=randn(1,6);
%Number of vehicles
n=6;
%Initialize the model parameter and Output vectors
X=zeros(1,4*n);
XX=zeros(4*n,1);
h=zeros(4*n,1);
Aveh=[[0 1;0 -2] zeros(2);zeros(2) [0 1;0 -2]];
Bveh=kron(eye(2),[0;1]);
%Finding A=I_N(kron)A_veh,B=I_N(kron)B_veh%
A=kron(eye(n),Aveh);
B=kron(eye(n),Bveh);
%Feedback Values%
f1=-1;
f2=-3;
%Feedback matrix%
F=kron(eye(n*2),[f1 f2]);
for i=1:n
hp(2*i-1)=hx(i);
hp(2*i)=hy(i);
end
%Calculation of Formation Vector%
h=kron(hp',[1;0]);
for i=1:n
X(4*i-3)=x(i);
X(4*i-1)=y(i);
end
BB=B*F;
XX=X';
tspan=0:0.05:50;
[t,XX]=ode45(@formmodel,tspan,XX,[],h,BB,A,n);
%Plotting the formation model%
linex=zeros(n+1);
liney=zeros(n+1);
for i=1:n
subplot(231);
plot(XX(1,4*i-3),XX(1,4*i-1),'o')
title('Formation at initial position');
xlabel('X');
ylabel('Y');
hold on;
subplot(232);
plot(XX(40,4*i-3),XX(40,4*i-1),'*')
title('Formation at the iteration t=40');
xlabel('X');
ylabel('Y');
hold on;
subplot(233);
plot(XX(80,4*i-3),XX(80,4*i-1),'*')
title('Formation at the iteration t=80');
xlabel('X');
ylabel('Y');
hold on;
subplot(234);
plot(XX(120,4*i-3),XX(120,4*i-1),'*')
title('Formation at the iteration t=120');
xlabel('X');
ylabel('Y');
hold on;
subplot(235);
plot(XX(150,4*i-3),XX(150,4*i-1),'*');
title('Formation at the iteration t=150');
xlabel('X');
ylabel('Y');
hold on;
subplot(236);
plot(XX(500,4*i-3),XX(500,4*i-1),'*');
title('Final Hexagone Formation at the iteration t=500');
xlabel('X');
ylabel('Y');
linex(i)= XX(1001,4*i-3);
liney(i)= XX(1001,4*i-1);
if i==n
linex(n+1)= linex(1);
liney(n+1)= liney(1);
line(linex,liney,'Color','g','LineWidth',2);
end
hold on;
grid on;
end


clear,clc,close all

% A=[-1 1 0;-1 0 0;0 -1 -1];
L=[2 -1 -1;-1 2 -1;-1 -1 2];
A=-L;
B=0;
C=[1 1 0;1 0 1];
F=[1;0;0];

ta_i=12;
ta_f=15;
tspan=[0 50];

poles=[-5 -2 -5];

x0=[1;2;3];
rng();
z0=10*rand(3,1);
xz0=[x0;z0];

[K,P,H]=UIOx(A,C,F,poles);
[t,xz]=ode45(@(t,xz) system(A,B,C,F,P,K,xz,t,ta_i,ta_f),tspan,xz0);
x=xz(:,1:size(A,1));
z=xz(:,size(A,1)+1:end);
x=x';
z=z';
xhat=z+H*C*x;
plot(t,x);
hold on
plot(t,xhat);
hold off

function [K,P,H]=UIOx(A,C,F,poles)
H=F*pinv(C*F);
T=eye(size(A,1))-H*C;
K1=place(A',C',poles)';
P=A-H*C*A-K1*C;
K2=P*H;
K=K1+K2;
end

function xzdot=system(A,B,C,F,P,K,xz,t,ta_i,ta_f)
    x=xz(1:size(A,1));
    z=xz(size(A,1)+1:end);
    
    u=0;
    
    %%%%%%%%%%%%%%%%FDIA%%%%%%%%%%%%%%
    
    if t>=ta_i && t<ta_f
        f=2+10*sin(t);
    else
        f=0;
    end

   %%%%%%%%%%%%%%%%MITMA%%%%%%%%%%%%%%
    
%     index=find(F==1);
%     if t>=ta_i && t<ta_f
%         f=3+1.5*sin(t);
%         A(:,index)=0;
%     else
%         f=0;
%     end
    
    xdot=A*x+B*u+F*f;
    zdot=P*z+K*C*x;
    xzdot=[xdot;zdot];
end

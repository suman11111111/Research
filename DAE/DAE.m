clc,clear all,close all
syms s;

E = [1 0 0 0;0 0 1 0;0 0 0 0;0 0 0 0];
A = [0 1 0 0;1 0 0 0;-1 0 0 1;0 1 1 1];
B = [0;0;-1;0];

eig_des=eig(A,E)

x0 = [2;3;-7;4];
tspan=[0 20];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,x]=ode23t(@(t,x) des(A,B,x,t),tspan,x0,options);

plot(x(:,1),'r-'),hold on,plot(x(:,2),'k-'),plot(x(:,3),'b-'),plot(x(:,4),'m-')


function dae=des(A,B,x,t)
    u=exp(-0.5*t);
    dae=A*x+B*u;
end




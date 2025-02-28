clc,clear all,close all

N=3;   %number of agents
syms f;

E = [1 0 0 0;0 0 1 0;0 0 0 0;0 0 0 0];
f0(:,1) = [2; 3; -5; 2];
f0(:,2) = [3; 1; -4; 3];
f0(:,3) = [7; 4; -11; 7];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');

for i=1:N
    tspan=[0 20];
    [t,f]=ode23t(@(t,f) des(f),tspan,f0(:,i),options);
    figure(i)
    plot(f)
end

function dae=des(f)
    dae=[f(2);f(1);-f(1)+f(4);f(2)+f(3)+f(4)];
end




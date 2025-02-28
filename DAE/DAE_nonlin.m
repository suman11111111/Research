clc,clear all,close all

E = [1 0 0 0;0 0 1 0;0 0 0 0;0 0 0 0];
f0 = [2;3;-7;4];
tspan=[0 20];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,f]=ode23t(@(t,f) des(f),tspan,f0,options);

plot(f)

function dae=des(f)
    dae=[f(2);f(1);-2*f(1)+f(4);f(2)+f(3)+f(4)];
end




clc,clear all,close all
syms s;

E = [1 0 0 0;0 0 1 0;0 0 0 0;0 0 0 0];
A = [0 1 0 0;1 0 0 0;-1 0 0 1;0 1 1 1];
B = [0;0;-1;0];
F = [1;1;0;0];

ta_i=12;
ta_f=12.5;

x0 = [2;3;-7;4];
tspan=[0 50];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes','RelTol',10e-1);
[t,x]=ode23t(@(t,x) des(A,B,F,x,t,ta_i,ta_f),tspan,x0,options);

plot(t,x(:,1),'r-'),hold on,plot(t,x(:,2),'k-'),plot(t,x(:,3),'b-'),plot(t,x(:,4),'m-')

function dae=des(A,B,F,x,t,ta_i,ta_f)
    u=0;
    index=find(F==1);
    if t>=ta_i && t<ta_f
        f=30+1.5*sin(t);
        A(:,index)=0;
    else
        f=0;
    end
    dae=A*x+B*u+F*f;
end




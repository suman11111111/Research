Vref=380;
L=[2 -1 0 -1;-1 2 -1 0;0 -1 2 -1;-1 0 -1 2];
V0=300*rand(4,1);
G=eye(4);

tspan=[0 20];
[t,V]=ode45(@(t,V) sys(L,G,V,Vref),tspan,V0);

plot(t,V)


function ode=sys(L,G,V,Vref)
    ode=-(L+G)*(V-Vref);
end
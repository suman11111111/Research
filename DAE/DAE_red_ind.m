clc, clear all, close all
% syms  x(t) y(t) z(t)
% eqs = [diff(x) == x + z, diff(y) == z, x == y];
% vars = [x(t), y(t), z(t)];
% 
% if isLowIndexDAE(eqs, vars)==0
%     [DAEs,DAEvars] = reduceDAEIndex(eqs, vars);
% end

syms  w(t) x(t) y(t) z(t)

E = [1 0 0 0;0 0 1 0;0 0 0 0;0 0 0 0];
f0 = [2;3;-7;4];
tspan=[0 20];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,w,x,y,z]=ode23t(@(t,w,x,y,z) des(w,x,y,z),tspan,f0,options);


function dae=des(w,x,y,z)
    eqs = [diff(w) == x, diff(y) == x, x == z, x+y+z == 0];
    vars = [w(t), x(t), y(t), z(t)];

    if isLowIndexDAE(eqs, vars)==0
        [eqs,vars] = reduceDAEIndex(eqs, vars);
    end

    dae=daeFunction(eqs,vars)
end

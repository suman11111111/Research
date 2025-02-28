clc,clear all,close all

global u_val u_t f_val

E = [1 0 0;0 1 0;0 0 0];
A = [0 1 0;0 0 1;0 0 -1];
B = [0 0;1 0;0 1];
K = [-1 -2 1;0 0 0];

ta_i=12;
ta_f=13;

x0 = [2;3;1];
tspan=[0 25];
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes','RelTol',10e-3);
[t,x]=ode23t(@(t,x) des(A,B,K,x,t,ta_i,ta_f),tspan,x0,options);

figure()
plot(t, x(:,1), 'r-', 'LineWidth', 3), hold on
plot(t, x(:,2), 'k-', 'LineWidth', 3)
plot(t, x(:,3), 'b-', 'LineWidth', 3)
title('Actuator Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('time', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('States: x(t)', 'FontSize', 14, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3'}, 'FontSize', 14, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontWeight', 'bold') 


figure()
plot(u_t, u_val, 'LineWidth', 3)
title('Actuator Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('time', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Input: u(t)', 'FontSize', 14, 'FontWeight', 'bold')
legendObj2 = legend({'u1','u2'}, 'FontSize', 14, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 14, 'FontWeight', 'bold') 

figure()
plot(u_t, f_val, 'LineWidth', 3)
title('Actuator Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('time', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Attack Signal: f(t)', 'FontSize', 14, 'FontWeight', 'bold')
legendObj2 = legend({'f'}, 'FontSize', 14, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 14, 'FontWeight', 'bold')

function dae=des(A,B,K,x,t,ta_i,ta_f)

    global u_val u_t f_val
    
    u=K*x;
    
    if t>=ta_i && t<ta_f
        f=2+10*sin(t);
    else
        f=0;
    end
    u(2)=u(2)+f;
    u_val=[u_val u];
    f_val=[f_val f];
    u_t=[u_t t];
    dae=A*x+B*u;
end




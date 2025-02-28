clc,clear all,close all
global u_val u_t

A = [-1.4286 -0.1081;377.0000 0];
B = [0.1429;0];
K = [ 46.0000 -0.3856];

ta_i=0.02;
ta_f=2.5;

t_i=0;
t_f=5;

x0 = [0.08;0.8726];
tspan=[t_i t_f];
[t,x]=ode23t(@(t,x) sys(A,B,K,x,t,ta_i,ta_f),tspan,x0);

figure()
plot(t, x, 'LineWidth', 3)
xlim([t_i-0.5 t_f+0.5])
% title('DOS Attack', 'FontSize', 28, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta\delta', '\Delta\omega'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 

set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

figure()
plot(u_t, u_val, 'LineWidth', 3)
xlim([t_i-0.5 t_f+0.5])
ylim([-4 2])
% title('DOS Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'\Delta T_M'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 


function ode=sys(A,B,K,x,t,ta_i,ta_f)
    
    global u_val u_t
    persistent x_hold
    if isempty(x_hold)
        x_hold = x;
    end
    
    if t >= ta_i && t <= ta_f
        u = -K * x_hold;
    else
        x_hold = x;
        u = -K * x;        
    end
    
    u_val=[u_val u];
    u_t=[u_t t];
    
    ode = A * x + B * u;
end




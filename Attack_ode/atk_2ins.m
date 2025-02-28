clc,clear all,close all

global u_val u_t f_val

A = [0 1 3;2 1 -4;1 -4 3];
B = [0; 1; 0];
K = [-1.8136   12.0000  -18.2034];

F = [0;0;1];

ta_i_1=12;
ta_f_1=13;

ta_i_2=17;
ta_f_2=18;

x0 = [2;3;1];
tspan=[0 25];

options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);
[t,x]=ode113(@(t,x) sys(A,B,K,F,x,t,ta_i_1,ta_f_1,ta_i_2,ta_f_2),tspan,x0,options);

%%
figure()
plot(t, x(:,1), 'r-', 'LineWidth', 1.5), hold on
plot(t, x(:,2), 'k-', 'LineWidth', 1.5)
plot(t, x(:,3), 'b-', 'LineWidth', 1.5)
%title('Sensor Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 


%%
figure()
plot(u_t, u_val, 'LineWidth', 1.5)
% scatter(u_t, u_val,100,".")
% title('Sensor Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'u'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
% hold on
% zoomX=[ta_i-0.5 ta_f+0.5];
% indexrange=(u_t>=zoomX(1))&(u_t<=zoomX(2));
% zoomY = [min(u_val(indexrange)+12), max(u_val(indexrange))-40];
% rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
%     'EdgeColor', 'r', 'LineWidth', 3);
% insetAx = axes('Position', [0.6, 0.5, 0.28, 0.32]);
% box on;
% annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
% plot(insetAx, u_t, u_val, 'b-', 'LineWidth', 1.5, 'Marker', '>','MarkerSize',2);
% scatter(insetAx, u_t, u_val,".")
% set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
% xlim(insetAx, zoomX);
% ylim(insetAx, zoomY);

%%
figure()
plot(u_t, f_val, 'LineWidth', 1.5)
% scatter(u_t, f_val,".")
title('Sensor Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Attack Signal: u^s(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
zoomX=[ta_i_1-0.5,ta_f_1+0.5];
indexrange=(u_t>=zoomX(1))&(u_t<=zoomX(2));
zoomY = [min(f_val(indexrange)), max(f_val(indexrange))];
xlim(zoomX)
ylim(zoomY)
legendObj2 = legend({'u^s'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')

function ode=sys(A,B,K,F,x,t,ta_i_1,ta_f_1,ta_i_2,ta_f_2)
    
    global u_val u_t f_val
    
    f=0;
    
    if t>=ta_i_1 && t<ta_f_1
        f=2*cos(t);
    end
    
    if t>=ta_i_2 && t<ta_f_2
        f=-5*sin(2*t);
    end
    
    x(1)=x(1)+f;
    u=-K*x;
    
    u_val=[u_val u];
    f_val=[f_val f];
    u_t=[u_t t];
    
    
    ode=A*x+B*u+F*f;
end




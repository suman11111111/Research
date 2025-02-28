clc,clear all,close all
global u_val u_t

A = [0 1 3;2 1 -4;1 -4 3];
B = [0; 1; 0];
K = [-1.8136   12.0000  -18.2034];

ta_i=3;
ta_f=3.5;

x0 = [2;3;1];
tspan=[0 15];
[t,x]=ode23t(@(t,x) sys(A,B,K,x,t,ta_i,ta_f),tspan,x0);

figure()
plot(t, x(:,1), 'r-', 'LineWidth', 3), hold on
plot(t, x(:,2), 'k-', 'LineWidth', 3)
plot(t, x(:,3), 'b-', 'LineWidth', 3)
% title('DOS Attack', 'FontSize', 28, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

figure()
plot(u_t, u_val, 'LineWidth', 3)
% title('DOS Attack', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'u'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold on
zoomX=[ta_i-1 ta_f+1];
indexrange=(u_t>=zoomX(1))&(u_t<=zoomX(2));
zoomY = [-5,5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.46, 0.25, 0.4, 0.32]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, u_t, u_val, 'b-', 'LineWidth', 2);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);


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




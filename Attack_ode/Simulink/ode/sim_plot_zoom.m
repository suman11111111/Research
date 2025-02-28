clc,close all;

u_val=out.Input.signals.values;
u_t=out.Input.time;
x_val=out.States.signals.values;
x_t=out.States.time;


%%
figure()
plot(x_t, x_val(:,1), 'r-', 'LineWidth', 3), hold on
plot(x_t, x_val(:,2), 'k-', 'LineWidth', 3)
plot(x_t, x_val(:,3), 'b-', 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 


%%
figure()
plot(u_t, u_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'u'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold on
zoomX=[0.55 1.45];
indexrange=(u_t>=zoomX(1))&(u_t<=zoomX(2));
zoomY = [-12,-5];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'r', 'LineWidth', 3);
insetAx = axes('Position', [0.4, 0.55, 0.4, 0.32]);
box on;
annotation('rectangle', insetAx.Position, 'Color', 'k', 'LineWidth', 2.5);
plot(insetAx, u_t, u_val, 'b-', 'LineWidth', 2);
set(insetAx, 'FontSize', 18 ,'FontWeight', 'bold');
xlim(insetAx, zoomX);
ylim(insetAx, zoomY);
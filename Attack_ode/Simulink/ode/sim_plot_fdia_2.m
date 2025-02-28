clc,close all;

u_val=out.Input.signals.values;
u_t=out.Input.time;
x_val=out.States.signals.values;
x_t=out.States.time;
a_val=out.Attack_Sig.signals.values;
a_t=out.Attack_Sig.time;

%%
% Main plot
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
annotation('arrow', ...
    [0.35 0.23], ... % x-coordinates in normalized figure space
    [0.55 0.48], ... % y-coordinates in normalized figure space
    'LineWidth', 2, 'Color', 'k');
zoomX=[0 10];
zoomY=[-3 3];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'g', 'LineWidth', 3);
insetAx = axes('Position', [0.16, 0.23, 0.20, 0.25]); % [left, bottom, width, height]
box on;
plot(insetAx, x_t, x_val(:,1), 'r-', 'LineWidth', 3), hold on
plot(insetAx, x_t, x_val(:,2), 'k-', 'LineWidth', 3)
plot(insetAx, x_t, x_val(:,3), 'b-', 'LineWidth', 3)
xlim(insetAx, zoomX)   
ylim(insetAx, zoomY)
set(insetAx, 'LineWidth', 2, 'FontSize', 20, 'FontWeight', 'bold')
axes(gca); 
rectangle('Position', [0, -3, 10, 6], 'EdgeColor', 'k', 'LineWidth', 2);

%%
figure()
plot(u_t, u_val, 'LineWidth', 3), hold on
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'u'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
annotation('arrow', ...
    [0.30 0.26], ... % x-coordinates in normalized figure space
    [0.55 0.7], ... % y-coordinates in normalized figure space
    'LineWidth', 2, 'Color', 'k');
zoomX=[0 10];
zoomY=[-15 1];
rectangle('Position', [zoomX(1), zoomY(1), diff(zoomX), diff(zoomY)], ...
    'EdgeColor', 'g', 'LineWidth', 3);
insetAx = axes('Position', [0.18, 0.63, 0.15, 0.25]); % [left, bottom, width, height]
box on;
plot(insetAx, u_t, u_val, 'LineWidth', 3)
xlim(insetAx, zoomX)   
ylim(insetAx, zoomY)
set(insetAx, 'LineWidth', 2, 'FontSize', 20, 'FontWeight', 'bold')
axes(gca); 
rectangle('Position', [0, -3, 10, 6], 'EdgeColor', 'k', 'LineWidth', 2);


%%
figure()
plot(a_t, a_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Attack Signal: u^a(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'u^a'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')

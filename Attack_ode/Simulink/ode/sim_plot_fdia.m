clc,close all;

u_val=out.Input.signals.values;
u_t=out.Input.time;
x_val=out.States.signals.values;
x_t=out.States.time;
% u_org_val=out.Org_Input.signals.values;
% x_org_val=out.Org_States.signals.values;
a_val=out.Attack_Sig.signals.values;
a_t=out.Attack_Sig.time;

%%
figure()
plot(x_t, x_val, 'LineWidth', 3)
% plot(x_t, x_org_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1', 'x_2', 'x_3', 'x_4'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 


%%
figure()
plot(u_t, u_val, 'LineWidth', 3), hold on
% plot(u_t, u_org_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'u_1','u_2','u_3','u_4'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

%%
figure()
plot(a_t, a_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Attack Signal: u^s(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'u^s'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')

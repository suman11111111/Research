clc,close all;

u_val=out.Input.signals.values;
u_t=out.Input.time;
x_val=out.States.signals.values;
x_t=out.States.time;


%%
figure()
plot(x_t, x_val, 'LineWidth', 3),
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\Delta\delta_1', '\Delta\delta_2', '\Delta\omega_1', '\Delta\omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch'); 
set(legendBox, 'LineWidth', 3) 
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 


%%
figure()
plot(u_t, u_val, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Input: u(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj2 = legend({'P_{M_1}','P_{M_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox2 = findobj(legendObj2, 'Type', 'Patch');
set(legendBox2, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 

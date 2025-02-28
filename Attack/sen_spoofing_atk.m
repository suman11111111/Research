clear,clc
L=[1 -1 0 0;-1 3 -1 -1;0 -1 2 -1;0 -1 -1 2];
V0=100*rand(4,1);

tspan=[0 40];
[t,V]=ode45(@(t,V) sys(L,V),tspan,V0);

figure()
plot(t,V, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('States: x(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'x_1','x_2','x_3','x_4'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')

function ode=sys(L,V)
    x_atk=[1000;0;-1000;0];
    V=V+x_atk;
    ode=-L*V;
end

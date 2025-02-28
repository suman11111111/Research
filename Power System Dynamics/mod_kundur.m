clear,clc

Kd=10;
Ks=0.757;
H=3.5;
omega=377;

A=[-Kd/(2*H) -Ks/(2*H);omega 0];
B=[1/(2*H);0];

x0=[0.08;0.8726];

p=[-4+2i -4-2i];

K=place(A,B,p);

tspan=[0 3];

[t,x]=ode45(@(t,x) (A-B*K)*x,tspan,x0);

figure()
plot(t,x, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'\delta','\omega'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
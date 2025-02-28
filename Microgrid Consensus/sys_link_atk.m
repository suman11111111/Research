clear,clc
Vref=380;
global L
L=[1 -1 0 0;-1 2 -1 0;0 -1 2 -1;0 0 -1 1];
V0=300*rand(4,1);
G=diag([1;0;0;1]);

tspan=[0 40];
[t,V]=ode45(@(t,V) sys(L,G,V,Vref,t),tspan,V0);

figure()
plot(t,V, 'LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
legendObj = legend({'V_1','V_2','V_3','V_4'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')

function ode=sys(L,G,V,Vref,t)
   
    if t>=7 && t<10
        L(1,2)=L(1,2)+2*sin(0.5*t);
        L(2,1)=L(2,1)+2*sin(0.5*t);
%     else
%         L(1,2)=-1;
%         L(2,1)=-1;
    end
    
    ode=-(L+G)*(V-Vref);
end
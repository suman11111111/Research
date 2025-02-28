clc;
clear all;
close all;

N = 10000; % Total number of Iterations
dt = 0.001; % Step Length

a = 1000; % Amplitude of actuator attack signal
s=0.1; % Amplitude of sensor attack signal

x = [1; 2; 3]; % Initial conditions 
L = [1 -1 0;-1 2 -1;-1 0 1]; % Laplacian matrix
x_act = zeros(size(x,1),1);
N_sen=2;
N_act=3;

% Initialize storage for the results
x_results = zeros(size(x,1), N+1);
x_results(:,1) = x;

for i = 1:N
    
    ta=i*dt;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Actuator Attack%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        if ta >= 4
            x_act(N_act) = a;
        else
            x_act(N_act) = 0;
        end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sensor Attack%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ta >= 2
        x(N_sen) = x(N_sen) + s;
    end

%     if ta == 3
%         x(N_sen) = x(N_sen) + s;
%     end

    % RK4 
    k1 = dt * f(x, L, x_act);
    k2 = dt * f(x + 0.5 * k1, L, x_act);
    k3 = dt * f(x + 0.5 * k2, L, x_act);
    k4 = dt * f(x + k3, L, x_act);

    x = x + (k1 + 2 * k2 + 2 * k3 + k4) / 6;

    % Store the result
    x_results(:, i+1) = x;
end

t = (0:N) * dt; % Time vector

% Plot all nodes
for i = 1:size(x, 1)
    legend('-DynamicLegend');
    plot(t, x_results(i,:),'DisplayName', sprintf('Node: %d', i));
    hold on;
end

%legend('Node 1', 'Node 2', 'Node 3');
title('');
xlabel('t (in seconds)');
ylabel('x');

% Define the system of differential equations 
function dx = f(x, L, x_act)
    x0 = [1; 2; 3];
    k=2700;
    dx = -L * x -k*(x-x0)+ x_act;
end

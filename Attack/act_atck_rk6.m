clc;
clear all;
close all;

N = 10000; % Total number of Iterations
dt = 0.001; % Step Length

a = 100; % Amplitude of attack signal

x = [0; 6; -2; 4]; % Initial conditions (vector)
a_mat = [2 -1 0 -1;0 2 -1 -1;-1 0 2 -1;-1 -1 -1 3]; % Coupling coefficients (matrix)
x3_act = 0;

% Initialize storage for the results
x_results = zeros(4, N+1);
x_results(:,1) = x;

for i = 1:N
    % Uncomment and adjust the attack signal condition as needed
    % if i >= 300 && i < 4000
    %     x3_act = a * tan(i);
    % else
    %     x3_act = 0;
    % end

    % RK6 with vectorization and corrected dt multiplication
    k1 = dt * f(x, a_mat, x3_act);
    k2 = dt * f(x + (1/3) * k1, a_mat, x3_act);
    k3 = dt * f(x + (1/6) * k1 + (1/6) * k2, a_mat, x3_act);
    k4 = dt * f(x + (1/8) * k1 + (3/8) * k3, a_mat, x3_act);
    k5 = dt * f(x + (1/2) * k1 - (3/2) * k3 + (3/2) * k4, a_mat, x3_act);
    k6 = dt * f(x - (3/2) * k1 + (9/2) * k3 - 6 * k4 + 4 * k5, a_mat, x3_act);

    x = x + (k1 + 4 * k4 + k6) / 6;

    % Store the result
    x_results(:, i+1) = x;
end

t = (0:N) * dt; % Time vector
plot(t, x_results(1,:)); hold on;
plot(t, x_results(2,:));
plot(t, x_results(3,:));
plot(t, x_results(4,:));
legend('Node 1', 'Node 2', 'Node 3', 'Node 4');
title('System Dynamics');
xlabel('t (in seconds)');
ylabel('x');

% Define the system of differential equations (replace this with your actual system)
function dx = f(x, a_mat, x3_act)
    dx = -a_mat * x + [0; 0; x3_act; 0]; % System of equations with vectorized multiplication
end

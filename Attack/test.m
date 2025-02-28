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
x_1 = zeros(size(x,1), N+1);
x_1(:,1) = x;
x_2 = zeros(size(x,1), N+1);
x_2(:,1)=x;

for i = 1:N
    
    ta=i*dt;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Actuator Attack%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        if ta >= 3 
            x_act(N_act) = a;
        else
            x_act(N_act) = 0;
        end
    
    %     if ta==3
    %         x_act(N_act)=a*tan(pi/2);
    %     else
    %         x_act(N_act)=0;
    %     end

%         if ta==2
%             x_act(N_act)=a*tan(ta);
%         else
%             x_act(N_act)=0;
%         end
    
%         if ta==2
%             x_act(N_act)=a;
%         else
%             x_act(N_act)=0;
%         end
    
%     if ta >= 3 && ta < 4
%         x_act(N_act) = a;
%     else
%         x_act(N_act) = 0;
%     end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sensor Attack%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     if ta >= 3 
%         x(N_sen) = x(N_sen) + s;
%     end

%     if ta == 3
%         x(N_sen) = x(N_sen) + s;
%     end
    % RK4 
    k1 = dt * f1(x, L, x_act);
    k2 = dt * f1(x + 0.5 * k1, L, x_act);
    k3 = dt * f1(x + 0.5 * k2, L, x_act);
    k4 = dt * f1(x + k3, L, x_act);

    x = x + (k1 + 2 * k2 + 2 * k3 + k4) / 6;

        
    % RK4 
    k1 = dt * f2(x, L);
    k2 = dt * f2(x + 0.5 * k1, L);
    k3 = dt * f2(x + 0.5 * k2, L);
    k4 = dt * f2(x + k3, L);

    x1 = x + (k1 + 2 * k2 + 2 * k3 + k4) / 6;

    % Store the result
    x_1(:, i+1) = x;
    x_2(:, i+1) = x1;
end

t = (0:N) * dt; % Time vector


% Plot all nodes
figure()
for i = 1:size(x, 1)
    legend('-DynamicLegend');
    plot(t, x_1(i,:),'DisplayName', sprintf('Node: %d', i));
    hold on;
end
hold off;
title('');
xlabel('t (in seconds)');
ylabel('x');

figure()
for i = 1:size(x, 1)
    legend('-DynamicLegend');
    plot(t, x_2(i,:),'DisplayName', sprintf('Node: %d', i));
    hold on;
end
hold off;
title('');
xlabel('t (in seconds)');
ylabel('x');

% Define the system of differential equations 
function dx = f1(x, L, x_act)
    x0 = [1; 2; 3];
    k=2700;
    dx = -L * x -k*(x-x0)+ x_act; 
end

function dx2 = f2(x, L)
    dx2 = -L * x; 
end
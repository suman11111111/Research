% Economic Load Dispatch using Lambda Iteration Method
clc;
clear all;
close all;

max_itr=1000000;

% Parameters
Pmin = [50 100 15 10 10 12]; % Minimum power output of generators
Pmax = [200 400 50 35 30 40]; % Maximum power output of generators
a = [0.00375 0.00175 0.0625 0.008324 0.025 0.025]; % Fuel cost coefficients of generators
b = [2 1.75 1 3.25 3 3]; % Fuel cost coefficients of generators
c = [0 0 0 0 0 0]; % Fuel cost coefficients of generators
Pd =500; % Total power demand

% Number of Generators
ng = length(Pmin);

% Step 1: Initial lambda value and power output of generators
lambda =1;
P = zeros(1,ng);

% Step 2: Iterate until convergence
for k=1:max_itr
%     if k==(max_itr/4)
%         Pd=550;
%     end
%     if k==(max_itr/2)
%         Pd=500;
%     end
    
    % Step 3: Calculate power output of generators
    for i = 1:ng
        P(i) = (b(i) - lambda)/(2*a(i));
        if P(i) > Pmax(i)
            P(i) = Pmax(i);
        elseif P(i) < Pmin(i)
            P(i) = Pmin(i);
        end
    end
    
    % Step 4: Calculate total cost of power generation
    C = sum(a .* P.^2 + b .* P + c);
    
    % Step 5: Calculate power mismatch
    Pmismatch = sum(P) - Pd;
    
    % Step 6: Check for convergence
    if Pmismatch > 0
        lambda = lambda + 0.00001; % Increase lambda by a small amount
    else
        lambda = lambda - 0.00001; % Decrease lambda by a small amount
    end
    
end

% Display Results
fprintf('Lambda: %f\n', lambda);
fprintf('Power Output of Generators:\n');
for i = 1:ng
    fprintf('Generator %d: %f MW\n', i, P(i));
end
fprintf('Total Cost of Power Generation: %f\n', C);

function [t, y] = stiff_solver(f, tspan, y0)
    
    h=1e-3;
    
    % Time vector
    t = tspan(1):h:tspan(2);
    N = length(t);
    
    % Solution initialization
    y = zeros(size(y0, 1), N);
    y(:, 1) = y0;
    
    % Iteratively solve using Backward Euler
    for k = 2:N
        % Implicit equation: y_next = y_current + h * f(t_next, y_next)
        % Solve using Newton-Raphson method
        y_next = y(:, k-1); % Initial guess
        t_next = t(k);
        
        % Define a tolerance for Newton-Raphson
        tol = 1e-6;
        max_iter = 100;
        for iter = 1:max_iter
            % Residual of the implicit equation
            r = y_next - y(:, k-1) - h * f(t_next, y_next);
            
            % Jacobian approximation (numerical differentiation)
            J = eye(size(y0, 1)) - h * approximate_jacobian(f, t_next, y_next);
            
            % Newton step
            delta = -J \ r;
            y_next = y_next + delta;
            
            % Convergence check
            if norm(delta) < tol
                break;
            end
        end
        
        % Store the result
        y(:, k) = y_next;
    end
end

function J = approximate_jacobian(f, t, y)
    % Numerical approximation of the Jacobian matrix
    eps = 1e-8; % Small perturbation
    n = length(y);
    J = zeros(n);
    for i = 1:n
        y_perturbed = y;
        y_perturbed(i) = y_perturbed(i) + eps;
        J(:, i) = (f(t, y_perturbed) - f(t, y)) / eps;
    end
end



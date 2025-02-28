function [P, Q] = findPQ(A, B)   
    % Dimensions of A and B
    [m, n] = size(A);
    [p, q] = size(B);
    
    % Check compatibility of dimensions
    if n ~= q
        error('Matrix dimensions do not allow QAP = B.');
    end

    % Initial guesses for P and Q
    P_init = eye(n);  % Initialize P as identity matrix
    Q_init = eye(p, m);  % Initialize Q as identity matrix

    % Objective function to minimize Frobenius norm of error
    objective = @(x) norm(B - reshape(x(1:p*m), [p, m]) * A * reshape(x(p*m+1:end), [n, q]), 'fro')^2;

    % Flatten Q and P for optimization
    x0 = [Q_init(:); P_init(:)];

    % Optimization options
    options = optimoptions('fminunc', 'Display', 'none', 'Algorithm', 'quasi-newton');
    


    % Solve the optimization problem
    x_optimized = fminunc(objective, x0, options);

    % Extract optimized Q and P
    Q = reshape(x_optimized(1:p*m), [p, m]);
    P = reshape(x_optimized(p*m+1:end), [n, q]);
end

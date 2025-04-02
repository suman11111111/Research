function [P, K] = solve_constrained_generalized_riccati(A, B, Q, R, E)
    % Optimized constrained Generalized Algebraic Riccati Equation (GARE) solver.
    % Balanced approach for GARE residual minimization and stability.

    n = size(A, 1);
    m = size(B, 2);

    % Normalize matrices for better conditioning
    A = A / norm(A, 'fro');
    B = B / norm(B, 'fro');
    Q = Q / norm(Q, 'fro');
    R = R / norm(R, 'fro');
    
    % Initial guess: Random or from dare
    P0 = randn(n);  % Try random initialization
    P0 = (P0 + P0') / 2;  % Ensure symmetry
    P0_vec = P0(:);

    % Pre-compute R inverse for speed
    Rinv = R \ eye(m);

    % Regularization parameter
    reg_param = 1e-4;

    % Objective function (balanced GARE weight)
    obj_fun = @(P_vec) objective_function_gare_balanced(P_vec, A, B, Q, Rinv, reg_param, E, n);

    % Constraint function
    nonlcon = @(P_vec) non_linear_constraint_fast(P_vec, E, n);

    % Optimization options (using 'sqp' instead of 'interior-point')
    options = optimoptions('fmincon', ...
        'Display', 'iter', ...
        'Algorithm', 'sqp', ...  % Use 'sqp' or 'trust-region-reflective'
        'MaxIterations', 5000, ...
        'FunctionTolerance', 1e-9, ...
        'StepTolerance', 1e-9, ...
        'MaxFunctionEvaluations', 10000, ...
        'SpecifyObjectiveGradient', false, ...
        'SpecifyConstraintGradient', false, ...
        'ConstraintTolerance', 1e-6);

    % Solve the optimization problem
    [P_opt_vec, ~, exitflag, output] = fmincon(obj_fun, P0_vec, [], [], [], [], [], [], nonlcon, options);

    % Display exit flag and output info
    fprintf('Exit flag: %d\n', exitflag);
    disp(output);

    % Reshape P and ensure symmetry
    P = reshape(P_opt_vec, n, n);
    P = (P + P') / 2;

    % Calculate K
    K = -Rinv * B' * P;

    % Display results
    fprintf('Optimized P matrix:\n');
    disp(P);
    fprintf('Feedback gain matrix K:\n');
    disp(K);

    % Verify residuals
    gare_residual = A' * P + P * A - P * B * (Rinv * B' * P) + Q;
    fprintf('GARE Residual: %.2e\n', norm(gare_residual, 'fro'));

    E_P_diff = E' * P - P * E;
    fprintf('E''P = PE Residual: %.2e\n', norm(E_P_diff, 'fro'));
end

function J = objective_function_gare_balanced(P_vec, A, B, Q, Rinv, reg_param, E, n)
    P = reshape(P_vec, n, n);
    BP = B' * P;
    residual = A' * P + P * A - P * B * (Rinv * BP) + Q;
    constraint_residual = E' * P - P * E;
    J = 1e2 * norm(residual, 'fro')^2 + reg_param * norm(P, 'fro')^2 + 1e1 * norm(constraint_residual, 'fro')^2;
end

function [c, ceq] = non_linear_constraint_fast(P_vec, E, n)
    P = reshape(P_vec, n, n);
    ceq = E' * P - P * E;
    c = [];
end

function linearized_dae_system_simulation()
    % Define the symbolic variables
    syms x1 x2 u z real

    % Define the differential equations
    f1 = x2;
    f2 = -sin(x1) + u;

    % Define the algebraic equation
    g1 = x1 + z - u;

    % Combine the equations into vectors
    f = [f1; f2];
    g = g1;

    % Solve for the equilibrium points, considering both differential and algebraic equations
    [x_eq, u_eq, z_eq] = solve_dae_equilibrium(f, g, [x1, x2], u, z);

    % Compute the Jacobian matrices A, B, C, and D for the DAE system
    A = jacobian(f, [x1, x2]);
    B = jacobian(f, u);
    C = jacobian(g, [x1, x2]);
    D = jacobian(g, [u, z]);

    % Substitute the equilibrium values into the Jacobians
    A_eq = double(subs(A, {x1, x2, u, z}, {x_eq(1), x_eq(2), u_eq, z_eq}));
    B_eq = double(subs(B, {x1, x2, u, z}, {x_eq(1), x_eq(2), u_eq, z_eq}));
    C_eq = double(subs(C, {x1, x2, u, z}, {x_eq(1), x_eq(2), u_eq, z_eq}));
    D_eq = double(subs(D, {x1, x2, u, z}, {x_eq(1), x_eq(2), u_eq, z_eq}));

    % Display the equilibrium point and linearized matrices
    fprintf('Equilibrium Point:\n');
    fprintf('x_eq = [%f; %f], u_eq = %f, z_eq = %f\n', x_eq(1), x_eq(2), u_eq, z_eq);

    fprintf('Linearized A matrix:\n');
    disp(A_eq);

    fprintf('Linearized B matrix:\n');
    disp(B_eq);

    fprintf('Linearized C matrix:\n');
    disp(C_eq);

    fprintf('Linearized D matrix:\n');
    disp(D_eq);

    % Define initial conditions and time span
    x0 = [1; 0]; % Initial state
    z0 = 0; % Initial algebraic variable (if needed)
    tspan = [0 10]; % Time span

    % Define the input function (can be customized)
    u_handle = @(t) 1; % Example constant input

    % Solve the DAE system using ode15s (appropriate for DAEs)
    [t, xz] = ode15s(@(t, xz) dae_system(t, xz, A_eq, B_eq, C_eq, D_eq, u_handle), tspan, [x0; z0]);

    % Plot the results
    figure;
    plot(t, xz(:,1), 'r', 'DisplayName', 'x1(t)');
    hold on;
    plot(t, xz(:,2), 'b', 'DisplayName', 'x2(t)');
    xlabel('Time (t)');
    ylabel('State Variables');
    title('State Response of the Linearized DAE System');
    legend('show');
    grid on;
end

function [x_eq, u_eq, z_eq] = solve_dae_equilibrium(f, g, x_vars, u_var, z_var)
    % Solve the system of equations f = 0, g = 0 to find equilibrium points
    eqns = [f == 0; g == 0];
    S = solve(eqns, [x_vars, u_var, z_var], 'Real', true);

    % Extract the equilibrium point values
    x_eq = double([S.x1; S.x2]);
    u_eq = double(S.u);
    z_eq = double(S.z);
end

function dxzdt = dae_system(t, xz, A, B, C, D, u_handle)
    % Split the state vector into differential and algebraic parts
    x = xz(1:2); % Differential states
    z = xz(3);   % Algebraic state

    % Evaluate the input function at time t
    u_val = u_handle(t);

    % Compute the derivatives for the differential part of the system
    dxdt = A * x + B * u_val;

    % Include algebraic equations' constraint (C*x + D*[u;z] = 0)
    algebraic_constraint = C * x + D * [u_val; z];

    % Combine differential and algebraic parts into a single system
    dxzdt = [dxdt; algebraic_constraint];
end

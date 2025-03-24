function [K, P] = solve_care(E,A, B, Q, R)
    n = size(A, 1);  
    tspan = [0 1000];
    P_init = eye(n);
    options = odeset('Mass',E,'MStateDependence','none','MassSingular','yes','RelTol',1e-6, 'AbsTol',1e-8);
    [t, P_vec] = ode23t(@(t, P) desare(A, B, Q, R, P, n), tspan, P_init(:), options);
    P = reshape(P_vec(end, :), n, n);
    K = -inv(R) * B' * P;    
end
function dcare = desare(A, B, Q, R, P_vec, n)
    P = reshape(P_vec, n, n);
    dP = -Q - A' * P - P * A + P * B * inv(R) * B' * P;
    dcare = dP(:);
end

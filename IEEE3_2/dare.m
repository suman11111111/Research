function K=dare(E,A,B,Q,R)
    n=size(A,1);
    tspan=[0 1000];
    options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
    [t,P]=ode23t(@(t,P) desare(A,B,Q,R,P),tspan,eye(n,n),options);
    function dcare=desare(A,B,Q,R,P)
        dcare=-Q-A'*P-P'*A+P*B*inv(R)*B'*P;
    end
    K=-inv(R)*B'*P;
end
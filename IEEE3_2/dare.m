function K=dare(E,A,B,Q,R)
    n=size(A,1);
    tspan=[0 1000];
<<<<<<< HEAD
    options=odeset('Mass',E','MStateDependence','none','MassSingular','yes');
=======
    options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a
    [t,P]=ode23t(@(t,P) desare(A,B,Q,R,P),tspan,eye(n,n),options);
    function dcare=desare(A,B,Q,R,P)
        dcare=-Q-A'*P-P'*A+P*B*inv(R)*B'*P;
    end
<<<<<<< HEAD
    K=-inv(R)*B'*P(end);
=======
    K=-inv(R)*B'*P;
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a
end
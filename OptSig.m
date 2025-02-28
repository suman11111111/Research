clc,clear all,close all;
P=[0.5 0 0 0 0 0.5;0.5 0.5 0 0 0 0;0 0.5 0.5 0 0 0;0 0 0.5 0.5 0 0;0 0 0 0.5 0.5 0;0 0 0 0 0.5 0.5];
Q=P;
v=[133.33;28.5714;8;59.952;20;20];
B=diag(v);

% Define matrix variable A
n = 6;
sigma = sdpvar(n,n);
A=[P sigma;B*(eye(6))-P Q-sigma*B];

% Define objective function (minimum eigenvalue of A)
obj = eig(A);

% Define constraints
constr = [A >= 0,max(eig((A)))==1];

% Set the solver to Sedumi
cvx_solver sedumi

% Solve the optimization problem
cvx_begin
    minimize(obj)
    subject to
        constr
cvx_end

Sig=double(sigma);

% Print the optimal solution
disp(diag(Sig))

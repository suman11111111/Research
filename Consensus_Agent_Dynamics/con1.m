clc,clear

N = 5; 
A = [0 1; -1 0]; 
B = [0; 1];
L = [2 -1 0 0 -1; -1 2 -1 0 0;0 -1 2 -1 0;0 0 -1 2 -1;-1 0 0 -1 2];

p=[-1 -2];
K=place(A,B,p);


x0 = rand(2*N, 1);

t_span = [0 10];

system_matrix = kron(eye(N), A) - kron(L, B*K);

[t, x] = ode45(@(t,x) system_matrix*x, t_span, x0);

figure;
subplot(2,1,1);
plot(t, x(:,1:2:end));
xlabel('Time');
ylabel('x1');
title('State x1');

subplot(2,1,2);
plot(t, x(:,2:2:end));
xlabel('Time');
ylabel('x2');
title('State x2');

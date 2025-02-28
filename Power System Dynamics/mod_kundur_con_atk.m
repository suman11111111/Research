clc,clear,close all

N = 5; 
A = [-1.4286 -0.1081;377.0000 0];
B = [0.1429;0];
L = [2 -1 0 0 -1; -1 2 -1 0 0;0 -1 2 -1 0;0 0 -1 2 -1;-1 0 0 -1 2];

p=[-6+3i -6-3i];

K=place(A,B,p);

x0 = [0.08;0.8726;0.06;0.3626;0.07;0.6726;0.035;0.5926;0.04;0.1126];

t_span = [0 10];

ta=1;
tf=1.5;

[t, x] = ode45(@(t,x) system_mat(A,L,B,K,N,x,t,ta,tf), t_span, x0);

figure;
subplot(2,1,1);
plot(t, x(:,1:2:end));
xlabel('Time');
ylabel('\delta');


subplot(2,1,2);
plot(t, x(:,2:2:end));
xlabel('Time');
ylabel('\omega');



function ode=system_mat(A,L,B,K,N,x,t,ta,tf)

    if t>ta && t<=tf
        for i=1:2:5
            x(2*i)=x(2*i)+1000*sin(0.25*t);
        end
    end
   ode=(kron(eye(N), A) - kron(L, B*K))*x;
end
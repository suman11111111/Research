clear,clc,close all
N=15000;
dt=0.001;
A=[-1 1 0;-1 0 0;0 -1 -1];
C=[1 0 0;0 0 1];
E=[1;0;0];
H=E*pinv(C*E);
T=eye(3)-H*C;
K1=place(A',C',[-1 -2 -10])';
F=A-H*C*A-K1*C;
K2=F*H;
K=K1+K2;
x(:,1)=[1;2;3];
x_ref(:,1)=[1;2;3];
K_tr=300;

rng();
z(:,1)=100*rand(3,1);

for i=1:N
    x_ref(:,i+1)=x_ref(:,i)+dt*(A*x_ref(:,i));
    y_ref(:,i)=C*x_ref(:,i);
end


for i=1:N
    
    if i>3000 && i<5000
        x_act=1000*sin(i*dt);
    else
        x_act=0;
    end
    
    x(:,i+1)=x(:,i)+dt*(A*x(:,i)+E*x_act-K_tr*(x_hat(:,i)-x_ref(:,i)));
    y(:,i)=C*x(:,i);
     
    z(:,i+1)=z(:,i)+dt*(F*z(:,i)+K*y(:,i));
    x_hat(:,i)=z(:,i)+H*y(:,i);
    
    e(:,i)=x_hat(:,i)-x_ref(:,i);
end

figure(1)
plot(x(1,:)),hold on,plot(x(2,:)),plot(x(3,:)),plot(x_hat(1,:)),plot(x_hat(2,:)),plot(x_hat(3,:))

figure(2)
plot(x_ref(1,:)),hold on,plot(x_ref(2,:)),plot(x_ref(3,:)),plot(x_hat(1,:),'--x'),plot(x_hat(2,:),'--x'),plot(x_hat(3,:),'--x')

figure(3)
plot(e(1,:)),hold on,plot(e(2,:)),plot(e(3,:))


e(1,end),e(2,end),e(1,end)
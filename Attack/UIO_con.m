clear,clc,close all
N=15000;
dt=0.001;
L=[2 -1 -1;-1 2 -1;-1 -1 2];
A=-L;
C=[1 0 0;0 1 0];
%C=eye(3);
E=[1;0;0];
H=E*pinv(C*E);
T=eye(3)-H*C;
K1=place(A',C',[-3 -1 -3])';
F=A-H*C*A-K1*C;
K2=F*H;
K=K1+K2;
x(:,1)=[1;2;3];
x_act=0;

z(:,1)=[100;200;300];


for i=1:N
    
    if i>3000 && i<5000
        x_act=1000*sin(i*dt);
    else
        x_act=0;
    end
    

%     if i>5000 
%         x_act=1000*sin(i*dt);
%     else
%         x_act=0;
%     end
 

    x(:,i+1)=x(:,i)+dt*(A*x(:,i)+E*x_act);
    y(:,i)=C*x(:,i);
    
    
    z(:,i+1)=z(:,i)+dt*(F*z(:,i)+K*y(:,i));
    x_hat(:,i)=z(:,i)+H*y(:,i);
    
    e(:,i)=x_hat(:,i)-x(:,i);
end

figure(1)
plot(x(1,:)),hold on,plot(x(2,:)),plot(x(3,:)),plot(x_hat(1,:)),plot(x_hat(2,:)),plot(x_hat(3,:))
legend('x_1','x_2','x_3','xhat_1','xhat_2','xhat_3')

figure(2)
plot(e(1,:)),hold on,plot(e(2,:)),plot(e(3,:))


e(1,end),e(2,end),e(1,end)
clear all,close all;

P=[0.5 0 0 0 0 0.5;0.5 0.5 0 0 0 0;0 0.5 0.5 0 0 0;0 0 0.5 0.5 0 0;0 0 0 0.5 0.5 0;0 0 0 0 0.5 0.5];
Q=P;
ef=4e-5;

N=650;
M=24;
n=rand(1,M);
TOT=sum(n);
D1=(n/TOT)*N;

D=[0;D1(1);D1(4);0;0;0];

p_max=[200;400;50;35;30;40];
p_min=[50;40;15;10;10;12];

lamda_max=[3.5;15.75;72.5;3.8338;4.5;5];
lamda_min=[2.375;5.25;28.75;3.4168;3.5;3.6];


p(1)=p_min(1);
p(4)=p_min(4);
p(5)=p_min(5);
p(6)=p_min(6);

if D(2)<p_min(2)
    p(2)=p_min(2);
elseif D(2)>p_max(2)
    p(2)=p_max(2);
else
    p(2)=D(2);
end

if D(3)<p_min(3)
    p(3)=p_min(3);
elseif D(3)>p_max(3)
    p(3)=p_max(3);
else
    p(3)=D(3);
end

v=[133.33;28.5714;8;59.952;20;20];
beta=diag(v);
alpha=[-266.6667;-50;-8;-194.8441;-60;-60];

for i=1:6
    lamda(i)=(p(i)-alpha(i))/v(i);
end

p=p';
lamda=lamda';

dell_p(:,1)=D(:,1)-p(:,1);


for i=1:50
lamda(:,i+1)=P*lamda(:,i)+ef*dell_p(:,i);
for j=1:6
if lamda(j,i+1)>lamda_max(j,1)
    p(j,i+1)=p_max(j,1);
elseif lamda(j,i+1)<lamda_min(j,1)
    p(j,i+1)=p_min(j,1);
else
 p(j,i+1)=beta(j)*lamda(j,i+1)+alpha(j);
end
end
dell_p(:,i+1)=Q*dell_p(:,i)-(p(:,i+1)-p(:,i));
end

% for i=1:3000
% lamda(:,i+1)=P*lamda(:,i)+ef*dell_p(:,i);
% if lamda(:,i+1)>lamda_max
%     p(:,i+1)=p_max;
% elseif lamda(:,i+1)<lamda_min
%     p(:,i+1)=p_min;
% else
%  p(:,i+1)=beta*lamda(:,i+1)+alpha;
% end
%  dell_p(:,i+1)=Q*dell_p(:,i)-(p(:,i+1)-p(:,i));
% end

figure('Name','Incremental costs');
x1=lamda(1,:);
x2=lamda(2,:);
x3=lamda(3,:);
x4=lamda(4,:);
x5=lamda(5,:);
x6=lamda(6,:);
plot(x1);
hold on;
plot(x2);
plot(x3);
plot(x4);
plot(x5);
plot(x6);

figure('Name','power o/ps');
p1=p(1,:);
p2=p(2,:);
p3=p(3,:);
p4=p(4,:);
p5=p(5,:);
p6=p(6,:);
plot(p1);
hold on;
plot(p2);
plot(p3);
plot(p4);
plot(p5);
plot(p6);

figure('Name','dell_p mismatch');
dell_p1=dell_p(1,:);
dell_p2=dell_p(2,:);
dell_p3=dell_p(3,:);
dell_p4=dell_p(4,:);
dell_p5=dell_p(5,:);
dell_p6=dell_p(6,:);

plot(dell_p1);
hold on;
plot(dell_p2);
plot(dell_p3);
plot(dell_p4);
plot(dell_p5);
plot(dell_p6);


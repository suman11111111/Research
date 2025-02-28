clc,clear all,close all
P=[0.5 0 0 0 0 0.5;0.5 0.5 0 0 0 0;0 0.5 0.5 0 0 0;0 0 0.5 0.5 0 0;0 0 0 0.5 0.5 0;0 0 0 0 0.5 0.5];
Q=P;
ef=4e-5;
v=[133.33;28.5714;8;59.952;20;20];
beta=diag(v);
alpha=[-266.6667;-50;-8;-194.8441;-60;-60];
dell_p(:,1)=[116.64;-148.98;210;230;235;233];
p_max=[200;400;50;35;30;40];
p_min=[50;100;15;10;10;12];
lamda_max=[3.5;15.75;72.5;3.8338;4.5;5];
lamda_min=[2.375;5.25;28.75;3.4168;3.5;3.6];
lamda(:,1)=lamda_min;
p(:,1)=p_min;
act_lam=0;
act_p=0;

for i=1:300
act_lam=4*(0.15^i);
act_p=80*(0.35^i);
lamda(:,i+1)=P*lamda(:,i)+ef*dell_p(:,i)+act_lam;
if lamda(:,i+1)>lamda_max
    p(:,i+1)=p_max;
elseif lamda(:,i+1)<lamda_min
    p(:,i+1)=p_min;
else
 p(:,i+1)=beta*lamda(:,i+1)+alpha;
end
 dell_p(:,i+1)=Q*dell_p(:,i)-(p(:,i+1)-p(:,i))+act_p;
end

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

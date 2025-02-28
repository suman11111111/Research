P=[0.5 0 0.5;0.5 0.5 0;0 0.5 0.5];
Q=[0.5 0 0.5;0.5 0.5 0;0 0.5 0.5];
ef=0.00000001;
%ef=2e-3;
%ef=0;
v=[320.10;257.73;103.73];
B=diag(v);
alpha=[-2535.211;-2023.19;-809.126];
p(:,1)=[275;235;140];
dell_p(:,1)=[25;-250;225];
lamda(:,1)=[8.779;8.761;9.149];
lamda_max=[9.013;9.014;9.246];
lamda_min=[8.70;8.626;8.28];
p_max=[350;300;150];
p_min=[250;200;50];
for i=1:20
lamda(:,i+1)=P*lamda(:,i)+ef*dell_p(:,i);
if lamda(:,i+1)>lamda_max
    p(:,i+1)=p_max;
elseif lamda(:,i+1)<lamda_min
    p(:,i+1)=p_min;
else
 p(:,i+1)=B*lamda(:,i+1)+alpha;
end
 dell_p(:,i+1)=Q*dell_p(:,i)-(p(:,i+1)-p(:,i));
end

figure('Name','Incremental costs');
x1=lamda(1,:);
x2=lamda(2,:);
x3=lamda(3,:);
plot(x1);
hold on;
plot(x2);
hold on;
plot(x3);

figure('Name','power o/ps');
p1=p(1,:);
p2=p(2,:);
p3=p(3,:);
plot(p1);
hold on;
plot(p2);
hold on;
plot(p3);

figure('Name','dell_p mismatch');
dell_p1=dell_p(1,:);
dell_p2=dell_p(2,:);
dell_p3=dell_p(3,:);
plot(dell_p1);
hold on;
plot(dell_p2);
hold on;
plot(dell_p3);
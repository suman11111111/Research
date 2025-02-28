P=[0.5 0 0 0.5;0.5 0.5 0 0;0 0.5 0.5 0;0 0 0.5 0.5];
Q=P;
ef=7.026e-4;
v=[352.1;352.1;257.7;103.7];
B=diag(v);
alpha=[-2535.2;-2535.2;-2023.2;-826.8];
p(:,1)=[150;150;100;50];
dell_p(:,1)=[600;-150;-100;700];
lamda(:,1)=[7.63;7.63;8.24;8.42];
for i=1:50
lamda(:,i+1)=P*lamda(:,i)+ef*dell_p(:,i);
 p(:,i+1)=B*lamda(:,i+1)+alpha;
 dell_p(:,i+1)=Q*dell_p(:,i)-(p(:,i+1)-p(:,i));
end
figure('Name','Incremental costs');
x1=lamda(1,:);
x2=lamda(2,:);
x3=lamda(3,:);
x4=lamda(4,:);
plot(x1);
hold on;
plot(x2);
hold on;
plot(x3);
hold on;
plot(x4);

figure('Name','power o/ps');
p1=p(1,:);
p2=p(2,:);
p3=p(3,:);
p4=p(4,:);
plot(p1);
hold on;
plot(p2);
hold on;
plot(p3);
hold on;
plot(p4);


figure('Name','dell_p mismatch');
dell_p1=dell_p(1,:);
dell_p2=dell_p(2,:);
dell_p3=dell_p(3,:);
dell_p4=dell_p(4,:);
plot(dell_p1);
hold on;
plot(dell_p2);
hold on;
plot(dell_p3);
hold on;
plot(dell_p4);
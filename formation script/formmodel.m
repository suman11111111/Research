% Function to determine the formation model%
function xdot = formmodel(t,XX,h,BB,A,n)
x=zeros(1,n);
y=zeros(1,n);
d=zeros(n);
s=zeros(n);
l=zeros(n);
k=zeros(1,n);
for i=1:n
x(i)=XX(4*i-3,1);
y(i)=XX(4*i-1,1);
end
r=3.8;
for i=1:n
for j=1:n
if i~=j
d(i,j)=abs(sqrt((x(i)-x(j))^2+(y(i)-y(j))^2));
s(i,j)= ( d(i,j)<=r);
else
d(i,j)=0;
s(i,j)=0;
end
end
end
for i=1:n k(i)=0;
for j=1:n
k(i)=k(i)+s(i,j);
end
end
for i=1:n
for j=1:n
if i==j
l(i,j)=k(i);
else
l(i,j)= -s(i,j);
end
end
end
L=kron(l,eye(4));
%Formation model%
xdot=A*XX+BB*(XX-h);
error=XX-h;
end
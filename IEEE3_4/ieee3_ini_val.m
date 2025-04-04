clc,clear all,close all,
N=2;
Xd=[0.8958;1.3125];
Xd_dash=[0.1198;0.1813];
Xq=[0.8645;1.2578];
Xq_dash=[0.1969;0.25];
Rs=[0;0];
Td=[6;5.89];
Tq=[0.535;0.6];
P=[0.0500;0.4000];
Q=[0.0651;0.0999];
V=[1;1];
theta=[0;0.0093];
theta=deg2rad(theta);
[V1,V2]=pol2cart(theta,V);
V=complex(V1,V2);
IG=(P-1i*Q)/V;
for i=1:N
    D(i)=V(i)+1i*Xq(i)*IG(i);
end
D=D';
delt=angle(D);
for i=1:N
    I(i)=IG(i)*exp(1i*(pi-delt(i)));
    Id(i)=real(I(i));
    Iq(i)=imag(I(i));
end
Id=Id';
Iq=Iq';
for i=1:N
    Vz(i)=V(i)*exp(1i*(pi-delt(i)));
    Vd(i)=real(Vz(i));
    Vq(i)=imag(Vz(i));
end
Vd=Vd';
Vq=Vq';
for i=1:N
    Ed(i)=(Xq(i)-Xq_dash(i))*Iq(i);
end
Ed=Ed';
for i=1:N
    Eq(i)=Vq(i)+Rs(i)*Iq(i)+Xd_dash(i)*Id(i);
end
Eq=Eq';
for i=1:N
    Efd(i)=Eq(i)+(Xd(i)-Xd_dash(i))*Id(i);
end
Efd=Efd';
x0=[Eq(1);Eq(2);Ed(1);Ed(2);delt(1);delt(2);1;1;Id(1);Id(2);Iq(1);Iq(2);1;1;0.9905;0.0093;-0.0217];


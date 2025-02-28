clc,clear all,close all,
N=2;
Xd=[0.146;0.8958];
Xd_dash=[0.0608;0.1198];
Xq=[0.0969;0.8645];
Xq_dash=[0.0969;0.1969];
Rs=[0;0];
Td=[8.96;6];
Tq=[0.31;0.535];
P=[0.0500;0.4000];
Q=[0.0468;0.0806];
V=[1;1];
theta=[0;0.5334];
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


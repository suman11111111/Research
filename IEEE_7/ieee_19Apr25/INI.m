clc,clear all


Xq1=0.8645;
Xd1=0.8958;
Xq1_dash=0.1969;
Xd1_dash=0.1198;
P1=0.05;
Q1=0.065;
V1=1;
IG1=(P1-Q1*1j)/conj(V1);
delta1=angle(V1+(Xq1*1j)*IG1);
angle1=((pi/2)-delta1);
[x1,y1]=pol2cart(angle1,1);
I1=IG1*exp(angle1*1j);
Id1=real(I1);
Iq1=imag(I1);
Vz1=V1*exp(angle1*1j);
Vd1=real(Vz1);
Vq1=imag(Vz1);
Ed1=(Xq1-Xq1_dash)*Iq1;
Ed1x=Vd1-Xq1_dash*Iq1;
Eq1=Vq1+Xd1_dash*Id1;
Efd1=Eq1+(Xd1-Xd1_dash)*Id1;
TM1=Ed1*Id1+Eq1*Iq1+(Xq1_dash-Xd1_dash)*Id1*Iq1;





Xd2=1.3125;
Xq2=1.2578;
Xd2_dash=0.1813;
Xq2_dash=0.25;
P2=0.4;
Q2=0.0999;
V2=1+0.0093j;
IG2=(P2-Q2*1j)/conj(V2);
delta2=angle(V2+(Xq2*1j)*IG2);
angle2=((pi/2)-delta2);
[x2,y2]=pol2cart(angle2,1);
I2=IG2*exp(angle2*1j);
Id2=real(I2);
Iq2=imag(I2);
Vz2=V2*exp(angle2*1j);
Vd2=real(Vz2);
Vq2=imag(Vz2);
Ed2=(Xq2-Xq2_dash)*Iq2;
Ed2x=Vd2-Xq2_dash*Iq2;
Eq2=Vq2+Xd2_dash*Id2;
Efd2=Eq2+(Xd2-Xd2_dash)*Id2;
TM2=Ed2*Id2+Eq2*Iq2+(Xq2_dash-Xd2_dash)*Id2*Iq2;
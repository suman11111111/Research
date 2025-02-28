KA=diag([20;20;20]);
TA=diag([0.2;0.2;0.2]);
KE=diag([1;1;1]);
TE=diag([0.314;0.314;0.314]);
KF=diag([0.063;0.063;0.063]);
TF=diag([0.35;0.35;0.35]);
H=diag([23.64;6.4;3.01]);
Xd=diag([0.146,0.8958,1.3125]);
Xd_dash=diag([0.0608,0.1198,1.1813]);
Xq=diag([0.0969,0.8645,1.2578]);
Xq_dash=diag([0.0969,1.1969,0.25]);
Tdo_dash=diag([8.96,6.0,5.89]);
Tqo_dash=diag([0.31,0.535,0.6]);

B=[-17.361 0 0 17.361 0 0 0 0 0;0 -16 0 0 0 0 16 0 0;0 0 -17.065 0 0 0 0 0 17.065;17.361 0 0 -39.309 11.604 10.511 0 0 0;0 0 0 11.604 -17.338 0 5.595 0 0;0 0 0 10.511 0 -15.841 0 0 5.588;0 16 0 0 5.975 0 -35.4460 13.698 0;0 0 0 0 0 0 13.698 -23.303 9.784;0 0 17.065 0 0 5.588 0 9.784 -32.1540];

f(1)=Tdo_dash*diff(Eq_dash)==(-Eq_dash-(Xd-Xd_dash)+Efd);
f(2)=Tqo_dash*diff(Eq_dash)==(-Ed_dash-(Xq-Xq_dash));
f(3)=diff(delta)==omega-omegas;
f(4)=(2*H)/omegas*diff(omega)==(TM-Ed_dash*Id-Eq_dash*Iq-(Xq_dash-Xq)*Id*Iq-D*(omega-omegas));
f(5)=TE*diff(Ef)==(KE+SE(Ef))*Ef+VR;
f(6)=TF*diff(Rf)==(-Rf+KF/TF*Ef);
f(7)=TA*diff(VR)==(-VR+KA*Rf-KA*KF/TF*Efd+KA*(Vref-V));

f(8)=Ed_dash-VD*sin_del+VQ*cos_del-Rs*Id+Xq_dash*Iq==0;
f(9)=Eq_dash-VD*cos_del-VQ*sin_del-Rs*Iq-Xd_dash*Id==0;
f(10)=Id*sin_del+Iq*cos_del+inv(V)*P*cos_del+inv(V)*Q*sin_del+B*V*sin_theta==0;
f(11)=Iq*sin_del-Id*cos_del+inv(V)*P*sin_del-inv(V)*Q*cos_del-B*V*cos_theta==0;

vars=[Tdo_dash,Tqo_dash,delta,omega,Ef,Rf,VR,Iq,Id,P,Q,theta];

M=incidenceMatrix(f,vars)


function se=SE(Ef)
    n=size(Ef,1);
    SE=0.0039*exp(1.555*Ef(1,1));
    for i=1:n
        SE=diag(SE,A*exp(B*Ef(i,i)));
    end    
end

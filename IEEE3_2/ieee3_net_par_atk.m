clc,clear,close all

syms s;

omega=1;

H1=6.4;
H2=3.01;

D1=0.1;
D2=0.1;

Rs1=0;
Rs2=0;

Xd1=0.8958;
Xd2=1.3125;

Xq1=0.8645;
Xq2=1.2578;

Xd_dash1=0.1198;
Xd_dash2=0.1813;

Xq_dash1=0.1969;
Xq_dash2=0.25;

Tdo1=6;
Tdo2=5.89;

Tqo1=0.535; 
Tqo2=0.6;

B11=-0.25;
B12=0.1;
B13=0.15;

B21=0.1;
B22=-0.2;
B23=0.1;

<<<<<<< HEAD
B31=0.15;
B32=0.1;
B33=-0.25; 

% B31=0;
% B32=0;
% B33=0; 
=======
B31=0;
B32=0;
B33=0; 
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a

P1=1.63;
P2=0.85;
P3=2.48;

Q1=0.0067;
Q2=-0.109;
Q3=-0.1023;

Efd1=0;
Efd2=0;

TM1=0;
TM2=0;

%x(1)=Eq1;x(2)=Eq2;x(3)=Ed1;x(4)=Ed2;x(5)=delt2;x(6)=omega1;x(7)=omega2;x(8)=Id1;x(9)=Id2...
%     ...x(10)=Iq1;x(11)=Iq2;x(12)=V1;x(13)=V2;x(14)=V3;x(15)=theta1;x(16)=theta2;x(17)=theta3;


f=@(x)[(-x(1)-(Xd1-Xd_dash1)*x(8)+Efd1);
    (-x(2)-(Xd2-Xd_dash2)*x(9)+Efd2);
    (-x(3)-(Xq1-Xq_dash1)*x(10));
    (-x(4)-(Xq2-Xq_dash2)*x(11));
    x(7)-x(6);
    TM1-x(3)*x(8)-x(1)*x(10)-(Xq_dash1-Xd_dash1)*x(8)*x(10)-D1*(x(6)-omega);
    TM2-x(4)*x(9)-x(2)*x(11)-(Xq_dash2-Xd_dash2)*x(9)*x(11)-D2*(x(7)-omega);
    x(3)+x(12)*sin(x(15))-Rs1*x(8)+Xq_dash1*x(10);
    x(4)-x(13)*cos(x(16))*sin(x(5))+x(13)*sin(x(16))*cos(x(5))-Rs2*x(9)+Xq_dash2*x(11);
    x(1)-x(12)*cos(x(15))-Rs1*x(10)-Xd_dash1*x(8);
    x(2)-x(13)*cos(x(16))*cos(x(5))-x(13)*sin(x(16))*sin(x(5))-Rs2*x(11)-Xd_dash2*x(9);
    x(8)*x(12)*sin(-x(15))+x(10)*x(12)*cos(-x(15))+P1-B11*x(12)*x(12)*sin(x(15)-x(15))-B12*x(12)*x(13)*sin(x(15)-x(16))-B13*x(12)*x(14)*sin(x(15)-x(17));
    x(9)*x(13)*sin(x(5)-x(16))+x(11)*x(13)*cos(x(5)-x(16))+P2-B21*x(13)*x(12)*sin(x(16)-x(15))-B22*x(13)*x(13)*sin(x(16)-x(16))-B23*x(13)*x(14)*sin(x(16)-x(17));
    P3-B31*x(14)*x(12)*sin(x(17)-x(15))-B32*x(14)*x(13)*sin(x(17)-x(16))-B33*x(14)*x(14)*sin(x(17)-x(17));
    x(8)*x(12)*cos(-x(15))-x(10)*x(12)*sin(-x(15))+Q1-B11*x(12)*x(12)*cos(x(15)-x(15))-B12*x(12)*x(13)*cos(x(15)-x(16))-B13*x(12)*x(14)*cos(x(15)-x(17));
    x(9)*x(13)*cos(x(5)-x(16))-x(11)*x(12)*sin(x(5)-x(16))+Q2-B21*x(13)*x(12)*cos(x(16)-x(15))-B22*x(13)*x(13)*cos(x(16)-x(16))-B23*x(13)*x(14)*cos(x(16)-x(17));
    Q3-B31*x(14)*x(12)*cos(x(17)-x(15))-B32*x(14)*x(13)*cos(x(17)-x(16))-B33*x(14)*x(14)*cos(x(17)-x(17));
    x(12)-1;
    x(13)-1;
    x(6)-1;
    x(7)-1];

%Solve
% x0=ones(17,1);
% x0=zeros(17,1);
x0=[-0.0477;-0.5021;0.0298;-0.0964;-0.4354;1;1;0.466;-0.1046;-0.05189;-0.3966;1;1;1;0;0.0093;-0.0217];
options = optimset('Algorithm', 'levenberg-marquardt','TolFun', 1e-6, 'TolX', 1e-6,'MaxIter', 10000000, 'MaxFunEvals', 1000000);
[xeq,fval,flag,out,J]=fsolve(f,x0,options);

%Defining of Symbolic Variables for each bus
syms omega_s
syms Eq1 Ed1 delt1 omega1 Id1 Iq1 P1 Q1 theta1 V1 Efd1 H1 TM1 D1 Tdo1 Tqo1 Rs1 Xq1 Xd1 Xd_dash1 Xq1 Xq_dash1 B11 B12 B13
syms Eq2 Ed2 delt2 omega2 Id2 Iq2 P2 Q2 theta2 V2 Efd2 H2 TM2 D2 Tdo2 Tqo2 Rs2 Xq2 Xd2 Xd_dash2 Xq2 Xq_dash2 B21 B22 B23
syms P3 Q3 theta3 V3 B31 B32 B33

%Differential Equation for 1st bus
f1(1)=(-Eq1-(Xd1-Xd_dash1)*Id1+Efd1);
f1(2)=(-Ed1-(Xq1-Xq_dash1)*Iq1);
f1(3)=TM1-Ed1*Id1-Eq1*Iq1-(Xq_dash1-Xd_dash1)*Id1*Iq1-D1*omega1;

%Algebraic Equation for 1st bus
f1(4)=Ed1+V1*sin(theta1)-Rs1*Id1+Xq_dash1*Iq1;
f1(5)=Eq1-V1*cos(theta1)-Rs1*Iq1-Xd_dash1*Id1;
f1(6)=Id1*V1*sin(-theta1)+Iq1*V1*cos(-theta1)+P1-B11*V1*V1*sin(theta1-theta1)-B12*V1*V2*sin(theta1-theta2)-B13*V1*V3*sin(theta1-theta3);
f1(7)=Id1*V1*cos(-theta1)-Iq1*V1*sin(-theta1)+Q1-B11*V1*V1*cos(theta1-theta1)-B12*V1*V2*cos(theta1-theta2)-B13*V1*V3*cos(theta1-theta3);

%States for 1st bus
x1=[Eq1 Ed1 omega1 Iq1 Id1 V1 theta1];

%Input States for 1st bus
u1=[Efd1 TM1 P1 Q1];

%Differential Equation for 2nd bus
f2(1)=(-Eq2-(Xd2-Xd_dash2)*Id2+Efd2);
f2(2)=(-Ed2-(Xq2-Xq_dash2)*Iq2);
f2(3)=omega2-omega1;
f2(4)=TM2-Ed2*Id2-Eq2*Iq2-(Xq_dash2-Xd_dash2)*Id2*Iq2-D2*omega2;

%Algebraic Equation for 2nd bus
f2(5)=Ed2-V2*cos(theta2)*sin(delt2)+V2*sin(theta2)*cos(delt2)-Rs2*Id2+Xq_dash2*Iq2;
f2(6)=Eq2-V2*cos(theta2)*cos(delt2)-V2*sin(theta2)*sin(delt2)-Rs2*Iq2-Xd_dash2*Id2;
f2(7)=Id2*V2*sin(delt2-theta2)+Iq2*V2*cos(delt2-theta2)+P2-B21*V2*V1*sin(theta2-theta1)-B22*V2*V2*sin(theta2-theta2)-B23*V2*V3*sin(theta2-theta3);
f2(8)=Id2*V2*cos(delt2-theta2)-Iq2*V2*sin(delt2-theta2)+Q2-B21*V2*V1*cos(theta2-theta1)-B22*V2*V2*cos(theta2-theta2)-B23*V2*V3*cos(theta2-theta3);

%States for 2nd bus
x2=[Eq2 Ed2 delt2 omega2 Iq2 Id2 V2 theta2];

%Input States for 2nd bus
u2=[Efd2 TM2 P2 Q2];

%Algebraic Equation for 3rd bus
f3(1)=P3-B31*V3*V1*sin(theta3-theta1)-B32*V3*V2*sin(theta3-theta2)-B33*V3*V3*sin(theta3-theta3);
f3(2)=Q3-B31*V3*V1*cos(theta3-theta1)-B32*V3*V2*cos(theta3-theta2)-B33*V3*V3*cos(theta3-theta3);

%States for 3rd bus
x3=[V3 theta3];

%Input States for 3rd bus
u3=[P3 Q3];


%Drifts
fd=[f1(1),f2(1),f1(2),f2(2),f2(3),f1(3),f2(4)];
xd=[x1(1),x2(1),x1(2),x2(2),x2(3),x1(3),x2(4)];

fa=[f1(4),f2(5),f1(5),f2(6),f1(6),f2(7),f3(1),f1(7),f2(8),f3(2)];
xa=[x1(4),x2(5),x1(5),x2(6),x1(6),x2(7),x3(1),x1(7),x2(8),x3(2)];

u=[u1(1),u2(1),u1(2),u2(2),u1(3),u2(3),u3(1),u1(4),u2(4),u3(2)];


%Jacobians for A and B
A11=jacobian(fd,xd);
A12=jacobian(fd,xa);
A21=jacobian(fa,xd);
A22=jacobian(fa,xa);
B1=jacobian(fd,u);
B2=jacobian(fa,u);

A=[A11,A12;A21,A22];
B=[B1;B2];

%Computation of E
E=zeros(17,17);
E=sym(E);
E(1,1)=Tdo1;
E(2,2)=Tdo2;
E(3,3)=Tqo1;
E(4,4)=Tqo2;
E(5,5)=1;
E(6,6)=(2*H1)/omega_s;
E(7,7)=(2*H2)/omega_s;

Hs=[H1 H2];
H=[6.4 3.01];

Eqs=[Eq1 Eq2];
Eq=[xeq(1) xeq(2)];

Eds=[Ed1 Ed2];
Ed=[xeq(3) xeq(4)];

Vs=[V1 V2 V3];
V=[xeq(12) xeq(13) xeq(14)];

delts=delt2;
delt=[xeq(5)];

omegas=[omega1 omega2];
omega=[xeq(6) xeq(7)];

Ds=[D1 D2];
<<<<<<< HEAD
D=[0.1 0.1];
=======
D=[0.3 0.3];
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a

Ids=[Id1 Id2];
Id=[xeq(8) xeq(9)];

Iqs=[Iq1 Iq2];
Iq=[xeq(10) xeq(11)];

Rss=[Rs1 Rs2];
Rs=[0 0];

Xds=[Xd1 Xd2];
Xd=[0.8958 1.3125];

Xqs=[Xq1 Xq2];
Xq=[0.8645 1.2578];

Xd_dashs=[Xd_dash1 Xd_dash2];
Xd_dash=[0.1198 0.1813];

Xq_dashs=[Xq_dash1 Xq_dash2];
Xq_dash=[0.1969 0.25];

Tdos=[Tdo1 Tdo2];
Tdo=[6 5.89];

Tqos=[Tqo1 Tqo2];
Tqo=[0.535 0.6];

thetas=[theta1 theta2 theta3];
theta=[xeq(15) xeq(16) xeq(17)];

B1xs=[B11 B12 B13];
B1x=[-0.25 0.1 0.15];

<<<<<<< HEAD
B2xs=[B21 B22 B23];
B2x=[0.1 -0.2 0.1];

B3s=[B31 B32 B33];
% B3=[0 0 0];
B3=[0.15 0.1 -0.25];
=======
B2xs=[B22 B21 B23];
B2x=[0.1 -0.2 0.1];

B3s=[B33 B31 B32];
B3=[0 0 0];
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a

E=subs(E,[Tdos Tqos Hs omega_s],[Tdo Tqo H 1]);
E=double(E);
A=subs(A,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos thetas B1xs B2xs B3s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo theta B1x B2x B3]);
A=double(A);
A22=subs(A22,[Eqs Eds Vs delts omegas Ds Ids Iqs Rss Xds Xqs Xd_dashs Xq_dashs Tdos Tqos thetas B1xs B2xs B3s],[Eq Ed V delt omega D Id Iq Rs Xd Xq Xd_dash Xq_dash Tdo Tqo theta B1x B2x B3]);
A22=double(A22);
B=double(B);

pol=eig(A,E);
s_pol=size(pol);

fin_pol=[];

for i=1:s_pol(1)
    if pol(i)~=Inf
        fin_pol=[fin_pol;pol(i)];
    end
end

%Impulse Free
im_free=(rank([E A;zeros(17,17) E])==size(A,1)+rank(E));

%I-Controllable

i_cont=(rank([E zeros(17,17) zeros(17,10);A E B])==rank(E)+size(J,1));
im_cont=(rank([E A B;zeros(17,17) E zeros(17,10)])==rank(E)+rank([E A B]));

%Admissibility
adm=(rank([s*E-A B E*xeq])==rank([s*E-A B]));
adm_ar=(rank([E A B])==rank([s*E-A B]));

tspan=[0 50];
<<<<<<< HEAD
[~,K,~]=icare(A,B,eye(17),eye(10),0,eye(17));
% K=[0.708551448300913	-0.0142993320471664	-0.0950739259320428	0.0156274408021272	-0.0328299863403630	0.00679611663019365	-0.00178358253252118	-0.217607259580449	0.0451270095773890	0.494069563857401	-0.0312698201827245	-0.239293235610895	-0.0117037376027514	-0.0271005226109929	0.0583521016021115	-0.0369536720621197	-0.0740370219499524;
% -0.0142993320471656	0.690497326968209	-0.0481155694049186	-0.0359144317389221	0.637855154093443	-0.303245737111365	0.403532407903134	0.0689136719154014	0.0239035249324489	-0.0224320851149178	0.124249094633182	0.0133710177805155	-0.0115896361670867	-0.00124413131992762	-0.00860375908020191	-0.297214331533327	0.0542330982070076;
% 0.00679611663019274	-0.303245737111364	0.319550672139202	0.0706091478151855	-1.11454804861840	1.37332373018257	-0.563494633787790	-0.729022726347850	0.0137059511601113	0.0227797270711091	-0.0234398641486518	-0.0259994121809437	-0.0395993190393602	-0.00108792338810388	-0.178031464600757	0.265973484805297	-0.0697930410054278;
% -0.00178358253252025	0.403532407903133	-0.160136624248286	-0.0957242051600196	0.852646781275212	-0.563494633787789	1.20986304378055	0.186710675529268	-0.0486199046334436	-0.000601438287505195	-0.571009121647320	0.0131316863657660	0.105472080155385	0.00549928159243905	0.0548644307485334	-0.115637674806085	0.0867763982931021;
% -0.239293235610896	0.0133710177805156	0.0941998518528981	-0.0290102280609077	0.0481960285681421	-0.0259994121809442	0.0131316863657663	0.297890209771550	-0.0471267504775733	-0.461408512046979	0.0247192829255443	0.461584758450901	0.0275896278585393	0.0273782340657109	0.231861119836804	-0.0168365195159970	-0.0518216986287065;
% -0.0117037376027501	-0.0115896361670856	0.0395406725892388	-0.514295749187676	0.394192060290542	-0.0395993190393596	0.105472080155385	0.0532017786008084	-1.04275838338618	-0.0146373542661786	0.139114968284134	0.0275896278585394	1.02841265219270	0.0433345806291031	0.0246441204981974	-0.212958608008317	0.203128464147058;
% -0.0271005226109928	-0.00124413131992713	0.00938149632285615	-0.0254438354545330	0.0180987609556988	-0.00108792338810455	0.00549928159244009	0.0214036026016594	-0.0556490484556444	-0.0494639544826951	0.00495530234664632	0.0273782340657113	0.0433345806291038	1.00765909192073	-0.0349261488437509	0.0378807409620807	0.0162180986528266;
% 0.0583521016021163	-0.00860375908020531	0.640190705493516	-0.0514478245603047	0.0181282832231459	-0.178031464600754	0.0548644307485310	1.44096553971363	0.0249881746109864	0.853549981348364	-0.0875313348144692	0.231861119836804	0.0246441204981974	-0.0349261488437505	4.02020212394254	-0.253427327400259	-1.60026819325952;
% -0.0369536720621209	-0.297214331533327	0.0246660262947910	0.292485489299491	-1.08246003198315	0.265973484805293	-0.115637674806083	0.0787265490078154	-0.259294502123859	-0.131624568575685	-0.999888515485740	-0.0168365195159953	-0.212958608008316	0.0378807409620810	-0.253427327400252	2.58594004009870	-0.660749297987200;
% -0.0740370219499549	0.0542330982070090	-0.0871771900657403	-0.144460001702989	0.283708822680364	-0.0697930410054292	0.0867763982931033	-0.172677051739286	-0.00546073040738947	-0.448253348787049	0.134062198821440	-0.0518216986287071	0.203128464147058	0.0162180986528264	-1.60026819325952	-0.660749297987196	2.19808965252371];
=======
% [~,K,~]=icare(A,B,eye(17),eye(10),0,eye(17));
K=dare(E,A,B,eye(17),eye(10))
>>>>>>> ba416f260342c3b83f1d67c237c9776863ec561a
options=odeset('Mass',E,'MStateDependence','none','MassSingular','yes');
[t,x]=ode23t(@(t,x) des(A,B,x,K),tspan,xeq,options);


function dae=des(A,B,x,K)   
    v=[1;1;1.63;0.85;0;0;0;0;0;0];
    dae=(A-B*K)*x+B*v;
end

pol2=eig(A-B*K,E);
s_pol2=size(pol2);

fin_pol2=[];

for i=1:s_pol2(1)
    if pol2(i)~=Inf
        fin_pol2=[fin_pol2;pol2(i)];
    end
end

figure()
plot(t,x(:,1),'r-','LineWidth', 3),hold on,plot(t,x(:,2),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis EMF: E_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{q_1}','\Delta E_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,3),'r-','LineWidth', 3),hold on,plot(t,x(:,4),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis EMF: E_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta E_{d_1}','\Delta E_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,5),'r-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Angle: \delta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \delta_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold') 
hold off

figure()
plot(t,x(:,6),'r-','LineWidth', 3),hold on,plot(t,x(:,7),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Rotor Anglular Velocity: \omega(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \omega_1','\Delta \omega_2'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,8),'r-','LineWidth', 3),hold on,plot(t,x(:,9),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('d-axis Current: I_d(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{d_1}','\Delta I_{d_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,10),'r-','LineWidth', 3),hold on,plot(t,x(:,11),'k-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('q-axis Current: I_q(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta I_{q_1}','\Delta I_{q_2}'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,12),'r-','LineWidth', 3),hold on,plot(t,x(:,13),'k-','LineWidth', 3),plot(t,x(:,14),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage: V(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta V_1','\Delta V_2','\Delta V_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off

figure()
plot(t,x(:,15),'r-','LineWidth', 3),hold on,plot(t,x(:,16),'k-','LineWidth', 3),plot(t,x(:,17),'b-','LineWidth', 3)
xlabel('Time t \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
ylabel('Voltage Phase: \theta(t) \rightarrow', 'FontSize', 28, 'FontWeight', 'bold')
grid on
legendObj = legend({'\Delta \theta_1','\Delta \theta_2','\Delta \theta_3'}, 'FontSize', 28, 'LineWidth', 1.5);
legendBox = findobj(legendObj, 'Type', 'Patch');
set(legendBox, 'LineWidth', 3)
set(gca, 'LineWidth', 3, 'FontSize', 28, 'FontWeight', 'bold')
hold off
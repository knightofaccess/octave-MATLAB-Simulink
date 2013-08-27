%example for use of ac_eqn.m
% MD11
% Common

global acparm stbdr
g=32.2; %Imperial gravitational constant
% 1knot= 1.689 ft/sec
pi=3.141592653589793;
 rads= pi/180;
U=175*1.689;
u=U;
U0=U;
u_ref=U0;
gama_ref=3*rads;
GAMA_ref=0;
h_cr=15000;
m=19771.3; %slugs weight=430000 lbs;
thet0=0;
Ixx=19378280;Iyy=39637518;Izz=35997582;Ixz=1300; %slug-ft*ft

Le=0;Me=0;Ne=0; % No external moments: could be changed?
Xe=0;Ye=0;Ze=0; % No external forces: could be changed?
thL=0;thT=0;thR=0; % Control surfaces set to zero

% Longitudinal
touh=2; % <---?
Xu=-0.02115;
Xw=0.09172;
Xq=-0.03753*rads;
XL=0.00009153; 
XT=0.00009152;
XR=0.00009153;
Zu=-0.1347;
Zw=-0.5656;
Zq=5.927*rads-U; %Velocity component?
ZL=0.000004427;
ZT=0.000001371;
ZR=-0.000001542;
Yv=-0.1219;
Yp=-5.8*rads;
Yr=0.3341*rads+U; % Velocity component?
YL=0.000002748;
YT=-0.000003678;
YR=-0.000002745;
Lv=0.04941/rads;
Lp=0.1373;
Lr=-0.06361;
LL=0.00005429/rads;
LT=0.000000005009/rads;
LR=0.00005429/rads;
Mq=-0.2458;
Mw=-0.654/rads;
Mu=0.004679/rads;
ML=0.000007164/rads;
MT=-0.000000003626/rads;
MR=-0.000007256/rads;
Nv=-0.18/rads;
Np=-0.8104;
Nr=-0.6971;
NL=0.00002962/rads;
NT=0.000036/rads;
NR=0.00001895/rads;

acparm(1)=0;acparm(2)=0;
acparm(3)=g;acparm(4)=m;acparm(5)=U; acparm(6)=thet0;
acparm(7)=Ixx;acparm(8)=Iyy;acparm(9)=Izz;acparm(10)=Ixz;
acparm(11)=Le;acparm(12)=Me;acparm(13)=Ne;
acparm(14)=Xe;acparm(15)=Ye;acparm(16)=Ze;
acparm(17)=thL;acparm(18)=thT;acparm(19)=thR;

%u=x(1);v=x(2);w=x(3);p=x(4);q=x(5);r=x(6);phi=x(7);thet=x(8);psi=x(9);
% u, w, q , theta : lon states 1, 3, 5, 8;
% v, p, r, phi: lat states: 2, 4, 6, 7
%xi=x(10);yi=x(11);zi=x(12);
%latdof=[v;p;r;phi];

% Dimensional Stab derivatives (State Space)
stbdr(1)=Xu;
stbdr(2)=Xw;
stbdr(3)=Xq;
stbdr(4)=XL;
stbdr(5)=XT;
stbdr(6)=XR;
stbdr(7)=Yv;
stbdr(8)=Yp;
stbdr(9)=Yr;
stbdr(10)=YL;
stbdr(11)=YT;
stbdr(12)=YR;
stbdr(13)=Zu;
stbdr(14)=Zw;
stbdr(15)=Zq;
stbdr(16)=ZL;
stbdr(17)=ZT;
stbdr(18)=ZR;

stbdr(19)=Lv;
stbdr(20)=Lp;
stbdr(21)=Lr;
stbdr(22)=LL;
stbdr(23)=LT;
stbdr(24)=LR;
stbdr(25)=Mu;
stbdr(26)=Mw;
stbdr(27)=Mq;
stbdr(28)=ML;
stbdr(29)=MT;
stbdr(30)=MR;
stbdr(31)=Nv;
stbdr(32)=Np;
stbdr(33)=Nr;
stbdr(34)=NL;
stbdr(35)=NT;
stbdr(35)=NR;

% Use Boeing mode to check algorithm (commented out)
%ap=[-1.08e-02 0.106 -8.42 -9.77;-0.155 -0.634 85.3 -1.01; 7.16e-4 -5.83e-03 -0.504 7.95e-04; 0 0 1 0];% Boeing
% pthrot=0.667; % Boeing
% bp=[0;0;0;0;pthrot]; Boeing
% Cp=[1 0 0 0 0;0 1/U0 0 -1 0]; Dp=[0; 0];
% All states measured (5 for plant and 3 Glide slope kinematics)
% One control (Boeing model!)
% nmeas=8;ncon=1; % Boeing
% md11
pthrot=1;
nmeas=10;ncon=3;
Dp=[0;0];
T1=100;
alpha1G=0.01;
Rn0=7600;
Vc0=84.7;
alpha2G=10;
alpha3G=1;
alpha1f=2.5e-7;
alpha2f=0.025;
alpha3f=1;
gamaR=1;
u_ref=165;gama_ref=pi/60;GAMA_ref=0;GAMA=3;
h_ini = 30;




% flare control law
ap=[Xu Xw 0 -g 0;Zu Zw Zq 0 0;Mu Mw Mq 0 0;0 0 1 0 0;0 -1/U0  0 1 0]
Cpf=[1 0 0 0 0 0 0 0;0 1 0 0 0 0 0 0;0 0 0 U0 0 0 0 0;0 0 0 0 1 0 0 0]; Dp=[0 0 0;0 0 0];
bp=[XL XT XR;ZL ZT ZR;ML MT MR;0 0 0; 0 0 0]
np=5;% no of original plant states
ncp=np+ncon; % No of plant states + number of engines (controls)
ngs=2; % No of additional flare states
ncr=2+ncon; % No of performance criterion equations
noisep=ngs; % No of plant disturbance inputs
noisem=ngs;% No of measurement disturbance inputs
ndis=noisep+noisem;% Total No of disturbance inputs
tou=1;
T2=200;
A11=[ap bp; zeros(ncon,np) -pthrot*eye(ncon)]
A12=zeros(ncp,ngs)
A21=[-1/T2 0 0 0 0 0 0 0;0 1 0 -U0 -1/tou 0 0 0]

A22=[-1/T2 0;0 0]
B11=zeros(ncp,ndis);B12=[zeros(np,ncon);pthrot*eye(ncon)];
B21=[1/T2 0 0 0; 0  1 0 0];
B22=zeros(ngs,ncon);
%Criterion function
C11=zeros(ncr,ncp);
C12=[alpha1f  0 ;0  alpha2f;0  0; 0  0; 0  0];
D11=zeros(ncr,ndis);
D12=[0 0 0;0 0 0; alpha3f*eye(ncon)];

% Measurement
C21=[eye(ncp);zeros(ngs,ncp)];
C22=[zeros(ncp,ngs); eye(ngs)];
D21=zeros(10,3); % Change this!
D21=[zeros(ncp,ndis);0*eye(ngs) eye(ngs)]
[md nd]=size(D21);
rdef=min(md,nd)-rank(D21);
D22=zeros(nmeas,ncon);
Ag=[A11 A12;A21 A22]

Bg1=[B11' B21']'
Bg2=[B12' B22']'
Cg1=[C11 C12]
Cg2=[C21 C22]
Bg=[Bg1 Bg2]
Cg=[Cg1;Cg2]
Dg=[D11 D12;D21 D22]
Kgs=lqr(Ag, Bg2, eye(10), eye(ncon));
Kgs1=Kgs(:,1:7)
Kgs2=Kgs(:,8:10)
if rdef==0
P=ss(Ag, Bg  , Cg , Dg);
[Kfl,Cloop2,gnormz] = h2syn(P,nmeas,ncon);
else
Kfl=lqr(Ag, Bg2, eye(10), eye(ncon));
Kfl1=Kfl(:,1:8)
Kfl2=Kgs(:,9:10)
end

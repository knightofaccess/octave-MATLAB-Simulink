%DIMENSIONS
L=15; %Length (m)
a1=5;
a2=2*a1;
xcv=6.875;
b=3.7/2; %max thickness
HV=107.42; %hull volume
HRA = 22.5973; %hull refernce area
SW = 4.3; %Span width
FA = 2.88; %fin area

h0=200;

%INERTIAL PROPERTIES
mass = 136.8; %kg at altitude 200m
Ixx = 213; %kgm^2
Iyy = 3310; %kgm^2
Izz = 3211; %kgm^2
Ixz  = 88; %kgm^2
del=(Ixx*Izz)-(Ixz*Ixz);

%CENTRE OF MASS LOCATION (AT ALTITUDE 200M)
xc = 0; %metres
yc = 0; %metres
zc = -0.45; %metres

%PORT THRUSTER LOCATION
XL = 8.13; %metres
YL = 0.6; %metres
ZL = 0.2; %metres

%STERN THRUSTER LOATION
Xs = 12.5; %metres
ys = 0; %metres
Zs = 0.25; %metres

MT = 120; %Newtons, max thrust of each of the three identical thrusters
TL = 0.3;
TR = 0.3;
TS = 0.3;

Cdh0 = 0.025; %hull zero incidence drag co-efficent
Cdf0 = 0.006; %fin 0 incidence drag coeffient
Cdg0 = 0.01; %gondola 0 incidence drag coeffient
Cdch  = 0.5; %hull cross flow drag coeffient
Cdcf = 1; %fin cross flow drag coeffient
Cdcg = 1; %gondola cross flow drag coeffient
DiffCLAlpha = 5.73; %derivative of fin lift coeffient with respect to the angle of attack at 0 incidence
DiffCLZeta = 1.24; %derivative of fin lift coeffient with respect to the fin flap deflecting angle
Sh=22.5973;
Sref=Sh; %hull reference area Vh^(2/3)
Sf = 10.132; %fin reference area
Sg = 0.56; %gondola reference area
Lf1 = 7.05; %x distance from the origian to the aerodynamic centre of fins
Lf2 = 7.782; %x distance from the origin to geometric centre of fins
Lf3 = 1.098; %y,z-distance from the origin to the aerodynamic centre of fins
Lgx = 1.752; %x-distance from the origin to the aerodynamic centre of gondola
Lgz = 2.4; %z-distance from the origin to the aerodynamic centre of gondola
Nf = 0.29; %fin efficiency factor accounting for the effect of the hull on the fins
Nk = 1.19; %hull efficiency factor accounting for the effect of the fins on the hull
a=b/0.246;
e = 0.9691;
f = 4.1543;
g = 0.0669;
Alphak = 0.1462;
Betak = 0.9259;
fh=0.5536;
SREF = 2.1017;
I1 = 0.33;
I2 = -0.69;
J1 = 1.31;
J2 = 0.53;
K21 = (Betak/(Betak-2))-(Alphak/(Alphak-2));


CX1 = -(Cdh0*Sh+Cdf0*Sf+Cdg0*Sg);
CY1 = K21*Nk*Sh*I1;
CY2 = (-1/2)*DiffCLAlpha*Sf*Nf;
CY3 = -((Cdch*J1*Sh)+(Cdcf*Sf)+(Cdcg*Sg));
CY4 = (-1/2)*DiffCLZeta*Sf*Nf;
CZ3 = -((Cdch*J1*Sh)+(Cdcf*Sf));
CL1 = (1/2)*DiffCLZeta*Sf*Nf*Lf3;
CL2 = -Cdcg*Sg*Lgz;
CM1 = K21*Nk*Sh*I2*L;
CM2 = (-1/2)*DiffCLAlpha*Sf*Nf*Lf1;
CM3 = -((Cdch*J2*Sh*L)+(Cdcf*Sf*Lf2));
CM4 = (-1/2)*DiffCLZeta*Sf*Nf*Lf1;

%DEFLECTIONS
top = 0;
bottom = 0;
left = 0;
right = 0;
u0 = 10;
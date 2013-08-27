function [c,ceq] = cons_path(pinput,param)

tauf=pinput(5);
dddot_x0=pinput(1);dddot_h0=pinput(2);dddot_y0=pinput(6);
dddot_xf=pinput(3);dddot_hf=pinput(4);dddot_yf=pinput(7);
%A matrix calculation t=[-1,1]
tf=tauf;
t0=0;

A=chebbcmatrix( 8,[t0,tf] );

%  boundary  condition vector
cx =[param.x_t0;
param.xdot_t0;
param.xddot_t0;dddot_x0;
param.x_tf;
param.xdot_tf;
param.xddot_tf;dddot_xf];  

ch =[param.h_t0;
param.hdot_t0;
param.hddot_t0;dddot_h0;
param.h_tf;
param.hdot_tf;
param.hddot_tf;dddot_hf];  

cy =[param.y_t0;
param.ydot_t0;
param.yddot_t0;dddot_y0;
param.y_tf;
param.ydot_tf;
param.yddot_tf;dddot_yf];  


B=A\cx;
ax=fliplr(B(:,1)');

B2=A\ch;
ah=fliplr(B2(:,1)');

B3=A\cy;
ay=fliplr(B3(:,1)');

x =chebfun(ax,[0,tauf],'coeffs');
h =chebfun(ah,[0,tauf],'coeffs');
y =chebfun(ay,[0,tauf],'coeffs');

[V, L, T, gamma,n,chi,phi] = longinvertdynFW(x,h,y);
Vdot=diff(V);

%t = pinput(1);
%a6x = pinput(1);a7x = pinput(2);
%a6h = pinput(3);a7h = pinput(4);

%x =chebfun([param.a0x,param.a1x,param.a2x,param.a3x,param.a4x,param.a5x,a6x,a7x],'coeffs');
%h =chebfun([param.a0h,param.a1h,param.a2h,param.a3h,param.a4h,param.a5h,a6h,a7h],'coeffs');

%x_final = x_dot*t; % x position at t = tflight
%h_final = h_dot*t-0.5*param.g*t^2; % y position at t = tflight


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vmin=15;
Vmax=30;
Vdotmax=5;
gammamax=30*pi/180;

Tmin=4; %Newtons ?
Tmax=20;
%nmin=0.6;
%nmax=1.4;
nmin=0.6;
nmax=1.5;
%Spehere radius calc for OBS
%AVOIDENCE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=sqrt((220-x).^2+(5-y).^2);
% constraints

c = [-min(V)+Vmin;        % speed between 15 and 30 m/s
max(V)-Vmax;          % speed between 15 and 30 m/s
    max(Vdot)-Vdotmax;
   -min(gamma)-gammamax;
   max(gamma)-gammamax;
   -min(T)+Tmin;
    max(T)-Tmax;
    -min(n)+nmin
  max(n)-nmax;]

%Obs avoid constraint add to code if needed%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%[-min(f)+30]
% equality constraints 
ceq = []; % we do not have any equality constraints (say)

% equality constraints require that the COMPUTED position at t = tflight
% equal the PRESCRIBED target position
%cineq = [max(gama)-param.gama1;max(-gama)+param.gama2;max(x)-param.xT;max(h)-param.hT];
%cineq = [max(x)-param.x_tf;max(h)-param.h_tf];
%cineq = [max(gama)-param.gama1;-min(gama)+param.gama2;max(vel)-230;-min(vel)+30;max(diff(vel))-5.6];
%cineq = [max(gama)-param.gama1;-min(gama)+param.gama2;max(diff(vel))-5.6];
%max(x)-param.xT;max(h)-param.xT

%end

end
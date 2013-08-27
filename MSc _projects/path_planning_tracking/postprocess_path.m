function [xlist, hlist, ylist,vel,chiA , phiA, gammaA,xv,yv,hv,xddot_v,yddot_v,hddot_v]=postprocess_path(pinput,param)


close all;

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
%initial conditions
x_t0=param.x_t0;     h_t0=param.h_t0; y_t0=param.y_t0;


%terminal conditions
x_tf=param.x_tf;    h_tf=param.h_tf; y_tf=param.y_tf;

figure(2)
subplot(3,2,1)
plot(V);
ylabel('V(ms-1)')
xlabel('time(s)')
grid on;
subplot(3,2,2)
plot(y);
ylabel('y(m)')
xlabel('time(s)')
grid on;
subplot(3,2,3)
plot(h);
ylabel('h(m)')
xlabel('time(s)')
grid on;
subplot(3,2,4)
plot(gamma);
ylabel('gamma(rad)')
xlabel('time(s)')
grid on;
subplot(3,2,5)
plot(Vdot);
ylabel('Vdot(ms-2)')
xlabel('time(s)')
grid on;
subplot(3,2,6)
plot(T);
ylabel('T(N)')
xlabel('time(s)')
grid on;
tm=[0:.5:tauf]';

X=x(tm);
Y=y(tm);
H=h(tm);
figure(1);
plot3(x_t0,y_t0,h_t0,'rs'); hold on; 
plot3(x_tf,y_tf,h_tf,'ro');
plot3(X,Y,H,'*');


h =-chebfun(ah,[0,tauf],'coeffs');
[V, L, T, gamma,n,chi,phi] = longinvertdynFW(x,h,y);
Vdot=diff(V);
xv=diff(x);
yv=diff(y);
hv=diff(h);
hddot_v=diff(hv);
xddot_v=diff(xv);yddot_v=diff(yv);



%initial conditions
x_t0=param.x_t0;     h_t0=param.h_t0; y_t0=param.y_t0;


%terminal conditions
x_tf=param.x_tf;    h_tf=param.h_tf; y_tf=param.y_tf;



xlist = x; % x position at t = tflight
hlist = -h; % y position at t = tflight
ylist = y;




vel = V;
chiA=chi;
phiA=phi;
gammaA=gamma;
% figure(1);
% plot3(x_t0,y_t0,h_t0,'rs'); hold on; 
% plot3(x_tf,y_tf,h_tf,'ro');
% stem3(xlist,ylist,hlist,'r','Marker','none','LineWidth',0.5);
% plot3(xlist,ylist,hlist,'b','LineWidth',2.5); 
% 
%  
% 
% grid on;
% 
% 
% hold off 
% title('3D UAV trajectory') 
% xlabel('x') 
% ylabel('y') 
% zlabel('h') 
% legend('initial position','trajectory','Target position','Location','NortheastOutside');
% tempx = [0; x]; tempy = [0; y];temph =[0; h];
% axis([(min(tempx)-min(tempx)) (max(tempx)+10) (min(tempy)-min(tempy)) (max(tempy)+10) (min(temph)-min(temph)) (max(temph)+10)]);

 




end
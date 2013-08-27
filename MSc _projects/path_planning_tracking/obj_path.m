function cost = obj_path(pinput,param)



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


%B=A\[cx,ch];% Chebychev polynomial coeeficients to meet boundary conditions ax=fliplr(B(:,1)'); % reorder and place x coefficients in row vector ah=fliplr(B(:,2)'); % reorder and place h coefficients in row vector

%Calculating the boundary condition coeffs
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

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%% cost function
%w1=1e7; % weighting on thrust control cost
%w2=1e8; % weighting on lift control cost
%cost=[sum(T.^2/w1+L.^2/w2), tf]
cost=tauf;% cost function


return


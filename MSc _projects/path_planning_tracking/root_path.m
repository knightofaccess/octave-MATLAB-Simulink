
function [O]= root_path(u1,u2,u3,u4,u5,u6,u7,u8,u9)
close all; % starting with a clean slate

%initial conditions

x_t0=u1;
xdot_t0=u2;
xddot_t0=u3;
h_t0=u4;
hdot_t0=u5;
hddot_t0=u6;
y_t0=u7;
ydot_t0=u8;
yddot_t0=u9;

param.x_t0=x_t0;     param.h_t0=h_t0;     param.y_t0=y_t0;
param.xdot_t0=xdot_t0;  param.hdot_t0=hdot_t0;   param.ydot_t0=ydot_t0;
param.xddot_t0=xddot_t0; param.hddot_t0=hddot_t0;   param.yddot_t0=yddot_t0;




%terminal conditions
% param.x_tf=x_tf ;param.h_tf=h_tf;      param.y_tf=y_tf;
% param.xdot_tf=30;  param.hdot_tf=0;      param.ydot_tf=0;  
% param.xddot_tf=0; param.hddot_tf=0;     param.yddot_tf=0;
% param.x_tf=500 ;param.h_tf=50;      param.y_tf=15;
% param.xdot_tf=23;  param.hdot_tf=0;      param.ydot_tf=0;  
% param.xddot_tf=0; param.hddot_tf=0;     param.yddot_tf=0;
% % % % % % % Climbing and turning%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% param.x_t0=10;     param.h_t0=50;     param.y_t0=0;
% param.xdot_t0=23.5;  param.hdot_t0=0;   param.ydot_t0=0;
% param.xddot_t0=0; param.hddot_t0=0;   param.yddot_t0=0;

% param.x_tf=400 ;param.h_tf=50;      param.y_tf=60;
% param.xdot_tf=10;  param.hdot_tf=0;      param.ydot_tf=23;  
% param.xddot_tf=0; param.hddot_tf=0;     param.yddot_tf=0;
% % % % % % % % % obs avodence &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

%  param.x_t0=0;     param.h_t0=50;     param.y_t0=15; param.xdot_t0=30;
% param.hdot_t0=0;   param.ydot_t0=0; param.xddot_t0=0; param.hddot_t0=0;
% param.yddot_t0=0;
% % 
param.x_tf=500 ;param.h_tf=50;      param.y_tf=5; param.xdot_tf=30;
param.hdot_tf=0;      param.ydot_tf=0; param.xddot_tf=0;
param.hddot_tf=0;     param.yddot_tf=0;



%  x_tf= param.x_tf;
%         h_tf= param.h_tf;
%         y_tf=param.y_tf;
%      xdot_tf=param.xdot_tf;
%      hdot_tf=param.hdot_tf;
%      ydot_tf=param.ydot_tf;
%     xddot_tf=param.xddot_tf;
%     hddot_tf=param.hddot_tf;
%     yddot_tf=param.yddot_tf;

dddot_x0=-1;dddot_h0=-1;dddot_xf=-1;dddot_hf=-1;tauf_f=15;dddot_y00=-1;dddot_yff=-1; % TRY CHANGING the initial guesses to see if the convergence is still reasonable

% arrange initial guessed for the unknowns into a single vector
pinput_0 = [dddot_x0;dddot_h0;dddot_xf;dddot_hf;tauf_f;dddot_y00;dddot_yff];



%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%
% Using MATLAB nonlinear optimization solved 'fmincon' to compute the
% optimal launch conditions and time of flight

Aineq = []; Bineq = []; % we have no linear inequality constraints
Aeq = []; Beq = []; % we have no equality constraints
LB = [-5; -5; -5;-5;0;-5;-5];  % lower bound on the unknown variables
UB = [Inf; Inf; Inf;Inf;Inf;Inf;Inf]; % upper bound on the unknown variables

    
 options = optimset('display','iter','algorithm','interior-point','MaxFunEvals',20000,'AlwaysHonorConstraints','bounds','tolcon',1e-2,'tolx',1e-1,'TolFun',1e-1);

[presult,optfval,pexitflag,poutput,plambda] = ...
    fmincon(@obj_path,pinput_0,Aineq,Bineq,Aeq,Beq,LB,UB,@cons_path,options,param)



pinput=(presult)'
[xlist, hlist, ylist ,vel,chiA , phiA, gammaA,xv,yv,hv,xddot_v,yddot_v,hddot_v]=postprocess_path(pinput,param);
time =(0:0.02:optfval)';
c_size = size(time,1)

x_points =xlist(time);
h_points =hlist(time);
y_points =ylist(time);
Vel=vel(time);
phia=phiA(time);
chia=chiA(time);
gammaa=gammaA(time);
Xv=xv(time);
Yv=yv(time);
Hv=hv(time);
xddot1=xddot_v(time);yddot1=yddot_v(time);hddot1=hddot_v(time);
% plot(x_points,'*');

% plot(h_points,'*');
O1=x_points;
O2=h_points;
O3=y_points;
O4=Vel;
O5 = phia;
O6=chia;
O7= gammaa;
O8=Xv;
O9=Yv;
O10=Hv;
O11=xddot1;
O12=yddot1;
O13=hddot1;

%%%%%%%%%change output array column lenth by changing ap and out put data
%%%%%%%%%by changing O number
ap=850;
O=[O1(1:ap), O2(1:ap), O3(1:ap),O4(1:ap),O5(1:ap),O6(1:ap),O8(1:ap),O9(1:ap),O10(1:ap),O7(1:ap)];

% [x,y,z] = sphere();
% r = 30;
% surf( r*x+220, r*y+5, r*z+50 );
% para=[u1,u2,u3,u4,u5,u6,u7,u8,u9, x_tf,h_tf,y_tf,xdot_tf,hdot_tf, ydot_tf,xddot_tf,hddot_tf,yddot_tf];
% O=[pinput,para'];

end

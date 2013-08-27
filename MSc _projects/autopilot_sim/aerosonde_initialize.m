%aerosonde_initialize.m
%   Aerosonde UAV Initialization Routine
%   
%   Copyright 2002 Unmanned Dynamics, LLC 
%   Modified JFW using Mathworks Aerospace Blockset 2 March 2011
%   For internal use only

% add ell4 path
%path(path,'C:\Documents and Settings\eh3081\My Documents\MATLAB\ATRAEAII\ell4')
%%  obtain aircraft data 
eagleray=aerosonde_data
 

%% Define initial state values  

theta_trim = 0;
q_trim =0;
chi_trim = 0;               % initial heading
h_trim=500;                % initial altitude

position_0 = [0; 0; -h_trim]%  position in inertial axes [Xe,Ye,Ze]: (m)
velocity_0 = [23; 0; 0]     %  velocity in body axes [u,v,w]: (m/s), yaw]: (rad)
rates_0 = [0; q_trim ; 0]   %  body rotation rates [p,q,r]: (rad/s)
euler_0 = [theta_trim; 0; 0]%  Euler orientation [roll, pitch, yaw]: (rad)
fuel_0 = 2                  %  fuel mass: (Kg)
Omega_0 = 5000*pi/30        %  engine speed: (rad/s); 
 
%% Define controls  

% controller initial states
flap= 0;
mixture = 13;
ignition = 1;
eta_trim=-0.1;   % elevator
xi_trim=0;       % aileron
zeta_trim=0;     % rudder
tau_trim=0.4;    %throttle
 
%for open loop case
control_0 = [flap; % flap
    eta_trim;      % elevator
    xi_trim;       % aileron
    zeta_trim;     % rudder
    tau_trim;      % throttle
    mixture;       % mixture
    ignition];     % ignition (1=on)






% San Fransisco Airport
% airport_ID : KSFO
% runway_ID : 10L
% latitude  = 37.76   
% longitude = -122.4

% get machine that Flightgear will run on
% host machine is 127.0.0.1
% 
%java.net.InetAddress.getByName('SOXP13426C')% 



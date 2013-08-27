
function eagleray=bwb11_data

%%% AERODYNAMICS %%%
% Aerodynamic force application point (usually the aerodynamic center)[x y z]
%(Location of the aerodynamic center with respect to the origin, in meters
eagleray.rAC = [29.1 0 0]; % m

%%% Aerodynamic parameter bounds %%%
% (the model will limit the parameters below to these intervals, to keep aerodynamics within linear region)
% Airspeed bounds
eagleray.VaBnd = [0 230]; % m/s
% Sideslip angle bounds
eagleray.BetaBnd = [-0.3 0.3]; % rad
% Angle of attack bounds
eagleray.AlphaBnd = [-16 24]; % rad

%%% Aerodynamic reference parameters %%%
% Mean aerodynamic chord
eagleray.MAC = 26.9; % m
% Wing span
eagleray.b = 79; % m
% Wing area
eagleray.S = 1372; % m^2

% ALL aerodynamics derivatives are per radian:
%%% Lift coefficient %%%
% Zero-alpha lift
eagleray.CL0 = 0.002;
% alpha derivative
eagleray.CLa = 4.13;
% Lift control (flap) derivative
eagleray.CLdf = 0; 
% Pitch control (elevator) derivative
eagleray.CLde = 0.573; 
% alpha-dot derivative
eagleray.CLalphadot = 1.9724; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Pitch rate derivative
eagleray.CLq = 2.6;
% Mach number derivative
eagleray.CLM = 0; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut

%%% Drag coefficient %%%
% Lift at minimum drag
eagleray.CLmind = 0.002;
% Minimum drag
eagleray.CDmin = 0.013;
% Lift control (flap) derivative
eagleray.CDdf = 0;
% Pitch control (elevator) derivative
eagleray.CDde = 0.0234;
% Roll control (aileron) derivative
eagleray.CDda = 0.0135; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Yaw control (rudder) derivative
eagleray.CDdr = 0.0303; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Mach number derivative
eagleray.CDM = 0; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Oswald's coefficient
eagleray.osw = 0.84; 
% pieaR, constant = \pi *e *AR where the wing aspect ratio AR=b^2/S
eagleray.AR =eagleray.b^2/eagleray.S;
eagleray.pieaR = pi*eagleray.osw*eagleray.AR;
%%% Side force coefficient %%%
% Sideslip derivative
eagleray.CYbeta = -0.3086; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Roll control derivative
eagleray.CYda = -3.78;
% Yaw control derivative
eagleray.CYdr = 0; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Roll rate derivative
eagleray.CYp = 0.0028;
% Yaw rate derivative
eagleray.CYr = -0.1655; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut

%%% Pitch moment coefficient %%%
% Zero-alpha pitch
eagleray.Cm0 = -0.294;
% alpha derivative
eagleray.Cma = -0.8995;
% Lift control derivative
eagleray.Cmdf = 0;
% Pitch control derivative
eagleray.Cmde = -0.1146;
% alpha_dot derivative
eagleray.Cmalphadot = -10.3796; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Pitch rate derivative
eagleray.Cmq = -2.32;
% Mach number derivative
eagleray.CmM = 0; %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut

%%% Roll moment coefficient %%%
% Sideslip derivative
eagleray.Clbeta = -0.195;
% Roll control derivative
eagleray.Clda = 0.00852;
% Yaw control derivative
eagleray.Cldr = 0.0059;   %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Roll rate derivative
eagleray.Clp = -0.249;
% Yaw rate derivative
eagleray.Clr = 0.126; 

%%% Yaw moment coefficient %%%
% Sideslip derivative
eagleray.Cnbeta = -0.0271;
% Roll control derivative
eagleray.Cnda = -0.000254;
% Yaw control derivative
eagleray.Cndr = 0;  %saluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut
% Roll rate derivative
eagleray.Cnp = -0.01623;
% Yaw rate derivative
eagleray.Cnr = -0.00486;


%%% SECTION 4 %%%
%%% INERTIA %%%
% Empty aircraft mass (zero-fuel)
eagleray.mempty =300469; % kg
% Gross aircraft mass (full fuel tank)
eagleray.mgross = 468348; % kg
% Empty CG location [x y z]
% (with respect to the origin)
eagleray.CGempty = [30.865 0 0]; % m
% Gross CG location [x y z]
% (with respect to the origin)
eagleray.CGgross = [30.435 0 0]; % m
% Empty moments of inertia [Jx Jy Jz Jxz]
eagleray.Jempty = [27526996 21481752 49008749 0]; % kg*m^2
% Gross moments of inertia [Jx Jy Jz Jxz]
eagleray.Jgross = [89068966 44861756 133930722 0]; % kg*m^2
%calorific value
eagleray.cali = 46.8 %J/kg
%efficency
eagleray.Efi = 0.7 %changes according to flght phase


%%% SECTION 5 %%%
%%% OTHER SIMULATION PARAMETERS %%%
% WMM-2000 date [day month year]
eagleray.dmy = [00 00 0000];

%%% SECTION 6 %%%
%%% engine model %%%

% Thrust value due to throttle authority N/rad
eagleray.ke =489.26667   %N/rad

%Engine time response(time constant)
eagleray.tc = 5 %sec

%CG to engine force vector distance
eagleray.z = 1%meters

%%% FINISHED ALL SECTIONS %%%


%%% OTHER SIMULATION PARAMETERS %%%
eagleray.g = 9.81; % m/s^2 gravitational constant

return
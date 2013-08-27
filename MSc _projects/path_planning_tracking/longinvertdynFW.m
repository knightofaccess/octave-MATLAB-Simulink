function [V, L, T, gamma,n,chi,phi] = longinvertdynFW(x,h,y)
%
% Inversion of longitudinal point-mass   
% dynamics for a fixed wing aircraft
%
% dynamics:
%   V^2 = hdot^2 + xdot^2
%   tan(gamma) = hdot / xdot
%   m Vdot = T - D - mg sin(gamma)
%   L = mg cos(gamma)
splitting on
m = 13.5;     % mass (kg) % 13.5 kg for Aerosonde; 
mg = m*9.81;  % weight = mg (N)
g=9.81;
xdot=diff(x);
%hdot=diff(h);
hdot=diff(h);%hamid


ydot=diff(y);
V2 = xdot.^2+hdot.^2+ydot.^2;    % square of airspeed (m/s)^2
V = sqrt(V2);            % airspeed (m/s)
gamma = asin(hdot./V);   % flight path angle (rad)
%L = mg*xdot./V;          % Lift (N) [L=mg cos gamma]
L=mg.*cos(gamma);
D = drag(V2,L);          % drag (N)    
T=D+m*diff(V)+mg*(hdot./V); % thrust (N)

n=L./mg;
chi=asin(ydot./(V.*cos(gamma))); %Heading angle
phi = atan(diff(chi).*(V.*cos(gamma)./(g.*cos(gamma)+V.*diff(gamma))));


end

%% -----------------------------------
function D=drag(V2,L);
% calculate drag
%
% V2 =  V^2 is square of airspeed (m/s)^2
% L is lift (N)
    
% constants for Aerosonde
    CD0 = 0.0434; % Minimum drag coefficient
    CLmind = 0.23;% Lift at minimum drag
    osw = 0.75;   % Oswalds coefficient (wing efficiency factor)
    rho = 1.225;   % mass density of air
    b = 2.8956;   % Wind span (m)
    S = 0.55;     % Wing area (m^2)
    
% drag calculation
    AR = b^2/S;   % wing aspect ratio
    CL = 2*L./(rho*S*V2);
    CD = CD0 + (CL-CLmind).^2./(pi*osw*AR);
    D = (rho*S/2)*CD.*V2;
    
end


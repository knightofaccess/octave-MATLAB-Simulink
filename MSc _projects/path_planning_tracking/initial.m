%% Define initial state values  
clear
theta_trim = 0;
q_trim =0;
chi_trim = 0;               % initial heading
h_trim=500;                % initial altitude

position_0 = [0; 5; 50]%  position in inertial axes [Xe,Ye,Ze]: (m)
velocity_0 = [30; 0; 0]     %  velocity in body axes [u,v,w]: (m/s), yaw]: (rad)
rates_0 = [0; q_trim ; 0]   %  body rotation rates [p,q,r]: (rad/s)
euler_0 = [theta_trim; 0; 0]%  Euler orientation [roll, pitch, yaw]: (rad)
fuel_0 = 2                  %  fuel mass: (Kg)
Omega_0 = 5000*pi/30        %  engine speed: (rad/s); 
 vel_0=sqrt(velocity_0(1)^2+velocity_0(2)^2+velocity_0(3)^2);
 
 phi_0=0; %???????????????????????/

 m=13.51;
 g=9.81;
 %%
% Tutorial 3, 2021: question 1
clear all; clc; 
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gerolamo Carboni 14/02/2019
% Updated: Nuria Peña Perez 04/02/2021
% Updated: Hannah 20/02/2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Initialisation

% Define sampling rate
dt = 0.01; % DEFINE HERE THE SAMPLING RATE

% Define movement duration
T = 20; % DEFINE HERE THE MOVEMENT DURATION

T_samples = fix(T/dt);

% Kinematic parameters
l = [0.31,0.34]; % m
% Dynamic parameters
m = [1.93,2.04]; % kg
I = [0.0141,0.0188]; %Inertia moments kg*m^2
cL = [0.165,0.2]; % m

% Initial joint angles
q_start = [0, 30*pi/180]; % WRITE HERE THE INITIAL JOINT ANGLES
shoulder_blocked = true;

%% Initialisation

q = zeros(T_samples,2);
q(1,:) = q_start;
qdot = zeros(T_samples,2);
qdot(1,:) = [0,0];
qddot = [0 0];

% Integration functions (uses Matlab anonymous function notation)

UpdateAngle = @(q,qdot)([q(1)+dt*qdot(1);
                       q(2)+dt*qdot(2)]); 

UpdateVel = @(qdot,qddot)([qdot(1)+dt*qddot(1);
                       qdot(2)+dt*qddot(2)]); 
                   
JointAccel = @(Torque,H,Cqdot)(H\(Torque-Cqdot)); %(given in dynamics lecture)



for i=1:T_samples

    if (i<200)
        Torque = -0.1.*qdot(i, :)'+[0, 0.02]'; %add the constant only to the elbow
    elseif (i>=200)
        Torque = -0.1*qdot(i, :)';
    end
    
    if (shoulder_blocked==true)
        Torque(1) = 0;
    end

    % Compute Dynamics
    H= mass(m,l,cL,I,q(i,:));
    Cqdot = coriolis(I,m,l,cL,q(i,:),qdot(i,:));
    qddot = JointAccel(Torque,H,Cqdot); 
    
    % Movement integration
    qdot(i+1,:) = UpdateVel(qdot(i,:),qddot);

    q(i+1,:) = UpdateAngle(q(i,:),qdot(i+1,:));
    
end

% Cartesian position of elbow and wrist/hand
for i = 1:size(q,1)

    X= kinFull(l,q(i,:));
    xwr(i) = X(1,2);  % Wrist
    ywr(i) = X(2,2);

    xe(i) = X(1,1);  % Elbow
    ye(i) = X(2,1);
end

%% Plots

% Visualize arm location
plotArm(xe, ye, xwr, ywr, 20, T)

t = 0:dt:T;
 

% Question 1.b/1.c
figure 
colororder("default")
plot(t,q(:,1)*180/pi,'linewidth',2);
hold on
plot(t,q(:,2)*180/pi,'r','linewidth',2);
legend('shoulder','elbow','Location','SouthEast')
xlabel('time [s]')
ylabel('angle [degree]')
set(gca,'fontsize',24)

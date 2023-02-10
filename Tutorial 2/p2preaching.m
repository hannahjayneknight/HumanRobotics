clear all;
clc;

T = 2;
dt = 0.001;
t = [ 0 : dt : T ];
t_n = t/T;

g = g(t_n);
x = -0.1334+0.1289.*g;
y = -0.0077+0.7355.*g;

qs_0 = pi/2;
qe_0 = 130*pi/180;
qw_0 = pi/2;

ls_0 = 0.3;
le_0 = 0.3;
lw_0 = 0.15;

% Forward kinematics to find initial position of end-effector
x_0 = ls_0*cos(qs_0) + le_0*cos(qe_0+qs_0-pi/2) + lw_0*cos(pi/2-qs_0-qe_0-qw_0);
y_0 = ls_0*sin(qs_0) - le_0*sin(qe_0+qs_0-pi/2) - lw_0*sin(pi/2-qs_0-qe_0-qw_0);

% trajectory of end-effector
x = x_0 + x;
y = y_0 + y;

plot3(x, y, t)
xlabel('x position')
ylabel('y position')
zlabel('time')
title('endpoint trajectory')




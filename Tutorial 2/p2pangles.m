clear all;
clc;

T = 2;
dt = 1;
t = [ 0 : dt : T ];
T_N = t/T;

% NB: position velocity from prev part
syms x(t_n) y(t_n)
x(t_n) = -0.1334+0.1289.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);
y(t_n) = -0.0077+0.7355.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);

xdot = diff(x);
ydot = diff(y);
pdot = [xdot; ydot]; 


% general equations for the end-effectors position
qe = (130*pi/180); % can play around with these - keep them fixed or change the ranges
qs = pi/2:pi/12:pi;
qw = pi/2:pi/12:pi;
ls = 0.3;
le = 0.3;
lw = 0.15;

%from 'checkingQ1.m' we have the Jacobian already
J = [ 
        [- le*cos(qe + qs - pi/2) - lw*cos(qe + qs + qw - pi/2), - le*cos(qe + qs - pi/2) - lw*cos(qe + qs + qw - pi/2) - ls*sin(qs), -lw*cos(qe + qs + qw - pi/2)]
        [- le*sin(qe + qs - pi/2) - lw*sin(qe + qs + qw - pi/2),   ls*cos(qs) - le*sin(qe + qs - pi/2) - lw*sin(qe + qs + qw - pi/2), -lw*sin(qe + qs + qw - pi/2)]
];

inverse = pinv(J); %since J is not square we need the pseudo inverse
qdot = inverse*pdot;
% NB: qdot = [ qs_dot, qe_dot, qw_dot ]

% subbing in values
qdot_vals = subs(qdot, t_n, T_N);

%plot qdot
plot(qdot_vals(2), T_N);
xlabel('qs dot');
ylabel('time');
title('joint velocity');

%integrate to find q wrt time
q = int(qdot);
q_vals = subs(q, t_n, T_N);

%plot q
%plot(q_vals(2), t_n);
%xlabel('qe dot');
%ylabel('qw dot');
%zlabel('time');
%title('joint angle');



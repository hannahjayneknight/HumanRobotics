clear all;
clc;

T = 2;
dt = 0.001;
t = [ 0 : dt : T ];
t_n = t/T;

% NB: position velocity from prev part
%syms x(t_n) y(t_n)
x = -0.1334+0.1289.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);
y = -0.0077+0.7355.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);

xdot = diff(x)/dt;
ydot = diff(y)/dt;
pdot = [xdot; ydot]; 


% conditions given in the question
qe = pi/2;
qs = 130*pi/180;
qw = pi/2;
ls = 0.3;
le = 0.3;
lw = 0.15;

%from 'checkingQ1.m' we have the Jacobian already
J = [
        - le*cos(qe + qs - pi/2) - lw*cos(qe + qs + qw - pi/2), - le*cos(qe + qs - pi/2) - lw*cos(qe + qs + qw - pi/2) - ls*sin(qs), -lw*cos(qe + qs + qw - pi/2);
        - le*sin(qe + qs - pi/2) - lw*sin(qe + qs + qw - pi/2), ls*cos(qs) - le*sin(qe + qs - pi/2) - lw*sin(qe + qs + qw - pi/2), -lw*sin(qe + qs + qw - pi/2)
];

inverse = pinv(J); %since J is not square we need the pseudo inverse
qdot = inverse*pdot;
% NB: each column of qdot is a new timestamp, row1= qs, row2=qe, row3=qw

f1 = figure;
figure(f1);
tiledlayout(1,3);

% left plot
nexttile
plot(t_n(2:end), qdot(1,:));
title('qs dot (joint s velocity) vs time')

% middle plot
nexttile
plot(t_n(2:end), qdot(2,:));
title('qe dot (joint e velocity) vs time')

% right plot
nexttile
plot(t_n(2:end), qdot(3,:));
title('qw dot (joint w velocity) vs time')


%integrate to find q wrt time
qs = cumtrapz(dt, qdot(1,:));
qe = cumtrapz(dt, qdot(2,:));
qw = cumtrapz(dt, qdot(3,:));

f2 = figure;
figure(f2);
tiledlayout(1,3);

% left plot
nexttile
plot(t_n(2:end), qs);
title('position of qs wrt time')

% middle plot
nexttile
plot(t_n(2:end), qe);
title('position of qe wrt time')

% right plot
nexttile
plot(t_n(2:end), qw);
title('position of qw wrt time')



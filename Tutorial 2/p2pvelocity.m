clear all;
clc;

T = 2;
dt = 0.001;
t = [ 0 : dt : T ];
T_N = t/T;


syms x(t_n) y(t_n)
x(t_n) = -0.1334+0.1289.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);
y(t_n) = -0.0077+0.7355.*(t_n.^3) .* ( 6.*(t_n.^2) - 15.*t_n + 10);

xdot = diff(x);
ydot = diff(y);

xdot_vals = subs(xdot, t_n, T_N);
ydot_vals = subs(ydot, t_n, T_N);
plot3(xdot_vals, ydot_vals, T_N);
xlabel('x velocity')
ylabel('y velocity')
zlabel('time')
title('endpoint velocity')
clear all;
clc;

T = 2;
t = [ 0 : 0.2 : T ];
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


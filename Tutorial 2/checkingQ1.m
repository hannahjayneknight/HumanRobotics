clear all;
clc;

syms ls le lw qs qe qw; 

%position of elbow
Ex = ls*cos(qs);
Ey = ls*sin(qs);

%position of wrist
Wx = Ex - le*sin(qe+qs-pi/2);
Wy = Ey + le*cos(qe+qs-pi/2);

%position of hand
Hx = Wx - lw*sin(qs+qe+qw-pi/2);
Hy = Wy + lw*cos(qs+qe+qw-pi/2);
Htheta = qe + qs + qw;

J = jacobian([Hx; Hy; Htheta], [qe qs qw])
s = tf('s');              % define Laplace variable
sys = (s+3)/((s)*(s+1)*(s^2 + 4*s + 16));       % open-loop transfer function
%rlocus(sys);             % plot root locus
%grid on;                 % adds grid (important)
%clc; clear; close all;

rlocus(sys)
axis([-6 6 -6 6])
axis square
grid on
title('Root Locus')
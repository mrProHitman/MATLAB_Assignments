clc; clear; close all;

syms x(t)

% Differential equation
Dx = diff(x,t);
D2x = diff(x,t,2);

ode = D2x + 3*Dx + 2*x == 0;

% Initial conditions
cond1 = x(0) == 0.1;
cond2 = Dx(0) == 0.05;

% Solve ODE
xSol(t) = dsolve(ode,[cond1 cond2]);

disp('Displacement x(t) = ');
pretty(xSol)

% Plot response
fplot(xSol,[0 10],'LineWidth',2)
grid on
xlabel('Time (s)')
ylabel('Displacement x(t) (m)')
title('Motion of Mass-Spring-Damper System')

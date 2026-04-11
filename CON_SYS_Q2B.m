clc; clear; close all;
num = [25];
den = [1 6 25];
t = 0:0.01:100;
sys = tf(num, den);
[y, t1] = step(sys, t);
figure;
plot(t1,y,'LineWidth', 2)
axis([0 5 0 2])
xlabel('time(s)')
ylabel('Step response')
title('Step response of the given transfer function')
grid on
info = stepinfo(sys);
disp(info)
den = [1 8 37 50]
sys = tf(num, den);
[y, t1] = step(sys, t);
figure;
plot(t1, y, 'LineWidth', 2)
xlabel('time(s)')
ylabel('Step response')
title('Step response of the given transfer function')
grid on
axis([0 100 0 1])
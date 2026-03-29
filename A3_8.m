clc; clear; close all;
ID_NO = '2024A3PS0378P';
A = ID_NO(12) - 48 + 4; %12
W = ID_NO(11) - 48 + 3; %10
X = ID_NO(12) - 48 + 10; %18
t = linspace(-10, 10, 20000);
dt = t(2) - t(1);
x = @(t) exp(-(abs(t)));
h = @(t) (sin(A*W*t)./(pi*t)) .* (t ~= 0) + (A*W/pi) .* (t == 0);
figure;
subplot(3, 1, 1)
plot(t, x(t), 'LineWidth', 2);
grid on
xlabel('Time')
ylabel('x(t)')
subplot(3, 1, 2)
plot(t, h(t), 'LineWidth', 2)
grid on
xlabel('Time')
ylabel('h(t)')
y = @(tt) integral(@(tau) x(tau).*h(tt - tau), -20, 20);
y_values = arrayfun(y, t);
subplot(3, 1, 3)
plot(t, y_values, 'LineWidth', 2)
grid on
xlabel('Time')
ylabel('y(t)')
%%
x_values = x(t);
h_values = h(t);
Xf = fftshift(fft(x_values))*dt;
N = numel(t);
f = (-N/2:N/2-1) * (1/(dt*N));
omega = 2*pi*f;
figure;
subplot(3,1,1)
plot(omega, abs(Xf), 'LineWidth', 2)
xlabel('omega')
ylabel('|X(jw)|')
Hf = fftshift(fft(h_values))*dt;
subplot(3, 1, 2)
plot(omega, h_values, 'LineWidth', 2);
grid on
xlabel('omega')
ylabel('|H(jw)|')
Yf = fftshift(fft(y_values))*dt;
subplot(3, 1, 3)
plot(omega, abs(Yf), 'LineWidth', 2);
grid on
xlabel('omega')
ylabel('|Y(jw)|')

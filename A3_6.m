clc; clear; close all;
ID_NO = '2024A3PS0378P';
A = ID_NO(12) - 48 + 4;
W = ID_NO(11) - 48 + 3;
X = ID_NO(12) - 48 + 10;
t = linspace(-10, 10, 2000);  % <-- You must define t
dt = t(2) - t(1);
x1_func = @(x) A*(abs(x) < W/2);
x2_func = @(x) x1_func(-2*x);
x1 = 2.*x1_func(t);
x2 = x1_func(-2*t);
figure;
subplot(2, 1, 1)
plot(t, x1, 'LineWidth', 2)
grid on
subplot(2, 1, 2)
plot(t, x2, 'LineWidth', 2)
grid on
y = @(tt) integral(@(tau) x1_func(tau).*x2_func(tt - tau), -20, 20);
y_values = arrayfun(y, t);
%% 
figure;
subplot(5, 1, 1);
plot(t, y_values, 'LineWidth', 2)
grid on
title('Time:x(t)')
xlabel('Time(s)')
ylabel('Amplitude')
N = length(y_values);
Yf = fftshift(fft(y_values))*dt;
f = (-N/2:N/2-1) * (1/(dt*N));
omega = 2*pi*f;
subplot(5,1,2)
plot(f, abs(Yf), 'LineWidth', 2)
grid on
title('Magnitude Spectrum')
xlabel('Frequency(Hz)')
ylabel('Magnitude(Mag)')
subplot(5,1,3)
plot(omega, angle(Yf), 'LineWidth', 2);
grid on
title('Phase Spectrum')
xlabel('Frequency (Hz)')
ylabel('Phase (radians)')
xlim([-1 1])
omega_c = 8;   % cutoff in rad/s (CHANGE THIS AS YOU LIKE)
LP_filter = abs(omega) < omega_c;  % rectangular LPF window
Yf_LP = Yf .* LP_filter;           % apply low-pass filter
y_rec = ifft(ifftshift(Yf_LP))/dt;
subplot(5, 1, 4)
plot(t, y_rec, 'LineWidth', 2)
grid on
title('FS Synthesis (+-8)')
xlabel('Time(s)')
ylabel('Amplitude')
omega_c = 80;
LP_filter2 = abs(omega) < omega_c;
Yf_LP = Yf.*LP_filter2;
y_rec2 = ifft(ifftshift(Yf_LP))/dt;
subplot(5, 1, 5)
plot(t, y_rec2, 'LineWidth', 2)
grid on
title('FS Synthesis (+-80)')
xlabel('Time(s)')
ylabel('Amplitude')

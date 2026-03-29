clc; clear; close all;
ID_NO = '2024A3PS0378P';
A = ID_NO(12) - 48 + 4; %12
W = ID_NO(11) - 48 + 3; %10
X = ID_NO(12) - 48 + 10; %18
t = linspace(-10, 10, 20000);
dt = t(2) - t(1);
x_func = @(x) sin(x.*t)./(pi.*t);
x = x_func(A*W);
figure;
subplot(5, 1, 1);
plot(t, x, 'LineWidth', 2)
grid on
title('Time:x(t)')
xlabel('Time(s)')
ylabel('Amplitude')
Xf = fftshift(fft(x))*dt;
N = numel(t);
f = (-N/2:N/2-1) * (1/(dt*N));
omega = 2*pi*f;
subplot(5,1,2)
plot(f, abs(Xf), 'LineWidth', 2)
grid on
title('Magnitude Spectrum')
xlabel('Frequency(Hz)')
ylabel('Magnitude(Mag)')
subplot(5,1,3)
plot(f, angle(Xf), 'LineWidth', 2);
grid on
title('Phase Spectrum)')
xlabel('Frequency (Hz)')
ylabel('Phase (radians)')
xlim([-1 1])
omega_c = 8;   % cutoff in rad/s (CHANGE THIS AS YOU LIKE)
LP_filter = abs(omega) < omega_c;  % rectangular LPF window
Xf_LP = Xf .* LP_filter;           % apply low-pass filter
x_rec = ifft(ifftshift(Xf_LP))/dt;
subplot(5, 1, 4)
plot(t, x_rec, 'LineWidth', 2)
grid on
title('FS Synthesis(+-8)')
xlabel('Time(s)')
ylabel('Amplitude')
omega_c2 = 80;
LP_filter2 = abs(omega) < omega_c2;
Xf_LP2= Xf.*LP_filter2;
x_rec2 = ifft(ifftshift(Xf_LP2))/dt;
subplot(5, 1, 5)
plot(t, x_rec2, 'LineWidth', 2)
grid on
title('FS Synthesis (+-80)')
xlabel('Time(s)')
ylabel('Amplitude')

clc; clear; close all;
t = -6:0.001:6;
T0 = 4;
t0 = 0;
omega0 = 2*pi*(1/T0);
x = @(t) square(omega0*t + pi/2)/2 + 0.5;

subplot(5, 1, 1);
plot(t, x(t), 'LineWidth', 2)
grid on
title('Square Wave')
N = 50;                    % compute Cn for n = -N..N
nvec = -N:N;
Cn = zeros(size(nvec));
t_fs = t0 : 0.001 : (t0 + T0); 
% Use integral for each harmonic
for k = 1:length(nvec)
    n = nvec(k);
    integrand = x(t_fs).*exp(-1j*n*omega0*t_fs);
    Cn(k) = (1/T0)*trapz(t_fs, integrand);
end
% Threshold to ignore phase where magnitude is negligible
mag = abs(Cn);
thresh = max(mag) * 1e-3;          % adjust threshold as needed

% Compute raw phase in radians
phase_rad = angle(Cn);              % in [-pi, pi]
phase_rad(mag < thresh) = NaN;      % mask noisy phases

% Plot magnitude and phase

subplot(5,1,2);
stem(nvec, mag, 'filled');
xlabel('Harmonic n'); ylabel('|C_n|');
title('Fourier Series Magnitude');
grid on;

subplot(5,1,3);
stem(nvec, rad2deg(phase_rad), 'filled');
xlabel('Harmonic n'); ylabel('Phase (degrees)');
title('Fourier Series Phase');
grid on;
n = -8:8;
x_rec = zeros(size(t));

for k = 1:length(n)
    x_rec = x_rec + Cn(nvec == n(k)) .* exp(1j*n(k)*omega0*t);
end

x_rec = real(x_rec);
subplot(5,1,4);
plot(t, x(t), 'k--', 'LineWidth', 1.5)
hold on
plot(t, x_rec, 'r', 'LineWidth', 1.2)
grid on
legend('Original signal', 'Fourier reconstruction')
title('Signal Reconstruction using Fourier Series')

x_rec = zeros(size(t));

for k = 1:length(nvec)
    x_rec = x_rec + Cn(k) * exp(1j * nvec(k) * omega0 * t);
end

x_rec = real(x_rec);   % imaginary part ≈ numerical error

subplot(5,1,5);
plot(t, x(t), 'k--', 'LineWidth', 1.5)
hold on
plot(t, x_rec, 'r', 'LineWidth', 1.2)
grid on
legend('Original signal', 'Fourier reconstruction')
title('Signal Reconstruction using Fourier Series')

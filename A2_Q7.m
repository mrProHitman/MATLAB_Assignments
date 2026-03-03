clc; clear; close all;
t = -6:0.001:6;
T0 = 4;
t0 = 0;
omega0 = 2*pi*(1/T0);
x = @(t) square(omega0*t + pi/2)/2;

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
mag = abs(Cn);
thresh = max(mag) * 1e-3;          % adjust threshold as needed

% Compute raw phase in radians
phase_rad = angle(Cn);              % in [-pi, pi]
phase_rad(mag < thresh) = NaN;      % mask noisy phases
Cn_diff = 1j * nvec * omega0 .* Cn;
dx_fs = zeros(size(t));

for k = 1:length(nvec)
    dx_fs = dx_fs + Cn_diff(k)*exp(1j*nvec(k)*omega0*t);
end
%%
%This will generate poles on the point where the function is changing from
%1 to 0 or 0 to 1
dt = t(2) - t(1);
dx_num = gradient(x(t), dt);
dx_fs = real(dx_fs);
figure
plot(t, dx_num, 'k--', 'LineWidth', 1.5)
figure;
plot(t, dx_fs, 'r', 'LineWidth', 1.2)
legend('Numerical derivative','FS using differentiation property')
title('Verification of Differentiation Property')
grid on
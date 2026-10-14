
clc;
clear;
close all;

% WR-90 Waveguide Parameters
a = 22.86e-3;
b = 10.16e-3;
f = 10e9;
c = 3e8;
mu0 = 4*pi*1e-7;
eps0 = 1/(mu0*c^2);

k0 = 2*pi*f/c;

% Cutoff Frequencies
fc_TE10 = c/(2*a);
fc_TM11 = (c/2)*sqrt((1/a)^2 + (1/b)^2);

% Propagation Constants
kc_TE10 = pi/a;
kc_TM11 = pi*sqrt((1/a)^2 + (1/b)^2);

beta_TE10 = sqrt(k0^2 - kc_TE10^2);
beta_TM11 = sqrt(complex(k0^2 - kc_TM11^2));

% Display Results
fprintf('TE10 vs TM11 MODE COMPARISON\n\n');

fprintf('TE10 Cutoff Frequency = %.4f GHz\n', ...
    fc_TE10/1e9);
fprintf('TM11 Cutoff Frequency = %.4f GHz\n', ...
    fc_TM11/1e9);

fprintf('\nTE10 Propagation Constant = %.2f rad/m\n', ...
    beta_TE10);
fprintf('TM11 Propagation Constant = %.2f + %.2fi rad/m\n', ...
    real(beta_TM11), imag(beta_TM11));

% Create Coordinate Grid
x = linspace(0,a,100);
y = linspace(0,b,60);
[X,Y] = meshgrid(x,y);

% TE10 Field Patterns (normalized)
Ey_TE10 = sin(pi*X/a);
Hz_TE10 = cos(pi*X/a);

figure;
surf(X*1000,Y*1000,Ey_TE10);
title('TE10 Electric Field');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Normalized Ey');
shading interp;
colorbar;

figure;
surf(X*1000,Y*1000,Hz_TE10);
title('TE10 Magnetic Field');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Normalized Hz');
shading interp;
colorbar;

% TM11 Field Patterns (normalized)
Ez_TM11 = sin(pi*X/a).*sin(pi*Y/b);

Ex_TM11 = (pi/a)*cos(pi*X/a).*sin(pi*Y/b);
Ey_TM11 = (pi/b)*sin(pi*X/a).*cos(pi*Y/b);

E_TM11 = sqrt(Ex_TM11.^2 + Ey_TM11.^2 + Ez_TM11.^2);

figure;
surf(X*1000,Y*1000,Ez_TM11);
title('TM11 Electric Field (Ez)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Normalized Ez');
shading interp;
colorbar;

figure;
surf(X*1000,Y*1000,E_TM11);
title('TM11 Electric Field Magnitude Pattern');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Relative Field Magnitude');
shading interp;
colorbar;

% Mode Decision
fprintf('\nMODE DECISION:\n');

if f > fc_TE10
    fprintf('TE10 propagates at 10 GHz.\n');
else
    fprintf('TE10 is below cutoff.\n');
end

if f > fc_TM11
    fprintf('TM11 propagates at 10 GHz.\n');
else
    fprintf('TM11 is below cutoff and is evanescent.\n');
end

% Optional HFSS comparison
fc_sim_TE10 = input('\nEnter HFSS TE10 cutoff (GHz): ')*1e9;
fc_sim_TM11 = input('Enter HFSS TM11 cutoff (GHz): ')*1e9;

dev_TE10 = abs(fc_sim_TE10-fc_TE10)/fc_TE10*100;
dev_TM11 = abs(fc_sim_TM11-fc_TM11)/fc_TM11*100;

fprintf('\nPercentage Deviation:\n');
fprintf('TE10 = %.4f %%\n',dev_TE10);
fprintf('TM11 = %.4f %%\n',dev_TM11);

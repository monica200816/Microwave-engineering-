
clc;
clear;
close all;

% Given parameters
a = 22.86e-3;       % Width (m)
b = 10.16e-3;       % Height (m)
L = 100e-3;         % Length (m)
f = 10e9;           % Operating frequency (Hz)
c = 3e8;            % Speed of light (m/s)

% Theoretical cutoff frequency
fc_theory = c/(2*a);

% Propagation constant
beta = (2*pi*f/c)*sqrt(1-(fc_theory/f)^2);

% Enter simulated cutoff frequency from HFSS
fc_simulated = input('Enter simulated cutoff frequency in GHz: ');
fc_simulated = fc_simulated*1e9;

% Percentage deviation
deviation = abs(fc_simulated-fc_theory)/fc_theory*100;

% Display results
fprintf('TE10 Mode Simulation Results\n');
fprintf('Theoretical cutoff frequency = %.4f GHz\n', fc_theory/1e9);
fprintf('Simulated cutoff frequency   = %.4f GHz\n', fc_simulated/1e9);
fprintf('Propagation constant beta    = %.4f rad/m\n', beta);
fprintf('Percentage deviation         = %.4f %%\n', deviation);

% E-field distribution (normalized)
x = linspace(0,a,100);
y = linspace(0,b,50);
[X,Y] = meshgrid(x,y);
E = sin(pi*X/a);

figure;
surf(X*1000,Y*1000,E);
xlabel('Width x (mm)');
ylabel('Height y (mm)');
zlabel('Normalized E-field');
title('TE10 Mode - E-field Distribution');
colorbar;
shading interp;

% H-field distribution (normalized magnitude)
H = cos(pi*X/a);

figure;
surf(X*1000,Y*1000,H);
xlabel('Width x (mm)');
ylabel('Height y (mm)');
zlabel('Normalized H-field component');
title('TE10 Mode - H-field Distribution');
colorbar;
shading interp;

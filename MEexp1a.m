
clc;
clear;
close all;

% WR-90 Waveguide Parameters
a = 22.86e-3;       % Width in metres
b = 10.16e-3;       % Height in metres
L = 100e-3;         % Length in metres
f = 10e9;           % Operating frequency (10 GHz)
c = 3e8;            % Speed of light

% TE10 Cutoff Frequency
fc_theory = c/(2*a);

% Propagation Constant
if f > fc_theory
    beta = (2*pi*f/c)*sqrt(1-(fc_theory/f)^2);
else
    beta = 0;
end

% Display Results
fprintf('TE10 Mode Results\n');
fprintf('Theoretical Cutoff Frequency = %.4f GHz\n', ...
    fc_theory/1e9);
fprintf('Operating Frequency = %.2f GHz\n', f/1e9);
fprintf('Propagation Constant beta = %.2f rad/m\n', beta);

% Field Distribution
x = linspace(0,a,100);
y = linspace(0,b,50);
[X,Y] = meshgrid(x,y);

% TE10 Electric and Magnetic Fields
Ey = sin(pi*X/a);
Hx = -Ey;
Hz = cos(pi*X/a);

% Plot E-field
figure;
surf(X*1000,Y*1000,Ey);
title('TE10 Electric Field Distribution');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Normalized Ey');
shading interp;
colorbar;

% Plot H-field
figure;
surf(X*1000,Y*1000,Hz);
title('TE10 Magnetic Field Distribution (Hz)');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Normalized Hz');
shading interp;
colorbar;

% Compare with simulated cutoff frequency
fc_sim = input('Enter HFSS cutoff frequency in GHz: ')*1e9;
deviation = abs(fc_sim-fc_theory)/fc_theory*100;

fprintf('HFSS Cutoff Frequency = %.4f GHz\n',fc_sim/1e9);
fprintf('Percentage Deviation = %.4f %%\n',deviation);

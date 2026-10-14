
clc;
clear;
close all;

% Input Parameters
Z0 = 50;              % Reference impedance (ohms)
ZL = 50;              % Load impedance (ohms)
L = 50e-3;             % Length in metres
f0 = 10e9;             % Centre frequency (Hz)
c = 3e8;               % Speed of light (m/s)

% Frequency Sweep
f = linspace(8e9,12e9,401);

% Assume a matched 50-ohm transmission line
Zin = ZL*ones(size(f));

% S-Parameters for ideal matched network
S11 = zeros(size(f));
S22 = zeros(size(f));

% Transmission phase
S21 = exp(-1j*2*pi*f*L/c);
S12 = S21;

% Values at 10 GHz
[~,idx] = min(abs(f-f0));

S11_10 = abs(S11(idx));
S21_10 = abs(S21(idx));

% Return Loss and Insertion Loss
RL = -20*log10(max(S11_10,eps));
IL = -20*log10(max(S21_10,eps));

% Transmission Efficiency
eta = S21_10^2*100;

fprintf('S-PARAMETERS AT 10 GHz\n');
fprintf('S11 = %.4f dB\n',20*log10(max(S11_10,eps)));
fprintf('S12 = %.4f dB\n',20*log10(abs(S12(idx))));
fprintf('S21 = %.4f dB\n',20*log10(S21_10));
fprintf('S22 = %.4f dB\n',20*log10(max(abs(S22(idx)),eps)));
fprintf('Return Loss = %.4f dB\n',RL);
fprintf('Insertion Loss = %.4f dB\n',IL);
fprintf('Transmission Efficiency = %.2f %%\n',eta);

% Plot S-Parameters
figure;
plot(f/1e9,20*log10(max(abs(S11),eps)),'r','LineWidth',2);
hold on;
plot(f/1e9,20*log10(abs(S21)),'b','LineWidth',2);
plot(f/1e9,20*log10(abs(S12)),'g--','LineWidth',1.5);
plot(f/1e9,20*log10(max(abs(S22),eps)),'k--','LineWidth',1.5);
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('S-Parameters of 50 Ohm Transmission Line');
legend('S11','S21','S12','S22');
grid on;

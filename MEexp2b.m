
clc;
clear;
close all;

% Parameters
Z0 = 50;
ZL = 50;
L = 50e-3;
c = 3e8;

% Frequency Sweep: 8 to 12 GHz
f = linspace(8e9,12e9,401);

% Ideal matched transmission line
S11 = zeros(size(f));
S21 = exp(-1j*2*pi*f*L/c);

% Find minimum S11 and maximum S21
[~,idx_min] = min(abs(S11));
[~,idx_max] = max(abs(S21));

f_min_S11 = f(idx_min);
f_max_S21 = f(idx_max);

% Select optimum frequency
f_opt = f_min_S11;

% Values at optimum frequency
S11_opt = abs(S11(idx_min));
S21_opt = abs(S21(idx_min));

RL_opt = -20*log10(max(S11_opt,eps));
IL_opt = -20*log10(max(S21_opt,eps));

% Values at 10 GHz
[~,idx10] = min(abs(f-10e9));
RL_10 = -20*log10(max(abs(S11(idx10)),eps));
IL_10 = -20*log10(max(abs(S21(idx10)),eps));

% Display Results
fprintf('OPTIMUM FREQUENCY ANALYSIS\n');
fprintf('Minimum S11 frequency = %.3f GHz\n',f_min_S11/1e9);
fprintf('Maximum S21 frequency = %.3f GHz\n',f_max_S21/1e9);
fprintf('Optimum frequency = %.3f GHz\n',f_opt/1e9);

fprintf('\nAt optimum frequency:\n');
fprintf('S11 = %.4f dB\n',20*log10(max(S11_opt,eps)));
fprintf('S21 = %.4f dB\n',20*log10(S21_opt));
fprintf('Return Loss = %.4f dB\n',RL_opt);
fprintf('Insertion Loss = %.4f dB\n',IL_opt);

fprintf('\nAt 10 GHz:\n');
fprintf('Return Loss = %.4f dB\n',RL_10);
fprintf('Insertion Loss = %.4f dB\n',IL_10);

% Plot S11 and S21
figure;
plot(f/1e9,20*log10(max(abs(S11),eps)),'r','LineWidth',2);
hold on;
plot(f/1e9,20*log10(abs(S21)),'b','LineWidth',2);
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Optimum Frequency Analysis');
legend('S11','S21');
grid on;

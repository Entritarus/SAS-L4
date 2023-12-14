clear variables
close all

% TODO :
% test with f_shift = f1
% test with f_shift = f2
% test with f_shift = some other frequency

% ///////////////////////
%      Definitions
% ///////////////////////
Fs = 50e6; % Sampling frequency
f1 = 1e6; % '1' component frequency
f2 = 3e6; % '0' component frequency
f_shift = f1; 
tau = 1/Fs;

% ///////////////////////
%       Bitstream
% ///////////////////////
N = 8;
b_t = randi([0 1], [1, N]);
t_bit = 1e-5;
b_t_upsampled = kron(b_t, ones(1, round(t_bit/tau)));

t = 0:tau:length(b_t_upsampled)*tau-tau;

% ////////////////////////
%     Applying methods
% ////////////////////////

spectral_method
analytic_method


fig7 = figure(7);
set(fig7, 'Position', [0 0 1280 720]);
plot(t, real(FSK_filt_sm)); hold on; grid on; grid minor;
plot(t, real(FSK_filt_am));
title("Comparing results");
xlabel('t, s');
ylabel('Filtered FSK');
ylim([-1.1 1.1]);
legend("Spectral Method","Analytical Method")
set(gca, 'FontSize', 12);


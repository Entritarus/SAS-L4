% ////////////////////////
%     Input FSK signal
% ////////////////////////

FSK_1 = cos(2*pi*f1*t).*b_t_upsampled;
FSK_2 = cos(2*pi*f2*t).*not(b_t_upsampled);

FSK = FSK_1 + FSK_2;

N = length(FSK);
spec_FSK = abs(fft(FSK))/N;
spec_FSK = spec_FSK(1:N/2)*2;

delta_f = Fs/N;
f = 0:delta_f:Fs/2-delta_f;

% ////////////////////////////
%     Filtering FSK signal
% ////////////////////////////

n = 1;
fn = f_shift*[0.9 1.1]/Fs*2;
[b, a] = butter(n, fn);
fvtool(b, a); grid on; grid minor;
xlim([0 1])
set(gca, 'FontSize', 12);

FSK_filt_sm = filter(b, a, FSK);

% ////////////////
%     Plotting
% ////////////////

fig2 = figure(2);
set(fig2, 'Position', [0 0 1280 720]);
hold on;
subplot(3,1,1);
plot(t, b_t_upsampled); grid on; grid minor;
title("Spectral method results");
xlabel('t, s');
ylabel('Bitstream');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

subplot(3,1,2);
plot(t, FSK); grid on; grid minor;
xlabel('t, s');
ylabel('FSK signal');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

subplot(3,1,3);
plot(t, FSK_filt_sm); grid on; grid minor;
xlabel('t, s');
ylabel('Filtered FSK signal');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

fig3 = figure(3);
set(fig3, 'Position', [0 0 1280 720]);
plot(f*1e-6, spec_FSK); grid on; grid minor;
title("FSK Signal Spectrum");
xlabel('f, MHz');
ylabel('F\{FSK\}');
set(gca, 'FontSize', 12);

% /////////////////////////////////////////////////////////////
%     Amplitudes of the analytic signal as baseband signals
% /////////////////////////////////////////////////////////////

FSK_m1 = b_t_upsampled.*exp(j*2*pi*(f1-f_shift)*t);
FSK_m2 = not(b_t_upsampled).*exp(j*2*pi*(f2-f_shift)*t);

% ////////////////////////////////
%     Bandpass Filter creation
% ////////////////////////////////

n = 1;
fn = f_shift*[0.9 1.1]/Fs*2;
[b, a] = butter(n, fn);

% shift spectrum of the filter BACKWARDS by 2*pi*f_shift
% z => z' = exp(s*tau - j*2*pi*f_shift*tau), and raise to matching power
for k = 1:length(b)
    bs(k) = exp(-j*(2*pi*f_shift)*(k-1)*tau)*b(k);
    as(k) = exp(-j*(2*pi*f_shift)*(k-1)*tau)*a(k);
end

fvtool(b, a, bs, as); grid on; grid minor;
xlim([0 1])
legend('Original Filter','Shifted Filter');
set(gca, 'FontSize', 12);

% //////////////////////////////////////
%     Filtering the baseband signals
% //////////////////////////////////////

FSK_m1_filt = filter(bs, as, FSK_m1);
FSK_m2_filt = filter(bs, as, FSK_m2);

% ///////////////////////////////////
%     Reassembling the FSK signal
% ///////////////////////////////////
FSK_filt1 = FSK_m1_filt.*exp(j*2*pi*f1*t);
FSK_filt2 = FSK_m2_filt.*exp(j*2*pi*f2*t);

FSK_filt_am = FSK_filt1+FSK_filt2;

% ////////////////
%     Plotting
% ////////////////

% Amplitudes of FSK components
fig5 = figure(5);
set(fig5, 'Position', [0 0 1280 720]);

subplot(2,1,1);
plot(t, real(FSK_m1_filt)); grid on; grid minor;
title("Analytic method. Amplitudes of filtered FSK components");
xlabel('t, s');
ylabel('Filtered FSK_{m1}');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

subplot(2,1,2);
plot(t, real(FSK_m2_filt)); grid on; grid minor;
xlabel('t, s');
ylabel('Filtered FSK_{m2}');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);


fig6 = figure(6);
set(fig6, 'Position', [0 0 1280 720]);
subplot(3,1,1);
plot(t, real(FSK_filt1));  grid on; grid minor;
title("Analytic method. Filtered FSK components");
xlabel('t, s');
ylabel('Filtered FSK_{1}');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

subplot(3,1,2);
plot(t, real(FSK_filt2));  grid on; grid minor;
xlabel('t, s');
ylabel('Filtered FSK_{2}');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);

subplot(3,1,3);
plot(t, real(FSK_filt_am));  grid on; grid minor;
xlabel('t, s');
ylabel('Filtered FSK signal');
ylim([-1.1 1.1]);
set(gca, 'FontSize', 12);



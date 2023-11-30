Fs = 10e6;
f1 = 1e6;
f2 = 3e6;
Fc = 1e6;

tau = 1/Fs;


N = 100;
b_t = randi([0 1], [1, N]);
t_bit = 1e-4;
b_t_upsampled = kron(b_t, ones(1, round(t_bit/tau)));


t = 0:tau:length(b_t_upsampled)*tau-tau;

modulated_1 = sin(2*pi*f1*t).*b_t_upsampled;
modulated_0 = sin(2*pi*f2*t).*not(b_t_upsampled);

FSK = modulated_1 + modulated_0;

N = length(FSK);
spec_FSK = abs(fft(FSK))/N;
spec_FSK = spec_FSK(1:N/2)*2;


delta_f = Fs/N;
f = 0:delta_f:Fs/2-delta_f;


n = 1;
fn = [f2*0.9 f2*1.1]/Fs*2;
[b, a] = butter(n, fn);
%[b,a] = zp2tf(z,p,k);
fvtool(b, a);

FSK_filt = filter(b, a, FSK);


figure(2)
hold on;
subplot(3,1,1);
plot(t, b_t_upsampled);
subplot(3,1,2);
plot(t, FSK);
subplot(3,1,3);
plot(t, FSK_filt);

figure(3);
plot(f*1e-6, spec_FSK);
xlabel('f, MHz')

% use BFSK
% one filter 

%---------------------------------------------------------------------------
% EX6_part2.m
%---------------------------------------------------------------------------

clear all;
format loose;


EbN0dB=0:35;
EbN0=10.^(EbN0dB/10);


% calculate awgn reference
awgn=0.5*erfc(sqrt(0.5*EbN0));

% calculate 1-order diversity rayleigh
ray1=0.5*(1-sqrt(EbN0./(2+EbN0)));

% calculate gamma_c
gamma_c = 0.25.*EbN0;

% calculate mu
mu = sqrt( gamma_c ./ (1+gamma_c) );

% calculate 2-order diversity rayleigh
ray2=((1-mu)./2).^2.*(2+mu);


%---------------------------------------------------------------------------
% Visualization
%---------------------------------------------------------------------------
figure

%
% plot ber curves
% ------------------------
semilogy(EbN0dB,awgn,'b');	       % AWGN
hold on
semilogy(EbN0dB,ray1,'g');	       % Rayleigh 1-path
hold on
semilogy(EbN0dB,ray2,'r');	       % Rayleigh 2-path

title('BER of BPSK over Rayleigh Fading with L order diversity')

box on
grid on
set(gca,'YScale','log')
%set(gca,'YTick',[1e-6 1e-4 1e-2 1e-0])
axis([0 35 1e-4 1e-0])
legend('AWGN','RAYLEIGH (L=1)','L=2')



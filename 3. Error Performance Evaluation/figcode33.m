% To generate figure 3.3

clear;close all;clc;j=1i;clc;
L = 30; % Number of Symbols
t = 1; % Delay
Ps = 0; % in dB
Ps_Linear = 10^(Ps/10); % Linear
Pr = 5; % in dB
Pr_Linear = 10^(Pr/10); % Linear
h_rr_gain =10; % in dB
h_rr_gain_Linear = 10^(h_rr_gain/10);
h_sd_gain = -5; % in dB
h_sd_gain_Linear = 10^(h_sd_gain/10);
Eb_N0_all = 0:2:30; % dB
Tx_number = 10^6; % Number of transmission
BER_all_FD = zeros(Tx_number,length(Eb_N0_all)); % Initialize
BER_all_HD = zeros(Tx_number,length(Eb_N0_all)); 
for s = 1:length(Eb_N0_all) 
    Eb_N0 = Eb_N0_all(s);
    fprintf(2,['Eb_N0 = ', num2str(Eb_N0), '\n']); % Display
    h_sr = 1/sqrt(2)*(randn(Tx_number,1)+j*randn(Tx_number,1)); 
    h_rr = 1/sqrt(2)*((randn(Tx_number,1)+j*randn(Tx_number,1)))*sqrt(h_rr_gain_Linear); 
    h_sd = 1/sqrt(2)*((randn(Tx_number,1)+j*randn(Tx_number,1)))*sqrt(h_sd_gain_Linear); 
    h_rd = 1/sqrt(2)*((randn(Tx_number,1)+j*randn(Tx_number,1))); 
    parfor Tx = 1:Tx_number % Transmission Loop
     M = 4; % QPSK
     Data = randi([0 M-1],L,1);
     x_s = pskmod(Data,M,pi/4);% modulation
     % Channel (S-R)
     H1_FD = sqrt(Ps_Linear)*h_sr(Tx)*[eye(L);zeros(t,L)] + sqrt(Pr_Linear)*h_rr(Tx)*[zeros(t,L);eye(L)];
     H1_HD = sqrt(Ps_Linear)*h_sr(Tx)*[eye(L);zeros(t,L)];
     N0 = 10^(-Eb_N0/10); sigma = sqrt(N0/2);% Noise (S-R)
     n_r = 1/sqrt(2)*sigma*(randn(L+t,1) + j*randn(L+t,1));
     yr_FD = H1_FD * x_s + n_r;% Received Signal (S-R)
     yr_HD = H1_HD * x_s + n_r;
        % ZF Equalizer (S-R)
        x_s_FD_hat = H1_FD\yr_FD; 
        x_s_HD_hat = H1_HD\yr_HD; 
        % Channel(R-D)
        H2 = sqrt(Ps_Linear)*h_sd(Tx)*[eye(L);zeros(t,L)] + sqrt(Pr_Linear)*h_rd(Tx)*[zeros(t,L);eye(L)];
        % Noise (R-D)
        n_d = 1/sqrt(2)*sigma*(randn(L+t,1) + j*randn(L+t,1));
        % Received Signal(R-D)
        yd_FD = sqrt(Ps_Linear)*h_sd(Tx)*[x_s;zeros(t,1)] + sqrt(Pr_Linear)*h_rd(Tx)*[zeros(t,1);x_s_FD_hat] + n_d;
        yd_HD = sqrt(Ps_Linear)*h_sd(Tx)*[x_s;zeros(t,1)] + sqrt(Pr_Linear)*h_rd(Tx)*[zeros(t,1);x_s_HD_hat] + n_d;
        % ZF Equalizer (R-D)
        x_s1_FD_hat = H2\yd_FD; 
        x_s1_HD_hat = H2\yd_HD; 
        Data_FD_hat = pskdemod(x_s1_FD_hat,M,pi/4);%demodulate
        Data_HD_hat = pskdemod(x_s1_HD_hat,M,pi/4);
        Error_number_FD = sum(Data_FD_hat ~= Data); 
        Error_number_HD = sum(Data_HD_hat ~= Data); 
        BER_all_FD(Tx,s) = Error_number_FD/L;
        BER_all_HD(Tx,s) = Error_number_HD/L;
    end
end
BER_FD = sum(BER_all_FD)/Tx_number/4;
BER_HD = sum(BER_all_HD)/Tx_number/4;
semilogy(Eb_N0_all,BER_FD,'mx-','LineWidth',2);
hold on
semilogy(Eb_N0_all,BER_HD,'go-','LineWidth',2);
hold off;
grid on;
legend('Half-duplex-Simulation','Full-duplex-Simulation');
axis([0 30 10^-5 0.5]);
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for Full-duplex and Half-Duplex with QPSK modulation');
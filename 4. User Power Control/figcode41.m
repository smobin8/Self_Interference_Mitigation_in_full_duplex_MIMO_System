clear all
close all
clc
w=10*10^6;
N0=3.9*10^-21;
fc=10*10^6;
c=3*10^8;
Pb=.1;Gb=10^-11;Gu=Gb;
% PL1= 30.8+24.2*log10(R); 
for i=70:120
    Pu=0.01;
    Gub(i)=10^-(i/10);
    Gbu(i)=Gub(i);Ib=0;Iu=0;
    Rul(i)=w*log2(1+((Gub(i)*Pu)/(w*N0+Gb*Pb+Ib)));
    Rdl(i)=w*log2(1+(Gbu(i)*Pb)/(w*N0+Gu*Pu+Iu));
    R1(i)=(Rul(i)+Rdl(i))/10^6;
end
for i=70:120
    Pu=0.1;
    Gub(i)=10^-(i/10);
    Gbu(i)=Gub(i);Ib=0;Iu=0;
    Ru2(i)=w*log2(1+(Gub(i)*Pu)/(w*N0+Gb*Pb+Ib));
    Rd2(i)=w*log2(1+(Gbu(i)*Pb)/(w*N0+Gu*Pu+Iu));
    R2(i)=(Ru2(i)+Rd2(i))/10^6;
end
plot(R1,'r')
hold on
plot(R2)
axis ([70 120 0 250]);
title('Throughput for different UE tx. power')
xlabel('Path loss from BS to UE [dB]');
ylabel('Throughput (BFD) [Mbps]');
legend ('P(UE)=10[dBm]','P(UE)=20[dBm]');
clear all
close all
clc
w=10*10^6;
N0=3.9*10^-21;
% R=0.35;
% PL1= 30.8+24.2*log10(R)+20;
for i=1:10
    Pb=0.1;Gb=10^-11;Gu=Gb;
    Pu=0.01;
    Gub=10^-(102.5/10);
    Gbu=Gub;Ib=0;Iu=0;
    Rul=w*log2(1+((Gub*Pu)/(w*N0+Gb*Pb+Ib)));
    Rdl=w*log2(1+(Gbu*Pb)/(w*N0+Gu*Pu+Iu));
    R1(i)=(Rul+Rdl)/10^6;
end

for i=1:20
    Pb=0.1;Gb=10^-11;Gu=Gb;
    Pu(i)=0.01+10^-3*10^((i-1)/10);
    Gub=10^-(102.5/10);
    Gbu=Gub;Ib=0;Iu=0;
    Ru2(i)=w*log2(1+((Gub*Pu(i))/(w*N0+Gb*Pb+Ib)));
    Rd2(i)=w*log2(1+(Gbu*Pb)/(w*N0+Gu*Pu(i)+Iu));
    R2(i)=(Ru2(i)+Rd2(i))/10^6;
end
rng(92)
 A=randi([-110,-90],1,20);
for i=1:10
    Pb=0.1;Gb=10^-10.5;Gu=Gb;
    for j=1:20
       Gub(j)=10^(A(j)/10);
    if Gub(j)<3.38*10^-10
        Pu(j)=0.01+10^-3*10^((i-1)/10);
    else Pu(j)=0.01;
    end
    Gbu(j)=Gub(j);Ib=0;Iu=0;
    Rul1(i,j)=w*log2(1+((Gub(j)*Pu(j))/(w*N0+Gb*Pb+Ib)));
    Rdl1(i,j)=w*log2(1+(Gbu(j)*Pb)/(w*N0+Gu*Pu(j)+Iu));
    R11(i,j)=(Rul1(i,j)+Rdl1(i,j))/10^6;
    end
    R12=sum(R11,2)/20;
end
R4=flipud(R12);
R3=R2(:,1:2:end);
plot (R1,'-x')
hold on
plot(R3,'-s')
hold on 
plot (R4,'-o')
title('Throughput for various increament in UE tx. power')
xlabel('Increment in UE Tx. power deltaP[dBm] ');
ylabel('Throughput R(BFD) [Mbps]');
legend ('Pue=Pstd','Pue=Pstd+deltaP','proposed TPC',3);
axis ([1 10 53 63]);
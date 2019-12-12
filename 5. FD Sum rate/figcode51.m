clear all
close all
clc
w=20*10^6;
Gt=100;Gr=10;
N0=10^-21;
fc=2.45*10^9;
% ht=40;hr=23;
c=3*10^8;
for d=5:500
    Pd1=0.001;Pu1=0.0001;
    B1=10^(10);
%delta(1,d)=69.55+26.16*log(fc)-13.82*log(ht)-((1.1*log(fc)-0.7)*hr-(1.56*log(fc)-0.8))+(44.9-6.55*log(ht))*log(d);
delta1(1,d)=((Pd1*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
delta2(1,d)=((Pu1*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
%Cd1(1,d)=w*(log2(1+(delta1(1,d))/(N0*w+(Pu1/B1))));
Cd2(1,d)=0.25*w*(log2(1+(delta2(1,d))/(N0*w+(Pd1/B1))));
Cd1(1,d)=4*Cd2(1,d);
end
for d=5:500;
    Pd2=0.1;Pu2=0.000001;
%delta(1,d)=69.55+26.16*log(fc)-13.82*log(ht)-((1.1*log(fc)-0.7)*hr-(1.56*log(fc)-0.8))+(44.9-6.55*log(ht))*log(d);
delta3(1,d)=((Pd2*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
delta4(1,d)=((Pu2*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
%Cd3(1,d)=w*(log2(1+(delta3(1,d))/(N0*w)));
Cd4(1,d)=0.25*w*(log2(1+(delta4(1,d))/(N0*w)));
Cd3(1,d)=4*Cd4(1,d);
end
d=0:500-1;

semilogx(d,Cd1); 
  hold on
  %grid on
  semilogx(d,Cd2,'r'); 
  hold on
  semilogx(d,Cd3,'g'); 
  hold on
  semilogx(d,Cd4,'k'); 
  axis ([5 500 0 6*10^8]);
xlabel('Link Distance [m]');
ylabel('Capacity [bits/s]');
legend ('Downlink FD','Uplink FD','Downlink HD','Uplink HD');
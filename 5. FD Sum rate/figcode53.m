clear all
close all
clc
w=20*10^6;
Gt=100;Gr=100;
N0=10^-20;
fc=2.45*10^9;
r=2/8;
% ht=40;hr=23;
c=3*10^8;
for d=5:500
    Pd1=1;Pu1=0.00002;
    B1=10^(10);
%delta(1,d)=69.55+26.16*log(fc)-13.82*log(ht)-((1.1*log(fc)-0.7)*hr-(1.56*log(fc)-0.8))+(44.9-6.55*log(ht))*log(d);
delta1(1,d)=((Pd1*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
delta2(1,d)=((Pu1*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
Cd1(1,d)=w*(log2(1+(delta1(1,d))/(N0*w+(Pu1/B1))));
Cd2(1,d)=w*(log2(1+(delta2(1,d))/(N0*w+(Pd1/B1))));
%Cd1(1,d)=4*Cd2(1,d);
adf(1,d)=Cd2(1,d)/(Cd2(1,d)+r*Cd1(1,d));
auf(1,d)=(r*Cd1(1,d))/(Cd2(1,d)+r*Cd1(1,d));
Csum(1,d)=adf(1,d)*Cd1(1,d)+auf(1,d)*Cd2(1,d);
end

for d=5:500;
    Pd2=0.0001;Pu2=0.00001;
%delta(1,d)=69.55+26.16*log(fc)-13.82*log(ht)-((1.1*log(fc)-0.7)*hr-(1.56*log(fc)-0.8))+(44.9-6.55*log(ht))*log(d);
delta3(1,d)=((Pd2*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
delta4(1,d)=((Pu2*Gt*Gr*(c^2))/((4*pi*d*fc)^2));
Cd3(1,d)=w*(log2(1+(delta3(1,d))/(N0*w)));
Cd4(1,d)=w*(log2(1+(delta4(1,d))/(N0*w)));
% Cd3(1,d)=4*Cd4(1,d);
adh(1,d)=Cd4(1,d)/(Cd4(1,d)+r*Cd3(1,d));
auh(1,d)=(r*Cd3(1,d))/(Cd4(1,d)+r*Cd3(1,d));
Csumh(1,d)=adh(1,d)*Cd3(1,d)+auh(1,d)*Cd4(1,d);
end

d=0:500-1;
semilogx(d,Csum);
% semilogx(d,Cd1); 
  hold on
  semilogx(d,Csumh,'r');
%   %grid on
%   semilogx(d,Cd2,'r'); 
%   hold on
%   semilogx(d,Cd3,'g'); 
%   hold on
%   semilogx(d,Cd4,'k'); 
  axis ([5 500 0 6*10^8]);
  title('Sum rate capacity for 802.11')
xlabel('Link Distance [m]');
ylabel('Sum Capacity [bits/s]');
legend ('FD','HD');
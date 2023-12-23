% Lo script richiede che siano già costruiti i pattern; si faccia uso della prima sezione
% di MAIN a tal scopo.
clc
close all
clear
MAIN
t_sim=1.5;
dt=0.0001;
t=0:dt:t_sim;

train_flag=0; 
%% TEST COND. ALTERATA: sogno / esplorazione (solo L1, L2, L3)
clc
t_sim=2.5;
dt=0.0001; %0.1 millisecondi
t=(0:dt:t_sim);
T=length(t);
train_flag=0; 
load_sinapsi

rng('shuffle')
mediaIN=80+80*rand([numero_colonne, T]); 
sigma=0;
noise=randn(numero_colonne,T)*sigma; 


rete_sim_dream
fonte = 14;
linea = 1.0;
figure
subplot(411), hold on, title('Input to L1'), ylabel('Hz')
plot(t,sum(IN1(pos1,:))/size(pos1,2),'b-','linewidth',linea)
plot(t,sum(IN1(pos2,:))/size(pos2,2),'r-','linewidth',linea)
plot(t,sum(IN1(pos3,:))/size(pos3,2),'g-','linewidth',linea)
plot(t,sum(IN1(pos4,:))/size(pos4,2),'k-','linewidth',linea)
plot(t,sum(IN1(pos5,:))/size(pos5,2),'k-','linewidth',linea)
plot(t,sum(IN1(pos6,:))/size(pos6,2),'c--','linewidth',linea)
plot(t,sum(IN1(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(IN1(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(IN1(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(412), title('z_p_,_L_1'), hold on, ylabel('Hz')
plot(t,sum(zp1(pos1,:))/size(pos1,2),'b-','linewidth',linea)
plot(t,sum(zp1(pos2,:))/size(pos2,2),'r-','linewidth',linea)
plot(t,sum(zp1(pos3,:))/size(pos3,2),'g-','linewidth',linea)
plot(t,sum(zp1(pos4,:))/size(pos4,2),'k-','linewidth',linea)
plot(t,sum(zp1(pos5,:))/size(pos5,2),'c-','linewidth',linea)
plot(t,sum(zp1(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp1(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp1(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp1(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(413), title('z_p_,_L_2'), hold on, ylabel('Hz')
plot(t,sum(zp2(pos1,:))/size(pos1,2),'b-','linewidth',linea)
plot(t,sum(zp2(pos2,:))/size(pos2,2),'r-','linewidth',linea)
plot(t,sum(zp2(pos3,:))/size(pos3,2),'g-','linewidth',linea)
plot(t,sum(zp2(pos4,:))/size(pos4,2),'k-','linewidth',linea)
plot(t,sum(zp2(pos5,:))/size(pos5,2),'c-','linewidth',linea)
plot(t,sum(zp2(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp2(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp2(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp2(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(414), title('z_p_,_L_3'), hold on, ylabel('Hz'), xlabel('time (s)')
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b-','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r-','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g-','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k-','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c-','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

if SET_PATT==3
    subplot(411), plot(t,sum(IN1(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(412), plot(t,sum(zp1(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(413), plot(t,sum(zp2(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(414), plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--')
end
legend('obj1','obj2','obj3','obj4','obj5','obj6','obj7', 'obj8','obj9','obj10')

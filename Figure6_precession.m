% Lo script richiede che siano già costruiti i pattern; si faccia uso della prima sezione
% di MAIN a tal scopo.
%% test rete intera (recall di sequenze) + Working Memory 
clc
MAIN
t_sim=1.8;
dt=0.0001;
t=0:dt:t_sim;

train_flag=0; 
load_sinapsi
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
% il set di sinapsi caricate contiene tutti i collegamenti tra L1,L2,L3 +
% WM; tutti i valori sono settati per la funzione di recall di sequenze.

% if SET_PATT==3
%     Wp_L1L1=Wp_L1L1*0.75;
% end

INPUT_WM=zeros(numero_colonne,length(t));
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,1))==1);
buff(pos,:)=1;
INPUT_WM(:,51:550)=buff;
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,2))==1);
buff(pos,:)=1;
INPUT_WM(:,6051:6550)=buff;
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,3))==1);
buff(pos,:)=1;
INPUT_WM(:,12051:12550)=buff;
% buff=zeros(numero_colonne, round(0.05/dt));
% pos=find(corrupt_pattern(all_patterns(:,4))==1);
% buff(pos,:)=1;
% INPUT_WM(:,24051:24550)=buff;

reteWM_sim, IN0=INPUT_WM*600+np0;

line = 1.0;
font = 12;
figure
subplot(511), hold on, ylabel('Input'), xlim([0 t_sim])
plot(t,sum(IN0(pos1,:))/size(pos1,2),'b','linewidth',line)
plot(t,sum(IN0(pos2,:))/size(pos2,2),'r','linewidth',line)
plot(t,sum(IN0(pos3,:))/size(pos3,2),'g','linewidth',line)
% plot(t,sum(IN0(pos4,:))/size(pos4,2),'r--','linewidth',line)
set(gca,'fontsize',font)

subplot(512), hold on, ylabel('z_p_,_W_M(Hz)'), axis([0 t_sim 0 5])
plot(t,sum(zp0(pos1,:))/size(pos1,2),'b ','linewidth',line)
plot(t,sum(zp0(pos2,:))/size(pos2,2),'r','linewidth',line)
plot(t,sum(zp0(pos3,:))/size(pos3,2),'g','linewidth',line)
plot(t,sum(zp0(pos4,:))/size(pos4,2),'k','linewidth',line)
plot(t,sum(zp0(pos5,:))/size(pos5,2),'c','linewidth',line)
plot(t,sum(zp0(pos6,:))/size(pos6,2),'b--','linewidth',line)
plot(t,sum(zp0(pos7,:))/size(pos7,2),'r--','linewidth',line)
plot(t,sum(zp0(pos8,:))/size(pos8,2),'g--','linewidth',line)
plot(t,sum(zp0(pos9,:))/size(pos9,2),'k--','linewidth',line)
set(gca,'fontsize',font)

subplot(513),  hold on, ylabel('z_p_,_L_1(Hz)'), axis([0 t_sim 0 5])
plot(t,sum(zp1(pos1,:))/size(pos1,2),'b','linewidth',line)
plot(t,sum(zp1(pos2,:))/size(pos2,2),'r','linewidth',line)
plot(t,sum(zp1(pos3,:))/size(pos3,2),'g','linewidth',line)
plot(t,sum(zp1(pos4,:))/size(pos4,2),'k','linewidth',line)
plot(t,sum(zp1(pos5,:))/size(pos5,2),'c','linewidth',line)
plot(t,sum(zp1(pos6,:))/size(pos6,2),'b--','linewidth',line)
plot(t,sum(zp1(pos7,:))/size(pos7,2),'r--','linewidth',line)
plot(t,sum(zp1(pos8,:))/size(pos8,2),'g--','linewidth',line)
plot(t,sum(zp1(pos9,:))/size(pos9,2),'k--','linewidth',line)
set(gca,'fontsize',font)

subplot(514), hold on, ylabel('z_p_,_L_2(Hz)'), axis([0 t_sim 0 5])
plot(t,sum(zp2(pos1,:))/size(pos1,2),'b','linewidth',line)
plot(t,sum(zp2(pos2,:))/size(pos2,2),'r','linewidth',line)
plot(t,sum(zp2(pos3,:))/size(pos3,2),'g','linewidth',line)
plot(t,sum(zp2(pos4,:))/size(pos4,2),'k','linewidth',line)
plot(t,sum(zp2(pos5,:))/size(pos5,2),'c','linewidth',line)
plot(t,sum(zp2(pos6,:))/size(pos6,2),'b--','linewidth',line)
plot(t,sum(zp2(pos7,:))/size(pos7,2),'r--','linewidth',line)
plot(t,sum(zp2(pos8,:))/size(pos8,2),'g--','linewidth',line)
plot(t,sum(zp2(pos9,:))/size(pos9,2),'k--','linewidth',line)
set(gca,'fontsize',font)

subplot(515), hold on, ylabel('z_p_,_L_3(Hz)'), xlabel('time (s)'), axis([0 t_sim 0 5])
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',line)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',line)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',line)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',line)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',line)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',line)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',line)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',line)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',line)
set(gca,'fontsize',font)
legend('obj1','obj2','obj3','obj4','obj5','obj6','obj7', 'obj8','obj9')
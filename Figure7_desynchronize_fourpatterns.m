% Lo script richiede che siano già costruiti i pattern; si faccia uso della prima sezione
% di MAIN a tal scopo.

%% test rete intera (DESYNC) - WM + L1,L2,L3
%no feedback L3->L2, connessioni tra L1 e WM (sia in avanti sia in feedback)
%triplicate.
clc
close all
clear
MAIN
t_sim=0.5;
dt=0.0001;
t=0:dt:t_sim;

train_flag=0; 
M_fac = 1.7*2/3;  % multiplicative factor, representing attention
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata

INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:4),2))==1);
nP=4;
INPUT_WM(pos,1:499)=1;


    if nP > 4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
    else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
    end

% if nP>5
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
% else
%     if nP == 5
%     A_L2L2=A_L2L2*1.15;
%     A_L3L3=A_L3L3*1.15;
%     else
%     A_L2L2=A_L2L2*2/3;
%     A_L3L3=A_L3L3*2/3;
%     end
% end

reteWM_desync

fonte = 14;
linea = 1;
figure
subplot(411), hold on, ylabel('zp WM')
plot(t,sum(zp0(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp0(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp0(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp0(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp0(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp0(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp0(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp0(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp0(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(412), hold on, ylabel('zp L1')
plot(t,sum(zp1(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp1(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp1(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp1(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp1(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp1(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp1(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp1(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp1(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(413), hold on, ylabel('zp L2')
plot(t,sum(zp2(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp2(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp2(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp2(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp2(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp2(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp2(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp2(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp2(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

subplot(414), hold on, ylabel('zp L3')
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
xlabel('time (s)')
set(gca,'fontsize',fonte)

if SET_PATT==3
    subplot(411), plot(t,sum(zp0(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(412), plot(t,sum(zp1(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(413), plot(t,sum(zp2(pos10,:))/size(pos10,2),'c--','linewidth',linea)
    subplot(414), plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end
legend('obj1','obj2','obj3','obj4','obj5','obj6','obj7', 'obj8','obj9')
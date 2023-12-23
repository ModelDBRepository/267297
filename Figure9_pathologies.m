% Lo script richiede che siano già costruiti i pattern; si faccia uso della prima sezione
% di MAIN a tal scopo.
clc
close all
clear

MAIN

%% TEST COND. ANOMALA - patologia Alzheimer
clc
t_sim=0.8;
dt=0.0001;
t=0:dt:t_sim;
train_flag=0; 
load_sinapsi

% A_L2L2=A_L2L2*0.25;
% A_L3L3=A_L3L3*0.25;

coeff_Cff=0.25;
coeff_Cpf=1;
coeff_Cfp=1;
coeff_Cfs=1;

INPUT_WM=zeros(numero_colonne,length(t));
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,1))==1);
buff(pos,:)=1;
INPUT_WM(:,51:550)=buff;

reteWM_sim_pat, IN0=INPUT_WM*600+np0;
figure
line = 1.0;
font = 12;
subplot(311), hold on, ylabel('z_p_,_L_3(Hz)'), axis([0 t_sim 0 5])
title('Reduction in the C_{ff} parameter: recall','fontsize',font)
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

%% TEST COND. ANOMALA - patologia Schizofrenia, modalità recall
clc
t_sim=0.8;
dt=0.0001;
t=0:dt:t_sim;
train_flag=0; 
load_sinapsi

A_L2L2=A_L2L2*2/3;
A_L3L3=A_L3L3*2/3;

A_L2L2=A_L2L2*0.25;
A_L3L3=A_L3L3*0.25;

coeff_Cff=1;
coeff_Cpf=1;
coeff_Cfp=1;
coeff_Cfs=1;

INPUT_WM=zeros(numero_colonne,length(t));
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,1))==1);
buff(pos,:)=1;
INPUT_WM(:,51:550)=buff;

reteWM_sim_pat, IN0=INPUT_WM*600+np0;
line = 1.0;
font = 12;
subplot(312), hold on, ylabel('z_p_,_L_3(Hz)'), axis([0 t_sim 0 5])
title('Reduction in the AMPA synapses: recall','fontsize',font)
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

%% TEST COND. ANOMALA - patologia Schizofrenia, modalità desync

%no feedback L3->L2, connessioni tra L1 e WM (sia in avanti sia in feedback)
%triplicate.
clc
t_sim=0.8;
dt=0.0001;
t=0:dt:t_sim;

train_flag=0; 
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata


INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:5),2))==1);
nP=5;
INPUT_WM(pos,1:499)=1;

    if nP > 4
    A_L2L2=A_L2L2*1.15;
    A_L3L3=A_L3L3*1.15;
    else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
    end
    
    
A_L2L2=A_L2L2*0.25;
A_L3L3=A_L3L3*0.25;

coeff_Cff=1;
coeff_Cpf=1;
coeff_Cfp=1;
coeff_Cfs=1;
reteWM_desync
subplot(313), hold on, ylabel('z_p_,_L_3(Hz)'), xlabel('time (s)'), axis([0 t_sim 0 5])
title('Reduction in the AMPA synapses: desynchronize','fontsize',font)
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
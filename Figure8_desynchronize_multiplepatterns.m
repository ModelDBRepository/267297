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

M_fac = 1.7*2/3;  % multiplicative factor, representing attention
%% five patterns
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata
INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:5),2))==1);
nP=5;
INPUT_WM(pos,1:499)=1;

if nP>4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
end

reteWM_desync

fonte = 12;
linea = 1;
figure


subplot(511), hold on, ylabel('zp L3')
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

if SET_PATT==3
 plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end

%% six patterns
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata
INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:6),2))==1);
nP=6;
INPUT_WM(pos,1:499)=1;

if nP>4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
end

reteWM_desync

subplot(512), hold on, ylabel('zp L3') 
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

if SET_PATT==3
 plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end

%% seven patterns
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata
INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:7),2))==1);
nP=7;
INPUT_WM(pos,1:499)=1;

if nP>4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
end

reteWM_desync

subplot(513), hold on, ylabel('zp L3') 
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

if SET_PATT==3
 plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end

%% eight patterns
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata
INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:8),2))==1);
nP=8;
INPUT_WM(pos,1:499)=1;

if nP>4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
end

reteWM_desync

subplot(514), hold on, ylabel('zp L3') 
plot(t,sum(zp3(pos1,:))/size(pos1,2),'b','linewidth',linea)
plot(t,sum(zp3(pos2,:))/size(pos2,2),'r','linewidth',linea)
plot(t,sum(zp3(pos3,:))/size(pos3,2),'g','linewidth',linea)
plot(t,sum(zp3(pos4,:))/size(pos4,2),'k','linewidth',linea)
plot(t,sum(zp3(pos5,:))/size(pos5,2),'c','linewidth',linea)
plot(t,sum(zp3(pos6,:))/size(pos6,2),'b--','linewidth',linea)
plot(t,sum(zp3(pos7,:))/size(pos7,2),'r--','linewidth',linea)
plot(t,sum(zp3(pos8,:))/size(pos8,2),'g--','linewidth',linea)
plot(t,sum(zp3(pos9,:))/size(pos9,2),'k--','linewidth',linea)
set(gca,'fontsize',fonte)

if SET_PATT==3
 plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end

%% nine patterns
load_sinapsi
Wp_WML1=Wp_WML1*3; %feedback L1->WM maggiorato
Wp_L1WM=Wp_L1WM*3; %propagazione in avanti WM->L1 maggiorata
INPUT_WM=zeros(numero_colonne,length(t));
pos=find(corrupt_pattern(sum(all_patterns(:,1:9),2))==1);
nP=9;
INPUT_WM(pos,1:499)=1;

if nP>4
    A_L2L2=A_L2L2*M_fac;
    A_L3L3=A_L3L3*M_fac;
%     A_L2L2=A_L2L2*(1.025+0.025*(nP-3)); %da +2.5% a +15%
%     A_L3L3=A_L3L3*(1.025+0.025*(nP-3));
else
    A_L2L2=A_L2L2*2/3;
    A_L3L3=A_L3L3*2/3;
end

reteWM_desync

subplot(515), hold on, ylabel('zp L3') 
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
 plot(t,sum(zp3(pos10,:))/size(pos10,2),'c--','linewidth',linea)
end
legend('obj1','obj2','obj3','obj4','obj5','obj6','obj7', 'obj8','obj9')
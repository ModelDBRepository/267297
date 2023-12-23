% Lo script richiede che siano già costruiti i pattern; si faccia uso della prima sezione
% di MAIN a tal scopo.
%% test su L1 & Working Memory
clc

MAIN
t_sim=.8;
dt=0.0001;
t=0:dt:t_sim;

train_flag=0; 
load_sinapsi

INPUT_WM=zeros(numero_colonne,length(t));
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,1))==1);
buff(pos,:)=1;
INPUT_WM(:,51:550)=buff;
buff=zeros(numero_colonne, round(0.05/dt));
pos=find(corrupt_pattern(all_patterns(:,2))==1);
buff(pos,:)=1;
INPUT_WM(:,4051:4550)=buff;

WML1_sim, IN0=INPUT_WM*600+np0;

line = 1.5;
font = 14;
figure
subplot(311), title('Input to WM'), hold on, ylabel('Hz'),xlabel('time (s)')
plot(t,sum(IN0(pos1,:))/size(pos1,2),'linewidth',line), plot(t,sum(IN0(pos2,:))/size(pos2,2),'r','linewidth',line)
set(gca,'fontsize',font)
subplot(312), title('z_p_,_W_M'), hold on, ylabel('Hz'), xlabel('time (s)')
plot(t,sum(zp0(pos1,:))/size(pos1,2),'linewidth',line), plot(t,sum(zp0(pos2,:))/size(pos2,2),'r','linewidth',line)
set(gca,'fontsize',font)
subplot(313), title('z_p_,_L_1'), hold on, ylabel('Hz'), xlabel('time (s)')
plot(t,sum(zp1(pos1,:))/size(pos1,2),'linewidth',line), plot(t,sum(zp1(pos2,:))/size(pos2,2),'r','linewidth',line)
set(gca,'fontsize',font)
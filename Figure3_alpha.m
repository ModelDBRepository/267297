clear
clc
close all
N=20;
M=20; 
numero_colonne=N*M;

MAIN

%nella variabile "all_patterns" sono contenuti i pattern per colonna.
clc
t_sim=1.5;
dt=0.0001; 
t=0:dt:t_sim;
train_flag=0; 
Wp_L1L1=zeros(400,400);

INPUT_L1 = ones(400,1)*1;
L1_sim;
line = 1.5;
font = 14;
figure
subplot(221), title('pyramidal activity'), hold on, ylabel('Hz')
set(gca,'fontsize',font)
plot(t,zp1(10,:),'k','linewidth',line)
xlabel('time (s)')




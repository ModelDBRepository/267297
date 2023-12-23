% WARNING
% codice dipendente da L1_main. Richiede la presenza nel workspace di
% Wp_L1L1, t_sim, INPUT_L1

%% parametri
dt=0.0001; %0.1 millisecondi
if train_flag
    t=(0:dt:t_end1);
else
    t_sim=1.5;
    t=(0:dt:t_sim);
end
T=length(t);

rng(11)  % stabilisco un certo seme per ripetere le simulazioni successive
sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);
np = randn(numero_colonne,T)*sigma_p;
nf = randn(numero_colonne,T)*sigma_f;

% Parametri sigmoide
e0=2.5; %Hz
r=0.7; %1/mV
s0=10; %centro della sigmoide

% ritardi nella comunicazione tra colonne diverse
D_intraLayer=round(dt/dt);
                
% costanti di tempo sinapsi intra-colonna
a=[1/7.7 1/34 1/6.8]*1000; %nell'ordine: ae, as, af; a=1/tau (1/secondi)

% Guadagni (mV) delle sinapsi (G)
G=[5.17 4.45 57.1]; %Ge = 5.17; (per h_e)
                    %Gs = 4.45; (per h_s)
                    %Gf = 57.1; (per h_f)

%pesi sinaptici:
C(:,1) = 31.7*ones(1,numero_colonne); %Cep
C(:,2) = 17.3*ones(1,numero_colonne); %Cpe  
C(:,3) = 51.9*ones(1,numero_colonne); %Csp
C(:,4) = 100*ones(1,numero_colonne); %Cps 
C(:,5) = 100*ones(1,numero_colonne); %Cfs
C(:,6) = 66.9*ones(1,numero_colonne); %Cfp 
C(:,7) = 16*ones(1,numero_colonne); %Cpf
C(:,8) = 18*ones(1,numero_colonne); %Cff

%%
yp1=zeros(numero_colonne,T);
xp1=zeros(numero_colonne,T);
vp1=zeros(numero_colonne,1); 
zp1=zeros(numero_colonne,T);

ye1=zeros(numero_colonne,T);
xe1=zeros(numero_colonne,T);
ve1=zeros(numero_colonne,1);
ze1=zeros(numero_colonne,T);

ys1=zeros(numero_colonne,T);
xs1=zeros(numero_colonne,T);
vs1=zeros(numero_colonne,1);
zs1=zeros(numero_colonne,T);

yf1=zeros(numero_colonne,T);
xf1=zeros(numero_colonne,T);
zf1=zeros(numero_colonne,T);
vf1=zeros(numero_colonne,1);

xl1=zeros(numero_colonne,T);
yl1=zeros(numero_colonne,T);

Ep=zeros(numero_colonne,1);
mf1=zeros(numero_colonne,1); %media input gabaFast

% TOTSINW=130;
% buff=Wp_L1L1; 

for k=1:T-1 %ciclo nel tempo...
    %completo ingressi a piramidali e gaba fast:
    if size(INPUT_L1,2)==1
        mp1=INPUT_L1*600; 
%         S=sum(INPUT_L1>0);
%         Wp_L1L1(Wp_L1L1>0)=TOTSINW/S;
    else
        mp1=INPUT_L1(:,k)*600; %se ho dato un ingresso variabile nel tempo
%         S=sum(INPUT_L1(:,k)>0);
%         if S>0
%             Wp_L1L1(Wp_L1L1>0)=TOTSINW/S;
%         end
    end
    up1=np(:,k)+mp1;
    uf1=nf(:,k)+mf1;
    
    if(k>D_intraLayer) %se il tempo trascorso è maggiore del delay tra colonne...
        Ep=Wp_L1L1*yp1(:,k-D_intraLayer);
    end
    
    %potenziali post-sinaptici: (comb lin degli outputs standard)
    vp1(:)=C(:,2).*ye1(:,k)-C(:,4).*ys1(:,k)-C(:,7).*yf1(:,k)+Ep;
    ve1(:)=C(:,1).*yp1(:,k);
    vs1(:)=C(:,3).*yp1(:,k);
    vf1(:)=C(:,6).*yp1(:,k)-C(:,5).*ys1(:,k)-C(:,8).*yf1(:,k)+yl1(:,k);
    %spikes:
    zp1(:,k)=2*e0./(1+exp(-r*(vp1(:)-s0)));
    ze1(:,k)=2*e0./(1+exp(-r*(ve1(:)-s0)));
    zs1(:,k)=2*e0./(1+exp(-r*(vs1(:)-s0)));
    zf1(:,k)=2*e0./(1+exp(-r*(vf1(:)-s0)));
        
    %nuovi outputs "standard" (non pesati) popolazioni:
    xp1(:,k+1)=xp1(:,k)+(G(1)*a(1)*zp1(:,k)-2*a(1)*xp1(:,k)-a(1)*a(1)*yp1(:,k))*dt;
    yp1(:,k+1)=yp1(:,k)+xp1(:,k)*dt;
    xe1(:,k+1)=xe1(:,k)+(G(1)*a(1)*(ze1(:,k)+up1(:)./C(:,2))-2*a(1)*xe1(:,k)-a(1)*a(1)*ye1(:,k))*dt;
    ye1(:,k+1)=ye1(:,k)+xe1(:,k)*dt;
    xs1(:,k+1)=xs1(:,k)+(G(2)*a(2)*zs1(:,k)-2*a(2)*xs1(:,k)-a(2)*a(2)*ys1(:,k))*dt;
    ys1(:,k+1)=ys1(:,k)+xs1(:,k)*dt;
    xl1(:,k+1)=xl1(:,k)+(G(1)*a(1)*uf1(:)-2*a(1)*xl1(:,k)-a(1)*a(1)*yl1(:,k))*dt;
    yl1(:,k+1)=yl1(:,k)+xl1(:,k)*dt;
    xf1(:,k+1)=xf1(:,k)+(G(3)*a(3)*zf1(:,k)-2*a(3)*xf1(:,k)-a(3)*a(3)*yf1(:,k))*dt;
    yf1(:,k+1)=yf1(:,k)+xf1(:,k)*dt; 
end
% Wp_L1L1=buff;
% clear buff
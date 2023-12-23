% WARNING
% Script dipendente da L1_main.

%% parametri & ingressi
dt=0.0001; %0.1 millisecondi
t_end1 = 0.25; 
t=(0:dt:t_end1);
T=length(t);

rng(11)  % stabilisco un certo seme per ripetere le simulazioni successive
sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);

% Parametri sigmoide
e0=2.5; %Hz
r=0.7; %1/mV
s0=10; %centro della sigmoide

% ritardi nella comunicazione tra colonne diverse
D_intraLayer=round(dt/dt); %"passi" di ritardo
                
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

%% addestramento
Wp_L1L1=zeros(numero_colonne,numero_colonne);
Wp_L1L1_max=10;
TOTSINW=130;
gammaWp_L1L1=0.1;
thresh_low=0.12;

%inizializzo i vettori di poten. di mem. (v), spikes (z), outputs (y)
%le (x) sono variabili parziali per l'aggiornamento delle rispettive (y),
%necessarie perchè le eq. sono del secondo ordine.
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
%xl e yl servono per l'ingresso ai gaba_fast. tale input deve infatti
%andare in contro alla dinamica della sinapsi h_e.

Ep=zeros(numero_colonne,1);
mf1=zeros(numero_colonne,1); %media input gabaFast

J=size(all_patterns,2);
w = waitbar(0,'Training L1...','WindowStyle','modal');
for j=1:J %per ogni pattern...
    up=zeros(numero_colonne,1);
    mp1=all_patterns(:,j)*2000; %seleziono un pattern come ingresso ai piramidali
    Ep=zeros(numero_colonne,1);
    
    np = randn(numero_colonne,T)*sigma_p;
    nf = randn(numero_colonne,T)*sigma_f;
    
    for k=1:T-1 %ciclo nel tempo...
        %completo ingressi a piramidali e gaba fast:
        up=np(:,k)+mp1;
        uf=nf(:,k)+mf1;
        
        if (k>D_intraLayer) %se il tempo trascorso è maggiore del delay tra colonne...
            if SET_PATT==3
                Ep=0;
            else
                Ep=Wp_L1L1*yp1(:,k-D_intraLayer);
            end
            %...aggiungo il contributo sinaptico.
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
        
        if k>500
            ATT_PRE=(zp1(:,k)/(2*e0)-thresh_low)'; %1x400
            ATT_PRE(ATT_PRE<0)=0; %...mantengo solo i valori >0 (colonne "accese")
            ATT_POST=(zp1(:,k)/(2*e0)-thresh_low); %400x1
            ATT_POST(ATT_POST<0)=0;
            WEIGHT=(Wp_L1L1_max - Wp_L1L1).*(ones(numero_colonne, numero_colonne)-eye(numero_colonne));
            Wp_L1L1 = Wp_L1L1 + gammaWp_L1L1 .* (ATT_POST * ATT_PRE) .* WEIGHT;
        end
        
        %nuovi outputs "standard" (non pesati) popolazioni:
        xp1(:,k+1)=xp1(:,k)+(G(1)*a(1)*zp1(:,k)-2*a(1)*xp1(:,k)-a(1)*a(1)*yp1(:,k))*dt;
        yp1(:,k+1)=yp1(:,k)+xp1(:,k)*dt;
        xe1(:,k+1)=xe1(:,k)+(G(1)*a(1)*(ze1(:,k)+up(:)./C(:,2))-2*a(1)*xe1(:,k)-a(1)*a(1)*ye1(:,k))*dt;
        ye1(:,k+1)=ye1(:,k)+xe1(:,k)*dt;
        xs1(:,k+1)=xs1(:,k)+(G(2)*a(2)*zs1(:,k)-2*a(2)*xs1(:,k)-a(2)*a(2)*ys1(:,k))*dt;
        ys1(:,k+1)=ys1(:,k)+xs1(:,k)*dt;
        xl1(:,k+1)=xl1(:,k)+(G(1)*a(1)*uf(:)-2*a(1)*xl1(:,k)-a(1)*a(1)*yl1(:,k))*dt;
        yl1(:,k+1)=yl1(:,k)+xl1(:,k)*dt;
        xf1(:,k+1)=xf1(:,k)+(G(3)*a(3)*zf1(:,k)-2*a(3)*xf1(:,k)-a(3)*a(3)*yf1(:,k))*dt;
        yf1(:,k+1)=yf1(:,k)+xf1(:,k)*dt;  
    end
    waitbar(j/J,w);
end
close(w)

for i=1:numero_colonne
    S=sum(Wp_L1L1(i,:),2); %somma dei pesi sinaptici ricevuti dalla i-esima colonna
    if S>TOTSINW
        Wp_L1L1(i,:)=Wp_L1L1(i,:).*(TOTSINW/S);
    end
end
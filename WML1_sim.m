% Simulazione Working Memory (riceve l'input esterno) & L1.
% Richiede che L1 sia già addestrato e un input, INPUT_WM.

%% parametri
dt=0.0001; %0.1 millisecondi
t_sim=.8;
t=(0:dt:t_sim);
T=length(t);

%noise:
sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);
rng(10) %per WM
np0 = randn(numero_colonne,T)*sigma_p;
nf0 = randn(numero_colonne,T)*sigma_f;
rng(11) %per L1
np1 = randn(numero_colonne,T)*sigma_p;
nf1 = randn(numero_colonne,T)*sigma_f;

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

%% simulazione
yp0=zeros(numero_colonne,T);
xp0=zeros(numero_colonne,T);
vp0=zeros(numero_colonne,1); 
zp0=zeros(numero_colonne,T);

ye0=zeros(numero_colonne,T);
xe0=zeros(numero_colonne,T);
ve0=zeros(numero_colonne,1);
ze0=zeros(numero_colonne,T);

ys0=zeros(numero_colonne,T);
xs0=zeros(numero_colonne,T);
vs0=zeros(numero_colonne,1);
zs0=zeros(numero_colonne,T);

yf0=zeros(numero_colonne,T);
xf0=zeros(numero_colonne,T);
zf0=zeros(numero_colonne,T);
vf0=zeros(numero_colonne,1);

xl0=zeros(numero_colonne,T);
yl0=zeros(numero_colonne,T);

Ee0=zeros(numero_colonne,1);
Ep0=zeros(numero_colonne,1);
mf0=zeros(numero_colonne,1); 

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

Ep1=zeros(numero_colonne,1);
mf1=zeros(numero_colonne,1);
mp1=zeros(numero_colonne,1);
Wp_WMWM=zeros(numero_colonne);
for k=2:T-1 %ciclo nel tempo...
    %completo ingressi a piramidali e gaba fast (di WM e L1):
    mp0=INPUT_WM(:,k)*600; %serve un ingresso variabile nel tempo.
    if (sum(mp0)==0 && sum(INPUT_WM(:,k-1))>0) %se smetto di ricevere ingresso...
        Wp_WMWM=diag(INPUT_WM(:,k-1))*300; %le colonne eccitate dall'ultimo ingresso mantengono l'info.
    elseif (sum(mp0)~=0) %se invece l'input è non nullo...
        Wp_WMWM=zeros(numero_colonne); %seguo l'ingresso senza auto-eccitazione.
    end
    up0=np0(:,k)+mp0;
    uf0=nf0(:,k)+mf0;
    up1=np1(:,k)+mp1;
    uf1=nf1(:,k)+mf1;
    
    if(k>D_intraLayer) %comunicazione sinaptica
        Ep0=Wp_WML1*yp1(:,k-D_intraLayer)+Wp_WMWM*yp0(:,k-D_intraLayer); %feedback da L1 & mantenimento dell'info sull'input
        Ep1=Wp_L1WM*yp0(:,k-D_intraLayer)+Wp_L1L1*yp1(:,k-D_intraLayer); %trasmissione WM->L1 e autoassociazione in L1
    end
    
    %potenziali post-sinaptici WM: (comb lin degli outputs standard)
    vp0(:)=C(:,2).*ye0(:,k)-C(:,4).*ys0(:,k)-C(:,7).*yf0(:,k)+Ep0;
    ve0(:)=C(:,1).*yp0(:,k);
    vs0(:)=C(:,3).*yp0(:,k);
    vf0(:)=C(:,6).*yp0(:,k)-C(:,5).*ys0(:,k)-C(:,8).*yf0(:,k)+yl0(:,k);
    %spikes:
    zp0(:,k)=2*e0./(1+exp(-r*(vp0(:)-s0)));
    ze0(:,k)=2*e0./(1+exp(-r*(ve0(:)-s0)));
    zs0(:,k)=2*e0./(1+exp(-r*(vs0(:)-s0)));
    zf0(:,k)=2*e0./(1+exp(-r*(vf0(:)-s0)));
        
    %nuovi outputs "standard" (non pesati) popolazioni di WM:
    xp0(:,k+1)=xp0(:,k)+(G(1)*a(1)*zp0(:,k)-2*a(1)*xp0(:,k)-a(1)*a(1)*yp0(:,k))*dt;
    yp0(:,k+1)=yp0(:,k)+xp0(:,k)*dt;
    xe0(:,k+1)=xe0(:,k)+(G(1)*a(1)*(ze0(:,k)+up0(:)./C(:,2))-2*a(1)*xe0(:,k)-a(1)*a(1)*ye0(:,k))*dt;
    ye0(:,k+1)=ye0(:,k)+xe0(:,k)*dt;
    xs0(:,k+1)=xs0(:,k)+(G(2)*a(2)*zs0(:,k)-2*a(2)*xs0(:,k)-a(2)*a(2)*ys0(:,k))*dt;
    ys0(:,k+1)=ys0(:,k)+xs0(:,k)*dt;
    xl0(:,k+1)=xl0(:,k)+(G(1)*a(1)*uf1(:)-2*a(1)*xl0(:,k)-a(1)*a(1)*yl0(:,k))*dt;
    yl0(:,k+1)=yl0(:,k)+xl0(:,k)*dt;
    xf0(:,k+1)=xf0(:,k)+(G(3)*a(3)*zf0(:,k)-2*a(3)*xf0(:,k)-a(3)*a(3)*yf0(:,k))*dt;
    yf0(:,k+1)=yf0(:,k)+xf0(:,k)*dt; 
    
    %potenziali post-sinaptici L1: (comb lin degli outputs standard)
    vp1(:)=C(:,2).*ye1(:,k)-C(:,4).*ys1(:,k)-C(:,7).*yf1(:,k)+Ep1;
    ve1(:)=C(:,1).*yp1(:,k);
    vs1(:)=C(:,3).*yp1(:,k);
    vf1(:)=C(:,6).*yp1(:,k)-C(:,5).*ys1(:,k)-C(:,8).*yf1(:,k)+yl1(:,k);
    %spikes L1:
    zp1(:,k)=2*e0./(1+exp(-r*(vp1(:)-s0)));
    ze1(:,k)=2*e0./(1+exp(-r*(ve1(:)-s0)));
    zs1(:,k)=2*e0./(1+exp(-r*(vs1(:)-s0)));
    zf1(:,k)=2*e0./(1+exp(-r*(vf1(:)-s0)));
        
    %nuovi outputs "standard" (non pesati) popolazioni L1:
    xp1(:,k+1)=xp1(:,k)+(G(1)*a(1)*zp1(:,k)-2*a(1)*xp1(:,k)-a(1)*a(1)*yp1(:,k))*dt;
    yp1(:,k+1)=yp1(:,k)+xp1(:,k)*dt;
    xe1(:,k+1)=xe1(:,k)+(G(1)*a(1)*(ze1(:,k)+up0(:)./C(:,2))-2*a(1)*xe1(:,k)-a(1)*a(1)*ye1(:,k))*dt;
    ye1(:,k+1)=ye1(:,k)+xe1(:,k)*dt;
    xs1(:,k+1)=xs1(:,k)+(G(2)*a(2)*zs1(:,k)-2*a(2)*xs1(:,k)-a(2)*a(2)*ys1(:,k))*dt;
    ys1(:,k+1)=ys1(:,k)+xs1(:,k)*dt;
    xl1(:,k+1)=xl1(:,k)+(G(1)*a(1)*uf1(:)-2*a(1)*xl1(:,k)-a(1)*a(1)*yl1(:,k))*dt;
    yl1(:,k+1)=yl1(:,k)+xl1(:,k)*dt;
    xf1(:,k+1)=xf1(:,k)+(G(3)*a(3)*zf1(:,k)-2*a(3)*xf1(:,k)-a(3)*a(3)*yf1(:,k))*dt;
    yf1(:,k+1)=yf1(:,k)+xf1(:,k)*dt;
end
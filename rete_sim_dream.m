% Simulazione dell'intera rete; funzioni: ricostruzione pattern incompleti,
% recall di sequenze. 

%% parametri
dt=0.0001; %0.1 millisecondi
t=(0:dt:t_sim);
T=length(t);

% rng(11) 
sigma_p = sqrt(5/dt);
np = randn(numero_colonne,T)*sigma_p; 
sigma_f = sqrt(5/dt); 
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
IN1=zeros(numero_colonne,T);
for k=1:T-1 %ciclo nel tempo...
    %completo ingressi a piramidali e gaba fast:
    if size(mediaIN,2)==1
        mp1=mediaIN+noise; 
    else
        mp1=mediaIN(:,k)+noise(:,k); %se ho dato un ingresso variabile nel tempo
    end
    up1=np(:,k)+mp1;
    IN1(:,k)=up1;
    uf1=nf(:,k)+mf1;
    
    if(k>D_intraLayer) 
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

%% sim L2 L3
%var stato L2
yp2=zeros(numero_colonne,T);
xp2=zeros(numero_colonne,T);
vp2=zeros(numero_colonne,1); 
zp2=zeros(numero_colonne,T);

ye2=zeros(numero_colonne,T);
xe2=zeros(numero_colonne,T);
ve2=zeros(numero_colonne,1);
ze2=zeros(numero_colonne,T);

ys2=zeros(numero_colonne,T);
xs2=zeros(numero_colonne,T);
vs2=zeros(numero_colonne,1);
zs2=zeros(numero_colonne,T);

yf2=zeros(numero_colonne,T);
xf2=zeros(numero_colonne,T);
zf2=zeros(numero_colonne,T);
vf2=zeros(numero_colonne,1);

xl2=zeros(numero_colonne,T);
yl2=zeros(numero_colonne,T);

mf2=zeros(numero_colonne,1);
mp2=zeros(numero_colonne,1);

%var stato L3
yp3=zeros(numero_colonne,T);
xp3=zeros(numero_colonne,T);
vp3=zeros(numero_colonne,1); 
zp3=zeros(numero_colonne,T);

ye3=zeros(numero_colonne,T);
xe3=zeros(numero_colonne,T);
ve3=zeros(numero_colonne,1);
ze3=zeros(numero_colonne,T);

ys3=zeros(numero_colonne,T);
xs3=zeros(numero_colonne,T);
vs3=zeros(numero_colonne,1);
zs3=zeros(numero_colonne,T);

yf3=zeros(numero_colonne,T);
xf3=zeros(numero_colonne,T);
zf3=zeros(numero_colonne,T);
vf3=zeros(numero_colonne,1);

xl3=zeros(numero_colonne,T);
yl3=zeros(numero_colonne,T);

mf3=zeros(numero_colonne,1); 
mp3=zeros(numero_colonne,1);

Ep2=zeros(numero_colonne,1);
If2=zeros(numero_colonne,1);
Ep3=zeros(numero_colonne,1);
If3=zeros(numero_colonne,1);

sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);
% rng(12)
np2 = randn(numero_colonne,T)*sigma_p;
nf2 = randn(numero_colonne,T)*sigma_f;
% rng(13)
np3 = randn(numero_colonne,T)*sigma_p;
nf3 = randn(numero_colonne,T)*sigma_f;

for k=1:T-1 %ciclo nel tempo...
    %completo ingressi a piramidali e gaba fast    
    up2=np2(:,k)+mp2;
    uf2=nf2(:,k)+mf2;
    up3=np3(:,k)+mp3;
    uf3=nf3(:,k)+mf3;
    
    if k>D_intraLayer
        Ep2=Wp_L2L1*yp1(:,k-D_intraLayer)+Wp_L2L3*yp3(:,k-D_intraLayer);
        Ep3=Wp_L3L2*yp2(:,k-D_intraLayer); 
        Inib=100-sum(zp1(:,k-D_intraLayer));
        Inibitore=(abs(Inib) + Inib)/2;  % se l'attività zp1 è bassa (THETA OFF) L2 è inibito
        If2=K_L2L2*yp2(:,k-D_intraLayer)+A_L2L2*zp2(:,k-D_intraLayer)+1000*Inibitore;
        If3=K_L3L3*yp3(:,k-D_intraLayer)+A_L3L3*zp3(:,k-D_intraLayer); 
    end
    
    %potenziali post-sinaptici: (comb lin degli outputs standard)
    vp2(:)=C(:,2).*ye2(:,k)-C(:,4).*ys2(:,k)-C(:,7).*yf2(:,k)+Ep2;
    ve2(:)=C(:,1).*yp2(:,k);
    vs2(:)=C(:,3).*yp2(:,k);
    vf2(:)=C(:,6).*yp2(:,k)-C(:,5).*ys2(:,k)-C(:,8).*yf2(:,k)+yl2(:,k)+If2;
    %spikes:
    zp2(:,k)=2*e0./(1+exp(-r*(vp2(:)-s0)));
    ze2(:,k)=2*e0./(1+exp(-r*(ve2(:)-s0)));
    zs2(:,k)=2*e0./(1+exp(-r*(vs2(:)-s0)));
    zf2(:,k)=2*e0./(1+exp(-r*(vf2(:)-s0)));
    
    %potenziali post-sinaptici: (comb lin degli outputs standard)
    vp3(:)=C(:,2).*ye3(:,k)-C(:,4).*ys3(:,k)-C(:,7).*yf3(:,k)+Ep3;
    ve3(:)=C(:,1).*yp3(:,k);
    vs3(:)=C(:,3).*yp3(:,k);
    vf3(:)=C(:,6).*yp3(:,k)-C(:,5).*ys3(:,k)-C(:,8).*yf3(:,k)+yl3(:,k)+If3;
    %spikes:
    zp3(:,k)=2*e0./(1+exp(-r*(vp3(:)-s0)));
    ze3(:,k)=2*e0./(1+exp(-r*(ve3(:)-s0)));
    zs3(:,k)=2*e0./(1+exp(-r*(vs3(:)-s0)));
    zf3(:,k)=2*e0./(1+exp(-r*(vf3(:)-s0)));
      
    xp2(:,k+1)=xp2(:,k)+(G(1)*a(1)*zp2(:,k)-2*a(1)*xp2(:,k)-a(1)*a(1)*yp2(:,k))*dt;
    yp2(:,k+1)=yp2(:,k)+xp2(:,k)*dt;
    xe2(:,k+1)=xe2(:,k)+(G(1)*a(1)*(ze2(:,k)+up2(:)./C(:,2))-2*a(1)*xe2(:,k)-a(1)*a(1)*ye2(:,k))*dt;
    ye2(:,k+1)=ye2(:,k)+xe2(:,k)*dt;
    xs2(:,k+1)=xs2(:,k)+(G(2)*a(2)*zs2(:,k)-2*a(2)*xs2(:,k)-a(2)*a(2)*ys2(:,k))*dt;
    ys2(:,k+1)=ys2(:,k)+xs2(:,k)*dt;
    xl2(:,k+1)=xl2(:,k)+(G(1)*a(1)*uf2(:)-2*a(1)*xl2(:,k)-a(1)*a(1)*yl2(:,k))*dt;
    yl2(:,k+1)=yl2(:,k)+xl2(:,k)*dt;
    xf2(:,k+1)=xf2(:,k)+(G(3)*a(3)*zf2(:,k)-2*a(3)*xf2(:,k)-a(3)*a(3)*yf2(:,k))*dt;
    yf2(:,k+1)=yf2(:,k)+xf2(:,k)*dt;
    
    xp3(:,k+1)=xp3(:,k)+(G(1)*a(1)*zp3(:,k)-2*a(1)*xp3(:,k)-a(1)*a(1)*yp3(:,k))*dt;
    yp3(:,k+1)=yp3(:,k)+xp3(:,k)*dt;
    xe3(:,k+1)=xe3(:,k)+(G(1)*a(1)*(ze3(:,k)+up3(:)./C(:,2))-2*a(1)*xe3(:,k)-a(1)*a(1)*ye3(:,k))*dt;
    ye3(:,k+1)=ye3(:,k)+xe3(:,k)*dt;
    xs3(:,k+1)=xs3(:,k)+(G(2)*a(2)*zs3(:,k)-2*a(2)*xs3(:,k)-a(2)*a(2)*ys3(:,k))*dt;
    ys3(:,k+1)=ys3(:,k)+xs3(:,k)*dt;
    xl3(:,k+1)=xl3(:,k)+(G(1)*a(1)*uf3(:)-2*a(1)*xl3(:,k)-a(1)*a(1)*yl3(:,k))*dt;
    yl3(:,k+1)=yl3(:,k)+xl3(:,k)*dt;
    xf3(:,k+1)=xf3(:,k)+(G(3)*a(3)*zf3(:,k)-2*a(3)*xf3(:,k)-a(3)*a(3)*yf3(:,k))*dt;
    yf3(:,k+1)=yf3(:,k)+xf3(:,k)*dt;
end 
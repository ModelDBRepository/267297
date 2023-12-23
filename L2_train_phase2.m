% WARNING
% Script dipendente da L2_main.

%% parametri
dt=0.0001; %0.1 millisecondi
t_end2 = 0.25; 
t=(0:dt:t_end2);
T=length(t);
 
rng(12)  % stabilisco un certo seme per ripetere le simulazioni successive
sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);
% Parametri sigmoide
e0=2.5; %Hz
r=0.7; %1/mV
s0=10; %centro della sigmoide

% ritardi nella comunicazione tra colonne diverse
D_intraLayer=round(dt/dt); 
D_extraLayer=round(dt/dt); %delay di 0.0166 secondi?
                
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
K_L2L2=zeros(numero_colonne,numero_colonne); 
%conn da piramidali a GabaFast, colonne appartenenti allo stesso pattern
%(addestramento hebbiano)
A_L2L2=zeros(numero_colonne,numero_colonne);
%conn da piramidali a GabaFast, colonne appartenenti a pattern differenti
%(addestramento anti-hebbiano)
K_L2L2_max=8;
A_L2L2_max=0.3;
gammaK=1; %0.02;
gammaA=1; %0.04;
thresh_low=0.8; %0.5
thresh_up=0.6; %0.2

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

w = waitbar(0,'Training L2 e L3 (fase 1)...','WindowStyle','modal');
J=size(all_patterns,2);
for j=1:J %per ogni pattern...
    
    Ep=zeros(numero_colonne,1);
    If=zeros(numero_colonne,1);
    np = randn(numero_colonne,T)*sigma_p;
    nf = randn(numero_colonne,T)*sigma_f;
    mp2=zeros(numero_colonne,1);
    mf2=zeros(numero_colonne,1);
    
    for k=1:T-1 %ciclo nel tempo...
        %completo ingressi a piramidali e gaba fast:
        mp2=all_patterns(:,j)*2000; 
        mp2=mp2+(~all_patterns(:,j))*0; 
        mf2=all_patterns(:,j)*2000; 
        mf2=mf2+(~all_patterns(:,j))*(0);
        up=np(:,k)+mp2;
        uf=nf(:,k)+mf2;
        
        if (k>D_intraLayer)
            if SET_PATT==3
                If=0;
            else
                If=K_L2L2*yp2(:,k-D_intraLayer)+A_L2L2*zp2(:,k-D_intraLayer); 
            end
            %A moltiplica zp e non yp perchè passa attraverso le sinapsi
            %veloci dei GABAfast.
        end
        
        if (k>D_extraLayer)
            %Ep=Wp_L2L1*yp1(:,k-D_extraLayer); %in addestramento è
%             il maestro a fornire input (dall'esterno)
        end
        
        %potenziali post-sinaptici: (comb lin degli outputs standard)
        vp2(:)=C(:,2).*ye2(:,k)-C(:,4).*ys2(:,k)-C(:,7).*yf2(:,k)+Ep;
        ve2(:)=C(:,1).*yp2(:,k);
        vs2(:)=C(:,3).*yp2(:,k);
        vf2(:)=C(:,6).*yp2(:,k)-C(:,5).*ys2(:,k)-C(:,8).*yf2(:,k)+yl2(:,k)+If;
        %spikes:
        zp2(:,k)=2*e0./(1+exp(-r*(vp2(:)-s0)));
        ze2(:,k)=2*e0./(1+exp(-r*(ve2(:)-s0)));
        zs2(:,k)=2*e0./(1+exp(-r*(vs2(:)-s0)));
        zf2(:,k)=2*e0./(1+exp(-r*(vf2(:)-s0)));
        
        if k>=2200 %addestrando solo negli ultimi 30 msec
            ATT_PRE=(zp2(:,k)/(2*e0) - thresh_low)'; %1x400
            ATT_PRE(ATT_PRE<0)=0; %e l'attività è <0, la colonna è spenta...
            ATT_POST=(zf2(:,k)/(2*e0)-thresh_low); %400x1
            ATT_POST(ATT_POST<0)=0;
            WEIGHT_k=(K_L2L2_max - K_L2L2).*(ones(numero_colonne, numero_colonne)-eye(numero_colonne));
            K_L2L2 = K_L2L2 + gammaK .* (ATT_POST * ATT_PRE) .* WEIGHT_k;
            
            ATT_POST=(thresh_up-zf2(:,k)./(2*e0)); %400x1
            ATT_POST(ATT_POST<0)=0; %se i gabaFast post-sin sono "accesi", non devo rinforzare l'inibizione
            WEIGHT_a=(A_L2L2_max - A_L2L2).*(ones(numero_colonne, numero_colonne)-eye(numero_colonne));
            A_L2L2 = A_L2L2 + gammaA .* (ATT_POST * ATT_PRE) .* WEIGHT_a;
        end
        
        %nuovi outputs "standard" (non pesati) popolazioni:
        xp2(:,k+1)=xp2(:,k)+(G(1)*a(1)*zp2(:,k)-2*a(1)*xp2(:,k)-a(1)*a(1)*yp2(:,k))*dt;
        yp2(:,k+1)=yp2(:,k)+xp2(:,k)*dt;
        xe2(:,k+1)=xe2(:,k)+(G(1)*a(1)*(ze2(:,k)+up(:)./C(:,2))-2*a(1)*xe2(:,k)-a(1)*a(1)*ye2(:,k))*dt;
        ye2(:,k+1)=ye2(:,k)+xe2(:,k)*dt;
        xs2(:,k+1)=xs2(:,k)+(G(2)*a(2)*zs2(:,k)-2*a(2)*xs2(:,k)-a(2)*a(2)*ys2(:,k))*dt;
        ys2(:,k+1)=ys2(:,k)+xs2(:,k)*dt;
        xl2(:,k+1)=xl2(:,k)+(G(1)*a(1)*uf(:)-2*a(1)*xl2(:,k)-a(1)*a(1)*yl2(:,k))*dt;
        yl2(:,k+1)=yl2(:,k)+xl2(:,k)*dt;
        xf2(:,k+1)=xf2(:,k)+(G(3)*a(3)*zf2(:,k)-2*a(3)*xf2(:,k)-a(3)*a(3)*yf2(:,k))*dt;
        yf2(:,k+1)=yf2(:,k)+xf2(:,k)*dt;
            
    end
    waitbar(j/J,w);
end
close(w)

TOTSINK=160;
TOTSINA=min(sum(A_L2L2,2));
for i=1:numero_colonne
    S=sum(K_L2L2(i,:),2); %somma dei pesi sinaptici ricevuti dalla i-esima colonna
    if S>TOTSINK
        K_L2L2(i,:)=K_L2L2(i,:).*(TOTSINK/S);
    end
    S=sum(A_L2L2(i,:),2); %somma dei pesi sinaptici ricevuti dalla i-esima colonna
    if S>TOTSINA
        A_L2L2(i,:)=A_L2L2(i,:).*(TOTSINA/S);
    end
end

K_L3L3=K_L2L2;
A_L3L3=A_L2L2;
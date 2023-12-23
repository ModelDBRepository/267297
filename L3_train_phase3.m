%% parametri
dt=0.0001; %0.1 millisecondi
t_end3=0.15;
t=0:dt:t_end3;
T=length(t);

% Parametri sigmoide
e0=2.5; %Hz
r=0.7; %1/mV
s0=10; %centro della sigmoide

% ritardi nella comunicazione tra colonne diverse
D_intraLayer=round(dt/dt); 
D_extraLayer=round(dt/dt); %delay di 0.0166 secondi ?
                
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
Wp_L2L3=zeros(numero_colonne,numero_colonne);
gammaWb=10;
thresh_lowb=0.7;
Wp_L2L3_max=11;
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

Ep2=zeros(numero_colonne,1);
If2=zeros(numero_colonne,1);
Ep3=zeros(numero_colonne,1);
If3=zeros(numero_colonne,1);

sigma_p = sqrt(5/dt);
sigma_f = sqrt(5/dt);
rng(12)  
np2 = randn(numero_colonne,T)*sigma_p;
nf2 = randn(numero_colonne,T)*sigma_f;
rng(13)
np3 = randn(numero_colonne,T)*sigma_p;
nf3 = randn(numero_colonne,T)*sigma_f;

if SET_PATT==3
    SEQ2=all_patterns(:,[2:5 7:10]);
    SEQ3=[all_patterns(:,1:4) all_patterns(:,6:9)];
else
    SEQ2=all_patterns;
    SEQ3=[zeros(numero_colonne,1) all_patterns(:,1:end-1)];
end

J=size(SEQ2,2);
w = waitbar(0,'Training L2 e L3 (fase 2)...','WindowStyle','modal');
for j=1:J
    %completo ingressi a piramidali e gaba fast:
        mp2=SEQ2(:,j)*2700; 
        mp3=SEQ3(:,j)*2700;

    for k=1:T-1 %ciclo nel tempo... 
        up2=np2(:,k)+mp2;
        uf2=nf2(:,k)+mf2;
        up3=np3(:,k)+mp3;
        uf3=nf3(:,k)+mf3;

        if (k>D_intraLayer)
            If2=K_L2L2*yp2(:,k-D_intraLayer)+A_L2L2*zp2(:,k-D_intraLayer);
            If3=K_L3L3*yp3(:,k-D_intraLayer)+A_L3L3*zp3(:,k-D_intraLayer);
        end
        
        if(k>D_extraLayer)
            Ep2=Wp_L2L3*yp3(:,k-D_extraLayer);
            %Ep3=Wp_L3L2*yp2(:,k-D_extraLayer);
            %input extra-layer solo dal maestro!
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
        
        %aggiornamento sinapsi...
        if k>500
            ATT_PRE=(zp3(:,k)/(2*e0) - thresh_lowb)'; %1x400
            ATT_PRE(ATT_PRE<0)=0;
            ATT_POST=(zp2(:,k)/(2*e0)-thresh_lowb); %400x1
            ATT_POST(ATT_POST<0)=0;
            WEIGHT=(Wp_L2L3_max - Wp_L2L3).*(ones(numero_colonne, numero_colonne)-eye(numero_colonne));
            Wp_L2L3 = Wp_L2L3 + gammaWb .* (ATT_POST * ATT_PRE) .* WEIGHT;
        end
        
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
    waitbar(j/J,w);
end
close(w)
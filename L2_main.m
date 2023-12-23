%% LAYER 2 
%  Warning - Dipendenza da MAIN e L1_main! 
%  Preparazione del layer 2: addestramento e simulazione.

%% training layer2:
if train_flag
    %fase 1: addestramento sinapsi intra-livello (K e A)
    L2_train_phase2 %fornisce K e A anche per L3
        
    %sinapsi in avanti L2->L3:
    Wp_L3L2=eye(numero_colonne)*186;
end

%per visualizzare le matrici dei pesi
%figure, imagesc(K_L2L2), colormap gray, axis image, colorbar
%figure, imagesc(A_L2L2), colormap gray, axis image, colorbar


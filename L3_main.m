%% LAYER 3
%  Warning - Dipendenza da MAIN, L1_main e L2_main! 
%  Preparazione del layer 3: addestramento (feedback) e simulazione.

%% training layer3:
if train_flag
    %fase 3: addestramento sinapsi di feedback verso l2 (etero
    %associazione)
    L3_train_phase3
    
end

%figure, imagesc(Wp_L2L3), colormap gray, axis image, colorbar
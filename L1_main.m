%% LAYER 1
%  Preparazione del layer 1: addestramento e test di autoassociazione con
%  pattern parzialmente corrotto in ingresso. 

%% training layer1 e generazione output per training L2
if train_flag
    L1_train_phase1
    
    Wp_L2L1=eye(numero_colonne)*120; %sinapsi in avanti
    Wp_L1WM=eye(numero_colonne)*100; %sinapsi da WM
    Wp_WML1=eye(numero_colonne)*100; %feedback verso WM
end

%per visualizzare la matrice dei pesi
%figure, imagesc(Wp_L1L1), colormap gray, axis image, colorbar

%% test di autoassociazione:
if test_flag1
    P=randi(size(all_patterns,2),1,1);
    corrupted_input=corrupt_pattern(all_patterns(:,P));
    %prendo un pattern a caso tra quelli caricati e lo corrompo.
    figure
    subplot(121), title('pattern originale'), hold on, axis image
    imagesc(vecToIm(all_patterns(:,P),N,M)), colormap gray
    set(gca, 'YDir','reverse')
    subplot(122), title('pattern corrotto'), hold on, axis image
    imagesc(vecToIm(corrupted_input,N,M)), colormap gray
    set(gca, 'YDir','reverse')

    L1_test
end
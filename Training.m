%% MAIN
%  Lo script seguente gestisce tutti i codici ausiliari per la generazione,
%  addestramento e test della rete. Si consiglia di lanciare il programma
%  sezione per sezione.

clear
close all
clc

N=20;
M=20; 
numero_colonne=N*M;

SET_PATT = menu('Select the pattern:', 'SET1: Orthogonal fixed dimension', 'SET2: Orthogonal, variable dimension','SET3: not orthogonal fixed dimension');
load_patterns
%nella variabile "all_patterns" sono contenuti i pattern per colonna.

%parametri pilota:
train_flag=1;
t_sim=1.5; %impostare la durata della simulazione

%% ADDESTRAMENTO
test_flag1=0; %test di autoassociazione layer1, con visualizzazione di immagine dinamica (pattern corrotto)
L1_main
%A questo punto si avranno nel workspace Wp_L1L1, Wp_L2L1 addestrate e gli 
%output di L1 per il training parziale di L2 sono pronti nella variabile 
%yp1_train.
L2_main
%A questo punto si hanno A_L2L2, K_L2L2, A_L3L3, K_L3L3 (uguali a coppie) e
%Wp_L3L2. La rete è in grado di propagare l'info in avanti, ma le mancano
%ancora le connessioni a feedback per l'eteroassociazione L3-L2.
L3_main
%Training concluso. La matrice di sinapsi di feedback Wp_L2L3 è addestrata
%e la rete è pronta a lavorare.

%% SIMULAZIONE
% ... 
% Si vedano le sezioni di TEST_RETE.
clear
clc
close all
N=20;
M=20; 
numero_colonne=N*M;
fonte = 16;


%%
disp("choose the pattern with variable dimensions (number 2)")
N=20;
M=20; 
numero_colonne=N*M;

P=zeros(M*N,1);
all_patterns=zeros(N*M,9);
    figure
    %P1
    P1=P(:);
    pos1=[61:69 81:89 101:109];
    P1(pos1)=1;
    all_patterns(:,1)=P1;
    subplot(331)
    imm=vecToIm(P1,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 1'), axis image
    somma_pattern=imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P2
    P2=P(:);
    pos2=[3:16 23:36 43:56];
    P2(pos2)=1;
    all_patterns(:,2)=P2;
    subplot(332)
    imm=vecToIm(P2,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 2'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P3
    P3=P(:);
    pos3=[18:20 38:40 58:60 76:80 96:100 116:120 138:140 158:160];
    P3(pos3)=1;
    all_patterns(:,3)=P3;
    subplot(333)
    imm=vecToIm(P3,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 3'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P4
    P4=P(:);
    pos4=[92:94 112:114 129:137 149:157 169:177 192:194 212:214 232:234];
    P4(pos4)=1;
    all_patterns(:,4)=P4;
    subplot(334)
    imm=vecToIm(P4,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 4'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P5
    P5=P(:);
    pos5=[122:125 142:145 162:165 182:184 202:204 222:224];
    P5(pos5)=1;
    all_patterns(:,5)=P5;
    subplot(335)
    imm=vecToIm(P5,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 5'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P6
    P6=P(:);
    pos6=[205:210 225:230 245:250 265:270 285:290 305:310];
    P6(pos6)=1;
    all_patterns(:,6)=P6;
    subplot(336)
    imm=vecToIm(P6,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 6'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P7
    P7=P(:);
    pos7=[241:243 261:263 281:283 301:303 321:327 341:347 361:367];
    P7(pos7)=1;
    all_patterns(:,7)=P7;
    subplot(337)
    imm=vecToIm(P7,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 7'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P8
    P8=P(:);
    pos8=[195:198 215:218 235:238 255:260 275:280 295:300 318:320 338:340 358:360];
    P8(pos8)=1;
    all_patterns(:,8)=P8;
    subplot(338)
    imm=vecToIm(P8,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 8'), axis image
    somma_pattern=somma_pattern+imm;
    %P9
    P9=P(:);
    pos9=[312:314 329:335 349:355 369:375];
    P9(pos9)=1;
    all_patterns(:,9)=P9;
    xlim([0 20.5])
    ylim([0 20.5])
    subplot(339)
    imm=vecToIm(P9,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 9'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    
    % Decommentare la riga seguente per visualizzare tutti i pattern insieme e
    % verificare l'eventuale presenza di sovrapposizioni:
    %figure, imagesc(somma_pattern)
    clear P
%nella variabile "all_patterns" sono contenuti i pattern per colonna.

%%
disp("choose the pattern with equal dimensions and superimposition  (number 2)")
N=20;
M=20; 
numero_colonne=N*M;

P=zeros(M*N,1);
    all_patterns=zeros(N*M,10);
    figure
    %P1
    P1=P(:);
    pos1=[195:197 215:217 235:237 255:260 275:280 295:300 318:320 338:340 358:360];
    P1(pos1)=1;
    all_patterns(:,1)=P1;
    subplot(351)
    imm=vecToIm(P1,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 1'), axis image
    somma_pattern=imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P2
    P2=P(:);
    pos2=[18:20 38:40 58:60 75:80 95:100 115:120 138:140 158:160 178:180];
    P2(pos2)=1;
    all_patterns(:,2)=P2;
    subplot(352)
    imm=vecToIm(P2,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 2'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P3
    P3=P(:);
    pos3=[121:130 141:150 161:170 181:183 201:203];
    P3(pos3)=1;
    all_patterns(:,3)=P3;
    subplot(353)
    imm=vecToIm(P3,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 3'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P4
    P4=P(:);
    pos4=[241:243 261:263 281:283 301:303 321:328 341:348 361:368];
    P4(pos4)=1;
    all_patterns(:,4)=P4;
    subplot(354)
    imm=vecToIm(P4,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 4'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P5
    P5=P(:);
    pos5=[272:274 292:294 312:314 329:337 349:357 369:377];
    P5(pos5)=1;
    all_patterns(:,5)=P5;
    subplot(355)
    imm=vecToIm(P5,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 5'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    
    
    %P1', P4*
    P6=P(:);
    pos6=[222:228 243:248 263:269 283:289 303:308 323:325];
    P6(pos6)=1;
    all_patterns(:,6)=P6;
    subplot(356)
    imm=vecToIm(P6,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 6 (4*)'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P7
    P7=P(:);
    pos7=[5:16 25:36 45:56];
    P7(pos7)=1;
    all_patterns(:,7)=P7;
    subplot(357)
    imm=vecToIm(P7,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 7'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P8
    P8=P(:);
    pos8=[185:194 205:214 229:234 249:254 270:271 290:291];
    P8(pos8)=1;
    all_patterns(:,8)=P8;
    subplot(358)
    imm=vecToIm(P8,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 8'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P9
    P9=P(:);
    pos9=[1:3 21:23 41:43 61:69 81:89 101:109];
    P9(pos9)=1;
    all_patterns(:,9)=P9;
    subplot(359)
    imm=vecToIm(P9,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 9'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    %P10, P2*
    P10=P(:);
    pos10=[91:97 111:118 131:137 151:157 171:177];
    P10(pos10)=1;
    all_patterns(:,10)=P10;
    subplot(3,5,10)
    imm=vecToIm(P10,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('pattern 10 (2*)'), axis image
    somma_pattern=somma_pattern+imm;
    xlim([0 20.5])
    ylim([0 20.5])
    
    % Decommentare la riga seguente per visualizzare tutti i pattern insieme e
    % verificare l'eventuale presenza di sovrapposizioni:
    %figure, imagesc(somma_pattern)
    clear P





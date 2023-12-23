% WARNING
% Script dipendente da L1_main. Non lanciare il seguente script da solo.

% Creazione pattern di lavoro:
P=zeros(M*N,1);

% SET 1 - Ortogonali, dim fissa (36px)
if SET_PATT==1
    all_patterns=zeros(N*M,9);
    figure
    %P1
    P1=P(:);
    pos1=[1:3 21:23 41:43 61:69 81:89 101:109];
    P1(pos1)=1;
    all_patterns(:,1)=P1;
    subplot(331)
    imm=vecToIm(P1,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 1'), axis image
    somma_pattern=imm;
    %P2
    P2=P(:);
    pos2=[5:16 25:36 45:56];
    P2(pos2)=1;
    all_patterns(:,2)=P2;
    subplot(332)
    imm=vecToIm(P2,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 2'), axis image
    somma_pattern=somma_pattern+imm;
    %P3
    P3=P(:);
    pos3=[18:20 38:40 58:60 75:80 95:100 115:120 138:140 158:160 178:180];
    P3(pos3)=1;
    all_patterns(:,3)=P3;
    subplot(333)
    imm=vecToIm(P3,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 3'), axis image
    somma_pattern=somma_pattern+imm;
    %P4
    P4=P(:);
    pos4=[72:74 92:94 112:114 132:137 152:157 172:177 192:194 212:214 232:234];
    P4(pos4)=1;
    all_patterns(:,4)=P4;
    subplot(334)
    imm=vecToIm(P4,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 4'), axis image
    somma_pattern=somma_pattern+imm;
    %P5
    P5=P(:);
    pos5=[122:130 142:150 162:170 182:184 202:204 222:224];
    P5(pos5)=1;
    all_patterns(:,5)=P5;
    subplot(335)
    imm=vecToIm(P5,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 5'), axis image
    somma_pattern=somma_pattern+imm;
    %P6
    P6=P(:);
    pos6=[205:210 225:230 245:250 265:270 285:290 305:310];
    P6(pos6)=1;
    all_patterns(:,6)=P6;
    subplot(336)
    imm=vecToIm(P6,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 6'), axis image
    somma_pattern=somma_pattern+imm;
    %P7
    P7=P(:);
    pos7=[241:243 261:263 281:283 301:303 321:328 341:348 361:368];
    P7(pos7)=1;
    all_patterns(:,7)=P7;
    subplot(337)
    imm=vecToIm(P7,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 7'), axis image
    somma_pattern=somma_pattern+imm;
    %P8
    P8=P(:);
    pos8=[195:197 215:217 235:237 255:260 275:280 295:300 318:320 338:340 358:360];
    P8(pos8)=1;
    all_patterns(:,8)=P8;
    subplot(338)
    imm=vecToIm(P8,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 8'), axis image
    somma_pattern=somma_pattern+imm;
    %P9
    P9=P(:);
    pos9=[272:274 292:294 312:314 329:337 349:357 369:377];
    P9(pos9)=1;
    all_patterns(:,9)=P9;
    subplot(339)
    imm=vecToIm(P9,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 9'), axis image
    somma_pattern=somma_pattern+imm;
    
    % Decommentare la riga seguente per visualizzare tutti i pattern insieme e
    % verificare l'eventuale presenza di sovrapposizioni:
    %figure, imagesc(somma_pattern)
    clear P
    
    % SET 2 - Ortogonali, dim variabile (36 +/- 9 px)
elseif SET_PATT==2
    all_patterns=zeros(N*M,9);
    figure
    %P1
    P1=P(:);
    pos1=[61:69 81:89 101:109];
    P1(pos1)=1;
    all_patterns(:,1)=P1;
    subplot(331)
    imm=vecToIm(P1,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 1'), axis image
    somma_pattern=imm;
    %P2
    P2=P(:);
    pos2=[3:16 23:36 43:56];
    P2(pos2)=1;
    all_patterns(:,2)=P2;
    subplot(332)
    imm=vecToIm(P2,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 2'), axis image
    somma_pattern=somma_pattern+imm;
    %P3
    P3=P(:);
    pos3=[18:20 38:40 58:60 76:80 96:100 116:120 138:140 158:160];
    P3(pos3)=1;
    all_patterns(:,3)=P3;
    subplot(333)
    imm=vecToIm(P3,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 3'), axis image
    somma_pattern=somma_pattern+imm;
    %P4
    P4=P(:);
    pos4=[92:94 112:114 129:137 149:157 169:177 192:194 212:214 232:234];
    P4(pos4)=1;
    all_patterns(:,4)=P4;
    subplot(334)
    imm=vecToIm(P4,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 4'), axis image
    somma_pattern=somma_pattern+imm;
    %P5
    P5=P(:);
    pos5=[122:125 142:145 162:165 182:184 202:204 222:224];
    P5(pos5)=1;
    all_patterns(:,5)=P5;
    subplot(335)
    imm=vecToIm(P5,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 5'), axis image
    somma_pattern=somma_pattern+imm;
    %P6
    P6=P(:);
    pos6=[205:210 225:230 245:250 265:270 285:290 305:310];
    P6(pos6)=1;
    all_patterns(:,6)=P6;
    subplot(336)
    imm=vecToIm(P6,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 6'), axis image
    somma_pattern=somma_pattern+imm;
    %P7
    P7=P(:);
    pos7=[241:243 261:263 281:283 301:303 321:327 341:347 361:367];
    P7(pos7)=1;
    all_patterns(:,7)=P7;
    subplot(337)
    imm=vecToIm(P7,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 7'), axis image
    somma_pattern=somma_pattern+imm;
    %P8
    P8=P(:);
    pos8=[195:198 215:218 235:238 255:260 275:280 295:300 318:320 338:340 358:360];
    P8(pos8)=1;
    all_patterns(:,8)=P8;
    subplot(338)
    imm=vecToIm(P8,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 8'), axis image
    somma_pattern=somma_pattern+imm;
    %P9
    P9=P(:);
    pos9=[312:314 329:335 349:355 369:375];
    P9(pos9)=1;
    all_patterns(:,9)=P9;
    subplot(339)
    imm=vecToIm(P9,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 9'), axis image
    somma_pattern=somma_pattern+imm;
    
    % Decommentare la riga seguente per visualizzare tutti i pattern insieme e
    % verificare l'eventuale presenza di sovrapposizioni:
    %figure, imagesc(somma_pattern)
    clear P
    
elseif SET_PATT==3
    all_patterns=zeros(N*M,10);
    figure
    %P1
    P1=P(:);
    pos1=[195:197 215:217 235:237 255:260 275:280 295:300 318:320 338:340 358:360];
    P1(pos1)=1;
    all_patterns(:,1)=P1;
    subplot(251)
    imm=vecToIm(P1,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 1'), axis image
    somma_pattern=imm;
    %P2
    P2=P(:);
    pos2=[18:20 38:40 58:60 75:80 95:100 115:120 138:140 158:160 178:180];
    P2(pos2)=1;
    all_patterns(:,2)=P2;
    subplot(252)
    imm=vecToIm(P2,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 2'), axis image
    somma_pattern=somma_pattern+imm;
    %P3
    P3=P(:);
    pos3=[121:130 141:150 161:170 181:183 201:203];
    P3(pos3)=1;
    all_patterns(:,3)=P3;
    subplot(253)
    imm=vecToIm(P3,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 3'), axis image
    somma_pattern=somma_pattern+imm;
    %P4
    P4=P(:);
    pos4=[241:243 261:263 281:283 301:303 321:328 341:348 361:368];
    P4(pos4)=1;
    all_patterns(:,4)=P4;
    subplot(254)
    imm=vecToIm(P4,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 4'), axis image
    somma_pattern=somma_pattern+imm;
    %P5
    P5=P(:);
    pos5=[272:274 292:294 312:314 329:337 349:357 369:377];
    P5(pos5)=1;
    all_patterns(:,5)=P5;
    subplot(255)
    imm=vecToIm(P5,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 5'), axis image
    somma_pattern=somma_pattern+imm;
    
    
    %P1', P4*
    P6=P(:);
    pos6=[222:228 243:248 263:269 283:289 303:308 323:325];
    P6(pos6)=1;
    all_patterns(:,6)=P6;
    subplot(256)
    imm=vecToIm(P6,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 6 (4*)'), axis image
    somma_pattern=somma_pattern+imm;
    %P7
    P7=P(:);
    pos7=[5:16 25:36 45:56];
    P7(pos7)=1;
    all_patterns(:,7)=P7;
    subplot(257)
    imm=vecToIm(P7,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 7'), axis image
    somma_pattern=somma_pattern+imm;
    %P8
    P8=P(:);
    pos8=[185:194 205:214 229:234 249:254 270:271 290:291];
    P8(pos8)=1;
    all_patterns(:,8)=P8;
    subplot(258)
    imm=vecToIm(P8,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 8'), axis image
    somma_pattern=somma_pattern+imm;
    %P9
    P9=P(:);
    pos9=[1:3 21:23 41:43 61:69 81:89 101:109];
    P9(pos9)=1;
    all_patterns(:,9)=P9;
    subplot(259)
    imm=vecToIm(P9,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 9'), axis image
    somma_pattern=somma_pattern+imm;
    %P10, P2*
    P10=P(:);
    pos10=[91:97 111:118 131:137 151:157 171:177];
    P10(pos10)=1;
    all_patterns(:,10)=P10;
    subplot(2,5,10)
    imm=vecToIm(P10,N,M);
    imagesc(~imm), hold on, colormap gray, grid on, title('object 10 (2*)'), axis image
    somma_pattern=somma_pattern+imm;
    
    % Decommentare la riga seguente per visualizzare tutti i pattern insieme e
    % verificare l'eventuale presenza di sovrapposizioni:
    %figure, imagesc(somma_pattern)
    clear P
    
end
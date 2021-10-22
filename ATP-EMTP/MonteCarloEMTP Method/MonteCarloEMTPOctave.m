%function [BFR] = ATP(Rg,w,GFD)
%%
clc
clear all
pkg load statistics
%% Datos de diseño
Rg=50;%Resistencia de Impulso de Puesta a Tierra, ohms 
GFD=3.6;% Densidad de rayos, rayos/km^2/año
%%% Otros datos
w=200:10:240;% Aislamiento, en cm
D = 50; %Cantidad de descargas simuladas;
BW = 11; % distancia entre cables de guarda
TW = 39.3; % altura de la torre
RN = 0.1 * GFD * (BW + 28*TW^0.6); %Cantidad de descargas que impactan la torre
nfo(1,1) = 0; %Número de dstopescargas que causan BFR
nfo(1,2) = 0; %Número de dstopescargas que causan BFR
nfo(1,3) = 0; %Número de dstopescargas que causan BFR
nfo(1,4) = 0; %Número de dstopescargas que causan BFR
nfo(1,5) = 0; %Número de dstopescargas que causan BFR
kk=1;
for i = 1:D 
    I =  (lognrnd(log(33300),0.605)); %Corriente de la descarga    
    tf =  (lognrnd(log(2),0.494)); %Tiempo de frente de onda de la descarga
    %Modificación del archivo de ATP para incluir la nueva corriente,
    %tiempo de frente de onda de la descarga y Rg.
    fid = fopen('BFR','w');
    fprintf(fid,horzcat('BEGIN NEW DATA CASE\n$DUMMY, XYZ000\n   1.E-9   8.E-6                        \n     500       1       1       1       1       0       0       1       0\n/BRANCH\n-1XX0029XX0007                    145.2.55E8   2.7 1 0                         0\n-1XX0007XX0006                    145.2.55E8   6.6 1 0                         0\n-1XX0006XX0005                    145.2.55E8    6. 1 0                         0\n-1XX0005XX0004                    145.2.55E8   24. 1 0                         0\n  XX0004                     ',num2str(Rg),'.                                               0\n-1XX0030XX0011                    145.2.55E8   2.7 1 0                         0\n-1XX0011XX0010                    145.2.55E8   6.6 1 0                         0\n-1XX0010XX0009                    145.2.55E8    6. 1 0                         0\n-1XX0009XX0008                    145.2.55E8   24. 1 0                         0\n  XX0008                     ',num2str(Rg),'.                                               0\n-1XX0031PhaseA                    145.2.55E8   2.7 1 0                         0\n-1PhaseAPhaseB                    145.2.55E8   6.6 1 0                         0\n-1PhaseBPhaseC                    145.2.55E8    6. 1 0                         0\n-1PhaseCXX0012                    145.2.55E8   24. 1 0                         0\n  XX0012                     ',num2str(Rg),'.                                               0\n-1XX0032XX0016                    145.2.55E8   2.7 1 0                         0\n-1XX0016XX0015                    145.2.55E8   6.6 1 0                         0\n-1XX0015XX0014                    145.2.55E8    6. 1 0                         0\n-1XX0014XX0013                    145.2.55E8   24. 1 0                         0\n  XX0013                     ',num2str(Rg),'.                                               0\n-1XX0033XX0020                    145.2.55E8   2.7 1 0                         0\n-1XX0020XX0019                    145.2.55E8   6.6 1 0                         0\n-1XX0019XX0018                    145.2.55E8    6. 1 0                         0\n-1XX0018XX0017                    145.2.55E8   24. 1 0                         0\n  XX0017                     ',num2str(Rg),'.                                               0\n$INCLUDE, C:/ATP/work/span.lib, PHA###, PHB###, PHC###, PH2A##, PH2B## $$\n  , PH2C##, XX0031, XX0031, X0026A, X0026B, X0026C, X0025A, X0025B, X0025C $$\n  , XX0032, XX0032\n$INCLUDE, C:/ATP/work/span.lib, X0024A, X0024B, X0024C, X0023A, X0023B $$\n  , X0023C, XX0030, XX0030, PHA###, PHB###, PHC###, PH2A##, PH2B##, PH2C## $$\n  , XX0031, XX0031\n$INCLUDE, C:/ATP/work/span.lib, X0026A, X0026B, X0026C, X0025A, X0025B $$\n  , X0025C, XX0032, XX0032, X0028A, X0028B, X0028C, X0027A, X0027B, X0027C $$\n  , XX0033, XX0033\n$INCLUDE, C:/ATP/work/spanf.lib, X0028A, X0028B, X0028C, X0027A, X0027B $$\n  , X0027C, XX0033, XX0033, X0001A, X0001B, X0001C, X0001A, X0001B, X0001C $$\n  , ######, ######\n$INCLUDE, C:/ATP/work/span.lib, X0022A, X0022B, X0022C, X0021A, X0021B $$\n  , X0021C, XX0029, XX0029, X0024A, X0024B, X0024C, X0023A, X0023B, X0023C $$\n  , XX0030, XX0030\n$INCLUDE, C:/ATP/work/spanf.lib, X0002A, X0002B, X0002C, X0003A, X0003B $$\n  , X0003C, ######, ######, X0022A, X0022B, X0022C, X0021A, X0021B, X0021C $$\n  , XX0029, XX0029\n/SOURCE\n12XX0031-1   ',num2str(I),'.              ',num2str(tf),'E-6                                      1.\n14X0001A   281691.32       60.                                     -1.      100.\n14X0001B   281691.32       60.     -120.                           -1.      100.\n14X0001C   281691.32       60.     -240.                           -1.      100.\n/OUTPUT\n  PHA   PHB   PHC   PhaseAPhaseBPhaseCPH2A  PH2B  PH2C  \nBLANK BRANCH\nBLANK SWITCH\nBLANK SOURCE\nBLANK OUTPUT\nBLANK PLOT\nBEGIN NEW DATA CASE\nBLANKK CASE\nBLANK'));
    fclose(fid);
    system('rename BFR BFR.atp'); %Renombra el archivo a .atp
    system ('runATP.vbs'); %Corre el archivo de ATP a partir de un archivo .vbs
    system('pl42mat.vbs'); %Convierte los resultados de ATP de .pmatlab alll4 a .mat a través de un .vbs y GTPPL
    load('bfr01.mat');  
    %Carga el archivo .mat
    VI = vPHASEA - vPHA; 
    VI = [VI vPHASEB - vPHB];
    VI = [VI vPHASEC - vPHC];
    VI = [VI vPHASEA - vPH2A];
    VI = [VI vPHASEB - vPH2B];
    VI = [VI vPHASEC - vPH2C];
        for  h=1:length(w)   
     CFO = 0.01*w(h) * (400 + 710 * (t * 10^6) .^ -0.75) * 1000; %Calcula el CFO
    %Calcula el voltaje del aislador para cada fase
    %Verifica si hay backflashover
    IC = VI > CFO;
      nfo(kk+1,h) = nfo(kk,h) + (sum(sum(IC)) > 0);   
        P(kk,h) = nfo(kk,h)/kk; %Probabilidad de ocurrencia de backflashover
T(kk,h) = 0.6*RN*P(kk,h);
    end
    delete('BFR.atp'); 
 kk;   

kk=kk+1;
end
%length faults #BF       Frequency Probability BFOR 
[w(1)/100   kk-1 nfo(kk-1,1) RN        P(kk-1,1) T(kk-1,1);
 w(2)/100   kk-1 nfo(kk-1,2) RN        P(kk-1,2) T(kk-1,2);
 w(3)/100   kk-1 nfo(kk-1,3) RN        P(kk-1,3) T(kk-1,3);
 w(4)/100   kk-1 nfo(kk-1,4) RN        P(kk-1,4) T(kk-1,4);
 w(5)/100   kk-1 nfo(kk-1,5) RN        P(kk-1,5) T(kk-1,5)]
% save P
% save T
% % figure
% % plot(P(:,1))
% figure
% plot(T) 









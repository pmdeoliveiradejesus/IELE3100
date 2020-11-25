%function [BFR] = ATP(Rg,w,GFD)
%%
clear all
Rg=20;% Impulse grounding resistance in ohms
GFD=3.6;% Flash density (Flashe per km2
D = 20; % Number of aleatory flashes simulated
BW = 11; % Distance between shiel wires in meters
TW = 39.3; % Tower heigth in meters
RN = 0.1 * GFD * (BW + 28*TW^0.6); %Cantidad de descargas que impactan la torre
k=1:5;
nfo(1,k) = 0; %initialize the number of backflashes
w=200:100:600; % string length in centimeters 
kk=1;
for i = 1:D  %Iterative loop % No stop criteria is included
    I = round(lognrnd(log(33300),0.605)); %Flash current in Amperes    
    tf = round(lognrnd(log(2),0.494),1); % Wave front of the flash
    %Modificación del archivo de BFR.atp para incluir la nueva corriente,
    %tiempo de frente de onda de la descarga y Rg.
    fid = fopen('BFR','w');
    fprintf(fid,horzcat('BEGIN NEW DATA CASE\n$DUMMY, XYZ000\n   1.E-9   8.E-6                        \n     500       1       1       1       1       0       0       1       0\n/BRANCH\n-1XX0029XX0007                    145.2.55E8   2.7 1 0                         0\n-1XX0007XX0006                    145.2.55E8   6.6 1 0                         0\n-1XX0006XX0005                    145.2.55E8    6. 1 0                         0\n-1XX0005XX0004                    145.2.55E8   24. 1 0                         0\n  XX0004                     ',num2str(Rg),'.                                               0\n-1XX0030XX0011                    145.2.55E8   2.7 1 0                         0\n-1XX0011XX0010                    145.2.55E8   6.6 1 0                         0\n-1XX0010XX0009                    145.2.55E8    6. 1 0                         0\n-1XX0009XX0008                    145.2.55E8   24. 1 0                         0\n  XX0008                     ',num2str(Rg),'.                                               0\n-1XX0031PhaseA                    145.2.55E8   2.7 1 0                         0\n-1PhaseAPhaseB                    145.2.55E8   6.6 1 0                         0\n-1PhaseBPhaseC                    145.2.55E8    6. 1 0                         0\n-1PhaseCXX0012                    145.2.55E8   24. 1 0                         0\n  XX0012                     ',num2str(Rg),'.                                               0\n-1XX0032XX0016                    145.2.55E8   2.7 1 0                         0\n-1XX0016XX0015                    145.2.55E8   6.6 1 0                         0\n-1XX0015XX0014                    145.2.55E8    6. 1 0                         0\n-1XX0014XX0013                    145.2.55E8   24. 1 0                         0\n  XX0013                     ',num2str(Rg),'.                                               0\n-1XX0033XX0020                    145.2.55E8   2.7 1 0                         0\n-1XX0020XX0019                    145.2.55E8   6.6 1 0                         0\n-1XX0019XX0018                    145.2.55E8    6. 1 0                         0\n-1XX0018XX0017                    145.2.55E8   24. 1 0                         0\n  XX0017                     ',num2str(Rg),'.                                               0\n$INCLUDE, C:/ATP/work/span.lib, PHA###, PHB###, PHC###, PH2A##, PH2B## $$\n  , PH2C##, XX0031, XX0031, X0026A, X0026B, X0026C, X0025A, X0025B, X0025C $$\n  , XX0032, XX0032\n$INCLUDE, C:/ATP/work/span.lib, X0024A, X0024B, X0024C, X0023A, X0023B $$\n  , X0023C, XX0030, XX0030, PHA###, PHB###, PHC###, PH2A##, PH2B##, PH2C## $$\n  , XX0031, XX0031\n$INCLUDE, C:/ATP/work/span.lib, X0026A, X0026B, X0026C, X0025A, X0025B $$\n  , X0025C, XX0032, XX0032, X0028A, X0028B, X0028C, X0027A, X0027B, X0027C $$\n  , XX0033, XX0033\n$INCLUDE, C:/ATP/work/spanf.lib, X0028A, X0028B, X0028C, X0027A, X0027B $$\n  , X0027C, XX0033, XX0033, X0001A, X0001B, X0001C, X0001A, X0001B, X0001C $$\n  , ######, ######\n$INCLUDE, C:/ATP/work/span.lib, X0022A, X0022B, X0022C, X0021A, X0021B $$\n  , X0021C, XX0029, XX0029, X0024A, X0024B, X0024C, X0023A, X0023B, X0023C $$\n  , XX0030, XX0030\n$INCLUDE, C:/ATP/work/spanf.lib, X0002A, X0002B, X0002C, X0003A, X0003B $$\n  , X0003C, ######, ######, X0022A, X0022B, X0022C, X0021A, X0021B, X0021C $$\n  , XX0029, XX0029\n/SOURCE\n12XX0031-1   ',num2str(I),'.              ',num2str(tf),'E-6                                      1.\n14X0001A   281691.32       60.                                     -1.      100.\n14X0001B   281691.32       60.     -120.                           -1.      100.\n14X0001C   281691.32       60.     -240.                           -1.      100.\n/OUTPUT\n  PHA   PHB   PHC   PhaseAPhaseBPhaseCPH2A  PH2B  PH2C  \nBLANK BRANCH\nBLANK SWITCH\nBLANK SOURCE\nBLANK OUTPUT\nBLANK PLOT\nBEGIN NEW DATA CASE\nBLANKK CASE\nBLANK'));
    fclose(fid);
    system('rename BFR BFR.atp'); %Renombra el archivo a .atp
    system ('runATP.vbs'); %Mediante un script de Visual Basic se Corre el archivo de ATP (BFR.atp) a partir de un archivo .vbs
    system('pl42mat.vbs'); %Convierte los resultados de ATP de matlab .pl4 a .mat a través de un .vbs y GTPPL
    load('bfr01.mat'); %carga archivo .mat 
    %Carga el archivo .mat
    VI = vPHASEA - vPHA; % Surge voltage at phase a Circuit 1?
    VI = [VI vPHASEB - vPHB];% Surge voltage at phase b Circuit 1?
    VI = [VI vPHASEC - vPHC];% Surge voltage at phase c Circuit 1?
    VI = [VI vPHASEA - vPH2A];% Surge voltage at phase a Circuit 2?
    VI = [VI vPHASEB - vPH2B];% Surge voltage at phase b Circuit 2?
    VI = [VI vPHASEC - vPH2C];% Surge voltage at phase c Circuit 2?
   for  h=1:length(w)   
   CFO = 0.01*w(h) * (400 + 710 * (t * 10^6) .^ -0.75) * 1000; %Insulation strength (CFO)
   IC = VI > CFO; % Any backflashover?
   nfo(kk+1,h) = nfo(kk,h) + (sum(sum(IC)) > 0); % Backflash counter  
   P(kk,h) = nfo(kk,h)/kk; % Probability of backflash ocurrence
   T(kk,h) = 0.6*RN*P(kk,h); % BackFlashover Outage Rate (Tripouts/100km*year)
   end
    delete('BFR.atp'); 
 kk%iteration number   
[nfo(kk,1) P(kk,1) T(kk,1);
 nfo(kk,2) P(kk,2) T(kk,2);
 nfo(kk,3) P(kk,3) T(kk,3);
 nfo(kk,4) P(kk,4) T(kk,4);
 nfo(kk,5) P(kk,5) T(kk,5)]
kk=kk+1;% No stop criteria is included
end
% BFR=T(kk-1,1);
%save P
%save T
figure%plot results
plot(P(:,1));
%plot(T(:,1))
%matlab all





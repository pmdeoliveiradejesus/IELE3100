% This program determines the BFOR of a transmission line using the two
% point method (EPRI Red Book 1982)
% Developer:
% Paulo M. De Oliveira, pm.deoliveiradejes@uniandes.edu.co
% https://power.uniandes.edu.co/pdeoliveira
% Los Andes University
% First version: November 6, 2010 
clear all
close all
clc
%% Design parameters
Rg = 20;% Impulse resistancce [Ohm]
W = 2.63; % Insulator length [m]
%% Transmission Case data
global Vnom X Y R Dbundle span topcrossarm TR Po H Ta C hs Eo
Ng= 3.6; %Flash density [flashes per km2]
Vnom = 345; %kV
% coordinates;
X = [-5.5 5.5 -5.5 -8.6  -5.8 5.5 8.6  5.8]; %m
Y = [39.3 39.3 33.8 27.4  21.3 33.8 27.4 21.3];  %m
R = [0.45 0.45 1.48 1.48 1.48 1.48 1.48 1.48 ]/100;  % cm radius
Dbundle = 0.467;    %m distance in the bundle
span = 335; %m 
topcrossarm = [2.7 9.3 15.3];   %[m]
TR = 10;    % [m] Tower Base Radius
%T = 30; % Kereunic Level
Po = 760; %mmHg, atmospheric pressure at sea level
H = 0000;    %m, Altitude
Ta = 20;  %Celsius degrees, air temperature
C = 0.003671; %Thermal expansion coefficient 1/C
hs = 7;   %m midspan
Eo = 1500;    % kV/m 
%%
[Tbf] = EpriBFRAC(Rg,W,Ng) % BFOR outages/100km/yr

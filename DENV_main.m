%====================================================================
% SUMMARY:
% This main script will only run if you select the DENV dataset. 
% The optimal parameters are stored in the Nx2xM array where M_i
% corresponds to the sampling_rng values. Lastly,script outputs the mean
% optimal r and p parameters along with the MSE corresponding the specified
% sampling range(s).
%===================================================================
addpath('Functions\');

[fileName, path]= uigetfile('.csv');

year = 1; 
a = ((year-1)*52) + 1; 
b = year*52;
sampling_rng = [20,30,40,50];
sampling_prcnt= 1;
q_guess = [.9 .9];

numIterations = 10; 
VirusLoc = 'San Juan';


DengueData = readtable([path,fileName]);  
t_tot = table2array(DengueData([a:b],2)); 
t_tot = 1:length(t_tot) ;
y_tot = table2array(DengueData([a:b],end)); 

tic
qopt = zeros(numIterations,2,length(sampling_rng));

for ii = 1:length(sampling_rng)
    for tt =1:numIterations
    [qopt(tt,:,ii)] = dengue_forecast(DengueData,sampling_rng, sampling_prcnt,q_guess,year);
    end
end
% Get qmean and MSE. Plot solution
[qmean,MSEE] = plotVirus_D(t_tot,y_tot,qopt,sampling_rng);

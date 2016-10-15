%====================================================================
% SUMMARY:
% This main script will only run if you select the ZIKV dataset. 
% The optimal parameters are stored in the Nx2xM array where M_i
% corresponds to the sampling_rng values. 
%===================================================================
addpath('Functions\');
[fileName, path]= uigetfile('*.*');
sampling_rng = [20 35 50 70];
sampling_prcnt= 1; % Allows the user to sample a percentage of observations. Set=1 for paper results.
q_guess = [.81 .82]; %(r, p)
numIterations = 11; % must be >= 2
% Get data
ZikaData = readtable([path,fileName]);
t_tot = table2array(ZikaData(:,1));
y_tot = table2array(ZikaData(:,2));

tic
figure(2312)
% qopt is a n-dim array that stores our optimal q values for various ranges.
qopt = zeros(numIterations, 2, length(sampling_rng));
for ii = 1:length(sampling_rng)
% Solve for optimal qopt
    for jj =1:numIterations
        [qopt(jj,:,ii), ~, ~] = zika_forecast(ZikaData,sampling_rng(ii), sampling_prcnt,q_guess);
    end
end
% modify this for plot handles
[qmean, MSEZ] = plotVirus_D(t_tot, y_tot,qopt, sampling_rng);
toc
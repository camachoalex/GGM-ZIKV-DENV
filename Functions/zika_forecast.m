function [qopt, tsampled, ysampled] = zika_forecast(ZikaData,sampling_rng, sampling_prcnt,q_guess)
%==========================================================================
% The purpose of this function is to calculate the optimal parameters. This
% script outputs the sampled values along with the optimal values. The
% optimal values are not necessary, but useful for verifying the results.

% INPUT: ZikaData - matlab table structure containing days and number of
%                   documented cases.
%       sampling_rng - value sampled up to (e.g. 20 days
%       sampling_prcnt - fraction of points the user wants to sample. For
%                        this project set equal to 1.
%       q_guess - initial estimates of r and p.
% OUTPUT: qopt - optimized model parameters r and p.
%         tsampled - sampled t values (not necessary. used to check output)
%         ysampled - sampled y values (not necessary. used to check output)
%==========================================================================
    t = table2array(ZikaData(:,1)); % days
    t = t+1; % makes sure t spans [1,105] (matlab indexes at 1.)
    y = table2array(ZikaData(:,2)); % cases
    trng = t(1:sampling_rng);
    yrng = y(trng);
    numPts = numel(trng);
    tsampled = randsample(trng,ceil(numPts*sampling_prcnt),'true'); % sampling with replacement
    tsampled = sort(tsampled);
    ysampled = yrng(tsampled);
    t0 = min(tsampled);
    C0 = y(t0); 
    cumy = cumsum(ysampled);
    total_cumy = cumsum(y);
    K = total_cumy(end); % final epidemic size
    
    C   = @(q) (q(1)*(1-q(2)).*tsampled+C0^(1-q(2)) ).^(1/(1-q(2)));
    qopt = SmithLV(C,cumy,q_guess);
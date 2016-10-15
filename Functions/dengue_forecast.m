function [qopt,tsampled, ysampled] = dengue_forecast(DengueData,...
                                                    sampling_rng,...
                                                    sampling_prcnt,...
                                                    q_guess,year)
%==========================================================================
% The purpose of this function is to calculate the optimal parameters. This
% script outputs the sampled values along with the optimal values. The
% optimal values are not necessary, but useful for verifying the results.

% INPUT: 
%       DengueData - matlab table structure containing days and number of
%                   documented cases.
%       sampling_rng - value sampled up to (e.g. 20 weeks)
%       sampling_prcnt - fraction of points the user wants to sample. For
%                        this project set equal to 1.
%       q_guess - initial estimates of r and p.
%       year  - year to run analyses on. (1-18)
% OUTPUT: 
%         qopt - optimized model parameters r and p.
%         tsampled - sampled t values (not necessary. used to check output)
%         ysampled - sampled y values (not necessary. used to check output)
%========================================================================== 
% This section is used to specify the year(s) we want to run our
% algorithm on. Note: we are not taking leap year into account.
    a = ((year-1)*52) + 1; 
    b = year*52; 
    
    t = table2array(DengueData(a:b,1)); % weekly data
    t = 1:length(t); 
    y = table2array(DengueData(a:b,end)); % cases
    trng = t(1:sampling_rng);
    yrng = y(trng);
    numPts = numel(trng);
    % sampling with replacement
    tsampled = randsample(trng,ceil(numPts*sampling_prcnt),'true'); 
    tsampled = sort(tsampled);
    ysampled = yrng(tsampled);
    % get C0 and final epidemic size, K
    t0 = min(tsampled); C0 = 1;
    cumy = cumsum(ysampled)';
    total_cumy = cumsum(y);
    K = total_cumy(end); 

    C   = @(q) (q(1)*(1-q(2)).*tsampled+C0^(1-q(2)) ).^(1/(1-q(2)));
    qopt = SmithLV(C,cumy,q_guess);
end
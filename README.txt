**************************************************************
MATLAB Code for: Forecasting the Epidemic Outbreaks of Zika and Dengue Viruses using Phenomenological Generalized Growth Models
Authors: Alejandro Camacho, Luis Ramirez, Alejandra Solorzano.

Email: 
camacho@csu.fullerton.edu
hughjass@csu.fullerton.edu
asolorzano9@csu.fullerton.edu

MATLAB VERSION: R2015b - academic use

!~ By running these programs, the authors assume no responsibility for any damages damages.  
**************************************************************
FUNCTION: ZIKV_main.m
 SUMMARY:
 This main script will only run if you select the ZIKV dataset. 
 The optimal parameters are stored in the Nx2xM array where M_i
 corresponds to the sampling_rng values. Lastly,script outputs the mean
 optimal r and p parameters along with the MSE corresponding the specified
 sampling range(s). 
**************************************************************
FUNCTION: DENV_main.m
 SUMMARY:
 This main script will only run if you select the DENV dataset. 
 The optimal parameters are stored in the Nx2xM array where M_i
 corresponds to the sampling_rng values. Lastly,script outputs the mean
 optimal r and p parameters along with the MSE corresponding the specified
 sampling range(s). 
**************************************************************
FUNCTION: zika_forecast.m
 The purpose of this function is to calculate the optimal parameters. This
 script outputs the sampled values along with the optimal values. The
 optimal values are not necessary, but useful for verifying the results.

 INPUT: ZikaData - matlab table structure containing days and number of
                   documented cases.
       sampling_rng - value sampled up to (e.g. 20 days
       sampling_prcnt - fraction of points the user wants to sample. For
                        this project set equal to 1.
       q_guess - initial estimates of r and p.
 OUTPUT: qopt - optimized model parameters r and p.
         tsampled - sampled t values (not necessary. used to check output)
         ysampled - sampled y values (not necessary. used to check output)
**************************************************************
FUNCTION: dengue_forecast.m
 The purpose of this function is to calculate the optimal parameters. This
 script outputs the sampled values along with the optimal values. The
 optimal values are not necessary, but useful for verifying the results.

 INPUT: 
       DengueData - matlab table structure containing days and number of
                   documented cases.
       sampling_rng - value sampled up to (e.g. 20 weeks)
       sampling_prcnt - fraction of points the user wants to sample. For
                        this project set equal to 1.
       q_guess - initial estimates of r and p.
       year  - year to run analyses on. (1-18)
 OUTPUT: 
         qopt - optimized model parameters r and p.
         tsampled - sampled t values (not necessary. used to check output)
         ysampled - sampled y values (not necessary. used to check output)
*************************************************************
FUNCTION SmithLV.m

 This function wraps optimization procedure. This function minimizes the
 cost function J, using the levenber-marquart method. Below is the link
 regarding the modifications:
		https://www.mathworks.com/help/optim/ug/optimoptions.html
 FUN FACT: This wrapper was named after Professor Smith.

 INPUTS: y_model - anonymous function of the true model.
         y - observations
         q_guess - initial guess
 OUTPUT: q_opt - optimzed r and p parameters.
*************************************************************
FUNCTION PlotVirus_D.m

 The purpose of this function is to plot the solution given our optimal
 parameters. 
 INPUTS: t - time vector
         y - observations
         qopt- optimized r and p parameters
         s_rng - sampling range
 OUTPUT: qout - Mx2 matrix corresponding mean optimal paramters per
         sampling rang
         MSE_x - MSE for the mean optimal parameters and the data.

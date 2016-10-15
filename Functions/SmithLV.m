function q_opt = SmithLV(y_model, y,q_guess)
% This function wraps optimization procedure. This function minimizes the
% cost function J, using the levenber-marquart method. Below is the link
% regarding the modifications:
%>>>>>> https://www.mathworks.com/help/optim/ug/optimoptions.html
% FUN FACT: This wrapper was named after Professor Smith.
%
% INPUTS: y_model - anonymous function of the true model.
%         y - observations
%         q_guess - initial guess
% OUTPUT: q_opt - optimzed r and p parameters.
options.Algorithm = 'levenberg-marquardt';
options.MaxFunEvals = 1000;
% Professor Smith's code
    J = @(q) sum((y_model(q)-y).^2)./std(y);
    lb = [];
    ub = [];
    q_opt = lsqnonlin(J, q_guess,lb,ub, options);  % non-linearly minimize model
end
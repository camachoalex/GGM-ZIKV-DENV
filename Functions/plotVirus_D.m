function [qout,MSE_x] = plotVirus_D(t,y,qopt, s_rng)
%==========================================================================
% The purpose of this function is to plot the solution given our optimal
% parameters. 
% INPUTS: t - time vector
%         y - observations
%         qopt- optimized r and p parameters
%         s_rng - sampling range
% OUTPUT: qout - Mx2 matrix corresponding mean optimal paramters per
%         sampling rang
%         MSE_x - MSE for the mean optimal parameters and the data.
%==========================================================================
    a=1.5;
    tmp = cumsum(y);
    K = tmp(end);
    C0 = 1;
    % plot data and ode solution with optimal parameters
    [m,~,~]=size(qopt);
    qout=[];
    for ii=1:length(s_rng)
        subplot(2,2,ii)
        for k = 1 : m
            Cp = @(t,C) qopt(k,1,ii)*(C^qopt(k,2,ii))*(1-(C./K).^a);
            [t_ode,y_ode]  = ode45(Cp,0:150,C0);
           plot(t_ode(1:end-1),diff(y_ode),'Color',[0 0 0]+0.05*17,'linewidth',1.5); 
           hold on;
        end
        q_mean = [mean(qopt(:,1,ii)), mean(qopt(:,2,ii))];
      
        qout = [qout;q_mean];
        Cp = @(t,C) q_mean(1)*(C^q_mean(2))*(1-(C./K).^a);
        [t_mean,y_mean] = ode45(Cp,min(t):max(t)+50,C0);
        plot(y,'ro');
        plot(diff(y_mean),'black','linewidth', 3);
        line([s_rng(ii) s_rng(ii)],[0 max(y)*2],'linewidth',2);
        axis([0 150 0 max(y)]);
        hold off
        ht= title(sprintf('Sample up to: %i days',s_rng(ii)));
        textt = text(50,50,strcat('q_{mean}=(',num2str(q_mean(1) ),...
                                           num2str(q_mean(2)),')'),...
                                           'HorizontalAlignment','center');
        textt(1).FontSize = 20; 
        set(ht,'fontsize',25)
        % calculate MSE
        MSE_x(ii) = immse(diff(y_mean(1:length(y))),y(1:end-1)); 
    end
end
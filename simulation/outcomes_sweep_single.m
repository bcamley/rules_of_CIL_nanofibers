function [fwb,frev,ftrain,statesall,qs] = outcomes_sweep_single(qWT,Nits,varyparam,paramfactor,doplot)

if(nargin<5)
    doplot = false;
end
%doplot = false;

fwb = NaN*ones(size(paramfactor));
frev = fwb; ftrain = fwb;
statesall = cell(size(paramfactor));
qs = statesall;
%rinitsall = cell(length(adhs),length(betaffs));
%thetainitsall = cell(length(adhs),length(betaffs));
   
for ii = 1:length(paramfactor)
        q = qWT;
        if(~strcmp(varyparam,'repolarizefactor'))
            q.(varyparam) = paramfactor(ii)*(qWT.(varyparam));
        else
            %disp('Varying repolarize factor');
            if(abs(qWT.repolarizefactor-1) < 50*eps)
               % don't vary repolarize factor for cells that aren't
               % dividing
                q.repolarizefactor = 1;
            else
                q.repolarizefactor = paramfactor(ii)*(qWT.repolarizefactor);                
            end
            fprintf('Varying repolarizefactor from WT = %3.3g to mut = %3.3g \n',qWT.repolarizefactor,q.repolarizefactor);
        end
        [states,rinits,theta_inits] = harmonic_cil_statistics(q,Nits);
        statesall{ii} = states;
        fwb(ii) = sum(states==3)/sum(states~=0);
        frev(ii) = sum(states==2)/sum(states~=0);
        qs{ii} = q;
    %end
    if(Nits>200)
        fprintf('%d/%d ...',ii,length(paramfactor));
    end
    %fprintf('Completed %d/%d sweeps on adhesion \n',ii,length(adhs));
end
fprintf('\n');
ftrain = 1-frev-fwb;
%%

if(doplot)
    shaded_outcome_plot(frev,fwb,ftrain,Nits,varyparam,paramfactor,0.05);
end
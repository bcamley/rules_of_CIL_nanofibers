function fall = outcomes_sweep_single_allpossible(qWT,Nits,varyparam,paramfactor,repolamt)
% sweep over a parameter in the spindle, parallel, spindle-div, and
% parallel-div configurations
fall = cell(1,4);
% Spindle, parallel, spindle div, parallel div
Deltas = [NaN 2*qWT.R NaN 2*qWT.R];
repols = [1 1 repolamt repolamt];
names = {'Spindle-Spindle','Parallel-Parallel','Spindle-Daughter','Parallel-Daughter'};


doplot=false;

if(doplot)
    subplot(4,1,1)
end
for s = 1:4
    if(doplot)
        subplot(1,4,s)
    end
    qWT.Delta = Deltas(s);
    qWT.repolarizefactor = repols(s);
    [fwb,frev,ftrain,statesall,qs] = outcomes_sweep_single(qWT,Nits,varyparam,paramfactor,doplot);
    if(doplot)
        drawnow;
        title(names{s})
        if(s~=1)
            ylabel('');
        end
        
    end
    fdata = struct;
    fdata.fwb = fwb; fdata.frev = frev; fdata.ftrain = ftrain; fdata.statesall = statesall; fdata.qs = qs;
    fall{s} = fdata;
    
end
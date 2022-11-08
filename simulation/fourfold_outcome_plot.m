function hs = fourfold_outcome_plot(fall,Nits,varyparam,paramfactor,alpha)
clf
% Deltas = [NaN 2*qWT.R NaN 2*qWT.R];
% repols = [1 1 repolamt repolamt];
% 1 = spindle
% 2 = parallel
% 3 = spindle-div
% 4 = parallel-div
names = {'Spindle-Spindle','Parallel-Parallel','Spindle-Daughter','Parallel-Daughter'};
for s = 1:4
    subplot(1,4,s)
    fd = fall{s};
    hs{s} = shaded_outcome_plot(fd.frev,fd.fwb,fd.ftrain,Nits,varyparam,paramfactor,alpha);
    if(s~=1)
        ylabel('');
    end
    title(names{s})
    xlim([min(paramfactor) max(paramfactor)]);
end
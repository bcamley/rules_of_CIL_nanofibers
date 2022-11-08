load('sweep_over_extra_params.mat');
rerun = false; % rerun = true means we run all of the sweeping over parameters again
              % THIS WILL TAKE ~1 hr

% Compare walk-past rates for different conditions for all of the
% parameters generated over the plausible range
compare_outcomes_from_latin_params_separate(fs_array);
drawnow
qWT = qfinal_optimized;

params_to_vary = {'adhcell','betaff','sigma','kappa','kappacell','dt','repolarizefactor','tau','cgv'};
paramfactor = linspace(0.5,2,12);
%%

alpha = 0.05; % plot 95% confidence intervals

for j = 1:length(params_to_vary)
    fprintf('Varying parameter %s ... \n',params_to_vary{j});
    if(rerun)
        fall_vary_params.(params_to_vary{j}) = outcomes_sweep_single_allpossible(qWT,Nits,params_to_vary{j},paramfactor,repolamt);
        save('temp_state3');
    end
    figure
    fourfold_outcome_plot(fall_vary_params.(params_to_vary{j}),Nits,params_to_vary{j},paramfactor,alpha);
    set(gcf,'Position',1.0e+3*[-0.0230 0.3330 1.28 0.2853]);
    drawnow
end

%% Compare between best fit and experimental data
Nits_final = 500; % run to get most reliable numbers

fprintf('Recalculating best-fit fractions with Nits = %d collisions; note this is a re-run so numbers will not perfectly match paper \n',Nits_final)
[err,fsall] = get_relevant_fractions(qWT,Nits_final,repolamt,discardparWB,qt);

fprintf('Spindle: Frac walkby is %3.3g vs %3.3g true, train = %3.3g vs %3.3g true, rev = %3.3g vs %3.3g true\n',fsall{1}.fwb,qt.fwb_spindle_true,1-fsall{1}.fwb-fsall{1}.frev,1-qt.fwb_spindle_true-qt.frev_spindle_true,fsall{1}.frev,qt.frev_spindle_true);
fprintf('Parallel: Frac walkby is %3.3g vs %3.3g true, train = %3.3g vs %3.3g true, rev = %3.3g vs %3.3g true \n',fsall{2}.fwb,qt.fwb_parallel_true,1-fsall{2}.fwb-fsall{2}.frev,1-qt.fwb_parallel_true-qt.frev_parallel_true,fsall{2}.frev,qt.frev_parallel_true);
fprintf('Spindle div: Frac walkby is %3.3g vs %3.3g true, train = %3.3g vs %3.3g true, rev = %3.3g vs %3.3g true \n',fsall{3}.fwb,qt.fwb_spindle_div_true,1-fsall{3}.fwb-fsall{3}.frev,1-qt.fwb_spindle_div_true-qt.frev_spindle_div_true,fsall{3}.frev,qt.frev_spindle_div_true);
fprintf('Parallel div: Frac walkby is %3.3g vs %3.3g true, train = %3.3g vs %3.3g true, rev = %3.3g vs %3.3g true \n',fsall{4}.fwb,qt.fwb_parallel_div_true,1-fsall{4}.fwb-fsall{3}.frev,1-qt.fwb_parallel_div_true-qt.frev_parallel_div_true,fsall{4}.frev,qt.frev_parallel_div_true);
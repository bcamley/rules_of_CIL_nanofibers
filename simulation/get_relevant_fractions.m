function [err,fsall] = get_relevant_fractions(q,Nits,repolamt,discardparWB,qt)

fs_spindle = struct;
fs_spindle_div = struct;
fs_parallel_div = struct;
fs_parallel = struct;

% run simulation for single, no repolarization
q.Delta = NaN;
q.repolarizefactor = 1;

[states,rinits,theta_inits] = harmonic_cil_statistics(q,Nits);

fs_spindle.states = states;
fs_spindle.fwb = sum(states==3)/sum(states~=0);
fs_spindle.frev = sum(states==2)/sum(states~=0);

% run simulation for single with repolarization
q.Delta = NaN;
q.repolarizefactor = repolamt;

states = harmonic_cil_statistics(q,Nits);

fs_spindle_div.fwb =  sum(states==3)/sum(states~=0);
fs_spindle_div.frev =  sum(states==2)/sum(states~=0);
fs_spindle_div.states = states;

% run simulation for parallel, no repolarization
q.Delta = q.R*2;
q.repolarizefactor = 1;

states = harmonic_cil_statistics(q,Nits);

fs_parallel.fwb =  sum(states==3)/sum(states~=0);
fs_parallel.frev =  sum(states==2)/sum(states~=0);
fs_parallel.states = states;

% run simulation for parallel with repolarization
q.Delta = q.R*2;
q.repolarizefactor = repolamt;

states = harmonic_cil_statistics(q,Nits);

fs_parallel_div.fwb =  sum(states==3)/sum(states~=0);
fs_parallel_div.frev =  sum(states==2)/sum(states~=0);
fs_parallel_div.states = states;

fsall = {fs_spindle,fs_parallel,fs_spindle_div,fs_parallel_div};

err = (fs_spindle.fwb-qt.fwb_spindle_true)^2          +(fs_spindle.frev-qt.frev_spindle_true)^2           + (fs_spindle.fwb-qt.fwb_spindle_true + fs_spindle.frev - qt.frev_spindle_true)^2 + ...
      (fs_spindle_div.fwb-qt.fwb_spindle_div_true)^2  +(fs_spindle_div.frev-qt.frev_spindle_div_true)^2   + (fs_spindle_div.fwb-qt.fwb_spindle_div_true + fs_spindle_div.frev - qt.frev_spindle_div_true)^2 + ...
      (fs_parallel_div.fwb-qt.fwb_parallel_div_true)^2+(fs_parallel_div.frev-qt.frev_parallel_div_true)^2 + (fs_parallel_div.fwb-qt.fwb_parallel_div_true + fs_parallel_div.frev - qt.frev_parallel_div_true)^2 + ...
      (fs_parallel.fwb-qt.fwb_parallel_true)^2        +(fs_parallel.frev-qt.frev_parallel_true)^2         + (fs_parallel.fwb-qt.fwb_parallel_true + fs_parallel.frev - qt.frev_parallel_true)^2;
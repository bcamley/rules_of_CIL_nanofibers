clf
repolarize_time_spindle = [85
70
340
228
120
120
20
30
84
24
198
42];

repolarize_time_spindle_div = [55
59
108
120
54
36
120
60
48];

%c1 = [0 ; 0.45 ; 0.74];
%c3 = [0.93 ; 0.63 ;  0.13];
%c2 = [0.85 ; 0.33 ; 0.1];
%C = [c1 c2 c1 c2 c1 c2];
%C = [c1 c1];

c0 = [0.3 ; 0.3 ; 0.3];
C = [c0 c0];

beeswarm_mark([ones(size(repolarize_time_spindle)) ; 2*ones(size(repolarize_time_spindle_div))],[repolarize_time_spindle ; repolarize_time_spindle_div],'colormap',C.','sort_style','rand','overlay_style','se','MarkType',{'o','^'});
%ylim([0 300]);
set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter'})
ylabel('Repolarization time [min]')
set(gca,'FontSize',18)

[~,p_daught_vs_spindle] = ttest2(repolarize_time_spindle,repolarize_time_spindle_div);
text(1.5,mean([repolarize_time_spindle ; repolarize_time_spindle_div]),sprintf('p = %3.3g',p_daught_vs_spindle),'FontSize',18);
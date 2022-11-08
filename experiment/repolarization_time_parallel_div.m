clf
repol_time_par = [54
30
12
61
42
103
75
92
90
42
42
30
102];

repol_time_push = [34
33
10
60
32
27
60];

repol_time_div_not_push = [114
50
32
70
48
180
70];

repolarization_time_all_dividing = [repol_time_push ; repol_time_div_not_push];

%c1 = [0 ; 0.45 ; 0.74];
%c3 = [0.93 ; 0.63 ;  0.13];
%c2 = [0.85 ; 0.33 ; 0.1];
%C = [c1 c2 c1 c2 c1 c2];
%C = [c1 c1 c1];
c0 = [0.3 ; 0.3 ; 0.3];
C = [c0 c0 c0];
Q = [ones(size(repol_time_par)) ; 2*ones(size(repolarization_time_all_dividing))];
TT = [repol_time_par ; repolarization_time_all_dividing];
beeswarm_mark(Q,TT,'colormap',C.','sort_style','rand','overlay_style','se','MarkType',{'o','^','^'});
%ylim([0 300]);
set(gca,'XTick',[1 2 3]);
set(gca,'XTickLabel',{'Parallel','Daughter'})
ylabel('Repolarization time [min]')
set(gca,'FontSize',18)
[~,p_daught_vs_par] = ttest2(repol_time_par,repolarization_time_all_dividing);
text(1.5,mean([repol_time_par ; repolarization_time_all_dividing]),sprintf('p = %3.3g',p_daught_vs_par),'FontSize',18);
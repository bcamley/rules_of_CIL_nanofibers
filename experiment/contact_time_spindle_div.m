contacttime_spindle = [174
252
162
408
144
390
486
138
66
312
54
60
72
60
264
366
222
132];
contacttime_spindle_div = [168
210
180
288
180
294
168
156
102
456
498
120
252
102
168
216];

%c1 = [0 ; 0.45 ; 0.74];
%c3 = [0.93 ; 0.63 ;  0.13];
%c2 = [0.85 ; 0.33 ; 0.1];
%C = [c1 c2 c1 c2 c1 c2];
c0 = [0.3 ; 0.3 ; 0.3];
C = [c0 c0];


beeswarm_mark([ones(size(contacttime_spindle)) ; 2*ones(size(contacttime_spindle_div))],[contacttime_spindle ; contacttime_spindle_div],'colormap',C.','sort_style','rand','overlay_style','se','MarkType',{'o','^'});
ylim([0 550]);

set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter'})
ylabel('Time in contact [min]')
set(gca,'FontSize',18)

[~,p_contacttime] = ttest2(contacttime_spindle,contacttime_spindle_div);
text(1.5,mean([contacttime_spindle ; contacttime_spindle_div]),sprintf('p = %3.3g',p_contacttime),'FontSize',18);
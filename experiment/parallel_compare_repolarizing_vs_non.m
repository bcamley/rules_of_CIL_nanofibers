speeds_pre_during_par_both = [0.624048634	0.55622343	0.561294309	0.514513536
0.330674192	0.524070598	0.507022599	0.975401479
0.444794906	0.549622678	0.555457053	0.602676403
1.19413364	0.637982501	1.086924983	0.575509718
1.024764233	0.603081785	0.808934009	0.47346947
0.594056655	0.602129101	0.356552638	0.719896504
0.512890028	0.502307474	0.907124369	0.69397071
0.649117983	0.753528266	1.154874202	1.011698828
0.289535251	0.408286477	0.588950458	0.315662981
0.492035524	0.612610337	1.026575484	0.835087626
1.083857532	0.613200952	0.990107511	0.500653403
0.528769109	0.555218453	0.418863962	0.561863362
0.418460646	0.483582345	0.541711931	0.522185168
0.956017442	0.367774105	0.495781104	0.618253316
0.3376169	0.441090045	0.575753126	0.629339565];
% parallel pre, parallel during, parallel pre (cell that repols), parallel
% during (the one that repols)
np = size(speeds_pre_during_par_both,1);
Zreorg = [speeds_pre_during_par_both(:,1) ; speeds_pre_during_par_both(:,3) ; speeds_pre_during_par_both(:,2) ; speeds_pre_during_par_both(:,4)  ];
Q = ones(np,1)*(1:1:4);
c1 = [0 ; 0.45 ; 0.74];
c2 = [0.93 ; 0.63 ;  0.13];
C = [c1 c1 c2 c2];
%beeswarm_mark(Q(:),speeds_pre_during_par_both(:),'sort_style','rand','overlay_style','se','colormap',C.')
%set(gca,'XTick',[1 2 3 4]);
%set(gca,'XTickLabel',{'Parallel pre','Parallel During','Repol pre','Repol during'})

beeswarm_mark(Q(:),Zreorg,'sort_style','rand','overlay_style','se','colormap',C.')
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel',{'Non-repol.','Repol.','Non-repol.','Repol.'})

text(1,1.3,'Pre-collision','color',c1,'FontSize',18);
text(3,1.3,'During','color',c2,'FontSize',18)
ylim([0 1.35])

ylabel('Speed [\mum/min]');
set(gca,'fontSize',18)
figure
beeswarm_mark(ones(15,1),speeds_pre_during_par_both(:,3)-speeds_pre_during_par_both(:,1),'sort_style','rand','overlay_style','se')
ylabel('Speed difference [\mum /min]')
set(gca,'FontSize',18)
set(gca,'XTick',1);
set(gca,'XTickLabel',{'Pre-collision: Repolarizing minus Nonrepolarizing'})
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
[~,p_compare_speed_pre] = ttest(speeds_pre_during_par_both(:,3)-speeds_pre_during_par_both(:,1));
text(1,0,sprintf('p = %2.1g',p_compare_speed_pre));

%%
figure
beeswarm_mark(ones(15,1),speeds_pre_during_par_both(:,4)-speeds_pre_during_par_both(:,2),'sort_style','rand','overlay_style','se')
ylabel('Speed difference [\mum /min]')
set(gca,'FontSize',18)
set(gca,'XTick',1);
set(gca,'XTickLabel',{'During interaction: Repolarizing minus Nonrepolarizing'})
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
[~,p_compare_speed_during] = ttest(speeds_pre_during_par_both(:,4)-speeds_pre_during_par_both(:,2));
text(1,0,sprintf('p = %2.1g',p_compare_speed_during));

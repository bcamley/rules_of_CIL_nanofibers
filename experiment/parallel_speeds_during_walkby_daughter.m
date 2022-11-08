% plot data
Z = [1.25465517	1.086324144	1.260133846	1.530329708	0.627024324	1.828500099
1.055595822	1.139311487	0.666018763	0.858626287	0.469050794	0.791227434
1.152492961	1.242679532	1.285381101	2.12086253	1.955170148	1.927961594
0.5112572	1.104795321	0.88462237	0.709357735	0.807977358	1.023418533
1.371127709	0.953335674	1.310161556	0.926781859	0.663509174	0.127337184
1.022329349	0.857434638	0.548387091	0.645413793	0.508591775	0.23861957
1.423861135	0.886323487	0.875081934	0.370026319	0.648441122	0.691580991
0.4599795	0.752578551	0.615962859	0.403437378	0.739056623	0.895625871
0.768435364	0.876358467	0.865188829	0.646302953	0.862452099	0.857569024];
% daughter pre, daughter during, daughter after, par pre, par during, par
% after
Zreorg = [Z(:,1) Z(:,4) Z(:,2) Z(:,5) Z(:,3) Z(:,6)];
% eorg to daughter pre, par pre, daughter during, par during, daughter
% post par post
np = size(Zreorg,1);
Q = ones(np,1)*(1:1:6);
c1 = [0 ; 0.45 ; 0.74];
c3 = [0.93 ; 0.63 ;  0.13];
c2 = [0.85 ; 0.33 ; 0.1];
%C = [c1 c2 c1 c2 c1 c2];
C = [c1 c1 c2 c2 c3 c3];
beeswarm_mark(Q(:),Zreorg(:),'sort_style','rand','overlay_style','se','colormap',C.','MarkType',{'^','o','^','o','^','o'});
set(gca,'XTickLabel',{'Daughter','Parallel','Daughter','Parallel','Daughter','Parallel'})
ylabel('Speed [\mum/min]')
set(gca,'FontSize',18)

%line([1 2],[2.1 2.1],'LineWidth',4,'color',c1)
text(1,2.3,'Pre-collision','FontSize',18,'color',c1)
text(3,2.3,'During','FontSize',18,'color',c2)
text(5,2.3,'Post-collision','FontSize',18,'color',c3)
%ylim([0 2.2])

figure
% Check differences
Zdaughter_prevsduring = Z(:,1)-Z(:,2);
Zdaughter_duringvspost = Z(:,2)-Z(:,3);
Zpar_prevsduring = Z(:,4)-Z(:,5);
Zpar_duringvspost = Z(:,5)-Z(:,6);
Q2 = [ones(np,1) ; 2*ones(np,1) ; 3*ones(np,1) ; 4*ones(np,1)];
Zdiff = [Zdaughter_prevsduring ; Zdaughter_duringvspost ; Zpar_prevsduring ; Zpar_duringvspost];
beeswarm_mark(Q2(:),Zdiff(:),'sort_style','rand','overlay_style','se');
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel',{'Daught Pre - During','Daught During - Post','Par Pre - During','Par During - Post'})
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'k--')


[h1,p_daughter_prevsduring] = ttest(Zdaughter_prevsduring);
[h2,p_daughter_duringvspost] = ttest(Zdaughter_duringvspost);
[h3,p_par_prevsduring] = ttest(Zpar_prevsduring);
[h4,p_par_duringvspost] = ttest(Zpar_duringvspost);

text(1,0,sprintf('p = %3.3g',p_daughter_prevsduring));
text(2,0,sprintf('p = %3.3g',p_daughter_duringvspost));
text(3,0,sprintf('p = %3.3g',p_par_prevsduring));
text(4,0,sprintf('p = %3.3g',p_par_duringvspost));
title('Speed changes during collision')
ylabel('Change in speed [\mum/min]')
set(gca,'FontSize',18)

%% Compare daughter vs parallel
figure
% Z 1,2,3,4,5,6
% daughter pre, daughter during, daughter after, par pre, par during, par
Zdaughtvspar_pre = Z(:,1)-Z(:,4);
Zdaughtvspar_during = Z(:,2)-Z(:,5);
Zdaughtvspar_post = Z(:,3)-Z(:,6);
Q3 = [ones(np,1) ; 2*ones(np,1) ; 3*ones(np,1)];
Zdiff_daughtvspar = [Zdaughtvspar_pre ; Zdaughtvspar_during ; Zdaughtvspar_post];
beeswarm_mark(Q3(:),Zdiff_daughtvspar(:),'sort_style','rand','overlay_style','se');

set(gca,'XTick',[1 2 3]);
set(gca,'XTickLabel',{'Pre','During','Post'})
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'k--')


[h5,pdaughtvspar_pre] = ttest(Zdaughtvspar_pre);
[h6,pdaughtvspar_during] = ttest(Zdaughtvspar_during);
[h7,pdaughtvspar_post] = ttest(Zdaughtvspar_post);

text(1,0,sprintf('p = %3.3g',pdaughtvspar_pre));
text(2,0,sprintf('p = %3.3g',pdaughtvspar_during));
text(3,0,sprintf('p = %3.3g',pdaughtvspar_post));

title('Daughter speed - parallel speed')
ylabel('Speed difference [\mum/min]')
set(gca,'FontSize',18)

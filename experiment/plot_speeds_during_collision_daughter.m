% daughter/spindle 
Z2 = [0.727031344	0.305581381	0.911777951	0.483005752	0.673921889	0.340915317
1.540297374	0.413177177	0.637763691	0.42717833	0.372311038	0.366860284
0.309264428	0.39044162	0.453173875	0.746219652	0.478737062	0.450490371
0.412923117	0.492103655	0.51959606	0.39634632	0.632800768	0.571954423
0.773602306	0.585543843	0.434499634	0.531408117	0.422881144	0.674939137
0.865034841	0.633367694	0.568408028	0.533995911	1.075450384	0.580357541
0.470637056	0.378429541	0.492364014	0.637584396	0.600595382	0.402075221
0.645057566	0.735802524	0.961024846	0.641594284	0.830848581	0.463754874
1.991857569	0.454204679	0.989705945	0.772032334	1.123083888	0.83107031
1.314417185	0.295745214	0.52633896	0.192642361	0.357646213	0.175953295
0.585394305	0.576935396	0.372182628	0.409546667	0.436361785	0.562162751
1.197767542	0.476193068	0.947528642	0.654287303	0.81747983	0.386988764
1.202139452	0.30370197	0.480694442	0.39800423	0.642218378	0.533333333
0.771844973	0.599714404	0.589167821	0.792044393	0.62828951	0.562753044
0.810151084	0.219718642	0.729205626	0.343626656	0.752970025	0.453305313
0.699377318	0.52802918	0.471299642	0.343913196	0.703397975	0.296777973];
% daughter pre, spindle pre, daughter during, spindle during, daughter
% post, spindle post
% data for daughter/spindle before, during, after
np = size(Z2,1);
Q = ones(np,1)*(1:1:6);
c1 = [0 ; 0.45 ; 0.74];
c3 = [0.93 ; 0.63 ;  0.13];
c2 = [0.85 ; 0.33 ; 0.1];
%C = [c1 c2 c1 c2 c1 c2];
C = [c1 c1 c2 c2 c3 c3];
beeswarm_mark(Q(:),Z2(:),'sort_style','rand','overlay_style','se','colormap',C.','MarkType',{'^','o','^','o','^','o'});
set(gca,'XTickLabel',{'Daughter','Spindle','Daughter','Spindle','Daughter','Spindle'})
ylabel('Speed [\mum/min]')
set(gca,'FontSize',18)

%line([1 2],[2.1 2.1],'LineWidth',4,'color',c1)
text(1,2.1,'Pre-collision','FontSize',18,'color',c1)
text(3,2.1,'During','FontSize',18,'color',c2)
text(5,2.1,'Post-collision','FontSize',18,'color',c3)
ylim([0 2.2])

%% Plots the differences between time stages
figure
Zd_pre_during = Z2(:,1)-Z2(:,3);
Zd_during_post = Z2(:,3)-Z2(:,5);
Zs_pre_during = Z2(:,2)-Z2(:,4);
Zs_during_post = Z2(:,4)-Z2(:,6);
Zdiff = [Zd_pre_during ; Zd_during_post ; Zs_pre_during ; Zs_during_post];
Qdiff = [ones(np,1) ; 2*ones(np,1) ; 3*ones(np,1);4*ones(np,1)];
beeswarm_mark(Qdiff,Zdiff,'sort_style','rand','overlay_style','se');
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel',{'Daught Pre - During','Daught During - Post','Spindle Pre - During','Spindle During - Post'})

hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'k--')

[h1,p_daught_pre_during] = ttest(Zd_pre_during);
[h2,p_daught_during_post] = ttest(Zd_during_post);
[h3,p_spind_pre_during] = ttest(Zs_pre_during);
[h4,p_spind_during_post] = ttest(Zs_during_post);
text(1,0,sprintf('p = %3.3g',p_daught_pre_during));
text(2,0,sprintf('p = %3.3g',p_daught_during_post));
text(3,0,sprintf('p = %3.3g',p_spind_pre_during));
text(4,0,sprintf('p = %3.3g',p_spind_during_post));
title('Speed changes during collision')
ylabel('Change in speed [\mum/min]')
set(gca,'FontSize',18)

%% Plot comparisons between daughter-and-spindle
figure
% Z = 1,2,3,4,5,6
% daughter pre, spindle pre, daughter during, spindle during, daughter
% post, spindle post
Z_daughtvsspind_pre = Z2(:,1)-Z2(:,2);
Z_daughtvsspind_during = Z2(:,3)-Z2(:,4);
Z_daughtvsspind_post = Z2(:,5)-Z2(:,6);
Zdiff_daughtvsspind = [Z_daughtvsspind_pre ; Z_daughtvsspind_during ; Z_daughtvsspind_post];
Qdiff2 = [ones(np,1) ; 2*ones(np,1) ; 3*ones(np,1)];
beeswarm_mark(Qdiff2,Zdiff_daughtvsspind,'sort_style','rand','overlay_style','se');
set(gca,'XTick',[1 2 3]);
set(gca,'XTickLabel',{'Pre','During','Post'})
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'k--')
[~,p_daughtvsspind_pre] = ttest(Z_daughtvsspind_pre);
[~,p_daughtvsspind_during] = ttest(Z_daughtvsspind_during);
[~,p_daughtvsspind_post] = ttest(Z_daughtvsspind_post);
text(1,0,sprintf('p = %3.3g',p_daughtvsspind_pre));
text(2,0,sprintf('p = %3.3g',p_daughtvsspind_during));
text(3,0,sprintf('p = %3.3g',p_daughtvsspind_post));

title('Daughter speed - spindle speed')
ylabel('Speed difference [\mum/min]')
set(gca,'FontSize',18)


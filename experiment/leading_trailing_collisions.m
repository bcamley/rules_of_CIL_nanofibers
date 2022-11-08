% script to do the L-T collisions
spindleLT_preduring = [0.778993333	0.680910769	0.225946667	0.518140171
0.271869863	0.296400865	0.224195088	0.318145837
0.606741402	0.706304573	0.337485503	0.735603625
0.411064273	0.265930388	0.233382767	0.349954289
0.182992439	0.200522308	0.16671844	0.188236087
0.412705902	0.58575799	0.379628479	0.710704732
0.731064817	0.543183743	0.556378709	0.567577914
1.102047479	0.645239578	0.713008479	0.737047366
0.31381962	0.454968108	0.268912096	0.411711711
0.66318895	0.560772208	0.490565494	0.473706797
0.382897265	0.510151111	0.26524786	0.385344066
0.617511555	0.658198745	0.554126183	0.604872182
0.87714445	0.974862983	0.496005455	0.834235086
0.689907221	0.735710275	0.497640944	0.739961486
0.398462141	0.578823045	0.382817581	0.409409811
0.512455219	0.417536319	0.505564271	0.597506961];
% trailing pre, trailing during, leading pre, leading during

spindledivLT = [0.561169438	0.356687514	0.391911851	0.920092957
0.463316988	0.739432361	0.371405586	0.668804493
1.117594492	1.043881787	0.385952726	0.71279377
1.522229132	0.783149437	0.337695221	0.660556766
1.632027707	0.541811598	0.541811598	0.73614645
0.646114376	0.494114415	0.485553643	0.62016191
1.263053241	0.874884244	0.597970741	0.710080488
0.648540724	0.565788268	0.52805233	0.536469014
0.534977811	0.441290045	0.360841915	0.497179473];
% trailing pre, trailing during, leading pre, leading during

parallelLT = [0.803481373	0.705269512	0.634959027	0.651128979
0.568248161	0.437275711	0.500466321	0.516777771
1.028961434	0.635277854	0.594381033	0.692935608
0.6296901	0.482486705	0.308653113	0.575186809
0.914054163	0.90588914	0.719470751	0.829529299
1.205257682	0.761157641	0.605751652	0.665112889
0.736224471	0.635572649	0.525284541	0.682595791
0.925449021	0.600102945	0.832430498	0.800896569
0.987792063	0.696409521	0.974139837	1.410029708
1.076516933	0.736378536	0.780271706	1.145598592
0.458946768	0.488752931	0.330184841	0.654728413];
% trailing pre, trailing during, leading pre, leading during

paralleldivLT = [1.009860909	0.758877021	0.418890581	1.15955667
1.011598826	0.799120013	0.702950445	0.747446363
0.560460714	0.807537824	0.28712703	0.339774552
1.92232736	0.630529963	0.670304494	0.774760925
1.304001282	1.136199295	0.293106282	0.659812515
1.39740683	1.174851169	0.712521423	1.289116014
0.260322538	0.662048592	0.258341145	0.436025089
0.608350478	0.847073397	0.460021746	0.687035036
0.879154482	0.53838674	0.618463681	0.632637768
1.123000347	0.736687606	0.651287368	0.758669414
0.633116294	0.456574916	0.258958459	0.648950842
1.110343682	0.699238911	0.302604009	0.644947852
0.815775849	0.650479361	0.567359078	0.835570987
0.666773737	0.592334387	0.610085522	0.67954905
0.596479049	0.887162521	0.399520696	0.597348692
0.544867764	0.518629534	0.403064377	0.603025995
0.960026011	0.521801991	0.251285415	0.481996748
1.034017993	0.938845322	0.519274088	0.758172637];
% trailing pre trailing during leading pre leading during

LTs = cell(1,4);
LTs{1} = spindleLT_preduring;
LTs{2} = spindledivLT;
LTs{3} = parallelLT;
LTs{4} = paralleldivLT;
titles = {'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'};

for j = 1:4
    figure(1)
    subplot(2,2,j)
    np = size(LTs{j},1);
    Q = ones(np,1)*[1 2 4 5];
%c1 = [0 ; 0.45 ; 0.74];
%c2 = [0.93 ; 0.63 ;  0.13];
c1 = [0 ; 0.45 ; 0.74];
c3 = [0.93 ; 0.63 ;  0.13];
c2 = [0.85 ; 0.33 ; 0.1];
C = [c1 c2 c1 c2];
if(j==2 || (j==4))
    marks = {'^','^','o','o'};
else
    marks = {'o','o','o','o'};
end
    beeswarm_mark(Q(:),LTs{j}(:),'sort_style','rand','overlay_style','se','colormap',C.','MarkType',marks);
    set(gca,'FontSize',18)
    set(gca,'XTick',[1 2 4 5]);
    set(gca,'XTickLabel',{'Pre','During','Pre','During'})
    ylim([0 2]);
    text(1.2,1.8,'Trailing','FontSize',14)
    text(4.2,1.8,'Leading','FontSize',14)
%    figure(2)
%    subplot(2,2,j)
%    beeswarm(ones(np,1),LTs{j}(:,1)-LTs{j}(:,3),'sort_style','rand','overlay_style');
%    ylabel('Trailing cell speed - Leading cell speed [\mu m /min]')
    %figure(3)
    %subplot(2,2,j)
    %beeswarm(ones(np,1),LTs{j}(:,4)-LTs{j}(:,3),'sort_style','rand','overlay_style');
    %ylabel('Gain in speed by leading cell postcollision [\mu m /min]')
    %ylim([-0.1 0.8]);
    %xl = xlim;
    %hold on
    %plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
    if(j==1)
        ylabel('Speed [\mum/min]','FontSize',24)
    end
    title(titles{j})
end
%%

figure(2)
clf
%set(gcf,'Position',(1e3)*[0.2457 0.1457 1.0093 0.420]);
set(gcf,'Position',[115.6667  142.3333  635.3333  420.0000]);
GainsPre = cell(1,4);
IndicesPre = cell(1,4);
for j = 1:4
    GainsPre{j} = LTs{j}(:,1)-LTs{j}(:,3);
    IndicesPre{j} = j*ones(size(LTs{j}(:,1)));
end
IIP = cell2mat(IndicesPre(:));
GGP = cell2mat(GainsPre(:));

c4 = [ 0.3010    0.7450    0.9330].';
c5 = [    0.4660    0.6740    0.1880].';
C = [c4 c4 c5 c5];

beeswarm_mark(IIP,GGP,'sort_style','rand','overlay_style','se','MarkType',{'o','^','o','^'},'colormap',C.');
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
ylim([-0.05 1.4]);
set(gca,'FontSize',24)
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel',{});
%set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'})
%text(
text(0.7,-0.18,{'Spindle-' 'Spindle'},'FontSize',18)
text(1.7,-0.18,{'Spindle-' 'Daughter'},'FontSize',18)
text(2.7,-0.18,{'Parallel-' 'Parallel'},'FontSize',18)
text(3.7,-0.18,{'Parallel-' 'Daughter'},'FontSize',18)
set(gca,'FontSize',24)
ylabel('Trailing - Leading speed [\mum /min]','FontSize',18)

[~,p_TL_spind_spind] = ttest(GGP(IIP==1));
[~,p_TL_spind_daught] = ttest(GGP(IIP==2));
[~,p_TL_par_par] = ttest(GGP(IIP==3));
[~,p_TL_par_daught] = ttest(GGP(IIP==4));

text(1,0,sprintf('p = %1.2g',p_TL_spind_spind),'FontSize',18);
text(2,0,sprintf('p = %1.2g',p_TL_spind_daught),'FontSize',18);
text(3,0,sprintf('p = %1.2g',p_TL_par_par),'FontSize',18);
text(4,0,sprintf('p = %1.2g',p_TL_par_daught),'FontSize',18);

%set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'})
%set(gcf,'Position',(1e3)*[0.2457 0.1457 1.0093 0.420]);

%%
figure(3)
clf
%set(gcf,'Position',(1e3)*[0.2457 0.1457 1.0093 0.420]);
set(gcf,'Position',[115.6667  142.3333  635.3333  420.0000]);
Gains = cell(1,4);
Indices = cell(1,4);
for j = 1:4
    Gains{j} = LTs{j}(:,4)-LTs{j}(:,3);
    Indices{j} = j*ones(size(LTs{j}(:,1)));
end
II = cell2mat(Indices(:));
GG = cell2mat(Gains(:));
c4 = [ 0.3010    0.7450    0.9330].';
c5 = [    0.4660    0.6740    0.1880].';
C = [c4 c4 c5 c5];

IndMatrix3 = cell2mat(Indices(:));
GainMatrix3 = cell2mat(Gains(:));
%beeswarm_mark(cell2mat(Indices(:)),cell2mat(Gains(:)),'sort_style','rand','overlay_style','se','MarkType',{'o','^','o','^'},'colormap',C.')
beeswarm_mark(IndMatrix3,GainMatrix3,'sort_style','rand','overlay_style','se','MarkType',{'o','^','o','^'},'colormap',C.');

hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
set(gca,'XTick',[1 2 3 4]);
%set(gca,'XTickLabel',{'Spindle','Spindle + div','Parallel','Parallel+div'})
set(gca,'XTickLabel',{});
%set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'})
%text(
text(0.7,-0.18,{'Spindle-' 'Spindle'},'FontSize',18)
text(1.7,-0.18,{'Spindle-' 'Daughter'},'FontSize',18)
text(2.7,-0.18,{'Parallel-' 'Parallel'},'FontSize',18)
text(3.7,-0.18,{'Parallel-' 'Daughter'},'FontSize',18)
set(gca,'FontSize',24)
ylabel('Leading cell speed gain [\mum /min]','FontSize',18)

[~,p_LeadGain_spind_spind] = ttest(GainMatrix3(IndMatrix3==1));
[~,p_LeadGain_spind_daught] = ttest(GainMatrix3(IndMatrix3==2));
[~,p_LeadGain_par_par] = ttest(GainMatrix3(IndMatrix3==3));
[~,p_LeadGain_par_daught] = ttest(GainMatrix3(IndMatrix3==4));

text(1,0,sprintf('p = %1.2g',p_LeadGain_spind_spind),'FontSize',18);
text(2,0,sprintf('p = %1.2g',p_LeadGain_spind_daught),'FontSize',18);
text(3,0,sprintf('p = %1.2g',p_LeadGain_par_par),'FontSize',18);
text(4,0,sprintf('p = %1.2g',p_LeadGain_par_daught),'FontSize',18);


%% Do trailing cells robustly lose speed?
figure(4)
clf
%set(gcf,'Position',(1e3)*[0.2457 0.1457 1.0093 0.420]);
set(gcf,'Position',[115.6667  142.3333  635.3333  420.0000]);
Losses = cell(1,4);
Indices = cell(1,4);
for j = 1:4
    Losses{j} = LTs{j}(:,1)-LTs{j}(:,2); % 1 = trailing pre, 2 = trailing during
    Indices{j} = j*ones(size(LTs{j}(:,1)));
end
II = cell2mat(Indices(:));
LL = cell2mat(Losses(:));
c4 = [ 0.3010    0.7450    0.9330].';
c5 = [    0.4660    0.6740    0.1880].';
C = [c4 c4 c5 c5];

beeswarm_mark(II,LL,'sort_style','rand','overlay_style','se','MarkType',{'o','^','o','^'},'colormap',C.')
hold on
xl = xlim;
plot(linspace(xl(1),xl(2),100),zeros(1,100),'--','LineWidth',3,'color',[0.8 0.8 0.8]);
set(gca,'XTick',[1 2 3 4]);
%set(gca,'XTickLabel',{'Spindle','Spindle + div','Parallel','Parallel+div'})
set(gca,'XTickLabel',{});
%set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'})
%text(
text(0.7,-0.18,{'Spindle-' 'Spindle'},'FontSize',18)
text(1.7,-0.18,{'Spindle-' 'Daughter'},'FontSize',18)
text(2.7,-0.18,{'Parallel-' 'Parallel'},'FontSize',18)
text(3.7,-0.18,{'Parallel-' 'Daughter'},'FontSize',18)
set(gca,'FontSize',24)
ylabel('Trailing cell speed loss [\mum /min]','FontSize',18)

[~,p_TrailLoss_spind_spind] = ttest(LL(II==1));
[~,p_TrailLoss_spind_daught] = ttest(LL(II==2));
[~,p_TrailLoss_par_par] = ttest(LL(II==3));
[~,p_TrailLoss_par_daught] = ttest(LL(II==4));

text(1,0,sprintf('p = %1.2g',p_TrailLoss_spind_spind),'FontSize',18);
text(2,0,sprintf('p = %1.2g',p_TrailLoss_spind_daught),'FontSize',18);
text(3,0,sprintf('p = %1.2g',p_TrailLoss_par_par),'FontSize',18);
text(4,0,sprintf('p = %1.2g',p_TrailLoss_par_daught),'FontSize',18);

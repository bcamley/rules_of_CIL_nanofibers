function hs = compare_outcomes_from_latin_params_separate(fs_array)

clf

fontsize = 24;
ds = 2; %dotsize
%lw = 6;

% first step: extract walk-by fraction 
% 
% fsall = {fs_spindle,fs_parallel,fs_spindle_div,fs_parallel_div};

fwb_spindle = NaN*ones(size(fs_array));
fwb_parallel = NaN*ones(size(fs_array));
fwb_spindle_div = NaN*ones(size(fs_array));
fwb_parallel_div = NaN*ones(size(fs_array));

for s = 1:length(fs_array)
   fwb_spindle(s) = fs_array{s}{1}.fwb; 
   fwb_parallel(s) = fs_array{s}{2}.fwb;
   fwb_spindle_div(s) = fs_array{s}{3}.fwb;
   fwb_parallel_div(s) = fs_array{s}{4}.fwb;
end

%subplot(1,2,1);
figure(1);
clf
set(gcf,'Position',1.0e+03*[0.0010    0.0410    1.2800    0.6073]);


X = [zeros(size(fwb_spindle)) ones(size(fwb_spindle)) 2*ones(size(fwb_spindle)) 3*ones(size(fwb_spindle))].';
Y = [fwb_spindle fwb_spindle_div fwb_parallel fwb_parallel_div].';

c4 = [ 0.3010    0.7450    0.9330].';
c5 = [    0.4660    0.6740    0.1880].';
C = [c4 c4 c5 c5];

hs{1} = beeswarm_mark(X,Y,'corral_style','gutter','dot_size',ds,'overlay_style','se','MarkType',{'o','^','o','^'},'colormap',C.');

fprintf('Minimum of fwb_spindle - fwb_parallel is %3.3g \n',min(fwb_spindle-fwb_parallel))

set(gca,'XTick',[0 1 2 3]);
set(gca,'XTickLabel',{'Spindle-Spindle','Spindle-Daughter','Parallel-Parallel','Parallel-Daughter'})

yl = ylim;
if(min(yl)<0)
    ylim([-1 1]);
else
    ylim([0 1]);
end
%ylim([0 1]);

set(gca,'FontSize',fontsize);
ylabel('Walk-past Fraction','FontSize',fontsize*1.3)

%subplot(1,2,2);
figure(2);
clf
set(gcf,'Position',1.0e+03*[0.0010    0.0410    1.2800    0.6073]);

%hold on

X = [zeros(size(fwb_spindle)) ones(size(fwb_spindle)) 2*ones(size(fwb_spindle))].';
Y = [fwb_spindle-fwb_parallel fwb_spindle_div-fwb_spindle fwb_parallel_div-fwb_parallel].';


hs{2} = beeswarm_mark(X,Y,'corral_style','gutter','dot_size',ds,'overlay_style','se');
set(gca,'XTick',[0 1 2]);
set(gca,'XTickLabel',{'','',''});
text(-0.5,-0.1,{'Spindle minus parallel'},'FontSize',fontsize)
text(0.5,-0.1,{'Spindle daughter','minus spindle'},'FontSize',fontsize)
text(1.5,-0.1,{'Parallel daughter','minus parallel'},'FontSize',fontsize)

text(-0.5,0.7,{'Spindle geometry','promotes walk-past'},'FontSize',fontsize*1.3)
text(0.5,0.7,{'Division-increased speed promotes walk-past'},'FontSize',fontsize*1.3)
hold on
plot(linspace(-0.8,2.8,100),zeros(1,100),'--','color',[0.7 0.7 0.7],'LineWidth',3);
xlim([-0.5,2.5]);
ylim([-0.1,0.8]);
%ylim([-0.6 1]);

fprintf('Minimum of fwb_spindle_div - fwb_spindle is %3.3g \n',min(fwb_spindle_div-fwb_spindle))

set(gca,'FontSize',fontsize);
ylabel('Change in Walk-past Fraction','FontSize',fontsize*1.3)

fprintf('Minimum of fwb_parallel_div - fwb_parallel is %3.3g \n',min(fwb_parallel_div-fwb_parallel))


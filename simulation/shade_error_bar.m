function hs = shade_error_bar(x,flow,fmed,fhigh,col,styletype)
if(nargin<5)
    col = [0.8 0.8 0.8];
    styletype = '-';
end
hold on
x2 = [x fliplr(x)];
inBetween = [flow fliplr(fhigh)];
hs(1) = fill(x2, inBetween,'k');
set(hs,'FaceColor',col,'LineStyle','none','EdgeColor',col)
hs(2) = plot(x,fmed,styletype,'LineWidth',3,'color',col*0.5);

end
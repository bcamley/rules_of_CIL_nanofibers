function y = scaleto(ymin,ymax,x,logscale)
% function y = scaleto(ymin,ymax,x,logscale)
% takes x, where x is between 0 and 1 and
% generates y between ymin and ymax
if(nargin<4)
    logscale = false;
end
if(~logscale)
    y = ymin + (ymax-ymin)*x;
else
    y = exp(log(ymin) + log(ymax/ymin)*x);
end

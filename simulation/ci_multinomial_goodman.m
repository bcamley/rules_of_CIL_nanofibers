function [flows,fmeds,fhighs] = ci_multinomial_goodman(Nits,fvec,alpha)

flows = NaN*ones(size(fvec));
fmeds = flows;
fhighs = flows;
B = chi2inv(1-alpha,1);

for s = 1:size(fvec,2)
    n = fvec(:,s)*Nits; % number in each bin
    
    flows(:,s) = (B+2*n-sqrt(B*(B+4*n.*(Nits-n)/Nits)))/(2*(Nits+B));
    %R = mnrnd(Nits,f,Nmc);
    %flows(:,s) = quantile(R,1-p)/Nits;
    fmeds(:,s) = fvec(:,s);
    fhighs(:,s) = (B+2*n+sqrt(B*(B+4*n.*(Nits-n)/Nits)))/(2*(Nits+B));
    
    
end
function hs = shaded_outcome_plot(frev,fwb,ftrain,Nits,varyparam,paramfactor,alpha)

    fvec = [frev ; fwb; ftrain];
    [flows,fmeds,fhighs] = ci_multinomial_goodman(Nits,fvec,alpha);
    %clf;
    hold on
    hrev = shade_error_bar(paramfactor,flows(1,:),fmeds(1,:),fhighs(1,:),[0 0.447 0.741],'-');
    hwb = shade_error_bar(paramfactor,flows(2,:),fmeds(2,:),fhighs(2,:),[0.85 0.325 0.098],'--');
    htrain = shade_error_bar(paramfactor,flows(3,:),fmeds(3,:),fhighs(3,:),[0.929 0.6940 0.1250],'-.');
    set(gca,'FontSize',24)
    ylim([0 1]);
    lgd = legend([hwb(1) htrain(1) hrev(1)],'Walk-past','Train','Reverse');
    lgd.FontSize=24;
    ylabel('Fraction');
    xlabel(sprintf('%s [vs WT]',varyparam));
    hs = {hrev,hwb,htrain};
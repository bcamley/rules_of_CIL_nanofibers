% Generate cell motility with soft constraint r = R
%
function [states,rinits,theta_inits,lc] = harmonic_cil_statistics(q,Nits)
% q = struct;
% q.R = 1;
% q.tau = 1;
% q.kappa = 5;
% q.kappacell = 5;
% q.dt = 0.05;
% q.beta = 1;
% q.N = 2;
% q.sigma = 0.1;
% q.cgv = 0.5;
% 
% Tsim = 30;
% Trelax = 30;
% separation_start = q.R*3;
%% 
Tsim = q.Tsim;
Trelax = q.Trelax;
separation_start = q.separation_start;
%Nits = 100;
states = NaN*ones(1,Nits);
%zseps = cell(1,Nits);
rinits = cell(1,Nits);
theta_inits = NaN*ones(1,Nits);

for s = 1:Nits
    
    % Do run with no interactions to relax initial condition effects, if any
    dointeractions = false;
    %if(isfield(q,'Delta'))
        [xs,ys,zs,pxs,pys,pzs] = evolve_spring_pair(q,Trelax,dointeractions);
    %else
    %    [xs,ys,zs,pxs,pys,pzs] = evolve_harmonic_cil(q,Trelax,dointeractions);
    %end
    x = xs(:,end);   y = ys(:,end);   z = zs(:,end);
    
    px = pxs(:,end); py = pys(:,end); pz = pzs(:,end);
    
    % Now that cells are relaxed to their equilibrium distribution, we can
    % choose their relative z positions so that they are pointed at each other
    
    % We have an inversion symmetry, so we can choose pz(1) < 0 and pz(2) > 0
    %
    p1 = [px(1) py(1) pz(1)]; p2 = [px(2) py(2) pz(2)];
    if(pz(1)>0)
        p1 = -p1;
    end
    if(pz(2)<0)
        p2 = -p2;
    end
    
    px = [p1(1) ; p2(1)]; py = [p1(2) ; p2(2)]; pz = [p1(3) ; p2(3)];
    z = [separation_start/2 ; -separation_start/2];
    
    rinits{s} = [x y z];
    
    dointeractions = true;
    [xs,ys,zs,pxs,pys,pzs,collideflag,collidestep] = evolve_spring_pair(q,Tsim,dointeractions,x,y,z,px,py,pz);
    
    dr = sqrt((xs(1,:)-xs(2,:)).^2+(ys(1,:)-ys(2,:)).^2+(zs(1,:)-zs(2,:)).^2);
    if(min(dr) < q.R/2)
        collideflag = 1e4;
        warning('Very close approach');
    end
    zseparation = (zs(1,:)-zs(2,:));
    firstgopast = find(zseparation<-separation_start,1);
    stepind = 1:size(xs,2);
    firstgoneback = find((zseparation>separation_start)&(stepind>collidestep),1);
    
    state = NaN; % if you see a NaN state, indicates we missed a term
    if(~collideflag && min(zseparation)>0)
        state = 0; % no collision - cells didn't touch, but also didn't get close without touching
    elseif(isempty(firstgopast)) % the cell never gets past the other cell, so we either have a reversal or a stall
        if(isempty(firstgoneback)) % didn't reverse sufficiently far to count
            state = 1; % stall
        else
            state = 2; % reversal
        end
    else   % the cell got past the other cell - but not clear whether this happened before or after the end of this collision
        if(isempty(firstgoneback))
            state = 3; %walkby
        else
            if(firstgopast < firstgoneback)
                state = 3;
            else
                state = 2; % reversal
            end
        end
        
    end
    
    states(s) = state;
    %zseps{s} = zseparation(1:10:end);
    theta_inits(s) = acos(dot(rinits{s}(1,1:2),rinits{s}(2,1:2))/(norm(rinits{s}(1,1:2))*norm(rinits{s}(2,1:2))));
    if(rem(s,1000)==0)
        fprintf('Iteration %d/%d, mean walkby = %3.3g \n',s,Nits,sum(states(1:s)==3)/sum(states(1:s)~=0))
    end
    lc = struct;
    lc.xs = xs; lc.ys = ys; lc.zs = zs; lc.pxs = pxs; lc.pys = pys; lc.pzs = pzs; lc.state = state;
end



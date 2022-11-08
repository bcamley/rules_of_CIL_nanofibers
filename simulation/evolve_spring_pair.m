function [xs,ys,zs,pxs,pys,pzs,collideflag,collidestep,zdirffs] = evolve_spring_pair(q,Tmax,dointeractions,x,y,z,px,py,pz)

R = q.R;
tau = q.tau;
kappa = q.kappa;
if(q.lessadherentdividing)
    kf = [1/q.repolarizefactor ; 1];
else
    kf = [1 ; 1];
end

kappacell = q.kappacell;
adhcell = q.adhcell;
dt = q.dt;
sqdt = sqrt(dt);
Radh = q.Radh;

beta = q.beta; 
betaff = q.betaff; % CIL strength -- the model in the paper uses ONLY betaff

sigma = q.sigma;
cgv = q.cgv; % contact guidance velocity

steps = ceil(Tmax/dt);

N = q.N;

xs = zeros(N,steps);
ys = zeros(N,steps);
zs = zeros(N,steps);

pxs = zeros(N,steps);
pys = zeros(N,steps);
pzs = zeros(N,steps);

zdirffs = zeros(N,steps);

if(nargin<4) % need to generate initial conditions
    ths = 2*pi*rand(N,1);   % place cells with random orientation around the fiber
    x = cos(ths);
    y = sin(ths);
    z = (2*R*(1:N)).';
    px = (0.5*tau*sigma^2)*randn(N,1);
    py = (0.5*tau*sigma^2)*randn(N,1);
    pz = (0.5*tau*sigma^2)*randn(N,1);
end

collideflag = false;
collidestep = NaN;

logeye = logical(eye(N));

repolarizevec = ones(size(px));
if(q.repolarizetype==1)
    repolarizevec(1) = q.repolarizefactor;
else
    if(dointeractions)  % ONLY REPOLARIZE ON THE SECOND RUN, NOT WHILE EQUILIBRATING
        pz(1) = pz(1)*q.repolarizefactor; % make the first cell transiently faster
    end
end

ffvec = ones(size(px));
if(q.divCIL)
   ffvec(1) = 1/q.repolarizefactor;    
end

for s = 1:steps
    
    rho1 = sqrt(x.^2+y.^2);
    rho2 = sqrt((x-q.Delta).^2+y.^2);
    
    if(dointeractions)
        
        XIJ = x*ones(1,N)-ones(N,1)*(x.');
        YIJ = y*ones(1,N)-ones(N,1)*(y.');
        ZIJ = z*ones(1,N)-ones(N,1)*(z.');
        RIJ = sqrt(XIJ.^2+YIJ.^2+ZIJ.^2);
        
        FxIJ = kappacell*(XIJ./RIJ).*(RIJ-2*R).*(RIJ<2*R) +  adhcell*(XIJ./RIJ).*(RIJ-2*R).*(RIJ>2*R).*(RIJ<2*Radh);
        FyIJ = kappacell*(YIJ./RIJ).*(RIJ-2*R).*(RIJ<2*R) +  adhcell*(YIJ./RIJ).*(RIJ-2*R).*(RIJ>2*R).*(RIJ<2*Radh);
        FzIJ = kappacell*(ZIJ./RIJ).*(RIJ-2*R).*(RIJ<2*R) +  adhcell*(ZIJ./RIJ).*(RIJ-2*R).*(RIJ>2*R).*(RIJ<2*Radh);
        FxIJ(logeye) = 0;
        FyIJ(logeye) = 0; % eliminate the self-interaction
        FzIJ(logeye) = 0; % eliminate the self-interaction
        FxI = sum(FxIJ).';
        FyI = sum(FyIJ).';
        FzI = sum(FzIJ).';
        
        % Compute CIL sum over nearest neighbors
        nn = (RIJ<=2*R)&(RIJ>10*eps); % when you contact, CIL
        if(max(nn(:))>0)
            if(~collideflag)
                collidestep = s;
            end
            collideflag = true;
        end
        
        xdirIJ = -XIJ.*nn./RIJ;
        ydirIJ = -YIJ.*nn./RIJ;
        zdirIJ = -ZIJ.*nn./RIJ;
        xdirIJ(logeye) = 0;
        ydirIJ(logeye) = 0;
        zdirIJ(logeye) = 0;
        xdir = sum(xdirIJ).';
        ydir = sum(ydirIJ).';
        zdir = sum(zdirIJ).';
        
        pmag = sqrt(px.^2+py.^2+pz.^2);
        pxh = px./pmag;
        pyh = py./pmag;
        pzh = pz./pmag;
        
        pxmat = (pxh)*ones(1,N); 
        pymat = (pyh)*ones(1,N);
        pzmat = (pzh)*ones(1,N);
        pdotq = pxmat.*xdirIJ + pymat.*ydirIJ + pzmat.*zdirIJ;
        
    
        xdirff = sum(xdirIJ.*(pdotq).*(pdotq>0)).';
        ydirff = sum(ydirIJ.*(pdotq).*(pdotq>0)).';
        zdirff = sum(zdirIJ.*(pdotq).*(pdotq>0)).';
        
        if(isfield(q,'Delta')&&(~isnan(q.Delta)))   % there are two fibers
            Fx = -kappa.*kf.*(rho1-R).*x./rho1-kappa.*kf.*(rho2-R).*(x-q.Delta)./rho2 + FxI;
            Fy = -kappa.*kf.*(rho1-R).*y./rho1-kappa.*kf.*(rho2-R).*y./rho2 + FyI;
        else
            Fx = -kappa.*kf.*(rho1-R).*x./rho1 + FxI;
            Fy = -kappa.*kf.*(rho1-R).*y./rho1 + FyI;
        end
            Fz = FzI; % there is no force along the z direction due to the potential with the fiber
    else % don't compute interactions, total force is just the interaction with environment
        if(isfield(q,'Delta')&&(~isnan(q.Delta)))
            Fx = -kappa.*kf.*(rho1-R).*x./rho1-kappa.*kf.*(rho2-R).*(x-q.Delta)./rho2;
            Fy = -kappa.*kf.*(rho1-R).*y./rho1-kappa.*kf.*(rho2-R).*y./rho2;
        else
            Fx = -kappa.*kf.*(rho1-R).*x./rho1;
            Fy = -kappa.*kf.*(rho1-R).*y./rho1;
        end
        
        Fz = zeros(size(x));  % there is no force along the z direction due to the potential with the fiber
        xdir = 0;
        ydir = 0;
        zdir = 0;
        xdirff = 0;
        ydirff = 0;
        zdirff = 0;
    end
    vx = px + Fx;   % this assumes the mobility mu = 1
    vy = py + Fy;
    vz = pz + Fz;
    x = x + dt*vx;
    y = y + dt*vy;
    z = z + dt*vz;
    
    px = px*(1-dt/tau) + sigma*sqdt*randn(N,1) + beta*dt*xdir + betaff*dt*ffvec.*xdirff;
    py = py*(1-dt/tau) + sigma*sqdt*randn(N,1) + beta*dt*ydir + betaff*dt*ffvec.*ydirff;
    pz = pz*(1-dt/tau) + dt*(cgv/tau)*sign(pz).*repolarizevec + sigma*sqdt*randn(N,1) + beta*dt*zdir + betaff*dt*ffvec.*zdirff;
    
    xs(:,s) = x;
    ys(:,s) = y;
    zs(:,s) = z;
    
    pxs(:,s) = px;
    pys(:,s) = py;
    pzs(:,s) = pz;
    zdirffs(:,s) = zdirff; % note this is off by one; used only for debugging
    
end




end
clear all;close all
doPlot=1;

% Load data
MAT=load('ArrenaesGprTomo_30_60.mat');
%MAT=load('ArrenaesGprTomo_55_115.mat');

G=MAT.G;
d0=MAT.d0;
Cd=MAT.Cd+eye(size(MAT.Cd,1)).*0.2^2;
m0=MAT.m0;
Cm=MAT.Cm;
d_obs=MAT.d_obs;
d_std=MAT.d_std;
x=MAT.x;
y=MAT.y;
nx=length(x);
ny=length(y);

% next line for faster log-likelihood
iCd = inv(Cd);
% next line for faster prior sampler
L=chol(Cm,'lower');


%% The extended Metropolis algorithm
clear m_post

N_ite=100000;

% store every 'i_save' model
i_save = 10;
n_save = 0;
m_post = zeros(ny,nx,floor(N_ite/10));
logL_post=zeros(1,N_ite);

% get an initial current model, and data, and log-likelihood
m_cur=sample_prior(m0,L,nx,ny);
d_cur=forward(G,m_cur);
logL_cur=log_likelihood(d_cur,d_obs,iCd);

t_start=now;
step_final=0.02;
i_step_final=10000;
N_acc=0;
for i=1:N_ite
    
    % adjust step length in the first i_step_final iterations
    if i<i_step_final
        step=(1-step_final).*(1-(i/i_step_final))+step_final;
    else
        step=step_final;
    end
    
    % sample prior
    m_pro=sample_prior(m0,L,nx,ny);
    m_pro = m0 + cos(step*pi/2).*(m_cur-m0) + sin(step*pi/2).*(m_pro-m0);
    
    
    % forward response
    d_pro=forward(G,m_pro);
    
    % likelihood
    logL_pro=log_likelihood(d_pro,d_obs,iCd);
    
    % Accept move in Markov chain
    P_acc = exp((logL_pro-logL_cur));
    
    if rand(1)<P_acc
        d_cur = d_pro;
        m_cur = m_pro;
        logL_cur = logL_pro;
        N_acc=N_acc+1;
    end
    
    logL_post(i)=logL_cur;
    
    if (mod(i,1000)==0)
        disp(sprintf('i=%5d/%5d, logL_cur=%5.3f, Nacc=%4d',i,N_ite, logL_cur, N_acc));
    end
    if (doPlot==1)&&(mod(i,1000)==0)
        subplot(2,2,1);
        i1=ceil(i/5);
        plot(i1:i,logL_post(i1:i));
        xlim([i1 i])
        xlabel('Iteration number')
        ylabel('logL(m_c)')
        subplot(2,2,3);
        plot(1:length(d_obs),d_obs,'k-',1:length(d_obs),d_cur,'r-')
        subplot(1,2,2);
        imagesc(x,y,m_cur);
        title(sprintf('i=%4d',i))
        set(gca,'ydir','revers')
        caxis([0.11, 0.18])
        drawnow
    end
    
    % save model?
    if mod(i,i_save)==0
        n_save = n_save+1;
        m_post(:,:,n_save)=m_cur;
    end
    
end
t_stop=now;
t_elapsed  = (t_stop-t_start)*3600*24;

fprintf("%40s: t=%6.2fs, N_ite=%8d, %8d iterations/s\n", ['MATLAB ',version], t_elapsed, N_ite, ceil(N_ite/t_elapsed))

%% Remove models before burn-in
burnin=ceil(10000/i_save);
m_post=m_post(:,:,burnin:end);


%% Posterior statistics    
if doPlot==1;

    % Posterior mean and std
    cax=[-1 1].*.04+m0(1);
    figure(11);clf
    m_post_mean=mean(m_post,3);
    m_post_std=std(m_post,0,3);
    subplot(1,2,1);
    imagesc(x,y,m_post_mean);axis image
    title('Posterior pointwise mean')
    set(gca,'ydir','revers')
    caxis(cax)
    set(gca,'ydir','reverse')
    colorbar
    subplot(1,2,2);
    imagesc(x,y,m_post_std);axis image
    title('Posterior pointwise std')
    set(gca,'ydir','revers')
    colorbar
    
    % Posterior reals
    figure(12);
    iplot=ceil(linspace(1,size(m_post,3),16));
    for i=1:length(iplot);
        subplot(4,4,i);
        imagesc(x,y,m_post(:,:,iplot(i)));axis image
        title(sprintf('Real#%d',i))
        set(gca,'ydir','revers')
        caxis(cax)
    end
    
end

%% Posterior movie
figure(13);clf
for i=1:100:size(m_post,3);
    imagesc(x,y,m_post(:,:,i));axis image
    title(sprintf('Real#%d',i))
    set(gca,'ydir','revers')
    caxis(cax)
    drawnow;
end

%% Functions
function m_est=sample_prior(m0,L,nx,ny)
r=randn(size(L,1),1);
m_est = m0(:) + L*r;
if nargin>2
    m_est=reshape(m_est,ny,nx);
end
end

function d = forward(G,m)
d= G*(1./m(:));
end

function logL = log_likelihood(d,d_obs,iCd)
logL = -0.5*(d-d_obs)'*iCd*(d-d_obs);
end




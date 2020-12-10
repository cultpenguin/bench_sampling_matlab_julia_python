##
using Random, MAT, Statistics, Printf, LinearAlgebra
doPlot=1;


## Functions

function forward(G,m)
    d= G*(m[:].^(-1))
    return d
end


function log_likelihood(d,d_obs,iCd)
    logL = -0.5*(d-d_obs)'*iCd*(d-d_obs)
    return logL[1]
end 

function sample_prior(m0,L,nx,ny)
    r=randn(size(L,1),1);
    m_est = m0[:] + L*r;
    m_est=reshape(m_est,ny,nx);
    return m_est
end

## LOAD SOME DATA
#vars = matread("linefit_nd05.mat")
vars = matread("ArrenaesGprTomo_30_60.mat");
#vars = matread("ArrenaesGprTomo_55_115.mat");

G = vars["G"]
d0 = vars["d0"]
Cd = vars["Cd"]
Cd = Cd + I(size(Cd,1))*0.8.^2
m0 = vars["m0"]
Cm = vars["Cm"]
d_obs = vars["d_obs"]
d_std = vars["d_std"]
x = vars["x"]
y = vars["y"]
nx=length(x)
ny=length(y)

# next line for faster log-likelihood
iCd = inv(Cd);
# next line for faster prior sampler
C = cholesky(Cm)
L = C.L



## The extended Metropolis algorithm
N_ite=10000

# store every 'i_save' model
i_save = 10;
n_save = 0;
m_post = zeros(ny,nx,Int(floor(N_ite/10)))
size(m_post)
logL_post=zeros(1,N_ite)

# get an initial current model, and data, and log-likelihood
m_cur=sample_prior(m0,L,nx,ny);
d_cur=forward(G,m_cur);
logL_cur=log_likelihood(d_cur,d_obs,iCd);


t_start=time()
step_final=0.02
i_step_final=10000
global N_acc=0
for i=1:N_ite
    
    ## adjust step length in the first i_step_final iterations
    if (i<i_step_final)
        stepsize=(1-step_final).*(1-(i/i_step_final))+step_final;
    else
        stepsize=step_final
    end
    
    ## sample prior
    m_pro=sample_prior(m0,L,nx,ny);
    m_pro = m0 + cos(stepsize*pi/2).*(m_cur-m0) + sin(stepsize*pi/2).*(m_pro-m0);
    
    ## forward response
    d_pro=forward(G,m_pro);
    #
    ## likelihood
    logL_pro=log_likelihood(d_pro,d_obs,iCd);
    
    ## Accept move in Markov chain
    P_acc = exp(logL_pro-logL_cur);
    #P_acc = 1.0

    if rand(1)[1] <P_acc[1]
        global d_cur = d_pro;
        global m_cur = m_pro;
        global logL_cur = logL_pro;
        global N_acc=N_acc+1;
    end
    
    logL_post[i]=logL_cur;
    
    if (mod(i,1000)==0)
        #@printf("i=%5d/%5d, logL_cur=%5.3f, Nacc=%4d, P_acc=%3.2f\n",i,N_ite, logL_cur, N_acc, P_acc);
        @printf("i=%5d/%5d, logL=%5.3f,%5.3f, Nacc=%4d, P_acc=%3.2f\n",i,N_ite, logL_cur,logL_pro, N_acc, P_acc);
    end
    
    # save model?
    if mod(i,i_save)==0
        global n_save = n_save+1;
        m_post[:,:,n_save]=m_cur;
    end
    
end
t_stop=time()
t_elapsed  = (t_stop-t_start)

@printf("%34s%6s: t=%6.2fs, N_ite=%8d, %8d iterations/s\n", "JULIA", VERSION,t_elapsed, N_ite, ceil(N_ite/t_elapsed))

## 
#using Plots
#plot(logL_post)

#= %% Remove models before burn-in
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
        subplot(4,i_save = 10;
        n_save = 0;
        
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


 =#

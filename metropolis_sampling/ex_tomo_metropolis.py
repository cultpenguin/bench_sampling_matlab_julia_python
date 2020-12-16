#!/usr/bin/env python3
doPlot=0
import numpy as np
import scipy.io as sio
import time as time
import matplotlib.pyplot as plt
import platform

def sample_prior(m0,L,nx,ny):
    r=np.random.randn(len(L),1);
    m_est = m0.reshape([len(L),1])+ L@r;
    return m_est.reshape([nx,ny]).T

def log_likelihood(d,d_obs,iCd):
    logL = -.5*np.dot(np.dot((d-d_obs).T,iCd),(d-d_obs))
    return logL[0,0]

def forward(G,v):
    v=v.T.reshape(G.shape[1],1)
    t = G@(1/v)
    return t


#%% Load data
#D = sio.loadmat('linefit_nd05.mat')
D = sio.loadmat('ArrenaesGprTomo_30_60.mat')
#D = sio.loadmat('ArrenaesGprTomo_55_115.mat')
G = D['G'].astype('<f8')
d0 = D['d0'].astype('<f8')
Cd = D['Cd'].astype('<f8')
Cd = Cd + np.eye(len(Cd))*0.4**2
m0 = D['m0'].astype('<f8')
Cm = D['Cm'].astype('<f8')
d_obs = D['d_obs'].astype('<f8')
d_std = D['d_std'].astype('<f8')
x = D['x'][0]
y = D['y'][0]
nx=len(x)
ny=len(y)

# next line for faster log-likelihood
iCd = np.linalg.inv(Cd);
# next line for faster prior sampler
L=np.linalg.cholesky(Cm)


#%% The extended Metropolis algorithm
N_ite=100000

# store every 'i_save' model
i_save = 10
n_save = 0
m_post = np.zeros( (ny,nx,int(np.floor(N_ite/10))) )
logL_post = np.zeros( N_ite )

# get an initial current model, and data, and log-likelihood
m_cur=sample_prior(m0,L,nx,ny)
d_cur=forward(G,m_cur)
logL_cur=log_likelihood(d_cur,d_obs,iCd)

t_start=time.time();
step_final=0.02
i_step_final=10000
N_acc=0

for i in np.arange(N_ite):
    ## adjust step length in the first i_step_final iterations
    if (i<i_step_final):
        step=(1-step_final)*(1-(i/i_step_final))+step_final;
    else:
        step=step_final

    # sample prior
    m_pro=sample_prior(m0,L,nx,ny)
    m_pro = m0 +np.cos(step*np.pi/2)*(m_cur-m0) + np.sin(step*np.pi/2)*(m_pro-m0)
    
    # forward response
    d_pro=forward(G,m_pro)
    
    # likelihood
    logL_pro=log_likelihood(d_pro,d_obs,iCd)
    
    # Accept move in Markov chain
    if (logL_pro>logL_cur):
        P_acc=1
    else:
        P_acc = np.exp((logL_pro-logL_cur))
    
    if (np.random.rand(1)<P_acc):
        d_cur = d_pro;
        m_cur = m_pro;
        logL_cur = logL_pro;
        N_acc=N_acc+1;
    
    logL_post[i]=logL_cur
    if (np.mod(i+1,20000)==0):
        print('i=%5d/%5d, logL_cur=%5.3f, Nacc=%4d' % (i+1,N_ite, logL_cur, N_acc))
        
    if (doPlot>1)&(np.mod(i,10000)==0):        

        fig=plt.figure(1)
        plt.clf()
        ax1=fig.add_subplot(2,2,1)
        ax2=fig.add_subplot(2,2,3)
        ax3=fig.add_subplot(1,2,2)
        i1=int(np.ceil(i/5))
        ax1.plot(logL_post[i1:i])
        ax1.set_xlabel('Iteration number')
        ax1.set_ylabel('logL(m_c)')
        ax2.plot(d_obs,'k-')
        ax2.plot(d_cur,'r-')
        ax3.imshow(m_cur, vmin=0.11, vmax=0.18,  extent=[x.min(), x.max(), y.min(), y.max()])
        ax3.set_title('i=%d' % (i))
        plt.ion()        
        plt.show(block=False)
        plt.pause(0.1)
        
    # save model?
    if np.mod(i+1,i_save)==0:
        n_save = n_save+1
        m_post[:,:,n_save-1]=m_cur

t_stop=time.time()
#print("End rejection sampling")
t_elapsed=t_stop-t_start
print("%40s: t=%6.2fs, N_ite=%8d, %8d iterations/s" % ("PYTHON "+platform.python_version(), t_elapsed,N_ite,np.ceil(N_ite/t_elapsed)))

##% Plot the posterior mean and std
i_burnin = int(np.ceil(5000/i_save))
m_post = m_post[:,:,i_burnin:-1]

m_mean = np.mean(m_post, axis=2)
m_std = np.std(m_post, axis=2)

if (doPlot>0):
    fig=plt.figure(1)
    plt.clf()
    ax1=fig.add_subplot(1,2,1)
    ax1.imshow(m_mean, vmin=0.11, vmax=0.18,  extent=[x.min(), x.max(), y.min(), y.max()])     
    ax1.set_title('Mean')
    ax2=fig.add_subplot(1,2,2)
    ax2.imshow(m_std, vmin=0.0, vmax=0.02,  extent=[x.min(), x.max(), y.min(), y.max()])
    ax2.set_title('i=%d' % (i))
    ax2.set_title('Std')
    plt.savefig('post_python')
        

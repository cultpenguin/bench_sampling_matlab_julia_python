#!/usr/bin/env python3

import numpy as np
import scipy.io as sio
import time as time
import platform

def forward(m,x):
    d= m[0]+ m[1]*x + m[2]*x*x;
    return d

def sample_prior():
    m1 = np.random.randn(1)*np.sqrt(10)
    m2 = (np.random.rand(1)-0.5)*20
    m3 = (np.random.rand(1)-0.5)*0.2
    return m1, m2, m3

def log_likelihood(d,d_obs,d_std):
    logL=-0.5*np.sum( (d_obs-d)**2/d_std**2 ) 
    
    return logL



#%%
#D = sio.loadmat('linefit_nd05.mat')
D = sio.loadmat('linefit_nd35.mat')
d_obs = D['d_obs'][0].astype('<f8')
d_std = D['d_std'][0].astype('<f8')

#d_std = D['d_std'][0].astype(d_obs.dtype) # otherwise d_std**2 does
x_obs = D['x_obs'][0]
nm=3
nd=len(d_obs)

#%% The rejection sampler
N_ite=500000;
N_acc=0;
logL_max  =  -250

m_post=np.zeros((nm,N_ite))
#print("Start rejection sampling")
t_start=time.time()
for i in range(N_ite):
    #% 1. PROPOSE FROM A UNIFORM DISTRIBUTION
    m=sample_prior()
    #% 2. SOLVE THE 'FORWARD PROBLEM' 
    d = forward(m,x_obs);
    #% 3. Evaluate the pdf
    logL = log_likelihood(d,d_obs,d_std)
    
    if logL_max<logL:
        logL_max = logL*.99;
        #print('logL_max = %g, i=%d' % (logL_max,i))
        N_acc = 0

    
    P_acc = np.exp(logL-logL_max)
    if np.random.rand(1)<P_acc:
        N_acc=N_acc+1
        m_post[:,N_acc-1]=m
        #print('%7d/%07d Nacc=%d, f_total=%4.3g'  % (i,N,Nacc,f_total))
        #f_post(Nacc)=f_total;
            
t_stop=time.time()
#print("End rejection sampling")
t_elapsed=t_stop-t_start
print("%40s: t=%6.2fs, N_ite=%8d, %8d iterations/s" % ("PYTHON "+platform.python_version(), t_elapsed,N_ite,np.ceil(N_ite/t_elapsed)))

#%% Posterior stats
showPostStat=0
if showPostStat==1:
    m_post = m_post[:,0:N_acc]
    m_post_mean = np.mean(m_post,axis=1)
    m_post_std = np.std(m_post,axis=1)
    print(m_post_mean)
    print(m_post_std)
    

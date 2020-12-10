# Simple rejection sampling

The folder contains a simple application of the extended Metropolis algorithm (for a linear Gaussian cross hole GPR traveltime inversion) implemented for Matlab, Julia and Python, through 
 
    ex_tomo_metropolis.m
    ex_tomo_metropolis.jl
    ex_tomo_metropolis.py
    
Run all three using  
    
    sh ./run.sh 

## Results


### OS:Pop\!_OS 20.10, Intel i7-8700, 32GB RAM, 

Note that for this run JULIA had a signifcant higher CPU load (800%) than MATLAB (600%)!

           MATLAB 9.8.0.1323502 (R2020a): t= 82.40s, N_ite=  100000,     1214 iterations/s
                             JULIA 1.5.3: t=335.11s, N_ite=  100000,      299 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X, 256GB RAM, 

      MATLAB 9.9.0.1495850 (R2020b) Update 1: t=161.77s, N_ite=  100000,      619 iterations/s
                                 JULIA 1.5.3: t=144.20s, N_ite=  100000,      694 iterations/s


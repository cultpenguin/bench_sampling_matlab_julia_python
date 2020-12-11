# The extended Metropolis algorithm 

The folder contains a simple application of the extended Metropolis algorithm (for a linear Gaussian cross hole GPR traveltime inversion) implemented for Matlab, Julia and Python, through 
 
    ex_tomo_metropolis.m
    ex_tomo_metropolis.jl
    ex_tomo_metropolis.py
    
Run all three using  
    
    sh ./run.sh 

## Results


### OS:Pop\!_OS 20.10, Intel i7-8700, 32GB RAM, 

Note that for this run JULIA had a signifcant higher CPU load (800%) than MATLAB (600%)!

    MATLAB 9.8.0.1323502 (R2020a) (threads= 6): t= 78.34s, N_ite=  100000,     1277 iterations/s
    MATLAB 9.8.0.1323502 (R2020a) (threads= 1): t=128.32s, N_ite=  100000,      780 iterations/s
                      JULIA 1.5.3: t=287.91s, N_ite=  100000,      348 iterations/s
                     PYTHON 3.8.5: t=111.66s, N_ite=  100000,      896 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X, 256GB RAM, 
                     
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads=64): t=166.73s, N_ite=  100000,      600 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 1): t=156.40s, N_ite=  100000,      640 iterations/s
                               JULIA 1.5.3: t=146.68s, N_ite=  100000,      682 iterations/s
                              PYTHON 3.8.5: t= 26.97s, N_ite=  100000,     3708 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX, 64GB RAM, 

    MATLAB 9.8.0.1359463 (R2020a) Update 1: t=153.75s, N_ite=  100000,      651 iterations/s
                  JULIA 1.5.3 ( 1 threads): t=225.60s, N_ite=  100000,      444 iterations/s
                  JULIA 1.5.3 ( 2 threads): t=221.08s, N_ite=  100000,      453 iterations/s
                  JULIA 1.5.3 ( 8 threads): t=165.30s, N_ite=  100000,      605 iterations/s
                  JULIA 1.5.3 (32 threads): t=171.65s, N_ite=  100000,      583 iterations/s



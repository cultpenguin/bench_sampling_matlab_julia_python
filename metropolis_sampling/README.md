# Th extended Metropolis algorithm 

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
                            JULIA 1.5.3 : t=335.11s, N_ite=  100000,      299 iterations/s
                  JULIA 1.5.3 (t thread): t=225.60s, N_ite=  100000,      444 iterations/s
 

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X, 256GB RAM, 

      MATLAB 9.9.0.1495850 (R2020b) Update 1: t=161.77s, N_ite=  100000,      619 iterations/s
                     JULIA 1.5.3( 1 threads): t=241.66s, N_ite=  100000,      414 iterations/s
                     JULIA 1.5.3( 8 threads): t=144.20s, N_ite=  100000,      694 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX, 64GB RAM, 

    MATLAB 9.8.0.1359463 (R2020a) Update 1: t=153.75s, N_ite=  100000,      651 iterations/s
                  JULIA 1.5.3 ( 1 threads): t=225.60s, N_ite=  100000,      444 iterations/s
                  JULIA 1.5.3 ( 2 threads): t=221.08s, N_ite=  100000,      453 iterations/s
                  JULIA 1.5.3 ( 8 threads): t=165.30s, N_ite=  100000,      605 iterations/s
                  JULIA 1.5.3 (32 threads): t=171.65s, N_ite=  100000,      583 iterations/s



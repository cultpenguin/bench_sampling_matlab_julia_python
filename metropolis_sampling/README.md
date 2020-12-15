# The extended Metropolis algorithm 

The folder contains a simple application of the extended Metropolis algorithm (for a linear Gaussian cross hole GPR traveltime inversion) implemented for Matlab, Julia and Python, through 
 
    ex_tomo_metropolis.m
    ex_tomo_metropolis.jl
    ex_tomo_metropolis.py
    
Run all three using  
    
    sh ./run.sh 

## Results

The binary used for Julia is the standard 64bit download from https://julialang.org/downloads/.
The python version is installed thrugh the 64 bit Anaconda distribution from https://www.anaconda.com/products/individual.


### Windows 10, Intel i7-8650U 4cores/8threads, 16GB RAM [Surfacebook 2] (WSL: indicates running is WLS/Ubuntu20.10)

### Windows 10, Intel i7-8700K 6 cores/12 threads, 32GB RAM (WSL: indicates running is WLS/Ubuntu20.10)

MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 6): t=139.11s, N_ite=  100000,      719 iterations/s
MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 1): t=187.37s, N_ite=  100000,      534 iterations/s
                                        JULIA 1.5.3: t=265.37s, N_ite=  100000,      377 iterations/s
                                       PYTHON 3.7.9: t=163.09s, N_ite=  100000,      614 iterations/s
                                  JULIA 1.5.3 (WSL): t=309.31s, N_ite=  100000,      324 iterations/s
                                 PYTHON 3.7.4 (WSL): t=152.73s, N_ite=  100000,      655 iterations/s

### OS:Pop\!_OS 20.10, Intel i7-8700, 32GB RAM, 

Note that for this run JULIA had a signifcant higher CPU load (800%) than MATLAB (600%)!

    MATLAB 9.8.0.1323502 (R2020a) (threads= 6): t= 81.56s, N_ite=  100000,     1227 iterations/s
    MATLAB 9.8.0.1323502 (R2020a) (threads= 1): t=140.65s, N_ite=  100000,      711 iterations/s
                                   JULIA 1.5.3: t=275.50s, N_ite=  100000,      363 iterations/s
                                  PYTHON 3.8.5: t=109.93s, N_ite=  100000,      910 iterations/s
              
### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX, 32 cores/64 threads, 64GB RAM, 

    MATLAB 9.8.0.1359463 (R2020a) Update 1 (threads=32): t=154.58s, N_ite=  100000,      647 iterations/s
    MATLAB 9.8.0.1359463 (R2020a) Update 1 (threads= 1): t=153.93s, N_ite=  100000,      650 iterations/s
                                            JULIA 1.5.3: t=162.38s, N_ite=  100000,      616 iterations/s
                                           PYTHON 3.8.3: t=174.49s, N_ite=  100000,      574 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X, 64 cores/128 threads, 256GB RAM, 
                     
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads=64): t=168.12s, N_ite=  100000,      595 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 1): t=147.83s, N_ite=  100000,      677 iterations/s
                                            JULIA 1.5.3: t=150.19s, N_ite=  100000,      666 iterations/s
                                           PYTHON 3.8.5: t= 18.73s, N_ite=  100000,     5339 iterations/s


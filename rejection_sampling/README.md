# Simple rejection sampling

The folder contains a simple application of the rejection sampler for 2nd order polynomial linefitting implemented for Matlab, Julia and Python, through 
 
    ex_linefit_rejection.m
    ex_linefit_rejection.jl
    ex_linefit_rejection.py
    
Run all three using  
    
    sh ./run.sh 

## Results

For this simple algorithm I find the speed to Julia and Maltab to be similar. Matlab is in general slighly faster, except on a Surfacebook 2, where Julia is significantly faster.

In all cases Python is (more than 20 times) slower Matlab and Julia!

### Windows 10, Intel i7-8650 4 cores/8 threads, 16 GB RAM, (Surfacebook 2) ]WSL indicate running in WSL/Ubuntu2010]
                      
                       JULIA 1.5.3 (WSL): t=  2.82s, N_ite= 2000000,   709930 iterations/s   
                             JULIA 1.5.3: t=  2.93s, N_ite= 2000000,   681664 iterations/s
           MATLAB 9.7.0.1190202 (R2019b): t=  4.58s, N_ite= 2000000,   436491 iterations/s
           MATLAB 9.7.0.1190202 (R2019b): t=  4.69s, N_ite= 2000000,   426168 iterations/s
                      PYTHON 3.8.5 (WSL): t= 65.17s, N_ite= 2000000,    30691 iterations/s
                            PYTHON 3.7.3: t= 68.84s, N_ite= 2000000,    29053 iterations/s
                            
## Windows 10, Intel i7-8700K, 6 cores/12 threads, 32GB RAM (WSL: indicates running is WLS/Ubuntu20.10)                            

    MATLAB 9.9.0.1495850 (R2020b) Update 1: t=  1.45s, N_ite= 2000000,  1375511 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1: t=  1.46s, N_ite= 2000000,  1374570 iterations/s
                         JULIA 1.5.3 (WSL): t=  1.96s, N_ite= 2000000,  1019991 iterations/s
                               JULIA 1.5.3: t=  2.14s, N_ite= 2000000,   932401 iterations/s
                              PYTHON 3.7.3: t= 39.10s, N_ite= 2000000,    51157 iterations/s
                        PYTHON 3.7.4 (WSL): t= 55.75s, N_ite= 2000000,    35878 iterations/s                              
                 
### OS:Pop\!_OS 20.10, Intel i7-8700, 6 cores/12 threads, 32GB RAM, 

           MATLAB 9.8.0.1323502 (R2020a): t=  1.43s, N_ite= 2000000,  1400625 iterations/s
                             JULIA 1.5.3: t=  1.75s, N_ite= 2000000,  1140608 iterations/s
                            PYTHON 3.8.5: t= 47.35s, N_ite= 2000000,    42236 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X 64 cores/128 threads, 256GB RAM, 

    MATLAB 9.9.0.1495850 (R2020b) Update 1: t=  1.85s, N_ite= 2000000,  1080165 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1: t=  1.85s, N_ite= 2000000,  1082824 iterations/s
                               JULIA 1.5.3: t=  1.98s, N_ite= 2000000,  1011213 iterations/s
                              PYTHON 3.8.5: t= 50.08s, N_ite= 2000000,    39939 iterations/s
                              
### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX 32 cores/64 threads, 64GB RAM, 

    MATLAB 9.8.0.1359463 (R2020a) Update 1: t=  2.04s, N_ite= 2000000,   978559 iterations/s
    MATLAB 9.8.0.1359463 (R2020a) Update 1: t=  2.10s, N_ite= 2000000,   953647 iterations/s
                               JULIA 1.5.3: t=  2.16s, N_ite= 2000000,   925663 iterations/s
                              PYTHON 3.8.3: t= 64.47s, N_ite= 2000000,    31025 iterations/s

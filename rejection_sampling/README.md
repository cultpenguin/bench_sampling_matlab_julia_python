# Simple rejection sampling

The folder contains a simple application of the rejection sampler for 2nd order polynomial linefitting implemented for Matlab, Julia and Python, through 
 
    ex_linefit_rejection.m
    ex_linefit_rejection.jl
    ex_linefit_rejection.py
    
Run all three using  
    
    sh ./run.sh 

## Results

For this simple algorithm I find the speed to Julia and Maltab to be similar. Matlab is in general slighly faster, except on a Surfacebook 2, where Julia is significantly faster.

In ann cases Python is (more than 20 times) slower Matlab and Julia!

### Windows 10, Intel i7-8650 (Surfacebook 2)

The windows version of Matlab is run both directly in W10, and from Ubuntu 20.10 running in WSL (Windows Subsystem for Linux).
Julia and Python has been installed and run in both W10 and Ubunut20.10/WSL.

I consistently see slighter better performance running in Ubuntu20.10/WSL than in W10.

    MATLAB 9.7.0.1190202 (R2019b from WSL): t=  4.62s, N_ite= 2000000,   432995 iterations/s
    MATLAB 9.7.0.1190202 (R2019b W10):      t=  4.66s, N_ite= 2000000,   429646 iterations/s
    JULIA 1.5.3 (WSL/Ubuntu 20.10)          t=  2.94s, N_ite=2000000, 679297 iterations/s
    JULIA 1.5.3 (W10)                       t=  3.02s, N_ite=2000000, 662691 iterations/s
    PYTHON 3.8.5 (WSL/Ubuntu 20.10) T       t= 70.21s, N_ite=2000000, 28486 iterations/s
    PYTHON 3.7.3 (W10)                      t= 81.00s, N_ite=2000000, 24689 iterations/s
    

### OS:Pop\!_OS 20.10, Intel i7-8700, 32GB RAM, 

           MATLAB 9.8.0.1323502 (R2020a): t=  1.43s, N_ite= 2000000,  1400625 iterations/s
                             JULIA 1.5.3: t=  1.75s, N_ite= 2000000,  1140608 iterations/s
                            PYTHON 3.8.5: t= 47.35s, N_ite= 2000000,    42236 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X 64 cores/128 threads, 256GB RAM, 

    MATLAB 9.9.0.1495850 (R2020b) Update 1: t=  1.91s, N_ite= 2000000,  1045778 iterations/s
                               JULIA 1.5.3: t=  1.92s, N_ite= 2000000,  1041644 iterations/s
                              PYTHON 3.8.5: t= 54.58s, N_ite= 2000000,    36642 iterations/s

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX 32 cores/64 threads, 64GB RAM, 

    MATLAB 9.8.0.1359463 (R2020a) Update 1: t=  2.09s, N_ite= 2000000,   955214 iterations/s
                               JULIA 1.5.3: t=  2.26s, N_ite= 2000000,   884552 iterations/s
                              PYTHON 3.8.3: t= 69.64s, N_ite= 2000000,    28720 iterations/s


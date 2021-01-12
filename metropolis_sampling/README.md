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

Perhaps a bit surprising Julia consistently ends up in the last place, with respect to clock time.

When using Matlab on Ryzen CPU (on POP\!_OS), only one thread is used even though "N = maxNumCompThreads" report many more available threads?). On Intel/Windows 10 Matlab makes can make use of all available cores.

Some version of Python use all avaiable cores by default, where as others use only one thread (see below). When Python use all available threads on multicore machines it is by far the fastest implementation.

### Windows 10, Intel i7-8650U, 4 cores/8 threads, 16GB RAM [Surfacebook 2] (WSL: indicates running is WLS/Ubuntu20.10)

           MATLAB 9.7.0.1190202 (R2019b) (threads= 4): t=191.03s, N_ite=  100000,      524 iterations/s
                                   PYTHON 3.8.5 (WSL): t=211.21s, N_ite=  100000,      474 iterations/s
                                         PYTHON 3.7.3: t=215.73s, N_ite=  100000,      464 iterations/s
           MATLAB 9.7.0.1190202 (R2019b) (threads= 1): t=271.40s, N_ite=  100000,      369 iterations/s
                                          JULIA 1.5.3: t=397.83s, N_ite=  100000,      252 iterations/s
                                    JULIA 1.5.3 (WSL): t=658.33s, N_ite=  100000,      152 iterations/s

### Windows 10, Intel i7-8700K, 6 cores/12 threads, 32GB RAM (WSL: indicates running is WLS/Ubuntu20.10)

                                   JULIA 1.5.3 (mkl,0t): t=120.66s, N_ite=  100000,      829 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 6): t=139.11s, N_ite=  100000,      719 iterations/s
                                     PYTHON 3.7.4 (WSL): t=143.69s, N_ite=  100000,      696 iterations/s
                                           PYTHON 3.7.9: t=163.09s, N_ite=  100000,      614 iterations/s
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 1): t=187.37s, N_ite=  100000,      534 iterations/s
                                 JULIA 1.5.3 (openblas): t=265.37s, N_ite=  100000,      377 iterations/s
                            JULIA 1.5.3 (openblas64,8t): t=339.55s, N_ite=  100000,      295 iterations/s
                            
### OS:Pop\!_OS 20.10, Intel i7-8700, 6 cores/12 threads, 32GB RAM, 

Note that for this run JULIA had a signifcant higher CPU load (800%) than MATLAB (600%)!

                          JULIA 1.5.3 (mkl,0t): t= 67.25s, N_ite=  100000,     1487 iterations/s, av CPU load: 600%
    MATLAB 9.8.0.1323502 (R2020a) (threads= 6): t= 81.56s, N_ite=  100000,     1227 iterations/s, av CPU load: 600%
                                  PYTHON 3.8.5: t=109.93s, N_ite=  100000,      910 iterations/s, av CPU load: 600%
    MATLAB 9.8.0.1323502 (R2020a) (threads= 1): t=140.65s, N_ite=  100000,      711 iterations/s, av CPU load: 100%
                    JULIA 1.5.3(openblas64,8t): t=275.50s, N_ite=  100000,      363 iterations/s, av CPU load: 800%
              
### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 2990WX, 32 cores/64 threads, 64GB RAM, 

                                           PYTHON 3.8.5: t= 68.78s, N_ite=  100000,     1454 iterations/s, av CPU load: 6400%
    MATLAB 9.8.0.1359463 (R2020a) Update 1 (threads= 1): t=153.93s, N_ite=  100000,      650 iterations/s, av CPU load: 100%
    MATLAB 9.8.0.1359463 (R2020a) Update 1 (threads=32): t=154.58s, N_ite=  100000,      647 iterations/s, av CPU load: 100% (?)
                                            JULIA 1.5.3: t=162.38s, N_ite=  100000,      616 iterations/s, av CPU load: 800%
                                           PYTHON 3.8.3: t=174.49s, N_ite=  100000,      574 iterations/s, av CPU load: 100%
                                           

### OS:Pop\!_OS 20.10, AMD Ryzen Threadripper 3990X, 64 cores/128 threads, 256GB RAM, 
Note: difference in python runtime, is related to using numpy w. mkl (slow) and numpy without mkl (very fast)

                    	             PYTHON 3.8.5 (32t): t= 17.34s, N_ite=  100000,     5766 iterations/s, av CPU load: 3200%
                                     PYTHON 3.8.5 (64t): t= 18.67s, N_ite=  100000,     5357 iterations/s, av CPU load: 6400%
      		                     PYTHON 3.8.5 (16t): t= 21.35s, N_ite=  100000,     4685 iterations/s, av CPU load: 1600%
                                     PYTHON 3.8.5  (8t): t= 27.40s, N_ite=  100000,     3650 iterations/s, av CPU load: 800%
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads= 1): t=128.12s, N_ite=  100000,      781 iterations/s, av CPU load: 100%
                                            JULIA 1.5.3: t=143.80s, N_ite=  100000,      701 iterations/s, av CPU load: 800%
    MATLAB 9.9.0.1495850 (R2020b) Update 1 (threads=64): t=154.86s, N_ite=  100000,      646 iterations/s, av CPU load: 100% (??)
                               PYTHON 3.7.4 (numpy/mkl): t=164.60s, N_ite=  100000,      608 iterations/s, av CPU load: 100%




# Simple rejection sampling

The folder contains a simple application of the rejection sampler for 2nd order polynomial linefitting implemented for Matlab, Julia and Python, through 
 
    ex_linefit_rejection.m
    ex_linefit_rejection.jl
    ex_linefit_rejection.py
    
Run all three using 
sh ./run.sh

## Results

For this simple algorithm I find Matlab to be slightly faster than Julia, with Python being more than 20 times slower than Matlab and Julia!

OS:Pop!_OS 20.10, , i7-8700, 32GB RAM, Matlab R2020, Julia 1.5.3, Python 3.8

    MATLAB Time elapsed =1.48s, N_ite=2000000, 1.349566e+06 iterations/s
    JULIA Time elapsed =1.90s, N_ite=2000000, 1050071 iterations/s
    PYTHON Time elapsed = 49.63s, N_ite=2000000, 40296 iterations/s


Windows 10, i7-8650 (Surfacebook 2) Matlab R2020, Julia 1.5.3, Python 3.8

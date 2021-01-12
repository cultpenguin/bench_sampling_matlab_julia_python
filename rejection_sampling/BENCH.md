In Python the #iterations/s does not vary much with then number of iterations using Nite=50000 to 5000000
In Matlab the #iterations/s vary some, from around 0.7e+6/s to 1.4e+6/s using Nite=50000 to 5000000
In Julia the #iterations/s vary a lot, from around 0.1e+6/s to 1.3e+6/s using Nite=50000 to 5000000

So, for this particular algorithm, Matlab is consistently faster, both for fewer and many iterations!
Julia is almost as fast for many iterations.
Python is by far the slowest, but with an almost constant #ite/s for different number of iterations!



  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  3.51s, N_ite= 5000000,  1423063 iterations/s
  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  3.53s, N_ite= 5000000,  1417920 iterations/s
                             JULIA 1.5.3: t=  3.75s, N_ite= 5000000,  1334151 iterations/s
                            PYTHON 3.8.5: t=105.97s, N_ite= 5000000,    47183 iterations/s

  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  1.51s, N_ite= 2000000,  1326492 iterations/s
  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  1.43s, N_ite= 2000000,  1394193 iterations/s
                             JULIA 1.5.3: t=  1.76s, N_ite= 2000000,  1136454 iterations/s
                            PYTHON 3.8.5: t= 41.68s, N_ite= 2000000,    47980 iterations/s


  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  0.38s, N_ite=  500000,  1299989 iterations/s
  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  0.38s, N_ite=  500000,  1301180 iterations/s
                             JULIA 1.5.3: t=  0.86s, N_ite=  500000,   579465 iterations/s
                            PYTHON 3.8.5: t= 10.39s, N_ite=  500000,    48135 iterations/s

  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  0.07s, N_ite=   50000,   738418 iterations/s
  MATLAB 9.9.0.1538559 (R2020b) Update 3: t=  0.07s, N_ite=   50000,   684055 iterations/s
                             JULIA 1.5.3: t=  0.48s, N_ite=   50000,   103799 iterations/s
                            PYTHON 3.8.5: t=  1.09s, N_ite=   50000,    45813 iterations/s


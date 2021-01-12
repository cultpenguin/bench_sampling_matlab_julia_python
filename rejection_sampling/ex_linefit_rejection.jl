##
using Random, MAT, Statistics, Printf
  

##
function forward(m,x)
    d=m[1].+m[2].*x + m[3]*x.^2
    return d
end

function log_likelihood(d,d_obs,d_std)
    logL=-0.5*sum(((d_obs.-d).^2)./(d_std.^2))
end

function sample_prior()
    m1 = randn(1).*sqrt(10)
    m2 = (rand(1).-0.5).*20
    m3 = (rand(1).-0.5).*0.2
    m=[m1[1],m2[1],m3[1]]
    return m
end

## LOAD SOME DATA
#vars = matread("linefit_nd05.mat")
vars = matread("linefit_nd35.mat")
x_obs = vars["x_obs"][:]
d_obs = vars["d_obs"][:]
d_std = vars["d_std"][:]
nd=length(d_obs)
nm=3

## Rejection sampler
N_ite=5000000
N_acc=0
logL_max = -250

m_post=zeros((nm,N_ite))
#println("Start rejection sampling")
t_start=time()
for i = 1:N_ite    
    m = sample_prior()
    d = forward(m,x_obs)
    logL=log_likelihood(d,d_obs,d_std)
    
    if logL_max<logL
        global logL_max = logL*.99
        #println("logL_max = ",logL_max, ", i=",i)
        global N_acc = 0
    end

    Pacc = exp(logL-logL_max)
    if rand(1)[1]<Pacc
        N_acc = N_acc+1
        m_post[:,N_acc]=m
     end
end
t_stop=time()
#println("End rejection sampling")
t_elapsed  = t_stop-t_start

@printf("%34s%6s: t=%6.2fs, N_ite=%8d, %8d iterations/s\n", "JULIA", VERSION, t_elapsed, N_ite, ceil(N_ite/t_elapsed))

## Posterior statistics
showPostStat=0
if showPostStat==1
    m_post = m_post[:,1:N_acc]
    m_post_mean = mean(m_post, dims=2)
    m_post_std = std(m_post, dims=2)
    @printf("m1_mean=%4.2f, m2_mean=%4.2f, m3_mean=%4.3f\n", m_post_mean[1], m_post_mean[2], m_post_mean[3])
    @printf("m1_std=%4.2f, m2_std=%4.2f, m3_std=%4.3f\n", m_post_std[1], m_post_std[2], m_post_std[3])
end

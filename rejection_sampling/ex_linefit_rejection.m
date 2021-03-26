% load the data
clear all;
load linefit_nd05.mat
load linefit_nd35.mat
nd=length(d_obs);
nm=3;

%% Rejection sampler
N_ite=2000000;
N_acc=0;
logL_max = -250;
% 
m_post=zeros(nm,N_ite);
%fprintf("Start rejection sampling\n")
t_start=now;
for i = 1:N_ite
    m = sample_prior();
    d = forward(m,x_obs);
    logL=log_likelihood(d,d_obs,d_std);
     
     if logL_max<logL
         logL_max = logL*.99;
         %fprintf("logL_max = %f,  i=%d\n",logL_max,i)
         N_acc = 0;
     end
 
     Pacc = exp(logL-logL_max);
     if rand(1)<Pacc
         N_acc = N_acc+1;
         m_post(:,N_acc)=m;
      end
end
t_stop=now;
%fprintf("End rejection sampling\n")
t_elapsed  = (t_stop-t_start)*3600*24;

fprintf("%40s: t=%6.2fs, N_ite=%8d, %8d iterations/s\n", ['MATLAB ',version], t_elapsed, N_ite, ceil(N_ite/t_elapsed))

%% Posterior statistics
showPostStat=0;
if showPostStat==1
    m_post = m_post(:,1:N_acc);
    m_post_mean = mean(m_post, 2);
    m_post_std = std(m_post')';
    fprintf("m1_mean=%4.2f, m2_mean=%4.2f, m3_mean=%4.3f\n", m_post_mean(1), m_post_mean(2), m_post_mean(3))
    fprintf("m1_std=%4.2f, m2_std=%4.2f, m3_std=%4.3f\n", m_post_std(1), m_post_std(2), m_post_std(3))
end


%% Functions

function d=forward(m,x)
  d= m(1)+ m(2).*x + m(3).*x.^2;
end

function logL=log_likelihood(d,d_obs,d_std)
  logL=-0.5*sum(((d_obs-d).^2)./(d_std.^2));
end

function m=sample_prior()
  m=zeros(1,3);
  m(1) = randn(1)*sqrt(10);
  m(2) = (rand(1)-0.5)*20;
  m(3) = (rand(1)-0.5)*0.2;
end


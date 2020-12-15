# export MKL_DEBUG_CPU_TYPE=5
# export OPENBLAS_NUM_THREADS=8
# Run matlab
matlab -batch "ex_tomo_metropolis; exit"
# Run matlab
matlab  -singleCompThread -batch "ex_tomo_metropolis; exit"
# Run Julia
julia ex_tomo_metropolis.jl
# Run Python
python ex_tomo_metropolis.py

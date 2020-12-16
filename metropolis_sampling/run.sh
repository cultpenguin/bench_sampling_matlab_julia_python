# export MKL_DEBUG_CPU_TYPE=5
# export OPENBLAS_NUM_THREADS=4
# export OMP_NUM_THREADS=4
# export MKL_NUM_THREADS=4

# Run matlab
matlab -batch "ex_tomo_metropolis; exit"
# Run matlab
matlab  -singleCompThread -batch "ex_tomo_metropolis; exit"
# Run Julia
julia ex_tomo_metropolis.jl
# Run Python
python ex_tomo_metropolis.py

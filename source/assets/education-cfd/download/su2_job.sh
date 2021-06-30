#!/bin/bash
#SBATCH -A userid				# user account name
#SBATCH -J su2rotor  		# job name
#SBATCH -p debug				# partition name: debug, short, long, ...
#SBATCH -N 1 					# number of nodes (-N)
#SBATCH -n 16  					# total number of tasks / cores (-n / -c)
#SBATCH --time = 00-04:00:00  	# max run time
#SBATCH --workdir = /truba/home/userid/SU2/run/
#SBATCH --output = slurm-%j.out
#SBATCH --error = slurm-%j.err
#SBATCH --nodelist = levrek		# levrek, barbun, ...

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

mpirun SU2_CFD rotor.cfg
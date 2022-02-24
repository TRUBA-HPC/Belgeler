#!/bin/bash
#SBATCH -M truba
#SBATCH -p barbun 
#SBATCH -A accountname
#SBATCH -J qe67barbun
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --time=0-01:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=


export OMP_NUM_THREADS=1

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

module purge
module load centos7.3/comp/intel/PS2018-update2
module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

ESPRESSO_DIR=/truba/home/username/espresso/q-e-qe-6.7.0

mpirun $ESPRESSO_DIR/bin-barbun-openmpi4-intel18/pw.x < in.SiC > SiC.out

exit



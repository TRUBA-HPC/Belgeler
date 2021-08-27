=============================================
TRUBA'da GROMACS Programı Nasıl Kullanılır?
=============================================


#!/bin/bash
#SBATCH -p mid1
#SBATCH -C hamsi
#SBATCH -A accountname
#SBATCH -J gromacs-test
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --time=03:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

export OMP_NUM_THREADS=1

module load centos7.9/comp/cmake/3.18.0
source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
module load centos7.9/lib/openmpi/4.1.1-gcc-7



GROMACS_DIR=/truba/home/kullaniciadi/gromacs/gromacs-2021.2/bin

mpirun  $GROMACS_DIR/gmx_mpi  mdrun calistıracağınız inputlar 
exit
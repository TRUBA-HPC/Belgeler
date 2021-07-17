#!/bin/bash
#SBATCH -M truba
#SBATCH -p hamsi
#SBATCH -A accountname
#SBATCH -J qe67impi
#SBATCH -N 1
#SBATCH --ntasks=28
#SBATCH --time=1-00:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

export OMP_NUM_THREADS=1
export OMPI_MCA_btl_openib_allow_ib=1

echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

ESPRESSO_DIR=/truba/home/username/espresso/q-e-qe-6.7.0

mpirun $ESPRESSO_DIR/bin-hamsi-impi-oneapi/pw.x < in.SiC > SiC.out


exit


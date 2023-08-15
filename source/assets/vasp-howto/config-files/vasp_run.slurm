
#!/bin/bash
#SBATCH -p mid2
#SBATCH -A kullanici_adi
#SBATCH -J vasp-test
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --time=03:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

# Compiler Links
module load centos7.3/comp/intel/PS2018-update2
module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

export OMP_NUM_THREADS=1


echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

ulimit -s unlimited


mpirun  /truba/home/kullanici_adi/derleme/vasp.6.2.0/bin/vasp_std > vasp.out
  
exit
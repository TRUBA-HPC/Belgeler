
#!/bin/bash
#SBATCH -p mid1 
#SBATCH -C barbun
#SBATCH -A accountname
#SBATCH -J vasp-test
#SBATCH -N 2
#SBATCH -n 20
#SBATCH --time=03:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err


echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

export OMP_NUM_THREADS=1
 
source /truba/sw/centos7.3/comp/intel/PS2018-update2/bin/compilervars.sh intel64
module load centos7.3/comp/intel/PS2018-update2

VASP_DIR=/truba/home/username/vasp/vasp.5.4.1/bin

mpirun $VASP_DIR/vasp_std 
  
exit
=============================================
TRUBA'da GROMACS Programı Nasıl Kullanılır?
=============================================

Hamsi hesaplama kümesinde (:ref:`hamsi-gromacs-install`) GNU Derleyicileri ve OpenMPI ile kurulumu gerçekleştirdiyseniz aşağıdaki betik dosyasını referans alabilirsiniz:

.. code-block::

    #!/bin/bash
    #SBATCH -p hamsi
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

    module load centos7.9/comp/gcc/7
    module load centos7.9/lib/openmpi/4.1.1-gcc-7
    
    GROMACS_DIR=/truba/home/kullaniciadi/gromacs/gromacs-2021.2/bin

    mpirun  $GROMACS_DIR/gmx_mpi  mdrun calistiracaginiz_girdi_dosyalari parametre_tanimlari

    exit


------------------------------------------------------------------------------------------------
TRUBA'da GROMACS Programını Singularity Container Kullanarak GPU Destekli Nasıl Çalıştırılır?
------------------------------------------------------------------------------------------------

Programı GPU destekli kullanmak için **Singularity** ile kayıt ettikten sonra, aşağıdaki slurm betik dosyasını çalıştırmanız uygun olacaktır.

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p palamut-cuda
  #SBATCH -A kullanici_adi
  #SBATCH -J grmx
  #SBATCH -N 1    #number of nodes
  #SBATCH -n 16   #number of cpus
  #SBATCH --gres=gpu:1 
  #SBATCH --time=00-01:00:00
  #SBATCH --mail-type=ALL
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

  # Automatic selection of ntomp argument based on "-c" (-c, --cpus-per-task=<ncpus>) argument to sbatch

  if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
  else
    ntomp="1"
  fi

  echo $ntomp

  export OMP_NUM_THREADS=$ntomp


  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"


  export SIF=/truba/home/kullanici_adi/gromacs-gpu/gromacs-2021.sif

  singularity run --nv $SIF gmx mdrun $ntmpi -ntomp $ntomp -v -s calistiracaginiz_girdi_dosyalari

  exit

---------------------------------------------------------------------------------------
TRUBA'da GROMACS Programını Palamut-Cuda Kümelerinde GPU Destekli Nasıl Çalıştırılır?
---------------------------------------------------------------------------------------

Bir önceki bölümde GROMACS yazılımını palamut-cuda kümelerinde derlemeyi gösterdik. Programın bu kümelerde düzgün çalışabilmesi için aşağıdaki örnek **slurm** dosyasını 
kendinize göre uyarlayabilirsiniz.


.. code-block:: bash

  #!/bin/bash
  #SBATCH -p palamut-cuda
  #SBATCH -A kullanici_adi
  #SBATCH -J grmx
  #SBATCH -N 1    #number of nodes
  #SBATCH -n 16   #number of cpus
  #SBATCH --gres=gpu:1 
  #SBATCH --time=00-01:00:00
  #SBATCH --mail-type=ALL
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

   module purge
   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh  
   module load centos7.9/comp/cmake/3.18.0 
   module load centos7.9/comp/gcc/7 
   module load centos7.9/lib/cuda/11.4

 # Automatic selection of ntomp argument based on "-c" (-c, --cpus-per-task=<ncpus>) argument to sbatch

 if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
 else
    ntomp="1"
 fi

 echo $ntomp

 export OMP_NUM_THREADS=$ntomp

 echo "SLURM_NODELIST $SLURM_NODELIST"
 echo "NUMBER OF CORES $SLURM_NTASKS"

 GROMACS_DIR=/truba/home/kullanici_adi/gromacs-derleme/gromacs-2021.3

 mpirun $GROMACS_DIR/bin/bin/gmx_mpi mdrun $ntmpi -ntomp $ntomp -v -s calistiracaginiz_girdi_dosyalari
 
 exit
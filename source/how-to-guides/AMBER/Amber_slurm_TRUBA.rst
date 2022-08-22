
==========================================
Amber SLURM Dosyası
==========================================


SLURM betik dosyanızı aşağıdaki gibi yapilandirabilirsiniz. Node sayısını ve de ``--ntasks-per-node`` parametresini probleminizin gereksinimlerine göre değiştirebilirsiniz (https://slurm.schedmd.com/sbatch.html)


------------------
Amber_mpi.slurm
------------------

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p barbun
    #SBATCH -A accountname
    #SBATCH -J amber-test
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=20
    #SBATCH --time=3-00:00:00
    #SBATCH --output=slurm-%j.out
    #SBATCH --error=slurm-%j.err

    export OMP_NUM_THREADS=1
    export OMPI_MCA_btl_openib_allow_ib=1

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    module purge
    module load centos7.3/comp/gcc/10.4 
    module load centos7.3/lib/openmpi/4.1.4-gcc-10.4

    source /truba/home/fcaglar/amber-ulak/amber20/amber.sh

    mpirun calistirma komutu

    exit



----------------------
Amber_CudaMPI.slurm
----------------------


.. code-block:: bash

    #!/bin/bash
    #SBATCH -p barbun-cuda
    #SBATCH -A accountname
    #SBATCH -J amber-test
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=20
    #SBATCH --gres=gpu:1 
    #SBATCH --time=3-00:00:00
    #SBATCH --output=slurm-%j.out
    #SBATCH --error=slurm-%j.err

    export OMP_NUM_THREADS=1
    export OMPI_MCA_btl_openib_allow_ib=1

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    export CUDA_VISIBLE_DEVICES=0

    module purge
    module load centos7.3/comp/gcc/10.4 
    module load centos7.3/lib/openmpi/4.1.4-gcc-10.4
    module load centos7.9/lib/cuda/11.1

    source /truba/home/fcaglar/amber-ulak/amber20/amber.sh

    mpirun calistirma komutu

    exit



.. note::

    GPU kullanımı için aşağıdaki dökümantasyon sayfamızı inceleyebilirsiniz:
    
    https://docs.truba.gov.tr/how-to-guides/GPU/index.html



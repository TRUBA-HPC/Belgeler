
==========================================
Amber SLURM Dosyası
==========================================

slrm dosyası yapılandırma
SLURM betik dosyanızı aşağıdaki gibi yapilandirabilirsiniz. Node sayısını (``-N``) ve de ``--ntasks`` (``-n``) parametresini probleminizin gereksinimlerine göre değiştirebilirsiniz (https://slurm.schedmd.com/sbatch.html)


------------------
Amber_MPI.slurm
------------------


.. tabs::

    .. tab:: orfoz

        .. code-block:: bash

            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 55
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00

            export OMP_NUM_THREADS=1
            export OMPI_MCA_btl_openib_allow_ib=1

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF CORES $SLURM_NTASKS"

            module purge
            module load lib/openmpi/5.0.4 

            source /arf/home/username/amber24/amber.sh

            mpirun calistirma komutu

            exit

    .. tab:: hamsi

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p hamsi
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 54
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00

            export OMP_NUM_THREADS=1
            export OMPI_MCA_btl_openib_allow_ib=1

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF CORES $SLURM_NTASKS"

            module purge
            module load lib/openmpi/5.0.4 

            source /arf/home/username/amber24/amber.sh

            mpirun calistirma komutu

            exit

    .. tab:: barbun

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p barbun
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 20
            #SBATCH --time=3-00:00:00
            #SBATCH --output=slurm-%j.out
            #SBATCH --output=slurm-%j.err

            export OMP_NUM_THREADS=1
            export OMPI_MCA_btl_openib_allow_ib=1

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF CORES $SLURM_NTASKS"

            module purge
            module load lib/openmpi/5.0.4 

            source /arf/home/username/amber24/amber.sh

            mpirun calistirma komutu

            exit


----------------------
Amber_CudaMPI.slurm
----------------------


.. tabs::

    .. tab:: barbun-cuda

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p barbun-cuda
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 20
            #SBATCH --gres=gpu:1
            #SBATCH --time=3-00:00:00
            #SBATCH --output=slurm-%j.out
            #SBATCH --output=slurm-%j.err

            export OMP_NUM_THREADS=1
            export OMPI_MCA_btl_openib_allow_ib=1

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF CORES $SLURM_NTASKS"

            export CUDA_VISIBLE_DEVICES=0

            module purge
            module load lib/cuda/12.4
            module load lib/openmpi/5.0.4-cuda-12.4

            source /arf/home/username/amber-ulak/amber24/amber.sh

            mpirun calistirma komutu

            exit

    .. tab:: akya-cuda

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p akya-cuda
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 10
            #SBATCH --gres=gpu:1
            #SBATCH --time=3-00:00:00
            #SBATCH --output=slurm-%j.out
            #SBATCH --output=slurm-%j.err

            export OMP_NUM_THREADS=1
            export OMPI_MCA_btl_openib_allow_ib=1

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF CORES $SLURM_NTASKS"

            export CUDA_VISIBLE_DEVICES=0

            module purge
            module load lib/cuda/12.4
            module load lib/openmpi/5.0.4-cuda-12.4

            source /arf/home/username/amber-ulak/amber24/amber.sh

            mpirun calistirma komutu

            exit



.. note::

    GPU kullanımı için aşağıdaki dökümantasyon sayfamızı inceleyebilirsiniz:
    
    https://docs.truba.gov.tr/how-to-guides/GPU/index.html



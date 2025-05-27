.. _castep-slurm:

==========================================
TRUBA'da CASTEP Kullanımı
==========================================

--------------------------------
CASTEP SLURM Dosyası Örneği
--------------------------------

.. code-block::

    #!/bin/bash
    #SBATCH -M truba
    #SBATCH -p barbun
    #SBATCH -A ACCOUNTNAME
    #SBATCH -J castep-test
    #SBATCH -N 1
    #SBATCH --ntasks=20
    #SBATCH --time=0-02:00:00
    #SBATCH --output=slurm-%j.out
    #SBATCH --error=slurm-%j.err

    export OMP_NUM_THREADS=1

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    module purge
    module load centos7.3/comp/intel/PS2018-update2

    CASTEP_DIR=/truba/home/USERNAME/CASTEP/CASTEP-19.11/bin-barbun-intel-PS2018/linux_x86_64_ifort18--mpi

    mpirun $CASTEP_DIR/castep.mpi inputfile

    exit


* :download:`CASTEP için örnek olarak verilen slurm dosyasını indirmek için tıklayınız... </assets/castep-howto/config-files/CASTEP-barbun_intel18.slurm>`



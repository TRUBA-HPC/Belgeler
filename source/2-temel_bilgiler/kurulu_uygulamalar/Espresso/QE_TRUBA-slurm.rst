TRUBA'da Quantum Espresso Kullanımı
==========================================

------------------------------------------------------
Barbun Hesaplama Kümesi için Örnek Slurm Dosyası
------------------------------------------------------


.. code-block:: bash
    
    #!/bin/bash
    #SBATCH -p orfoz
    #SBATCH -J qe_test
    #SBATCH -N 1
    #SBATCH -n 110
    #SBATCH -c 1
    #SBATCH -C weka
    #SBATCH --time=3-00:00:00

    export OMP_NUM_THREADS=1


    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    module purge

    module load apps/espresso/7.4-epw-5.9-oneapi-2024

    mpirun pw.x < in.Si > Si.out

    exit





------------------------------------------------------
Hamsi Hesaplama Kümesi için Örnek Slurm Dosyası
------------------------------------------------------

.. code-block:: bash

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


* :download:`İlgili Slurm dosyasını indirmek için tıklayınız... </assets/qe-howto/config-files/qe-hamsi_inteloneapi.slurm>`


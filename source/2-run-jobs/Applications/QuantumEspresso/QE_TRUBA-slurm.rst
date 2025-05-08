==========================================
TRUBA'da Quantum Espresso Kullanımı
==========================================

------------------------------------------------------
Barbun Hesaplama Kümesi için Örnek Slurm Dosyası
------------------------------------------------------


.. code-block:: bash

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

    module load comp/oneapi/2023  
    module load lib/hdf5/1.14.3-oneapi-2023.0

    module load apps/espresso/7.2-oneapi-2023.0

    mpirun pw.x < in.Si > Si.out

    exit


* :download:`İlgili Slurm dosyasını indirmek için tıklayınız... </assets/qe-howto/config-files/qe-barbun_impi-intel18.slurm>`


------------------------------------------------------
ARF Hesaplama Kümesi için Örnek Slurm Dosyası
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

    #source /arf/sw/comp/oneapi/2023.0/setvars.sh
    module load comp/oneapi/2023  
    module load lib/hdf5/1.14.3-oneapi-2023.0

    module load apps/espresso/7.2-oneapi-2023.0

    mpirun pw.x < in.Si > Si.out



    exit





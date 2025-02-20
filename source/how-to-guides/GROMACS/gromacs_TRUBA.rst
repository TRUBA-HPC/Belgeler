=============================================
ARF'ta GROMACS Programı Nasıl Kullanılır?
=============================================

ARF kümesindeki sunucularda  hali hazırda kurulan olan GROMACS versiyonları için örnek SLURM betik dosyalarına ``/arf/sw/scripts/gromacs`` dizini altından erişim sağlayabilirsiniz.

Orfoz hesaplama kümesinde GROMACS 2024.1 versiyonunu kullanarak işinizi çalıştırmak için aşağıdaki betik dosyasını referans alabilirsiniz. 

.. note::

  İşlerinizi performanslı bir şekilde çalıştırmak için GROMACS kullanıcı el kitabında belirtildiği gibi ``ntmpi``, ``ntomp`` gibi parametreleri kullanmayı test edebilirsiniz:

  https://manual.gromacs.org/2024.2/user-guide/mdrun-performance.html



.. code-block:: bash

	#!/bin/bash
  #SBATCH -p orfoz
  #SBATCH -A kullanici_adi
  #SBATCH -J jobname
  #SBATCH -N 1
  #SBATCH -n 55
  #SBATCH -c 1
  #SBATCH -C weka
  #SBATCH --time=3-00:00:00

  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  module purge
  module load apps/gromacs/2024.1-oneapi2024

  #BURAYA is calistirma komutunuzu yaziniz
  
  mpirun gmx_mpi mdrun -v -s benchmark.tpr

  exit


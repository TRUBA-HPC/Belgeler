==========================================
TRUBA'da LAMMPS Kullanımı
==========================================

TRUBA sisteminde hali hazırda kurulan olan LAMMPS versiyonları için örnek SLURM betik dosyalarına ``/truba/sw/scripts/lammps`` dizini altından erişim sağlayabilirsiniz.

Bir önceki adımda anlatıldığı gibi (:ref:`LAMMPS kurulumu <lammps_install_truba>`) kendi kullanıcınıza kurduğunuz LAMMPS programını TRUBA sisteminde çalıştırmak için örnek iş betiği dosyası aşağıdaki gibidir:

------------------
LAMMPS_run.slurm
------------------

.. code-block:: bash

 #!/bin/bash
  #SBATCH -p orfoz
  #SBATCH -A tom
  #SBATCH -J lammps_test
  #SBATCH -N 1
  #SBATCH --ntasks=110 # orfoz sunucularinda node basina 55 veya 110 cekirdek talep edilebilir.
  #SBATCH --cpus-per-task=1
  #SBATCH -C weka
  #SBATCH --time=3-00:00:00

  export OMP_NUM_THREADS=1


  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  module purge

  module load apps/lammps/29Aug2024_stable_oneapi-2024


  mpirun lmp -var latconst 3.9 -in in-meam.lattice


  exit


Çalıştığınız klasör içerisinde yukarıdaki betik dosyasını düzenleyip oluşturduktan sonra aşağıdaki adıma geçebilirsiniz.

.. code-block:: bash
  
  sbatch LAMMPS_run.slurm

Komutu ile TRUBA sistemine işinizi gönderebilirsiniz.

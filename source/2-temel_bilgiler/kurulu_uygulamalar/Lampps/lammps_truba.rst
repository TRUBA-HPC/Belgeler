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
  #SBATCH -p mid2
  #SBATCH -A accountname
  #SBATCH -J lammps-test
  #SBATCH -N 1
  #SBATCH -n 20
  #SBATCH --time=03:00:00
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err


  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  export OMP_NUM_THREADS=1
  
  module load centos7.3/comp/intel/PS2018-update2
  module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

  LAMMPS_DIR=/truba/home/username/lammps-stable/build-intel18-openmpi4/bin

  mpirun  $LAMMPS_DIR/lmp  < in.lammpsinputfile > lammps-outputfile.out

  exit

* :download:`İlgili Slurm dosyasını indirmek için tıklayınız... </assets/LAMMPS-howto/config-files/LAMMPS-barbun_openmpi4-intel18.slurm>`

Çalıştığınız klasör içerisinde yukarıdaki betik dosyasını düzenleyip oluşturduktan sonra aşağıdaki adıma geçebilirsiniz.

.. code-block:: bash
  
  sbatch LAMMPS_run.slurm

Komutu ile TRUBA sistemine işinizi gönderebilirsiniz.

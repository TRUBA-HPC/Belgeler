.. _lammps-kilavuzu:

=================================
LAMMPS Kılavuzu
=================================

LAMMPS (Large-scale Atomic/Molecular Massively Parallel Simulator), Sandia Ulusal Laboratuvarı'ndaki araştırmacılar tarafından geliştirilen ve malzeme modellemeye odaklanan bir klasik moleküler dinamik kodudur. Bu belge, TRUBA altyapısında LAMMPS programının kullanımı hakkında bilgi vermek için oluşturulmuştur.

ARF sistemine bağlanmak için öncelikle VPN bağlantınızı kurun (:ref:`open-vpn`). Ardından arf-uiX (X=1,2,3,4,5) kullanıcı arayüzlerinden birine giriş yapın. Terminalde aşağıdaki komutu çalıştırarak ARF sisteminde yüklü olan tüm temel programların listesini görebilirsiniz:

.. code-block::

  module avail

Bu komut, sistemde kurulu olan tüm modülleri listeler.

.. note::

  * ARF kümesine nasıl bağlanacağınız hakkında detaylı bilgi için :ref:`arf_baglanti` sayfasını inceleyebilirsiniz.

Özel olarak sadece ``Lammps`` programına ait modülleri görüntülemek isterseniz terminalde

.. code-block:: bash

    module avail |& grep lammps

veya

.. code-block:: bash

    module avail 2>&1 | grep lammps

komutlarından birisini yazabilirsiniz.

ARF hesaplama kümesinde kurulu olan Lammps versiyonlarına ait module isimleri aşağıdaki gibidir:

.. code-block::

  apps/lammps/2Aug2023_update2-oneapi-2024
  apps/lammps/23Jun2022_update4-oneapi-2022
  apps/lammps/29Aug2024_stable_oneapi-2024
  apps/lammps/29Aug2024_update1_oneapi-2024-hamsi
  apps/lammps/29Aug2024_update1_oneapi-2024-orfoz
  


İlgili versiyonlar için örnek slurm betik dosyalarına ``/arf/sw/scripts/lammps`` klasörü altından ulaşabilirsiniz. 

TRUBA sisteminde kurulu olan LAMMPS versiyonları dışında başka bir versiyona ve/veya farklı parametrelerle kuruluma ihtiyacınız söz konusu ise örnek kurulum yönergesine aşağıdaki linkten ulaşabilirsiniz:

.. toctree::
    :maxdepth: 1

    lammps_install_truba.rst
    lammps_local.rst

-------------------------
TRUBA'da LAMMPS Kullanımı
-------------------------

TRUBA sisteminde hali hazırda kurulan olan LAMMPS versiyonları için örnek SLURM betik dosyalarına ``/arf/sw/scripts/lammps`` dizini altından erişim sağlayabilirsiniz.

LAMMPS programını TRUBA sisteminde çalıştırmak için örnek iş betiği dosyası aşağıdaki gibidir:


.. tabs::

    .. tab:: orfoz-lammps-run.slurm

        .. code-block:: bash

            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J lammps-orfoz
            #SBATCH -N 1
            #SBATCH -n 110
            #SBATCH -c 1  
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00


            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES $SLURM_CPUS_PER_TASK"

            export OMP_NUM_THREADS=1

            module purge
            module load apps/lammps/29Aug2024_stable_oneapi-2024

            mpirun lmp -var latconst 3.9 -in in-meam.lattice


            exit

    .. tab:: hamsi-lammps-run.slurm

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p hamsi
            #SBATCH -A kullanici_adi
            #SBATCH -J lammps-hamsi
            #SBATCH -N 1
            #SBATCH -n 54
            #SBATCH -c 1    
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00


            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES $SLURM_CPUS_PER_TASK"

            export OMP_NUM_THREADS=1

            module purge
            module load apps/lammps/29Aug2024_update1_oneapi-2024-hamsi

            mpirun lmp -var latconst 3.9 -in in-meam.lattice


            exit



Çalıştığınız klasör (``/arf/scratch/kullaniciadi/calismadizini``) içerisinde yukarıdaki betik dosyasını düzenleyip oluşturduktan sonra aşağıdaki adıma geçebilirsiniz.

.. code-block:: bash
  
  sbatch  orfoz-lammps-run.slurm

Komutu ile TRUBA sistemine işinizi gönderebilirsiniz.

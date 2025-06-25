.. _qe-kilavuzu:

=================================
Quantum Espresso Kılavuzu
=================================

`Quantum ESPRESSO <https://www.quantum-espresso.org/>`_; yoğunluk-fonksiyonel teorisine, düzlem dalga temel setlerine ve psödopotansiyellere dayanan, nano ölçekte elektronik yapı hesaplamaları ve malzeme modellemesi yapılmasını sağlayan GNU Genel Kamu Lisansı altında ücretsiz ve özgür yazılım olarak dağıtılan bir paket programdır. Bu belge, TRUBA altyapısında Quantum ESPRESSO programının kullanımı hakkında bilgi vermek için oluşturulmuştur.

ARF sistemine VPN ile bağlantı sağladıktan sonra (:ref:`open-vpn`) arf-uiX (X=1,2,3,4,5) kullanıcı arayüzünde iken terminalden

.. code-block::

  module available

komutunu yazdığınızda ARF sisteminde kurulu olan temel programlar listelenecektir. 

.. note:: 

    * ARF kümesine bağlantı için :ref:`arf_baglanti` sayfasını inceleyebilirsiniz.

Özel olarak sadece QE programına ait modülleri görüntülemek isterseniz terminalde

.. code-block:: bash

    module avail |& grep espresso

veya

.. code-block:: bash

    module avail 2>&1 | grep espresso

komutlarından birisini yazabilirsiniz.

ARF hesaplama kümesinde kurulu olan QE versiyonlarına ait module isimleri aşağıdaki gibidir:

.. code-block::

  apps/espresso/6.7-oneapi-2022

  apps/espresso/7.2-oneapi-2023.0

  apps/espresso/7.4-epw-5.9-oneapi-2024



arf-ui kullanıcı arayüz sunucularından birisine bağlı iken örnek SLURM betik dosyalarına aşağıdaki dizinden erişim sağlayabilirsiniz:

.. code-block::

  /arf/sw/scripts/espresso


QE için ilgili çalışma dosyalarınızı hazırladıktan sonra terminalden

.. code-block::

  sbatch QE-slurmfile.slurm

komutu ile sistemde çalışmak üzere submit edebilirsiniz.


ARF sisteminde mevcut olan QE sürümleri dışında farklı bir sürüme ihtiyaç duyarsanız, ilgili versiyonu Quantum ESPRESSO’nun resmi web sitesinden (https://www.quantum-espresso.org) indirebilirsiniz. İndirdiğiniz klasördeki ``Doc`` dizininde yer alan kullanım kılavuzundan kurulum adımlarına ulaşabilirsiniz (`QE 7.3.1 Kullanıcı Kitapçığı <https://www.quantum-espresso.org/Doc/user_guide_PDF/user_guide.pdf>`_). QE’nin paralel çalışması için gerekli derleyici ve kütüphaneleri (ör. Intel OneAPI, OpenMPI) sistemde yüklü olan modüller arasından seçebilirsiniz. Ayrıca, Wannier90 ve HDF5 gibi QE ile entegre çalışabilen kütüphaneler de ARF sisteminde kurulu olarak bulunmaktadır, moduller arasında bu kütüphaneleri de bulabilirsiniz.

----------------------
Örnek Slurm Dosyası
----------------------



.. tabs::

    .. tab:: 7.4-epw-5.9-oneapi-2024

        .. code-block:: bash

            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J qe74-test
            #SBATCH -N 1
            #SBATCH -n 110
            #SBATCH -c 1   
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00


            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            export OMP_NUM_THREADS=1

            module purge

            module load apps/espresso/7.4-epw-5.9-oneapi-2024

            mpirun pw.x < in.Si > Si.out

            exit

    .. tab:: 7.2-oneapi-2023.0

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J qe72-test
            #SBATCH -N 1
            #SBATCH -n 110
            #SBATCH -c 1   
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00


            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            export OMP_NUM_THREADS=1

            module purge

            module load comp/oneapi/2023
            module load lib/hdf5/1.14.3-oneapi-2023.0
            module load apps/espresso/7.2-oneapi-2023.0

            mpirun pw.x < in.Si > Si.out

            exit

İlgili SLURM betik dosyasını kendi kullanıcı hesabınızın dizininizde yer alan çalışma klasörünüzde (/arf/scratch/kullaniciadi/calismaklasoru) düzenledikten sonra

.. code-block:: bash

    sbatch QEsubmitfile.slurm

komutu ile sisteme submit edebilirsiniz.


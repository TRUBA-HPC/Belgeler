.. _lammps-kilavuzu:

=================================
LAMMPS Kılavuzu
=================================

LAMMPS (Large-scale Atomic/Molecular Massively Parallel Simulator), Sandia Ulusal Laboratuvarı'ndaki araştırmacılar tarafından geliştirilen ve malzeme modellemeye odaklanan bir klasik moleküler dinamik kodudur. Bu belge, TRUBA altyapısında LAMMPS programının kullanımı hakkında bilgi vermek için oluşturulmuştur.

Kullanıcılarımız tarafından sıklıkla kullanılan, açık kaynak kodlu olan ve GNU GPL lisansı altında sunulan yazılımlar altyapımızda yer almaktadır. TRUBA’ya terminalden bağlantı sağladıktan sonra barbun1 kullanıcı arayüzünde terminalden

.. code-block::

  module available


komutunu yazdığınızda TRUBA sisteminde kurulu olan temel programlar listelenecektir.

TRUBA sisteminde güncel olarak kurulu olan LAMMPS versiyonları aşağıdaki gibidir. 

- Centos7.3 işletim sistemi olan ``barbun`` hesaplama kümesi için ilgili module ismi:

.. code-block::

  centos7.3/app/lammps/23Jun2022-impi-oneapi-2022.2-GOLD
  centos7.3/app/lammps/23Jun2022-openmpi-4.1.1-oneapi-2021.2-GOLD


- Centos7.9 işletim sistemi olan ``hamsi`` hesaplama kümesi için ilgili module ismi:

.. code-block::

  centos7.9/app/lammps/29Sept21-update3-impi-oneapi-2021.2-GOLD
  centos7.9/app/lammps/29Sept21-update3-openmpi-4.1.1-oneapi-2021.2-GOLD

İlgili versiyonlar için örnek slurm betik dosyalarına ``/truba/sw/scripts/lammps`` klasörü altından ulaşabilirsiniz. 

TRUBA sisteminde kurulu olan LAMMPS versiyonları dışında başka bir versiyona ve/veya farklı parametrelerle kuruluma ihtiyacınız söz konusu ise örnek kurulum yönergesine aşağıdaki linkten ulaşabilirsiniz:

.. toctree::
    :maxdepth: 1

    lammps_install_truba.rst
    lammps_gpu.rst
    lammps_truba.rst
    lammps_local.rst


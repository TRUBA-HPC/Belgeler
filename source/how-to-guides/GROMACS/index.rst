=================================
GROMACS Kılavuzu
=================================

GROMACS, yüzlerce hatta milyonlarca parçacık içeren sistemler için Newton’un hareket denklemlerini kullanarak moleküler dinamik simülasyonları gerçekleştiren açık kaynak kodlu bir paket yazılımdır. Proteinler, lipidler ve nükleik asit gibi çok sayıda birbiriyle karmaşık etkileşime sahip biyokimyasal moleküller için tasarlanmıştır, ancak birbiriyle etkileşmeyen sistemlerin hesaplamalarını da oldukça hızlı yapmaktadır. Program açık kaynak yazılım olduğu için kolaylıkla kendi ev dizininize kolaylıkla indirebilir ve derleyebilirsiniz. 

TRUBA’ya terminalden bağlantı sağladıktan sonra levrek1 kullanıcı arayüzünde terminalden

.. code-block::

  module available

komutunu yazdığınızda TRUBA sisteminde kurulu olan temel programlar listelenecektir. Module isimlendirmesi ile ilgili bilgilere TRUBA :ref:`moduller-truba` sayfamızdan ulaşabilirsiniz. 

Centos7.3 işletim sistemi olan ``barbun-cuda`` hesaplama kümesinde GROMACS 2021'in CUDA opsiyonu ile kurulu olan versiyonu bulunmaktadır. İlgili module ismi:

.. code-block::

  centos7.3/app/gromacs/2021-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA

İlgili versiyonda ``plumed patch`` de yer almaktadır. Bu versiyonu kullanmak için örnek slurm betik dosyasına ``/truba/sw/scripts/gromacs`` klasörü altından ulaşabilirsiniz. Dosya ismi: ``gromacs-2021-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA.slurm``

Hamsi hesaplama kümesinde ise Centos 7.9 işletim sistemi yüklüdür ve burada GROMACS 2021.2 versiyonu bulunmaktadır. İlgili modüle ismi:

.. code-block::

  centos7.9/app/gromacs/2021.2-impi-mkl-oneapi-2021.2-GOLD

Bu versiyonu kullanmak için örnek slurm betik dosyasına ``/truba/sw/scripts/gromacs`` klasörü altından ulaşabilirsiniz. Dosya ismi: ``gromacs-2021.2-impi-mkl-oneapi-2021.2-GOLD.slurm``

TRUBA sisteminde kurulu olan GROMACS versiyonları dışında başka bir versiyona ihtiyacınız söz konusu ise örnek kurulum yönergesine :ref:`gromacs-install` linkinden ulaşabilirsiniz:

.. toctree::
    :maxdepth: 1

    gromacs_install_TRUBA.rst
    gromacs_preprocess.rst
    gromacs_gpu.rst
    gromacs_TRUBA.rst
   


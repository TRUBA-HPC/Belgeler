.. _gromacs-kilavuzu:

=================================
GROMACS Kılavuzu
=================================

GROMACS, yüzlerce hatta milyonlarca parçacık içeren sistemler için Newton’un hareket denklemlerini kullanarak moleküler dinamik simülasyonları gerçekleştiren açık kaynak kodlu bir paket yazılımdır. Proteinler, lipidler ve nükleik asit gibi çok sayıda birbiriyle karmaşık etkileşime sahip biyokimyasal moleküller için tasarlanmıştır, ancak birbiriyle etkileşmeyen sistemlerin hesaplamalarını da oldukça hızlı yapmaktadır. Program açık kaynak yazılım olduğu için GROMACS'in kendi sayfasında yayınlanan kullanıcı kitabını referans alarak kolaylıkla kendi ev dizininize indirebilir ve derleyebilirsiniz. 

TRUBA’ya terminalden bağlantı sağladıktan sonra arf-uiX (X=1,2,3,4,5) kullanıcı arayüzünde terminalden

.. code-block::

  module available

komutunu yazdığınızda ARF sisteminde kurulu olan temel programlar listelenecektir. 

ARF hesaplama kümesinde yer alan ``orfoz`` sunucularında GROMACS 2023.3 ve GROMACS 2024.1 versiyonları bulunmaktadır. İlgili module isimleri aşağıdaki gibidir:

.. code-block::

  apps/gromacs/2023.3

.. code-block::

  apps/gromacs/2024.1-oneapi2024

arf-ui kullanıcı arayüz sunucularından birisine bağlı iken örnek SLURM betik dosyalarına aşağıdaki dizinden erişim sağlayabilirsiniz:

.. code-block::

  /arf/sw/scripts/gromacs


GROMACS için ilgili çalışma dosyalarınızı hazırladıktan sonra terminalden

.. code-block::

  sbatch slurmfilename.slurm

Komutu ile sistemde çalışmak üzere submit edebilirsiniz.



ARF sisteminde kurulu olan GROMACS versiyonları dışında başka bir versiyona ihtiyacınız söz konusu ise GROMACS'in kendi sayfasında yayınlanan kullanım yönergesinden bilgi edinebilirsiniz (`GROMACS Kurulum Yönergesi <https://manual.gromacs.org/2024.4/install-guide/index.html>`_). GROMACS'in paralel çalışması için gerekli derleyici ve kütüphaneleri (Intel OneAPI, OpenMPI, vb.) sistemde halihazırda kurulu bulunan moduller arasından yükleyebilirsiniz.


.. toctree::
    :maxdepth: 1

    gromacs_preprocess.rst
    gromacs_install_TRUBA.rst
    gromacs_TRUBA.rst
    gromacs_gpu.rst

   


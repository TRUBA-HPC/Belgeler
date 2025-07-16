.. _uygulamalar_kutuphane:

========================================
Yazılımlar ve Uygulamalar
========================================

Genel Bilgiler
--------------

Yaygın olarak kullanılan yazılımlar, uygulamalar ve kütüphanelerin güncel ve farklı sürümleri merkezi olarak kuruludur. Kullanıcıların öncelikli olarak bu merkezi kurulumları kullanmaları önerilir.

Merkezi yazılımları kullanmak için modül sisteminden yararlanabilirsiniz:

.. code-block:: bash

   module available      # Yüklü yazılımları listeler
   module load <modül>   # İlgili yazılımı yükler

Eğer ihtiyacınız olan yazılım merkezi olarak kurulu değilse veya mevcut sürümler gereksinimlerinizi karşılamıyorsa, yazılımı kendi ev dizininize (``/arf/home/$USER``) kurabilirsiniz. Kurulum sırasında güncel derleyici ve kütüphaneleri kullanmanız tavsiye edilir.

**Merkezi Yazılım ve Veri Dizinleri**

Aşağıdaki dizinlerde merkezi yazılımlar, kütüphaneler, konteynerler ve örnek betikler bulunmaktadır:

.. list-table:: Merkezi Yazılım Dizinleri
   :widths: 25 25
   :header-rows: 1
   :align: center

   * - Uygulama
     - /arf/sw/apps
   * - Kütüphane
     - /arf/sw/lib
   * - Konteyner
     - /arf/sw/containers
   * - Derleyici
     - /arf/sw/comp
   * - Modüller
     - /arf/sw/modulefiles
   * - Kaynak
     - /arf/sw/src  
   * - Veri Setleri
     - /arf/repo
   * - Örnek SLURM dosyaları
     - /arf/sw/scripts 



Uygulamalar Kılavuzu
--------------------

Bu bölümde, TRUBA altyapısında kurulu olan uygulamalar ve bu uygulamaların kullanımı hakkında bilgi verilmektedir. Aşağıda, kurulu uygulamaların listesi ve her birinin detaylarına erişim için bağlantılar bulunmaktadır.

.. toctree::
   :maxdepth: 1

   Python/index.rst  
   Cvmfs/index.rst
   
   SnakeMake/index.rst
   
   R/index.rst

   Amber/index.rst
   CASTEP/index.rst
   Gaussian/index.rst
   Gromacs/index.rst
   Lammps/index.rst
   Namd/index.rst
   QEspresso/index.rst
   Vasp/index.rst

   
   GREASY/index.rst
   Matlab/index.rst
  


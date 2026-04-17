.. _uygulamalar_kutuphane:

========================================
Yazılımlar ve Uygulamalar
========================================

Genel Bilgiler
--------------

Yaygın olarak kullanılan yazılımlar, uygulamalar ve kütüphanelerin güncel ve farklı sürümleri merkezi olarak kuruludur. Kullanıcıların öncelikli olarak bu merkezi kurulumları kullanmaları önerilir.

Merkezi olarak kurulu yazılımlara erişmek ve kullanmak için modül sisteminden faydalanabilirsiniz. Modül sistemi, sistemde yüklü olan yazılımları kolayca yüklemenizi ve ortam değişkenlerini otomatik olarak ayarlamanızı sağlar.

.. code-block:: bash

   module avail            # Sistemde erişilebilir yazılımları ve sürümleri listeler
   module load <modül>     # Seçtiğiniz yazılım veya kütüphaneyi ortamınıza dahil eder

Eğer varsayılan listede bulunmayan ek modüllere ihtiyacınız varsa, ilgili ek modül koleksiyonunu yükleyebilirsiniz:

.. code-block:: bash

   module load ek-moduller   # Ek modülleri kullanımınıza açar

Ek modül koleksiyonunu yükledikten sonra ``module avail`` komutunu tekrar çalıştırarak eklenen yeni modülleri görebilirsiniz.
Sistemde mevcut tüm derleme modüllerini ve alt kategorileri listelemek için ise ``module avail --all`` komutunu kullanabilirsiniz.

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


Lisanslı Yazılımlar
--------------------
Sistemde kullanılabilen uygulamaların bir kısmı lisansı ücretli olan uygulamalardır. Bu tür uygulamaları kullanmak isteyen kullanıcılar TRUBA'da çalışmaya uygun lisansı da kendileri (ya da bağlı bulundukları kurum aracılığıyla) sağlamalıdır.

.. toctree::
   :maxdepth: 1

   yazilimlar.rst



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
   QEspresso/index.rst
   Vasp/index.rst
   
   
   GREASY/index.rst
   Matlab/index.rst
   
  


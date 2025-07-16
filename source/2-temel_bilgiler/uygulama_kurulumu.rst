
========================================
Uygulama ve Kütüphane Kurulumu
========================================

Yaygın olarak kullanılan uygulama ve kütüphanelerin güncel ve farklı sürümleri merkezi olarak kuruludur. Kullanıcıların öncelikli olarak bu merkezi kurulumları kullanmaları önerilir.

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

**İyi Uygulamalar ve Kullanıcı Sorumlulukları**

- Ev dizinlerinizin erişim haklarını değiştirmeyiniz; yalnızca size açık olmalıdır.
- Gereksiz dosyaları ve kullanılmayan uygulamaları düzenli olarak siliniz.
- Büyük veri setleri veya çok sayıda küçük dosya gerektiren işler için merkezi kurulumları veya konteynerleri kullanınız.
- Scratch alanı geçici amaçlıdır; önemli verilerinizi kendi bilgisayarınıza indiriniz.
- Dosya ve dizinlerinizi arşivleyerek (örn. tar ile) saklamak inode kullanımını azaltır.
- Ev ve scratch dizinlerinizde kota ve dosya (inode) limiti uygulanmaktadır. Limit aşıldığında yeni dosya oluşturamaz, iş başlatamaz veya veri kaybı yaşayabilirsiniz. 


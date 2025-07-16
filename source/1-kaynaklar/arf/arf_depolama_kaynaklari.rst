.. _arf_depolama_kaynaklari:

====================================
Dosya Sistemleri ve Depolama
====================================

Hesaplama kümelerinde, kullanıcı verileri ile hesaplama çıktılarının yönetimi için yüksek performanslı merkezi dosya sistemleri kullanılmaktadır. Bu sistemler, paralel dosya sistemi altyapısı ile yapılandırılmış olup, farklı kullanım amaçlarına yönelik üç ana dosya sistemi sunmaktadır: WEKA tabanlı ev dizini (``/arf/home``), scratch alanı (``/arf/scratch``) ve LUSTRE tabanlı merkezi depolama alanı (``/truba/home``).

.. important::
   **Kritik Güvenlik Uyarısı:** Bu dosya sistemleri kalıcı veri depolama amacıyla tasarlanmamıştır. Tüm veri güvenliği ve yedekleme sorumluluğu kullanıcılara aittir. Ev dizinlerinin merkezi yedeklemesi yapılmamaktadır.

.. _dosya-sistemleri-genel-bakis:

Dosya Sistemleri Genel Bakış
============================

Hesaplama kümelerinde bulunan dosya sistemleri, farklı performans karakteristikleri ve kullanım amaçlarına göre tasarlanmıştır:

.. |br| raw:: html

     <br>

.. list-table:: Dosya Sistemleri Özeti
   :widths: 15 20 20 25 20
   :header-rows: 1
   :align: center

   * - Dosya Sistemi
     - Kullanım Amacı
     - Kota
     - Performans
     - Yaşam Süresi
   * - ``/arf/home``
     - Ev dizini
     - 100 GB |br| 100K dosya
     - Yüksek hız |br| Güvenilir
     - Kullanıcı kontrolü
   * - ``/arf/scratch``
     - Geçici hesaplama
     - 1 TB |br| 200K dosya
     - Yüksek hız |br| Paralel I/O
     - En fazla 1 ay
   * - ``/truba/home``
     - Merkezi depolama
     - 2 TB |br| 100K dosya
     - Orta hız
     - Geçici depolama

.. _dosya-sistemi-detaylari:

Dosya Sistemi Detayları
=======================

.. _arf-home-dizini:

ARF Ev Dizini (``/arf/home/$USER``)
-----------------------------------

Ev dizini, kullanıcıların kişisel dosyaları, uygulama kurulumları ve betiklerini saklamak için tasarlanmıştır.

**Önerilen Kullanım:**

- Betik dosyaları ve konfigürasyon dosyaları
- Küçük boyutlu uygulama kurulumları
- Girdi dosyaları ve parametre dosyaları
- Kalıcı olarak saklanması gereken küçük çıktı dosyaları

**Kullanım Kısıtlamaları:**

- Büyük veri setleri saklanmamalıdır
- Yoğun I/O gerektiren hesaplamalar çalıştırılmamalıdır
- Uzun süreli veri arşivleme yapılmamalıdır

.. _arf-scratch-dizini:

ARF Scratch Dizini (``/arf/scratch/$USER``)
-------------------------------------------

Scratch dizini, aktif hesaplama işleri için yüksek performanslı geçici depolama alanıdır.

**Önerilen Kullanım:**

- Aktif hesaplama işlerinin çalıştırılması
- Geçici çıktı dosyalarının saklanması
- Büyük veri setleri üzerinde işlem yapılması
- Paralel I/O gerektiren uygulamalar

**Kritik Uyarılar:**

- Dosyalar sistem tarafından periyodik olarak silinir
- Önemli veriler mutlaka başka konuma kopyalanmalıdır
- Uzun süreli veri saklanamaz

.. _truba-home-dizini:

TRUBA Merkezi Depolama (``/truba/home/$USER``)
----------------------------------------------

Merkezi depolama alanı, projeler boyunca geçici veri saklamak için kullanılır.

**Önerilen Kullanım:**

- Proje verilerinin geçici depolanması
- Scratch alanından çıktıların transferi
- Büyük veri setlerinin geçici saklanması

.. _kota-asim-cozumleri:

Kota Aşım Çözümleri
------------------

Kota limitine yaklaştığınızda veya aştığınızda:

1. **Gereksiz dosyaları silin:**

   .. code-block:: bash

      # Büyük dosyaları bul
      find /arf/home/$USER -type f -size +100M -ls
      
      # Eski dosyaları bul (30 günden eski)
      find /arf/scratch/$USER -type f -atime +30 -ls

2. **Dosyaları arşivleyin:**

   .. code-block:: bash

      # Sıkıştırılmış arşiv oluştur
      tar -czf arsiv.tar.gz klasor_adi/
      
      # Orijinal dosyaları sil
      rm -rf klasor_adi/

3. **Verileri yerel bilgisayara indirin:**

   Veri transferi için :ref:`dosya_transferi` bölümündeki yönergeleri takip edebilirsiniz.

.. _dosya-sayisi-yonetimi:

Dosya Sayısı (inode) Yönetimi
=============================

Dosya sayısı limiti, sistem performansını korumak için kritik önem taşır.

.. _inode-optimization:

İnode Optimizasyon Stratejileri
------------------------------

**1. Merkezi Yazılımları Kullanın:**

- ``module load`` sistemini kullanın
- Konteyner teknolojilerini tercih edin

**2. Dosya Birleştirme:**

.. code-block:: bash

   # Küçük dosyaları birleştir
   cat dosya1.txt dosya2.txt > birlesik_dosya.txt
   
   # Çoklu dosyaları tek arşivde topla
   tar -czf veri_seti.tar.gz *.dat

**3. Anaconda/Conda Kullanımından Kaçının:**

.. warning::
   ``/arf`` ve ``/truba`` dosya sistemlerine Anaconda, Miniconda, conda veya pip ile paket kurulumu yapılmamalıdır. Bu araçlar binlerce küçük dosya oluşturarak sistem performansını ciddi şekilde düşürür. Kullanım detayına :ref:`python-kilavuzu` bölümünden ulaşabilirsiniz.  

.. _veri-guvenlik-politikalari:

Veri Güvenliği ve Politikalar
============================

.. _yedekleme-sorumluluklari:

Yedekleme Sorumlulukları
-----------------------

.. danger::
   **Veri Kaybı Riski:** Dosya sistemlerinde hiçbir otomatik yedekleme hizmeti bulunmamaktadır. Tüm veri güvenliği kullanıcının sorumluluğundadır.

**Kullanıcı Sorumlulukları:**

- Önemli verilerin düzenli yerel yedeklemesi
- Scratch alanındaki geçici dosyaların zamanında silinmesi
- Dosya erişim haklarının korunması
- Lisans şartlarına uygun yazılım kullanımı

.. _veri-yasamam-politikalari:

Veri Yaşam Döngüsü Politikaları
------------------------------

**Ev Dizini (``/arf/home``):**

- Kullanıcı kontrolünde yaşam süresi
- Düzenli temizlik önerilir
- Kritik veriler için yedekleme zorunlu

**Scratch Alanı (``/arf/scratch``):**

- Maksimum 30 gün yaşam süresi
- Otomatik temizleme uygulanır
- Geçici dosyalar için tasarlanmıştır

**Merkezi Depolama (``/truba/home``):**

- Proje süresi boyunca geçici depolama
- Uzun vadeli arşivleme için uygun değil

.. _en-iyi-uygulamalar:

En İyi Uygulamalar ve Öneriler
=============================

.. _performans-optimizasyonu:

Performans Optimizasyonu
-----------------------

**1. Doğru Dosya Sistemi Seçimi:**

- Hesaplama işleri için ``/arf/scratch`` kullanın
- Küçük dosyalar için ``/arf/home`` tercih edin
- Büyük veri setleri için ``/truba/home`` değerlendirin

**2. Geçici Dosya Yönetimi:**

.. code-block:: bash

   # İş bitiminde geçici dosyaları temizle
   export TMPDIR=/arf/scratch/$USER/tmp
   mkdir -p $TMPDIR
   
   # İş sonunda temizlik
   trap 'rm -rf $TMPDIR' EXIT

.. _sorun-giderme:

Sorun Giderme ve Destek
======================

.. _yaygın-sorunlar:

Yaygın Sorunlar ve Çözümleri
---------------------------

**1. Kota Aşım Hatası:**

.. code-block:: bash

   # Disk kullanımını kontrol et
   du -sh /arf/home/$USER
   
   # Büyük dosyaları bul
   find /arf/home/$USER -type f -size +100M -exec ls -lh {} \;

**2. İnode Limiti Aşımı:**

.. code-block:: bash

   # Dosya sayısını kontrol et
   find /arf/home/$USER -type f | wc -l
   
   # Küçük dosyaları birleştir veya sil

**3. Erişim İzni Sorunları:**

.. code-block:: bash

   # Dosya izinlerini kontrol et
   ls -la /arf/home/$USER
   
   # Gerektiğinde izinleri düzelt
   chmod 755 /arf/home/$USER


**İyi Uygulamalar ve Kullanıcı Sorumlulukları**

- Ev dizinlerinizin erişim haklarını değiştirmeyiniz; yalnızca size açık olmalıdır.
- Gereksiz dosyaları ve kullanılmayan uygulamaları düzenli olarak siliniz.
- Büyük veri setleri veya çok sayıda küçük dosya gerektiren işler için merkezi kurulumları veya konteynerleri kullanınız.
- Scratch alanı geçici amaçlıdır; önemli verilerinizi kendi bilgisayarınıza indiriniz.
- Dosya ve dizinlerinizi arşivleyerek (örn. tar ile) saklamak inode kullanımını azaltır.
- Ev ve scratch dizinlerinizde kota ve dosya (inode) limiti uygulanmaktadır. Limit aşıldığında yeni dosya oluşturamaz, iş başlatamaz veya veri kaybı yaşayabilirsiniz. 




Herhangi bir sorun yaşarsanız, yardım ve destek almak için lütfen :ref:`truba_iletisim` sayfasındaki teknik destek iletişim bilgilerini kullanarak bizimle iletişime geçiniz.

.. _arf_depolama_kaynaklari:

====================================
Dosya Sistemleri ve Depolama
====================================

ARF hesaplama kümesinde kullanıcı verileri ve hesaplama çıktıları için yüksek performanslı merkezi dosya sistemleri kullanılmaktadır. Bu sistemler, hem ev dizini (``/arf/home``), hem geçici/scratch alanı (``/arf/scratch``), hem de proje bazlı depolama (``/truba/home``) olarak yapılandırılmıştır.

.. admonition:: Önemli Notlar
   :class: important

   - ARF dosya sistemleri kalıcı veri depolama alanı olarak tasarlanmamıştır. Verilerinizin güvenliğinden kullanıcılar sorumludur.
   - Ev dizinlerinin yedeklemesi yapılmaz. Önemli verilerinizi düzenli olarak kendi bilgisayarınıza indiriniz.
   - Scratch alanı geçici dosyalar için kullanılmalı, uzun süreli veri saklanmamalıdır. Sistem tarafından periyodik olarak dosyalar silinebilir.
   - Kota ve dosya sayısı (inode) kısıtlamalarına dikkat ediniz.

**Ev, İş ve Depolama Dizinleri**

ARF kümesinde, TRUBA kümesinden farklı olarak, ev dizini ve iş dizini olarak yüksek hızlı merkezi NVMe tabanlı bir dosya sistemi kullanılmaktadır. Kullanıcı ev dizinleri ve iş dizinleri bu yüksek hızlı NVMe dosya sisteminde yer almaktadır. Bu nedenle, ARF kümesindeki kullanıcı ev dizinlerinin ve iş dizinlerinin kotaları düşük tutulmuştur.

.. note::

  Kullanıcı Dizinleri:
    - Ev dizini: ``/arf/home/$USER`` (100 GB, 150.000 dosya/inode)
    - İş dizini: ``/arf/scratch/$USER`` (1 TB, 150.000 dosya/inode, dosya ömrü en fazla 1 ay)
    - Depolama dizini: ``/truba/home/$USER`` (2 TB, 100.000 dosya/inode)

Ev dizinleri, kullanıcıların uygulama kurulumları, ayar dosyaları ve betiklerini saklamak içindir. Kısa süreli düşük hacimli işler çalıştırılabilir, ancak üretim amaçlı tüm işler kesinlikle ``/arf/scratch`` altında çalıştırılmalıdır.

``/arf/scratch`` altında çalıştırılan işlerin sonuçları ivedilikle kontrol edilmeli, saklanması gerekmeyen dosyalar sistemden silinmeli, saklanması gerekenler kullanıcının kendi bilgisayarına indirilmelidir. Dosyaların ömrü en fazla 1 aydır.

``/truba/home/$USER`` ve eski ``/truba/scratch/$USER`` dizinlerindeki dosyalarınızı temizleyin, sadece gerekli olanları ARF ortamına taşıyın. Kalıcı depolama için kendi bilgisayarınızı kullanın.

.. warning::
   TRUBA ve ARF dosya sistemlerinde hiçbir veri kalıcı değildir, yedek sorumluluğu kullanıcıya aittir.

**Merkezi Yazılım Dizinleri ve Modül Sistemi**

ARF kümesinde merkezi olarak kurulu yazılımlar, kütüphaneler ve örnek betikler aşağıdaki dizinlerde bulunur. Kullanıcılar bu merkezi kurulumları modül dosyaları yardımı ile kullanabilirler.

.. list-table:: Merkezi yazılım dizinleri
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

Güncel yazılım ve modülleri görmek için:

.. code-block:: bash

   module available

Kendi uygulamanızı kurmak istiyorsanız, güncel derleyici ve kütüphanelerle yeniden derleyip ``/arf/home/$USER`` dizinine yükleyiniz. Ev dizinlerine conda, pip vb. kurulmamalı, gerekirse merkezi kurulumlar veya konteynerler kullanılmalıdır.

**Kullanıcı Sorumlulukları ve İyi Uygulamalar**

- Ev dizinleri yalnızca sahibi tarafından erişilebilir. Erişim haklarınızı değiştirmemeye özen gösteriniz.
- Kullanılmayan veya gereksiz dosyaları düzenli olarak siliniz.
- Büyük veri setleri veya çok sayıda küçük dosya oluşturacak uygulamalar için merkezi kurulumları ve konteyner teknolojilerini tercih ediniz.
- Anaconda, Miniconda, pip gibi araçları merkezi depolama alanına kurmayınız. Küçük dosya sayısı limiti nedeniyle performans sorunları yaşanabilir.
- Scratch alanında uzun süreli veri saklamayınız, önemli verilerinizi kendi bilgisayarınıza indiriniz.

**Dosya Sayısı (inode) Kısıtlaması**

Her kullanıcıya ev ve scratch dizinlerinde belirli bir dosya (inode) limiti uygulanır. Bu limitin aşılması sistem performansını olumsuz etkiler. Kendi kullanımınızı aşağıdaki komut ile kontrol edebilirsiniz:


**Ekstra Bilgiler ve İpuçları**

- /tmp dizinleri tüm sunucularda NVMe disk olarak yapılandırılmıştır. Yüksek I/O gerektiren işlerinizde bu alanı kullanmanız önerilir.
- Dosya sistemlerinde kota ve inode limitlerine ulaşılması durumunda yeni dosya oluşturulamaz, iş başlatılamaz veya veri kaybı yaşanabilir.
- Dosya ve dizinlerinizi arşivleyerek (ör. tar ile) saklamak inode kullanımını azaltır.

Daha fazla bilgi ve güncel depolama politikaları için sistem yöneticinizle iletişime geçebilirsiniz.

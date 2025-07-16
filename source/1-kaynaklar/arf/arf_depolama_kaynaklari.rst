.. _arf_depolama_kaynaklari:

====================================
Dosya Sistemleri ve Depolama
====================================

ARF hesaplama kümesinde kullanıcı verileri ve hesaplama çıktıları için yüksek performanslı merkezi dosya sistemleri kullanılmaktadır. Bu sistemler, hem ev dizini (``/arf/home``), hem geçici/scratch alanı (``/arf/scratch``), hem de depolama alanı (``/truba/home``) olarak yapılandırılmıştır.

.. admonition:: Önemli Notlar
   :class: important

   - ARF dosya sistemleri kalıcı veri depolama alanı olarak tasarlanmamıştır. Verilerinizin güvenliğinden kullanıcılar sorumludur.
   - Ev dizinlerinin yedeklemesi yapılmaz. Önemli verilerinizi düzenli olarak kendi bilgisayarınıza indiriniz.
   - Scratch alanı geçici dosyalar için kullanılmalı, uzun süreli veri saklanmamalıdır. Sistem tarafından periyodik olarak dosyalar silinebilir.
   - Kota ve dosya sayısı (inode) kısıtlamalarına dikkat ediniz.

**Ev, İş ve Depolama Dizinleri**

ARF kümesinde, ev dizini ve iş dizini olarak yüksek hızlı merkezi NVMe tabanlı bir dosya sistemi kullanılmaktadır. Kullanıcı ev dizinleri ve iş dizinleri bu yüksek hızlı NVMe dosya sisteminde yer almaktadır. Bu nedenle, ARF kümesindeki kullanıcı ev dizinlerinin ve iş dizinlerinin kotaları düşük tutulmuştur.

.. note::

  Kullanıcı Dizinleri:
    - Ev dizini: ``/arf/home/$USER`` (100 GB, 150.000 dosya/inode)
    - İş dizini: ``/arf/scratch/$USER`` (1 TB, 150.000 dosya/inode, dosya ömrü en fazla 1 ay)
    - Depolama dizini: ``/truba/home/$USER`` (2 TB, 100.000 dosya/inode)

Ev dizinleri, kullanıcıların uygulama kurulumları, ayar dosyaları ve betiklerini saklamak içindir. Kısa süreli düşük hacimli işler çalıştırılabilir, ancak üretim amaçlı tüm işler kesinlikle ``/arf/scratch`` altında çalıştırılmalıdır.

``/arf/scratch`` altında çalıştırılan işlerin sonuçları ivedilikle kontrol edilmeli, saklanması gerekmeyen dosyalar sistemden silinmeli, saklanması gerekenler kullanıcının kendi bilgisayarına indirilmelidir. Dosyaların ömrü en fazla 1 aydır.

``/truba/home/$USER`` dizini geçici depolama için kullanılabilir, kalıcı depolama imkanı sunmamaktadır. Kullanıcılar önemli verilerini kendi depolama alanlarına aktarmalıdır.

.. warning::
   TRUBA ve ARF dosya sistemlerinde hiçbir veri kalıcı değildir, yedek sorumluluğu kullanıcıya aittir.
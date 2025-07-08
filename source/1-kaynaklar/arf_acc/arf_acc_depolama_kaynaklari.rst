.. _arf_acc_depolama_kaynaklari:

====================================
Dosya Sistemleri ve Depolama
====================================

ARF ACC hesaplama kümesinde kullanıcı verileri ve hesaplama çıktıları için yüksek performanslı merkezi dosya sistemi olan ``/arf`` kullanılmaktadır. ``/arf`` dosya sistemi, WEKA tabanlı yüksek performanslı paralel dosya sistemi olarak yapılandırılmıştır ve hem ev dizini (``/arf/home``) hem de geçici/scratch alanı (``/arf/scratch``) olarak hizmet vermektedir.

.. admonition:: Önemli Notlar
   :class: important

   - ARF ACC dosya sistemleri kalıcı veri depolama alanı olarak tasarlanmamıştır. Verilerinizin güvenliğinden kullanıcılar sorumludur.
   - Ev dizinlerinin yedeklemesi yapılmaz. Önemli verilerinizi düzenli olarak kendi bilgisayarınıza indiriniz.
   - Scratch alanı geçici dosyalar için kullanılmalı, uzun süreli veri saklanmamalıdır. Sistem tarafından periyodik olarak dosyalar silinebilir.
   - Kota ve dosya sayısı (inode) kısıtlamalarına dikkat ediniz.

**/truba Dosya Sistemi Erişimi**

- ARF ACC ortamında, ``/truba`` dosya sistemine erişim **sadece cuda-ui kullanıcı arayüzü** üzerinden mümkündür.
- Kolyoz ve palamut hesaplama sunucularında doğrudan ``/truba`` dosya sistemine erişim **bulunmamaktadır**.
- Hesaplama işlerinizi ve veri transferlerinizi planlarken bu erişim kısıtını göz önünde bulundurunuz.

**/arf Dosya Sistemi (WEKA Yüksek Performanslı Dosya Sistemi)**

- ``/arf`` dosya sistemi, WEKA tabanlı yüksek performanslı paralel dosya sistemi olarak yapılandırılmıştır.
- Tüm hesaplama sunucuları (kolyoz ve palamut dahil) ve kullanıcı arayüzleri tarafından erişilebilir durumdadır.
- Hesaplama sırasında yüksek I/O performansı ve veri güvenliği için tüm işlerinizde bu dosya sistemini kullanmanız önerilir.

.. |br| raw:: html

     <br>

**Dosya Sistemleri ve Kotalar**

.. list-table:: ARF ACC Dosya Sistemleri
   :widths: 15 20 20 25 20
   :header-rows: 1
   :align: center

   * - Dizin
     - Kullanım
     - Kota
     - Açıklama
     - Erişim
   * - /arf/home
     - Ev dizini
     - 100 GB |br| 100K dosya (inode)
     - Kalıcı ve önemli dosyalar, betikler, uygulama kurulumları
     - kolyoz |br| palamut |br| cuda-ui
   * - /arf/scratch
     - Scratch/geçici alan
     - 1 TB |br| 200K dosya (inode)
     - Hesaplama sırasında geçici dosyalar ve çıktıların tutulduğu hızlı alan. Dosyalar periyodik olarak silinir.
     - kolyoz |br| palamut |br| cuda-ui
   * - /truba
     - Merkezi dosya sistemi
     - 2TB  |br| 100K dosya (inode) 
     - Sadece cuda-ui arayüzünden erişilebilir. Hesaplama sunucularında erişim yoktur.
     - cuda-ui

**Kullanıcı Sorumlulukları ve İyi Uygulamalar**

- Ev dizinleri yalnızca sahibi tarafından erişilebilir. Erişim haklarınızı değiştirmemeye özen gösteriniz.
- Kullanılmayan veya gereksiz dosyaları düzenli olarak siliniz.
- Büyük veri setleri veya çok sayıda küçük dosya oluşturacak uygulamalar için merkezi kurulumları ve konteyner teknolojilerini tercih ediniz.
- Anaconda, Miniconda, pip gibi araçları merkezi depolama alanına kurmayınız. Küçük dosya sayısı limiti nedeniyle performans sorunları yaşanabilir.
- Scratch alanında uzun süreli veri saklamayınız, önemli verilerinizi kendi bilgisayarınıza indiriniz.

**Dosya Sayısı (inode) Kısıtlaması**

Her kullanıcıya ev ve scratch dizinlerinde belirli bir dosya (inode) limiti uygulanır. Bu limitin aşılması sistem performansını olumsuz etkiler.


**Merkezi Yazılım Dizinleri**

- Tüm ortak yazılımlar ``/arf/sw`` dizininde tutulur ve tüm kullanıcılara salt-okunur (read-only) erişim sağlanır.
- Yazılım kurulumlarında lisans haklarına uyulması zorunludur.

Daha fazla bilgi ve güncel depolama politikaları için sistem yöneticinizle iletişime geçebilirsiniz.

.. _truba-arf-gecisrehberi:

=================================================
TRUBA Kümesinden ARF Kümesine Geçiş Rehberi
=================================================


.. grid:: 3
   
    .. grid-item-card:: :ref:`kullanici-arayuzleri-sunucular`
        :text-align: center
    .. grid-item-card::  :ref:`dosya-sistemi`
        :text-align: center
    .. grid-item-card:: :ref:`yazilim-ve-kutuphaneler`
        :text-align: center
    .. grid-item-card:: :ref:`interaktif-is-calistirma`
        :text-align: center


.. _kullanici-arayuzleri-sunucular:

------------------------------------
Kullanıcı Arayüzleri ve Kuyruklar
------------------------------------

Aşağıdaki tabloda, ARF kümesinde yer alan kullanıcı arayüz sunucularının adresleri ve IP bilgileri ile bu sunuculara iş göndermek için kullanılacak kuyruklar ve sunucu türleri hakkında detaylı bilgiler yer almaktadır. Bu bilgiler, kullanıcıların hangi sunucuların ve kuyrukların işlerine uygun olduğunu belirlemelerine yardımcı olacaktır. Daha fazla detaya :ref:`hesaplama kümeleri <hesaplama-kumeleri>`  sayfasından erişilebilir.


.. list-table:: ARF kümesinin kullanıcı arayüz sunucuları
   :widths: 25 25
   :header-rows: 1
   :align: center

   * - Adres
     - IP (tür)

   * - arf-ui1.yonetim
     - 172.16.6.11  (ssh)
   * - arf-ui2.yonetim
     - 172.16.6.12  (ssh)
   * - arf-ui3.yonetim
     - 172.16.6.13  (ssh)
   * - arf-ui4.yonetim
     - 172.16.6.14  (ssh)
   * - arf-ui5.yonetim
     - 172.16.6.15  (ssh)
   * - openondemand.yonetim
     - 172.16.6.20 (web / görsel)

ARF kümesinde kuyrukların güncel durumuna ``sinfo`` komutu ile bakılabilmektedir. 

Örneğin;

.. code-block:: bash

    sinfo -p orfoz

Ayrıca kuyruk yapılandırması 

.. code-block:: bash

    scontrol show partition=kuyruk_ismi

komutu ile kontrol edilebilir.

.. list-table:: ARF kümesinde yer alacak kuyruklar ve sunucu türleri
   :widths: 20 20 20 20 20 20
   :header-rows: 1
   :align: center


   * - Kuyruk
     - Sunucu Türü
     - Çalışma süresi
     - Çekirdek/Bellek 
     - Sunucu Sayısı
     - İşletim Sistemi

   * - debug
     - orfoz
     - 4:00:00
     - 112 çekirdek/256 Gbyte
     - 100
     - RockyLinux-9.2

   * - orfoz
     - orfoz
     - 3-00:00:00
     - 112 çekirdek/256 Gbyte
     - 454
     - RockyLinux-9.2

   * - hamsi
     - hamsi
     - 3-00:00:00
     - 56 çekirdek/190 Gbyte
     - 144
     - RockyLinux-9.2

   * - barbun
     - barbun
     - 3-00:00:00
     - 40 çekirdek/375 Gbyte
     - 120
     - RockyLinux-9.2

   * - barbun-cuda
     - barbun-cuda
     - 3-00:00:00
     - 40 çekirdek/375 Gbyte
     - 24
     - RockyLinux-9.2

   * - akya-cuda
     - akya-cuda
     - 3-00:00:00
     - 40 çekirdek/375 Gbyte
     - 20
     - RockyLinux-9.2

.. _dosya-sistemi:

----------------
Dosya Sistemleri
----------------

Ev, İş ve Depoloama Dizinleri:
--------------------------------

ARF kümesinde, TRUBA kümesinden farklı olarak, ev dizini ve iş dizini olarak yüksek hızlı merkezi NVMe tabanlı bir dosya sistemi kullanılmaktadır. Kullanıcı ev dizinleri ve iş dizinleri bu yüksek hızlı NVMe dosya sisteminde yer almaktadır. Bu nedenle, ARF kümesindeki kullanıcı ev dizinlerinin ve iş dizinlerinin kotaları düşük tutulmuştur.

.. note::

  Kullanıcı Dizinleri:
    - Ev dizini: ``/arf/home/$USER``
    - İş dizini: ``/arf/scratch/$USER``
    - Depolama dizini: ``/truba/home/$USER``

.. warning::

  Kullanıcı Disk Kotası:
    - Ev dizinleri  (``/arf/home``) için 100 GB / 150bin dosya
    - İş dizinleri  (``/arf/scratch``) için 1 TB ancak maksimum dosya ömrü 1 aydır. 	

Ev dizinleri, kullanıcıların kullanacakları uygulamaları kurmaları ve kullanıcı ayar dosyaları, betik dosyaları vb. dosyaların saklanması içindir. Bu dizinlerde kısa süreli düşük hacimli işler çalıştırılabilir, ancak üretim amaçlı tüm işler kesinlikle ``/arf/scratch`` altındaki dizinlerde çalıştırılmalıdır.

``/arf/scratch`` altında çalıştırılan işlerin sonuçları ivedilikle kontrol edilmeli, saklanması gerekmeyen dosyalar sistemden silinmeli, saklanması gerekenler kullanıcının kendi kişisel bilgisayarına indirilmelidir. Bazı dosyaların sonraki hesaplar için tekrar kullanılması gerekiyorsa ilgili dosyalar ``/arf/home/$USER`` dizinine taşınabilir ya da ``/arf/scratch`` altında bırakılabilirler. Ancak ``/arf/scratch`` dizinlerindeki dosyaların ömrünün en fazla 1 ay olduğu unutulmamalıdır.

``/truba/home/$USER`` ve ``/truba/scratch/$USER`` dizinleri altındaki dosyalar ivedilikle temizlenmeli, ihtiyaç bulunmayan dosyalar silinmeli, saklanması gereken dosyalar kullanıcının kendi ev bilgisayarına indirilmelidir. ARF hesaplama kümesinde hesaplar sırasında kullanılacak veriler ``/arf/home/$USER`` ve ``/arf/scratch/$USER`` dizinlerine kopyalanabilir. Bu temizlik ve kopyalama işlemi ARF kümesinin kullanıcı arayüzü olan ``arf-ui`` sunucularında gerçekleştirilebilir.

.. note::

  **Önemli Notlar:**
    - ``/truba/home/username`` dizini altındaki tüm dosyaların taşınmasına gerek yoktur. Lütfen sadece ihtiyacınız olan dosyaları taşıyınız. 
    - ``/truba/scratch/username`` dizini artık kullanılmamalıdır. Buradaki önemli veriler kullanıcının kendi bilgisayarına indirilmelidir. Eğer daha sonra ARF kümesindeki sunucularda yapılacak hesaplamalarda kullanılması gereken veriler varsa, bu tür veriler eğer kota yetiyorsa ``/arf/home/username`` dizinine eğer kota yetmiyorsa ``/truba/home/username`` dizinine taşınmalı ve ``/truba/scratch/username``  boşaltılmalıdır. 
    - TRUBA ve ARF kümelerindeki dosya sistemlerinden hiç biri kalıcı bir depolama alanı değildir. Buradaki verilerin yedekleri alınmamaktadır. Verilerin yedeklenmesinden kullanıcıların kendileri sorumludur. Saklanması gereken her türlü veri kullanıcının kendi bilgisayarına indirilmelidir. TRUBA ve ARF'ta sadece daha sonraki hesaplar için ihtiyaç olunan veriler saklanmalıdır.


.. _yazilim-ve-kutuphaneler:

------------------------
Yazılım ve Kütüphaneler
------------------------

ARF kümesinde merkezi olarak kurulu yazılımlar, kütüphaneler ve örnek betikleri bulunduğu dizinler aşağıdaki tabloda listelenmiştir. Kullanıcılar bu merkezi kurulumları modül dosyaları yardımı ile kullanabilirler.

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


ARF kümesindeki sunucular ``RockyLinux 9.2`` işletim sistemi kullanmaktadır. Bu nedenle, TRUBA'da ``barbun`` (``CentOS 7.3``), ``hamsi`` (``CentOS 7.9``) ve ``akya`` (``CentOS 7.3``) sunucuları için derlenmiş uygulamaların çoğu ARF'da ya çalışmayacak ya da düşük performans gösterecektir. Kullanıcılar, ARF'ta merkezi olarak kurulu uygulamaları kullanmalı veya kendi uygulamalarını kullanmak istiyorlarsa, bu uygulamaları güncel derleyici ve kütüphanelerle yeniden derleyip ``/arf/home/$USER`` dizinine yüklemelidirler.

Hem dosya sistemi yapısının ve yollarının değişmiş olması hem işletim sisteminin değişmiş olması nedeni ile TRUBA'da hali hazırda kullanılmakta olan betik dosyaları ARF'da çalışmayacaktır. Örnek betik dosyaları ``/arf/sw/scripts`` altında bulunmaktadır.

.. note::

  Önemli Notlar:
  
  - Ev dizinlerine kesinlikle conda, miniconda, anaconda veya PIP benzeri paket yöneticileri ile uygulama/kütüphane kurulmamalıdır. Bu tür ortamlara ihtiyaç duyulması halinde merkezi conda ve python kurulumları kullanılabilir. Eğer özel bir kuruluma ihtiyaç varsa, bu kurulum konteynerlar içine yapılmalıdır. Konteyner kurulumu hakkında detaylı bilgiye :ref:`Konteyner Kullanımı <Apptainer>` sayfasından ulaşılabilir.

  - Pek çok uygulama ve kütüphane ARF kümesinde hali hazırda kuruludur. Kullanıcılar bu merkezi kurulumları modül dosyaları yardımı ile kullanabilirler. 

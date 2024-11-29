.. _truba-arf-gecisrehberi:

=================================================
TRUBA Kümesinden ARF Kümesine Geçiş Rehberi
=================================================


Barbun1/Levrek1 üzerinden erişilip kullanılmakta olan barbun, hamsi, barbun-cuda akya-cuda sunucuları 1 Aralık itibari ile güncellenerek ARF kümesinde hizmet vermeye başlayacaklardır. Bu geçiş  daha sorunsuz olması için aşağıdaki rehberi takip edebilirsiniz.

.. list-table:: ARF kümesinin kullanıcı arayüz sunucuları

   :widths: 25 25
   :header-rows: 1

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
     - 172.16.6.20 (web) / görsel 


.. list-table:: ARF kümesinde yer alacak kuyruklar ve sunucu türleri
   :widths: 25 25 25 25 25
   :header-rows: 1

   * - Kuyruk
     - Sunucu Türü
     - Çalışma süresi
     - Çekirdek/Bellek 
     - Sunucu Sayısı
     - İşletim Sistemi

   * - Debug
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
     - 56 çekirdek/256 Gbyte
     - 144
     - RockyLinux-9.2

   * - barbun
     - barbun
     - 3-00:00:00
     - 40 çekirdek/256 Gbyte
     - 120
     - RockyLinux-9.2

   * - barbun-cuda
     - barbun-cuda
     - 3-00:00:00
     - 40 çekirdek/256 Gbyte
     - 24
     - RockyLinux-9.2

   * - akya-cuda
     - akya-cuda
     - 3-00:00:00
     - 40 çekirdek/256 Gbyte
     - 20
     - RockyLinux-9.2

----------------
Dosya Sistemleri
----------------

Ev dizinleri:
Ev dizini: /arf/home/$USER
İş dizini: /arf/scratch/$USER

Depolama Dizinleri: 
/truba/home/$USER

TRUBA kümesinden farklı olarak ARF kümesinde  ev dizini ve iş çalıştırma dizini olarak yüksek hızlı merkezi Nvme tabanlı bir dosya sistemi kullanılmaktadır.  Kullanıcı ev dizinleri ve iş dizinleri bu büksek hızlı NVME dosya sisteminde yer almaktadır.  Bu nedenle ARF kümesindeki kullanıcı ev dizinlerinin ve iş dizinlerinin kotaları düşük tutulmuştur. 

.. warning::

    Kullanıcı Disk Kotası:

    Ev dizinleri  (/arf/home) için 100TB / 150bin dosya
    İş dizinleri  (/arf/scratch) için 1TB ancak maksimum dosya ömrü 1 aydır. 	

Ev dizinleri  kullanıcıların kullanacakları uygulamaları kurmaları ve kullanıcı ayar dosyaları, betik dosyaları vs dosyaların saklanması içindir. Bu dizinlerde kısa süreli düşük hacimli işler çalıştırılabilir, ancak production amaçlı tüm işler kesinlikle /arf/scratch altındaki dizinlerde çalıştırılmalıdır.

/arf/scratch altında çalıştırılan işerin sonuçları ivedilikle  kontrol edilmeli, saklanması gerekmeyen dosyalar sistemden silinmeli, saklanması gerekenler kullanıcının kendi kişisel bilgisayarına indirilmelidir. Bazı dosyaların sonraki hesaplar için tekrar kullanılması gerekiyorsa  ilgili dosyalar /arf/home/$USER dizinine taşınabilir, yada scrach altında bırakılabilirler. Ancak scratch dizinlerindeki dosyaların ömrünün en fazla 1 ay olduğu unutulmamalıdır.

/truba/home/$USER ve /truba/scratch/$USER dizinleri altındaki dosyalar ivedilikle temizlenmeli, ihtiyaç bulunmayan dosyalar silinmeli, saklanması gereken dosyalar kullanıcın kendi ev  bilgisayarına indirilmelidir.  ARF kümesinde hesaplar sırasında kullanılacak  veriler  /arf/home/$USER ve /arf/scratch/$USER dizinlerine kopyalanabilir.   Bu  temizlik ve kopyalama işlemi ARF kümesinin kullanıcı arayüzü olan arf-ui  sunucularında gerçekleştirilebilir. 

.. note::

    Önemli Not: /truba/home ve /truba/scratch'deki tüm dosyaların taşınamasına gerek yoktur. Lütfen sadece ihtiyacınız olan dosyaları taşıyınız. 

.. note::

    Önemli Not:  TRUBA ve ARF kümelerindeki dosya sistemlerinden hiç biri kalıcı bir depolama alanı degildir.  Buradaki verilerin yedekleri alınmamaktadır. Verilerin yedeklenmesinden kullanıcıların kendileri sorumludur. Saklanması gereken her türlü veri kullanıcın kendi bilgisayarına indirilmelidir. TRUBA ve ARF'ta sadece daha sonraki hesaplar için ihtiyaç olunan veriler saklanmalıdır.


.. note::

    Yazılım:

.. list-table:: Merkezi yazılım dizinleri
   :widths: 25 25
   :header-rows: 1

   * - Uygulama
     - /arf/sw/apps

   * - Kütüphane
     - /arf/sw/lib

   * - Konteynır
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


ARF kümesindeki sunucuların işletim sistemleri RockyLinux 9.2'dir. Bu nedenle daha önce TRUBA 'da barbun (Centos7.3), hamsi (Centos7.9)  ve akya (Centos7.3) sunucuları için hali hazırda derlenmiş pek çok uygulama ya çalışmayacaktır ya da çok  düşük performansta çalışacaktır. Kullanıcılar bu nedenle ARF'da hali hazırda kurulu uygulamaları kullanmalı, eğer kendi uygulamalarını kullanmak isyorlarsa, uygulamalarını güncel derleyici ve kütüphanelerle yeniden derlemeli ve  /arf/home/$USER dizinine yüklemelidirler.

Hem dosya sistemi yapısının ve yollarının değişmiş olması hem işletim sisteminin değişmiş olması nedeni ile TRUBA'da hali hazırda kullanılmakta olan betik dosyaları ARF'da çalışmayacaktır. Örnek betik dosyaları /arf/sw/scripts altında bulunmaktadır.

.. note::

    Önemli Not: Ev dizinlerine kesinlikle conda, miniconda, anaconda ayada PIP benzeri paket yöneticileri ile uygulama/kütüphane kurulmamalıdır.  Bu ortamlara ihtiyaç duyulması halinde merkezi conda ve python kurulumları kullanılabilir, eğer özel bir kuruluma ihtiyaç varsa, bu kurulum konteynırlar içine yapılabilir. Konteynır kurulumu hakkında detaylı bilgiye docs.truba.gov.tr sayfasından ulaşılabilir.

.. note::

    Önemli Not:  Pek çok uygulama ve kütüphane ARF kümesinde hali hazırda kuruludur. Kullanıcılar bu merkezi kurulumları modül dosyaları yardımı ile kullanabilirler. 

ARF kümesinde kuyrukların güncel durumuna ``sinfo`` komutu ile bakılabilmektedir. Ayrıca kurul yapılandırması scontrol show partition=kuyruk_ismi komutu ile kontrol edilebilir.

----------------
İş Çalıştırma
----------------

.. warning::

    Kullanıcılar derleme ya da benzeri yük getiren işlerini kesinlikle ``arf-ui`` sunucuları üzerinde gerçekleştirmemelidirler. Bu tür işler için debug kuyruğundan srun ile interaktif kaynak talep edilmeli ve işlemler hesap sunucularında gerçekleştirilmelidir.  Ayrıca openondemand üzerinden Linux Desktop alınarak kısa süreli görsel ve interaktif işlerin gerçekleştirilmesi mümkündür.

Orfoz ve hamsi kuyruklarında çalışmakta olan  suncularında, cihazların sahip olduğu yüksek çekirdek sayıları nedeni ile yartmış oldukları yüksek I/O ihtiyacını yönetebilmek için her  orfoz ve hamsi sunucusunda 2 adet çekirdek I/O yönetimi için ayrılmıştır. Bu nedenle orfoz suncularında kullanılabilir çekirdek sayısı 110, hamsi sunucularında kullanılabilir çekirdek sayısı 54'dür.  Orfoz kuyruğuna gönderilen işlerde sunucu başına en fazla 110 çekirdek hamsi 54 çekirdek talep edilebilir. Bu kuyruklara gönderilen işlerde ``#SBATCH -C weka`` parametresinin kullanılması gerekmektedir.

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p orfoz
    ##SBATCH -A kullanici_adi
    #SBATCH -J jobname
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 110
    #SBATCH -C weka
    #SBATCH --time=3-00:00:00


Ya da 

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p hamsi
    #SBATCH -A kullanici_adi
    #SBATCH -J jobname
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 54
    #SBATCH -C weka
    #SBATCH --time=3-00:00:00


İnteraktif iş çalıştırmak için debug kuyruğundan kaynak talep edilmelidir.

.. code-block:: bash

    srun  -p debug -N 1 -n 1  -c 112  -A kullanici_adi -J test --time=0:00:00 --pty /usr/bin/bash -i 







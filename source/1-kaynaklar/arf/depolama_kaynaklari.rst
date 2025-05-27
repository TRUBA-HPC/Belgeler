.. _arf-depolama-kaynaklari:

====================================
Dosya Sistemleri
====================================

Hesaplama kümelerindeki sunucuların üzerinde bulunan yerel disklerden bağımsız olarak, sunucular kullanıcı verilerinin saklanması ve kullanıcı işlerinin çalıştırılması amacı ile *paylaştırılmış merkezi dosya sistemlerini* kullanırlar. Merkezi dosya sistemleri yüksek başarımlı LUSTRE paralel dosya sistemi kullanarak yapılandırılmıştır. Hesaplama kümelerinde farklı tipte ve özelliklerde yüksek performanslı dosya sistemleri kullanılmaktadır.
Bu kılavuz dosya sistemleri hakkında aşağıdaki başlıkları kapsamaktadır:

.. grid:: 3
   
    .. grid-item-card:: :ref:`dosya-sistemleri-onemli-notlar`
        :text-align: center   
    .. grid-item-card::  :ref:`arf-dosya-sistemi`
        :text-align: center
    .. grid-item-card:: :ref:`truba-dosya-sistemi`
        :text-align: center
    .. grid-item-card:: :ref:`sunucu-kuyruklar`
        :text-align: center  
    .. grid-item-card:: :ref:`dosya-sayisi`
        :text-align: center




.. _dosya-sistemleri-onemli-notlar:

-------------
Önemli Notlar
-------------

Öncelikle aşağıdaki uyarıyı vurgulamak isteriz.

.. warning:: 

    *Yüksek başarımlı hesaplama merkezimizde bulunan dosya sistemleri kesinlikle kalıcı bir dosya depolama alanı olarak düşünülmemelidir. Dosya sistemindeki verilerin güvenliğinden kullanıcının kendisi sorumludur.*

.. * Kullanım amacına göre dosya sistemleri farklı boyutlarda, ve farklı özellikteki donanımlarla hazırlanırlar. Örneğin, kullanıcı ev dizinleri(`../home/`) performans dosya sistemine(`../scratch/`) göre boyut olarak daha büyük olmasına rağmen, hız bakımından performans dosya sistemi daha başarılıdır. 

* Kullanıcı ev dizinleri ve merkezimiz tarafından sağlanan yazılımların (derleyici, uygulama ve kütüphaneler) kaydedildiği alan için “kullanıcı ev dizini” terimi kullanılmaktadır. Kullanıcı ev dizinleri için iki farklı dosya sistemi kullanılmaktadır. Kullanıcı dizinleri `../home`  dosya sistemi altında bulunmakla birlikte işlerini çalıştırırken yüksek performanslı dosya sistemi `../scratch` dosya sistemi altında bulunmaktadır. 

* `/truba` ve `/arf` dosya sistemlerinde kullanıcılar için kota uygulaması söz konusudur. Tüm kullanıcıların disk kotaları eşit olarak ayarlanmıştır. ARDEB vasıtası ile hesap açılan ve projeleri kapsamında işlerini çalıştıran kullanıcılar için, standart kota miktarından farklı olarak, projelerinde öngörülen disk kotası miktarı uygulanmaktadır. Detayları aşağıdaki tablolardan erişebilirisiniz.

* Kullanıcı ev dizinlerinin yedekleri alınmamaktadır. Bu nedenle buradaki kullanıcı verilerinin düzenli olarak kullanıcılar tarafından kendi kişisel bilgisayarlarına aktarılması, önemsiz verilerin ise yine kullanıcının kendisi tarafından silinmesi beklenmektedir. **Kullanıcı ev dizinleri kesinlikle uzun vadeli bir depolama alanı olarak düşünülmemelidir.**

* Kullanıcı ev dizinleri standart olarak sadece dizinin sahibi tarafından erişilebilecek şekilde oluşturulurlar. Ancak zamanla kullanıcılar dizin erişim haklarını bilerek ya da bilmeyerek değiştirebilirler. Kullanıcı ev dizinlerindeki verinin güvenliğinden yine kullanıcın kendisi sorumludur. 

* Kümelerde kullanılan ortak yazılımlar `/truba/sw` ve `/arf/sw` dizininde tutulurlar. Bu dizine tüm kullanıcıların read-only erişimleri vardır. Bu dizindeki yazılımlar genel olarak ücretsiz lisanslı yazılımlardır ve tüm TRUBA kullanıcılarının *yazılımın lisans haklarına uyulması şartı ile* kullanımına açıktır. 

.. * Tüm hesaplama kümelerinde hesaplama performans alanı okarak ``/truba_scratch`` dosya sistemi kullanılmaktadır. Kullanıcıların işlerini bu dosya sisteminde çalıştırması amaçlanmıştır. Bu dosya sistemindeki dosyalar da düzenli olarak kullanıcı tarafından silinmelidir. Dosya sisteminde, 30 gün boyunca hiç erişilmemiş dosyalar düzenli olarak sistem yöneticisi tarafından silinebilmektedir. 

.. Kullanıcı dizinleri hesaplama sunucuları tarafında read-only erişilebilir durumdadır. Kulanıcılar hesaplamaları sırasında bu dizinlerden verilerini okuyabilirlerken, bu dizinlere herhangi bir çıktı yazamazlar. Bu nedenle işler ev dizinlerinde değil performans alanında (/truba_scratch) çalıştırılmalıdır. 


.. _arf-dosya-sistemi:

----------------------------------
ARF Dosya Sistemi
----------------------------------

ARF hesaplama kümesi için `/arf/home`, `/arf/scratch` ve `/truba/home` dosya sistemleri hakkında detaylı içerik tablo içerisinde belirtilmiştir. Bu dosya sistemlerine bağlı bulunan suncular üzerinden iş gönderilebilir. İşler çalışırken sadece beliritlen dosya sistemlerine erişimi mevcuttur. 

.. |br| raw:: html

     <br>

.. list-table:: ARF Hesaplama Kümeleri Dosya Sistemleri 
   :widths: 10 15 25 25 25 25
   :header-rows: 1
   :align: center

   * - Dizin adı
     - Kullanım
     - Kotası
     - İşlevi
     - Açıklama
     - Bağlı bulunduğu sunucular

   * - `/arf/home`
     - Ev dizini
     - Bellek: 100GB  |br| Dosya Sayısı: 100K(inode) 
     - Araştırmacının önemli gördüğü, |br| kalıcı dosyalarının bulunacağı |br| hızlı ana dizin.
     - Uygulama kurulumları, |br| Betik dosyaları, |br| İşlerin girdi dosyaları  |br| Yeniden kullanılabilir, |br| Küçük boyutlu çıktı dosyalarının bulunacağı dizindir. |br| Herhangi bir kota arttırımı söz konusu değildir.  |br| Proje kotaları ayrıca belirlenmektedir.
     - arf-ui1(2,3,4,5)|br| OpenOndemand |br| orfoz |br| cuda-ui |br| kolyoz

   * - `/arf/scratch`
     - Scratch dizini
     - Bellek: 1TB  |br| Dosya Sayısı: 200K(inode) 
     - Araştırmacının işlerini, |br| çalıştırmak için kullanacağı |br| hızlı ana dizin
     - Çalışan işler için kullanılacak dizin, |br| Çalışan işin geçici dosyalarının kullanabileceği dizin, |br| Çalışan işlerin çıktı dosyalarının depolanabileceği dizindir. |br| Bu dizin içerisinde uzun süreli veri depolaması gerçekleştirilemez. |br| Dosyalar periyodik olarak sistem tarafından otomatik silinecektir. |br| Herhangi bir kota arttırımı ve süre uzatımı söz konusu değildir. |br| Proje kotaları ayrıca belirlenmektedir.
     - arf-ui1(2,3,4,5)  |br| arf-ui2 |br| OpenOndemand |br| orfoz |br| cuda-ui |br| kolyoz

   * - `/truba/home`
     - Depolama
     - Bellek: 2TB  |br| Dosya Sayısı: 100K(inode) 
     - Araştırmacının verilerini |br| geçici olarak depolayacağı dizin
     - `/arf/scratch` dizini |br| otomatik olarak temizleneceği için; |br| girdi ve çıktı dosyalarının |br| proje süresi boyunca depolanabileceği ev dizinidir.
     - arf-ui1(2,3,4,5)  |br| arf-ui2 |br| OpenOndemand |br| orfoz |br| cuda-ui |br| kolyoz

.. _truba-dosya-sistemi:

----------------------
TRUBA Dosya Sistemi
----------------------

TRUBA hesaplama kümesi için `/truba/home`  dosya sistemi hakkında detaylı içerik tablo içerisinde belirtilmiştir. Bu dosya sistemlerine bağlı bulunan suncular üzerinden iş gönderilebilir.  


.. note:: 
  
  Barbun, hamsi, barbun-cuda, akya-cuda, palamut-cuda kümelerinin işletim sistemleri başarıyla güncellenmiş ve bu sunucular ARF kümesine dahil edilmiştir. Güncelleme sonrasında tüm sunucular için ev dizini /arf/home, scratch dizini /arf/scratch ve depolama dizini /truba/home olarak belirlenmiştir. Ayrıca, /truba/scratch dizini kullanımdan kaldırılmıştır.
.. list-table:: TRUBA Hesaplama Kümeleri Dosya Sistemleri 
   :widths: 10 15 25 25 25 25
   :header-rows: 1
   :align: center

   * - Dizin adı
     - Kullanım
     - Kotası
     - İşlevi
     - Açıklama
     - Bağlı bulunduğu sunucular

   * - `/truba/home`
     - Ev dizini
     - Bellek: 2TB  |br| Dosya Sayısı: 100K(inode) 
     - Araştırmacının verilerini |br| geçici olarak depolayacağı dizin.
     - `/truba/scratch` dizini |br| otomatik olarak temizleneceği için; |br| girdi ve çıktı dosyalarının |br| proje süresi boyunca depolanabileceği ev dizinidir.
     - arf-ui(1,2,3,4,5) |br| OpenOndemand |br|



.. _sunucu-kuyruklar:

---------------------------------
Sunucular ve Kullanıcı Arayüzleri
---------------------------------


.. list-table:: ARF ACC Sistemi
   :widths: 10 15 25 25 25 25
   :header-rows: 1
   :align: center

   * - Sunucu Türü
     - Ev Dizini
     - Scratch
     - Depolama
     - Yerel
     - Kullanıcı Arayüzü

   * - kolyoz
     - `/arf/home`
     - `/arf/scratch`
     - `/truba/home`
     - `/tmp` - 6TB
     - cuda-ui |br| OpenOndemand

.. list-table:: ARF Sistemi
   :widths: 10 15 25 25 25 25
   :header-rows: 1
   :align: center

   * - Sunucu Türü
     - Ev Dizini
     - Scratch
     - Depolama
     - Yerel
     - Kullanıcı Arayüzü

   * - orfoz
     - `/arf/home`
     - `/arf/scratch`
     - `/truba/home`
     - `/tmp` - 800GB
     - arf-ui1  |br| arf-ui2  |br| arf-ui3  |br| arf-ui4  |br| arf-ui5 |br| OpenOndemand 

.. note:: 

  /truba/home dizininizde yer alan çalışma dosyalarınıza ARF kullanıcı arayüz sunucuları üzerinden doğrudan erişim sağlayabilirsiniz.


.. _dosya-sayisi:

--------------------
Dosya Sayısı (inode)
--------------------

Kullanıcının ev dizinlerinin (`../home/$USER` ve `../scratch/$USER`) boyutundan bağımsız olarak kullanıcı dizinlerindeki dosya sayısı da Dosya Sistemi'nde aşırı yük yaratmaktadır. Özellikle kurulum dosyalarının (source code) kurulumdan sonra silinmemesi, ya da anaconda gibi uygulamaların merkezi versiyonu yerine kullanıcı ev dizinlerine kurulması dosya sisteminin aşırı dolmasına ve sistem performansının düşmesine neden olmaktadır. Bu sorunlardan dolayı 1 Mayıs 2022 tarihinden itibaren dosya sayısı kotası (inode) uygulanmaya başlanmıştır. Kullanıcılar 

.. code-block::

  lfs quota -gh $USER /truba

komutu ile kullandığı dosya sayısını(inode) öğrenebilir. Ayrıca terminalden ``arf-ui`` kullanıcı arayüzüne bağlantı sağladıktan sonra login ekranına dökülen kota bilgilerine ``dosya kotası`` da % olarak eklenmiştir. Bu değerin %100'un altında olması gerekmektedir.

.. _inode-cozum-tavsiyeleri:

---------------------------------
Dosya Sayısı için çözüm önerileri
---------------------------------

.. note:: 

  Kullanıcılarımızdan 

    * kullandıkları uygulamaların merkezi versiyonu varsa (module vb.) merkezi versiyonlarını kullanmalarını
    * merkezi kurulumda olmayan uygulamaların konteyner teknolojilerinden faydalanarak tek bir imaj dosyası ile konteyner oluşturmaları(bkz. :ref:`konteyner kullanımı <Apptainer>`),
    * merkezi versiyonu olmayan ve konteyneri bulunmayan uygulamaların kendi ev dizinlerine kurulması gerekiyorsa, kurulum sonrasında kaynak dosyaları silmelerini
    * yapay zeka veya diğer alanlarda sıklıkla kullanılan ilgili veri setleri herhangi bir lisans sözleşmesi gerektirmeden doğrudan sayfa üzerinden açık olarak paylaşılan bir veri seti ise kullanıcı ev dizinleri yerine ``grid-teknik@ulakbim.gov.tr`` ile iletişime geçerek merkezi veri setleri dizine oluşturulması için bildirilmesi,
    * `/arf` ve `/truba` depolama sistemlerine anaconda, miniconda, conda  veya herhagi bir Python kütüphanesi kesinlikle yüklenmemelidir, pip ve türevleri kullanılmamalıdır. Küçük boyutlu yüzbinlerce dosyadan oluştuğu için, her kullanıcının kendi ev dizinine kurduğu bu tip kütüphaneler dosya sistemlerinin performanslarını büyük ölçüde düşürmekte ve çalışan işlerin yavaşlamasına neden olduğundan özellikle ``Anaconda`` kullanıcılarının merkezi Anaconda kurulumunu kullanmaları ve
    * ihtiyaç duymadıkları her türlü dosyayı silmelerini
    * saklanması gereken dosyaları kendi bilgisayarlarına indirmelerini
    * sadece kısa zaman icinde kullanacakları dosyaları sistemde tutmalarını
    * herhangi bir sebepten silemedikleri dosya ve dizinleri -tar komutu ile arşivleyerek tek bir dosya haline getirmeleri ve mümkünse ilgili arşiv dosyalarını kendi bilgisayarlarına indirmelerini 

  önemle rica etmekteyiz.

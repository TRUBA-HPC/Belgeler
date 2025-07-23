.. _open_ondemand:

Open OnDemand Arayüzü
=====================

Open OnDemand **web tabanlı** bir kullanıcı arayüzü servisidir. Bu arayüz, terminal tabanlı klasik kullanıcı arayüzü sunucusunun sağladığı tüm imkanlara ek olarak kullanıcılara pek çok ek özellik sunmaktadır. Open OnDemand ile ilgili ayrıntılı bilgilere `Open OnDemand web sayfasından <https://osc.github.io/ood-documentation/latest/>`_ ulaşabilirsiniz. 

.. note::

    Open OnDemand kullanıcılar için pek çok operasyonu kolaylaştırmasına ve pek çok yeni özellik sağlamasına rağmen doğru ve verimli bir şekilde kullanabilmek için tüm kullanıcıların temel linux kullanım bilgisine sahip olması şarttır. Ayrıca Open OnDemand'i kullanabilmek için kullanıcıların daha önce TRUBA kullanım deneyimlerinin olması ve burada bahsedilen kavramları biliyor olmaları gerekmektedir.

Erişim
~~~~~~~~

TRUBA'da hizmet veren Open OnDemand servisine erişim adresi ve güncel bağlantı bilgilerine :ref:`ARF bağlantı bilgileri <arf_baglanti>` sayfasından erişebilirsiniz. Bu servise sadece OpenVPN üzerinden sisteme bağlı kullanıcılar erişebilmektedir. 

.. note::

    * TRUBA VPN ile ilgili bilgilere ulaşmak için :ref:`open-vpn` sayfasını inceleyebilirsiniz.
    * Doğrudan ULAKNET altyapısından internete bağlı kullanıcılar için doğrudan bir erişim adresi bulunmamaktadır. Bu kullanıcılar da OpenVPN bağlantılarını gerçekleştirerek Open OnDemand servisine erişmelilerdir.

Web arayüz sunucusuna bağlantı için kullanıcı adı ve parolanın girilmesi gerekmektedir.

- Kullanıcı Adı: ``truba-kullanıcı-adınız``
- Şifre: ``truba-hesap-şifreniz``



.. _grafik-ekran:

Uygulamalar
~~~~~~~~~~~~~

Kullanıcı adı ve şifre bilginizi girdikten sonra Open OnDemand ana sayfasından "My Interactive Sessions" menüsü altında aşağıdaki uygulamaları görüntüleyebilirsiniz:

- **Desktop**: Grafik arayüz gerektiren uygulamalar için interaktif masaüstü ortamı
- **Jupyter Araçları**: Jupyter Notebook ve JupyterLab ortamları
- **Gnuplot**: Grafik çizim uygulaması
- **GaussView**: Moleküler modelleme ve görselleştirme yazılımı

Uygulama Seçimi ve Kaynak Tahsisi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Uygulama Seçimi**: İhtiyacınız olan uygulamayı listeden seçiniz.

2. **Kaynak Parametreleri**: Seçilen uygulama için aşağıdaki kaynak parametrelerini belirleyiniz:
   
   - **Account**: Hesap bilgisi (örn: kullaniciadi,projeadi)
   - **Partition**: İş kuyruğu seçimi (örn: orfoz, barbun, hamsi)
   - **Time Limit**: Talep edilen süre (saat:dakika:saniye)

3. **Kaynak Talebi**: "Launch" butonuna tıklayarak interaktif oturum için kaynak talebinde bulununuz.

4. **Oturum Başlatma**: Sistem kaynakları tahsis ettikten sonra oturum otomatik olarak başlatılacaktır. Uygulamayı başlatabilirsiniz.

.. note::

   Grafik ekran gerektiren uygulamaları çalıştırmak için ``Desktop`` uygulamasını seçmeniz önerilir. Bu yöntem, girdi dosyalarını görsel araçlarla hazırlamak veya iş çıktılarını doğrudan sunucu üzerinde görüntülemek isteyen kullanıcılar için idealdir. Gerekli yazılımları kendi ev dizininize (``/arf/home/kullaniciadi``) kurmanız gerekmektedir.

.. _sshXforward:

ssh X-forwarding
-----------------

Arayüz sunucularına grafik ekran bağlantısı gerçekleştirerek (X-forwarding) görsel uygulamalar çalıştırmak mümkündür. 

Sunucu üzerindeki görsel öğeyi kullanıcının kendi bilgisayarına aktarabilmesi için:

* SSH bağlantısı sırasında X-forwarding seçeneği aktif hale getirilmeli
* Lokal bilgisayarda bir X-server uygulaması doğru biçimde kurulmuş ve çalışıyor durumda olmalı:
  
  * MacOS için `XQuartz <https://www.xquartz.org/>`_
  * Windows için `Putty <https://www.putty.org/>`_ ya da `MobaXTerm <https://mobaxterm.mobatek.net/>`_
  * Linux kullanıcılarında Xorg yüklü olarak gelmektedir, yeni bir yazılım yüklenmesine gerek yoktur

* Lokal bilgisayardaki güvenlik duvarı ve benzeri yazılımların ayarları doğru şekilde yapılmalıdır

Windows sistemlerde sık kullanılan SSH istemcilerinden biri PuTTy'dir. PuTTy'de X-forwarding seçeneği ``Connection > SSH > X11`` altındadır. Diğer uygulamalarda bu seçeneğin nerede olduğuna dair uygulamanın yardım dökümanları kontrol edilmelidir.

Terminal üzerinden kullanıcı arayüz sunucularına bağlantı sağlarken ssh komutuna -XY parametresinin eklenmesi yeterlidir:

.. code-block::

    ssh -l <kullanici_adi> <arayüz_ip_adresi> -XY

Bağlantı gerçekleştiğinde xclock komutu ile test yapılabilir:

.. code-block::

    xclock

.. image:: /assets/grafik_ekran/xclock-arf.png
  :width: 400
  :alt: Alternative text



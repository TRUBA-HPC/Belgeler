.. _open_ondemand:

========================
Open OnDemand Arayüzü
========================


Open OnDemand **web tabanlı** bir kullanıcı arayüzü servisidir. Bu arayüz, terminal tabanlı klasik kullanıcı arayüzü sunucusunun sağladığı tüm imkanlara ek olarak kullanıcılara pek çok ek özellik sunmaktadır. Open OnDemand ile ilgili ayrıntılı bilgilere `Open OnDemand web sayfasından <https://osc.github.io/ood-documentation/latest/>`_ ulaşabilirsiniz. 

.. note::

    Open OnDemand kullanıcılar için pek çok operasyonu kolaylaştırmasına ve pek çok yeni özellik sağlamasına rağmen doğru ve verimli bir şekilde kullanabilmek için tüm kullanıcıların temel linux kullanım bilgisine sahip olması şarttır. Ayrıca Open OnDemand'i kullanabilmek için kullanıcıların daha önce TRUBA kullanım deneyimlerinin olması ve burada bahsedilen kavramları biliyor olmaları gerekmektedir.

Open OnDemand Erişim
========================

TRUBA'da hizmet veren Open OnDemand servisine https://172.16.6.20 adresinden ulaşılabilmektedir. İnteraktif arayüz ile ilgili güncel bağlantı bilgilerine :ref:`arf-baglanti` sayfasından erişebilirsiniz. Bu servise şimdilik sadece OpenVPN üzerinden sisteme bağlı kullanıcılar erişebilmektedir. 

.. note::

    Doğrudan ULAKNET altyapısından internete bağlı kullanıcılar için doğrudan bir erişim adresi bulunmamaktadır. Bu kullanıcılar da OpenVPN bağlantılarını gerçekleştirerek Open OnDemand servisine erişmelilerdir.



Web arayüz sunucusuna bağlantı için kullanılan kullanıcı adı ve parolanın girilmesi gerekmektedir.


.. _grafik-ekran:

===========================
Grafik Ekran Bağlantısı 
===========================

TRUBA’da hizmet veren Open OnDemand kullanıcı arayüzü servisi üzerinden ``Desktop`` talep ederek grafik ekran gerektiren uygulamaları çalıştırabilirsiniz. Girdi (input) dosyalarını aracı programlarla hazırlayan ya da işin çıktısını lokal bilgisayarına aktarmadan doğrudan sunucu üzerinde görmek isteyen kullanıcılar bu yöntemi tercih edebilirler. İlgili aracı programları kullanıcıların kendi ev diiznlerine kurmaları gerekmektedir (``/arf/home/kullaniciadi``)

Open OnDemand servisini kullanmak için TRUBA VPN bağlantısının başarılı bir şekilde sağlanmış olması gerekmektedir. 

* TRUBA VPN ile ilgili bilgilere ulaşmak için :ref:`open-vpn` sayfasını inceleyebilirsiniz.


Open OnDemand Desktop
======================

ARF kümesi Open OnDemand servisine internet tarayıcınızı kullanarak http://172.16.6.20 adresinden ulaşabilirsiniz. Karşınıza gelen ekranda TRUBA kullanıcı adı ve şifre bilginizi girmeniz gerekmektedir.

Kullanıcı adı ve şifre bilginizi girdikten sonra ARF menüsünden Desktop seçeneğine tıklayınız.

Bundan sonraki adımda interaktif masaüstü talebinde bulunmanız gerekmektedir. Karşınıza gelen ekranda "Launch" sekmesine tıklayarak interaktif masaüstü için kaynak talebinde bulununuz. 

.. _sshXforward:

================
ssh X-forwarding
================

Arayüz sunucularına grafik ekran bağlantısı gerçekleştirerek (X-forwarding) görsel uygulamalar çalıştırmak mümkündür. 


Sunucu üzerindeki görsel öğeyi kullanıcının kendi bilgisayarına aktarabilmesi için

* SSH bağlantısı sırasında X-forwarding seçenegi aktif hale getirilmeli
* Lokal bilgisayarda bir X-server uygulaması (MacOS için XQuartz (https://www.xquartz.org/), Windows için Putty(https://www.putty.org/) ya da MobaXTerm(https://mobaxterm.mobatek.net/) tercih edilebilir) doğru biçimde kurulmuş ve çalışıyor durumda olmalı. Linux kullanıcılarında Xorg yüklü olarak gelmektedir. Yeni bir yazılım yüklenmesine gerek yoktur.
* Lokal bilgisayardaki güvenlik duvarı ve benzeri yazılımların ayarları doğru şekilde yapılmalıdır. 


SSH bağlantısı sağlamak için farklı işletim sistemleri için pek çok farklı uygulama bulunmaktadır.

Windows sistemlerde sık kullanılan SSH istemcilerinden biri PuTTy'dir. PuTTy'de X-forwarding seçeneği ``Connection > SSH > X11`` altındadır. Diğer uygulamalarda bu seçeneğin nerede olduğuna dair uygulamanın yardım dökümanları kontrol edilmelidir.

Terminal üzerinden kullanıcı arayüz sunucularına bağlantı sağlarken ssh komutuna -XY parametresinin eklenmesi yeterlidir. 

.. code-block::

    ssh -l <kullanici_adi> <arayüz ip adresi>  -XY


Bağlantı gerçekleştiğinde xclock komutu ile test yapılabilir.

.. code-block::

    xclock


.. image:: /assets/grafik_ekran/xclock-arf.png
  :width: 400
  :alt: Alternative text




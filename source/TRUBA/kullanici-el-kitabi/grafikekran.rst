.. _grafik-ekran:

======================================
Grafik Ekran Bağlantısı (Open OnDemand)
======================================

TRUBA’da hizmet veren Open OnDemand kullanıcı arayüzü servisi üzerinden ``Desktop`` talep ederek grafik ekran gerektiren uygulamaları çalıştırabilirsiniz. Girdi (input) dosyalarını aracı programlarla hazırlayan ya da işin çıktısını lokal bilgisayarına aktarmadan doğrudan sunucu üzerinde görmek isteyen kullanıcılar bu yöntemi tercih edebilirler. İlgili aracı programları kullanıcıların kendi ev diiznlerine kurmaları gerekmektedir (``/arf/home/kullaniciadi``)

Open OnDemand servisini kullanmak için TRUBA VPN bağlantısının başarılı bir şekilde sağlanmış olması gerekmektedir. 

* TRUBA VPN ile ilgili bilgilere ulaşmak için :ref:`open-vpn` sayfasını inceleyebilirsiniz.


======================
Open OnDemand Desktop
======================

ARF kümesi Open OnDemand servisine internet tarayıcınızı kullanarak http://172.16.6.20 adresinden ulaşabilirsiniz. Karşınıza gelen ekranda TRUBA kullanıcı adı ve şifre bilginizi girmeniz gerekmektedir.

.. image:: /assets/open-ondemand/images/ondemand-signin.png
   :align: center
   :width: 600px

Kullanıcı adı ve şifre bilginizi girdikten sonra ARF menüsünden Desktop seçeneğine tıklayınız.

.. image:: /assets/open-ondemand/images/ondemand-desktop.png
   :align: center
   :width: 600px

Bundan sonraki adımda interaktif masaüstü talebinde bulunmanız gerekmektedir. Karşınıza gelen ekranda "Launch" sekmesine tıklayarak interaktif masaüstü için kaynak talebinde bulununuz. 

.. _sshXforward:

================
ssh X-forwarding
================

Arayüz sunucularına (arf-ui1, arf-ui2) grafik ekran bağlantısı gerçekleştirerek (X-forwarding) görsel uygulamalar çalıştırmak mümkündür. 


Sunucu üzerindeki görsel öğeyi kullanıcının kendi bilgisayarına aktarabilmesi için

* SSH bağlantısı sırasında X-forwarding seçenegi aktif hale getirilmeli
* Lokal bilgisayarda bir X-server uygulaması (MacOS için XQuartz (https://www.xquartz.org/), Windows için Putty(https://www.putty.org/) ya da MobaXTerm(https://mobaxterm.mobatek.net/) tercih edilebilir) doğru biçimde kurulmuş ve çalışıyor durumda olmalı. Linux kullanıcılarında Xorg yüklü olarak gelmektedir. Yeni bir yazılım yüklenmesine gerek yoktur.
* Lokal bilgisayardaki güvenlik duvarı ve benzeri yazılımların ayarları doğru şekilde yapılmalıdır. 


SSH bağlantısı sağlamak için farklı işletim sistemleri için pek çok farklı uygulama bulunmaktadır.

Windows sistemlerde sık kullanılan SSH istemcilerinden biri PuTTy'dir. PuTTy'de X-forwarding seçeneği ``Connection > SSH > X11`` altındadır. Diğer uygulamalarda bu seçeneğin nerede olduğuna dair uygulamanın yardım dökümanları kontrol edilmelidir.

Terminal üzerinden kullanıcı arayüz sunucularına bağlantı sağlarken ssh komutuna -XY parametresinin eklenmesi yeterlidir. 

.. code-block::

    ssh -l kullanici_adi 172.16.6.11 -XY


Bağlantı gerçekleştiğinde xclock komutu ile test yapılabilir.

.. code-block::

    xclock


.. image:: /assets/grafik_ekran/xclock-arf.png
  :width: 400
  :alt: Alternative text



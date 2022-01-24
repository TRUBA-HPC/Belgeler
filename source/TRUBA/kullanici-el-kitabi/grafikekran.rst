.. _grafik-ekran:

======================================
Grafik Ekran Bağlantısı (X-forwarding)
======================================

TRUBA üzerinde grafik ekran gerektiren uygulamaları çalıştırmak için "ssh X-forwarding" ve "vnc" yöntemlerini kullanmak mümkündür. Girdi (input) dosyalarını aracı programlarla hazırlayan ya da işin çıktısını lokal bilgisayarına aktarmadan doğrudan sunucu üzerinde görmek isteyen kullanıcılar bu yöntemleri tercih edebilirler.

================
ssh X-forwarding
================

Arayüz sunucularına (levrek1, barbun1,sardalya1) grafik ekran bağlantısı gerçekleştirerek (X-forwarding) görsel uygulamalar çalıştırmak mümkündür. 


Sunucu üzerindeki görsel öğeyi kullanıcının kendi bilgisayarına aktarabilmesi için

* SSH bağlantısı sırasında X-forwarding seçenegi aktif hale getirilmeli
* Lokal bilgisayarda bir X-server uygulaması (MacOS için XQuartz (https://www.xquartz.org/), Windows için Putty(https://www.putty.org/) ya da MobaXTerm(https://mobaxterm.mobatek.net/) tercih edilebilir) doğru biçimde kurulmuş ve çalışıyor durumda olmalı. Linux kullanıcılarında Xorg yüklü olarak gelmektedir. Yeni bir yazılım yüklenmesine gerek yoktur.
* Lokal bilgisayardaki güvenlik duvarı ve benzeri yazılımların ayarları doğru şekilde yapılmalıdır. 


SSH bağlantısı sağlamak için farklı işletim sistemleri için pek çok farklı uygulama bulunmaktadır.

Windows sistemlerde sık kullanılan SSH istemcilerinden biri Putty'dir. Putty'de X-forwarding seçeneği Connection > SSH > X11 altındadır. Diğer uygulamalarda bu seçeneğin nerede olduğuna dair uygulamanın yardım dökümanları kontrol edilmelidir.

Terminal arayüzü üzerinden ssh komutuna -XY parametresinin eklenmesi yeterlidir. 

.. code-block::

    ssh -l kullanici_adi levrek1.ulakbim.gov.tr -XY


Bağlanti gerçekleştiğinde xclock komutu ile test yapılabilir.

.. code-block::

    xclock


.. image:: /assets/grafik_ekran/xclock.png
  :width: 400
  :alt: Alternative text


.. _TRUBA-vnc:

===========================================================
TRUBA'da VNC ile Kullanıcı Arayüzlerine Görsel Bağlantı
===========================================================

Kullanıcı arayüzü sunucularında (sardalya1 ve barbun1) ``vncserver`` kuruludur. Kullanıcılar aşağıdaki ayarları gerçekleştirdikten sonra kişisel bilgisayarlarında vncviewer kullanarak grafik arayüzü gerektiren programları (MATLAB vb.) çalıştırabilirler. 


.. warning::

    levrek1 kullanıcı araryüz sunucusunda ``vncserver`` kurulu değildir. 

- Öncelikle (SSH kullanılarak) arayüz makinesine bağlanılırak kullanıcı hesabınızda bir VNC oturumu oluşturulur. Bu aşamada bir VNC parolasının da belirlenmesi gerekmektedir.

Aşağıdaki örnek kampüs dışından bağlantı gerçekleştirdirildiği varsayılarak ``barbun1`` kullanıcı arayüz sunucusu için yazılmıştır. Sunuculara nasıl bağlanılacağı hakkında `buradan <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/openvpn_info.html>`_ bilgi edinebilirsiniz. 

barbun1 arayüz makinesine bağlanmak için:

.. code-block::

    ssh username@172.16.11.1
    vncpasswd

    ## (olusturacaginiz sifre TRUBA'ya bağlandığınız kullanıcı şifrenizden farklı olabilir)
    ## ``view only password`` seçeneği sorulduğunda lütfen ``no`` seçeneği ile devam ediniz. 
 
.. image:: /assets/grafik_ekran/vnc1.png

Parola oluşturulduktan sonra bir vnc oturumunun başlatılması gerekir. Belirli bir ekran boyutuyla vnc oturumunu aşağıdaki gibi başlatabilirsiniz: 

.. code-block::

    vncserver -geometry 1440x900

.. image:: /assets/grafik_ekran/vnc2.png

Mevcut vnc oturumlarını listelemek ve ``X DISPLAY`` numarasını görmek için

.. code-block::

    vncserver -list

.. image:: /assets/grafik_ekran/vnc3.png

Bu aşamadan sonra, **kişisel bilgisayarınızdaki herhangi bir VNC istemcisini kullanarak**, (örneğin `tigerVNC <https://tigervnc.org/>`_  ya da `turboVNC <https://sourceforge.net/projects/turbovnc/>`_ yazılımları) oturum oluşturduğunuz kullanıcı arayüzü sunucusuna belirlemiş olduğunuz şifreyle görsel bağlantı gerçekleştirebilirsiniz.

.. note::

    VNC bağlantısı yaparken IP adresinin sonuna getirilecek ``X DISPLAY`` numarası buradaki örnekten farklılık gösterebilir.


.. code-block::

    ## terminal komutu ile (kendi bilgisayaranizdan)
    vncviewer 172.16.11.1:3
    ## bu aşamada oluşturmuş olduğunuz vnc şifresini girip masaüstüne erişim sağlayabilirsiniz. 

.. image:: /assets/grafik_ekran/vnc3_5.png

**tiger vnc-viewer** kullanıyorsanız eğer aşağıdaki gibi ``vnc sunucu bilgi`` kısmına *IP numarası* ve *XDisplay numarasını* yazarak da bağlanabilirsiniz. 

.. image:: /assets/grafik_ekran/vnc4.png

**turbovnc** kullanıyorsanız eğer aşağıdaki gibi ``vnc sunucu`` bilgi kısmına *IP numarası* ve *XDisplay numarasını* yazarak da bağlanabilirsiniz. 

.. image:: /assets/grafik_ekran/vnc6.png

-------------
Ek Notlar:
-------------

- Hangi sunucuda VNC oturumu oluşturduysanız (barbun1 ya da sardalya1) sadece o sunucuya VNC ile bağlanabilirsiniz.

- VNC oturumu oluşturulduktan sonra, aynı oturum tekrar tekrar kullanılabilir. Her seferinde yeni parola ya da yeni oturum oluşturmaya gerek yoktur.

- VNC bağlantısında sorun yaşandığınızda önceki oturumlarınızı silerek yeni bir oturum oluşturmayı deneyebilirsiniz.


.. code-block::

    ## vnc-server oluşturmuş olduğunuz sunucuya baglanin (örnegin barbun1)
    ssh username@172.16.11.1

    ## Mevcut VNC oturumlarını listeleyin
    vncserver -list

    ## Mevcut vnc oturumunu sonlandırin (X-DISPLAY numaranız farklı olabilir)\\
    vncserver -kill :3

.. image:: /assets/grafik_ekran/vnc5.png

.. note::

    VNC bilgileri ve logları ev dizininde ``.vnc`` dizininde tutulmaktadır. Herhangi bir sorunda bu dizini silip yeniden oluşturabilirsiniz.

.. code-block::

    rm -rf ~/.vnc


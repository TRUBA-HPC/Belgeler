=========================================
IOS İşletim Sistemi için OpenVPN Kurulumu
=========================================

OpenVPN  yapılandırması için öncelikle işletim sistemine OpenVPN kurulumunu yapmanız gerekmektedir. Eğer daha önceden sisteminize OpenVPN kuruldu ise, OpenVPN versiyonunun 2.4.0'dan yüksek olması gerekmektedir. Daha eski OpenVPN sürümleri bu belgedeki yapılandırma adımları  ile uyumlu değildir ve bağlantı kurmakta başarısız olacaktır.

OpenVPN Uygulamasının İnternetten İndirilmesi
=============================================

Bilgisayarınıza OpenVPN uygulamasını kolayca kurabilmek için sırasıyla aşağıdaki adımları takip ediniz.

**1.** OpenVPN uygulamasına  `openvpn.net <https://openvpn.net/>`_  web sayfasından kolayca ulaşabilirsiniz. Linke tıkladığınızda sizi aşağıdaki şekilde gösterildiği gibi ana ekran karşılayacaktır.

.. image:: /assets/openvpn-truba/images/openvpn-main-page.png  
   :width: 500

**2.** IOS için uygulamaya erişmek bu sayfada bulunan  **VPN Client** segmesine tıkladıktan sonra tek segmeden oluşan **OpenVPN Connect** menusünü ekranda aşağıdaki şekilde gösterildiği gibi göreceksiniz. 

.. image:: /assets/openvpn-truba/images/download-page.png   
   :width: 500

**3.**  **Download OpenVPN Connect for Mac**  sekmesine tıklayarak bilgisyarınıza kurulum dosyasını indiriniz. 

**4.** .dmg uzantılı kurulum dosyasına tıkladığınızda kurulum için gerekli ilerlemeler segmelerine aşağıdaki şekilde verildiği gibi ulaşabileceksiniz. Uygulama yükleme adımları izlediğinizde bilgisayarınıza uygulamayı yüklemiş olacaksınız.

.. image:: /assets/openvpn-truba/images/install.png   
   :width: 500

**5.** `OpenVPN Ios yapılandırma dosyasını aşağıdak linkten  indirdiriniz.

* :download:`OpenVPN iOS yapılandırma dosyası </assets/openvpn-truba/config-files/truba-ios.ovpn>`

.. note::

	Uzantısının **opvn** olduğunu kontrol ediniz.   

**6.** bu dosyayı OpenVPN uygulamasının içine sürükleyiniz. Sonrasında sizi aşağıdaki menü karşılayacaktır. Menüde TRUBA tarafından size sağlanana
hesap isminizi ve şifresinizi girdikten sonra uygulama artık çalışmaya hazır olacaktır.

.. image:: /assets/openvpn-truba/images/app_opvn.png   
   :width: 300
   
**7.** Artık TRUBA bilgisyarlarına ssh protokolüyle terminalinizden ulaşabilirsiniz. Aşağıdaki verilen komut satırını kendi kullanıcı adı
nıza göre uyarlayarak terminalden erişim sağlayabilirsiniz. Örnekte verilen adres **levrek1** bilgisayarlarına ulaşmak içindir.

.. code-block:: bash
     
	ssh  kullanici_adi@172.16.7.1      
    






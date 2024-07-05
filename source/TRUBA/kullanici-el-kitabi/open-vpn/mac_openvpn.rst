=========================================
IOS İşletim Sistemi için OpenVPN Kurulumu
=========================================

OpenVPN  yapılandırması için öncelikle işletim sistemine OpenVPN kurulumunu yapmanız gerekmektedir. Eğer daha önceden sisteminize OpenVPN kurulu ise, OpenVPN versiyonunun 2.4.0'dan yüksek olması gerekmektedir. Daha eski OpenVPN sürümleri bu belgedeki yapılandırma adımları  ile uyumlu değildir ve bağlantı kurmakta başarısız olacaktır.

OpenVPN Uygulamasının İnternetten İndirilmesi
=============================================

Bilgisayarınıza OpenVPN uygulamasını kolayca kurabilmek için sırasıyla aşağıdaki adımları takip ediniz.

**1.** OpenVPN uygulamasına  `openvpn.net <https://openvpn.net/>`_  web sayfasından kolayca ulaşabilirsiniz. Linke tıkladığınızda sizi aşağıdaki şekilde gösterildiği gibi bir ana ekran karşılayacaktır.

.. image:: /assets/openvpn-TRUBA/images/openvpn-main-page.png  
   :width: 500

**2.** IOS işletim sistemine ait uygulamaya erişmek için bu sayfada bulunan **VPN Client** sekmesine tıkladıktan sonra çıkan **OpenVPN Connect** menüsünü ekranda aşağıdaki şekilde gösterildiği gibi göreceksiniz. 

.. image:: /assets/openvpn-TRUBA/images/download-page.png   
   :width: 500

**3.**  **Download OpenVPN Connect for Mac**  sekmesine tıklayarak bilgisayarınıza kurulum dosyasını indiriniz. 

**4.** ``.dmg`` uzantılı kurulum dosyasına tıkladığınızda kurulum için gerekli sekmelere aşağıdaki şekilde verildiği gibi ulaşabileceksiniz. Uygulama yükleme adımlarını izlediğinizde bilgisayarınıza uygulamayı yüklemiş olacaksınız.

.. image:: /assets/openvpn-TRUBA/images/install.png   
   :width: 500

**5.** OpenVPN IOS yapılandırma dosyasını aşağıdaki linkten  indirebilirsiniz:

* :download:`OpenVPN iOS yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-ios.ovpn>`

.. note::

	Dosya uzantısının **.opvn** olduğunu kontrol ediniz.   

**6.** Bu dosyayı OpenVPN uygulamasının içine sürükleyiniz. Sonrasında sizi aşağıdaki menü karşılayacaktır. Menüde TRUBA tarafından size sağlanan hesap isminizi ve şifrenizi girdikten sonra uygulama artık çalışmaya hazır olacaktır.

.. image:: /assets/openvpn-TRUBA/images/app_opvn.png   
   :width: 300
   
**7.** Artık TRUBA bilgisayarlarına ssh protokolüyle terminalinizden ulaşabilirsiniz. Aşağıdaki verilen komut satırını kendi kullanıcı adınıza göre uyarlayarak terminalden erişim sağlayabilirsiniz. Örnekte verilen adres **barbun1** arayüz sunucusuna ulaşmak içindir.

.. code-block:: bash
     
	ssh  kullanici_adi@172.16.11.1      
    






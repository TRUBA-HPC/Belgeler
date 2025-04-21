==============================
Windows'da MobaXterm Kurulumu
==============================

MobaXterm Windows işletim sistemi için kullanılan bir yazılımdır. MobaXterm ile aynı arayüzde hem SSH bağlantısı hem de dosya transferi yapılabilir.

--------------------------------------
Windows'da MobaXterm Kurulum Adımları
--------------------------------------

1. Yazılımı indirmek için https://mobaxterm.mobatek.net sayfasına girin. 

.. image:: /assets/MobaXterm-howto/M1.png

2. Üst menüdeki Download simgesini tıklayın. MobaXterm’ün Home Edition versiyonu ücretsiz olarak indirilebilir ve çoğu kullanıcı için bu versiyon yeterli olacaktır. Home Edition versiyonunu indirmek için Download now’ı tıklayın.

.. image:: /assets/MobaXterm-howto/M2.png

3. MobaXterm Home Edition (Installer edition)’ı tıklayın. Daha sonra sol alt köşedeki zip dosyasına tıklayın.

.. image:: /assets/MobaXterm-howto/M3.png

4. Kurulumu başlatmak için MobaXterm_installer – Windows Installer Paketini tıklayın.

.. image:: /assets/MobaXterm-howto/M4.png

Dosya Windows'un farklı sürümünde .msi uzantılı da olabilir. Böyle bir durumunda .msi uzantılı dosyayı tıklayın.

.. image:: /assets/MobaXterm-howto/M4-2.png

5. Welcome to MobaXterm Setup wizard penceresinde next’i tıklayın. Ve kurulum tamamlana kadar devam edin. 

.. image:: /assets/MobaXterm-howto/M5.PNG 

6. Finish’i tıkladıktan sonra yazılımı indirmiş olacaksınız. 

.. image:: /assets/MobaXterm-howto/M6.PNG 

7. Kurulum tamamlandıktan sonra masaüstünüze gelen MobaXterm ikonuna çift tıklayın. Karşınıza aşağıdaki gibi bir pencere gelecektir. New sessions ı seçin ya da sol üst köşede bulunan sessions'tan SSH'ı seçin.

.. image:: /assets/MobaXterm-howto/M7.png 

8. SSH kullanarak uzak sunucunuza (TRUBA) erişebilirsiniz. Session type olarak SSH’ı seçin. 

.. image:: /assets/MobaXterm-howto/M8.png 

9. ULAKNET ağı içinde veya dışında olma durumunuz farketmeksizin, :ref:`OpenVPN bağlantısını başarılı bir şekilde sağlamalısınız <open-vpn>`. 


**Remote host:** kısmına arf-ui kullanıcı arayüz sunucularından birisnin IP adresini yazmanız gerekmektedir. Aşağıda verilen adres arf-ui1 kullanıcı arayüz sunucusuna erişim içindir. Diğer sunucular için farklı adresler :ref:`open-vpn` sayfasında verilmiştir.


**Remote host:** 172.16.6.11

**Specify username:** kullaniciadi (örnek:osari)

**Port:** 22


10.  Terminale bağlandıktan sonra şifrenizi giriniz. (örneğin PuTTY'yi daha önce yükleyip kullandıysanız, kaydedilmiş oturumları ve sol sütunda dosyalarınızı görebilirsiniz.)

11. Dosya transferi için yani dosyayı kendi bilgisayarınıza indirmek için sol sütunda indirmek istediğiniz dosyayı sağ tıklayarak download’u seçerek dosyanızı indirebilirsiniz.



..

    .. image:: /assets/MobaXterm-howto/M9.png

    .. image:: /assets/MobaXterm-howto/M10.png

    .. image:: /assets/MobaXterm-howto/M11.png 


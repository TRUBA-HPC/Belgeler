==============================
Windows‘da OpenVPN Kurulumu
==============================

Sisteminizde daha önceden OpenVPN kurulu ise, OpenVPN versiyonunun 2.4.0'dan yüksek olması gerekmektedir. 
Daha eski OpenVPN sürümleri bu belgedeki yapılandırma adımları ile uyumlu değildir ve bağlantı kurmakta başarısız olacaktır.

-----------------------------------
Windows'da OpenVPN Kurulum Adımları
-----------------------------------

Sisteminizde daha önceden OpenVPN kurulu değilse OpenVPN kurulumu için aşağıdaki adımları izleyiniz.

1. Öncelikle OpenVPN yazılımının ana sayfasına giriniz.
OpenVPN ana sayfasına `openvpn.net <https://openvpn.net/>`_  web sayfasından kolayca ulaşabilirsiniz.

.. image:: /assets/openvpn-howto/images/winopenvpn1.png

2. Ana sayfada sağ üstte yer alan “Community” kısmını seçip oradan da “Downloads” u tıklamanız gerekmektedir. Ekran görüntüsünde görülen tablodaki kendi Windows versiyonunuza uygun olan installer dosyasını indirmelisiniz. Bu dosyayı indirip, kaydettikten sonra dosyayı çalıştırarak kuruluma başlayabilirsiniz.

.. image:: /assets/openvpn-howto/images/winopenvpn2.png

3. Örneğin Windows 64-bit MSI installer’ı seçtiyseniz, .msi uzantılı dosyayı indirdiğinizde sol alt köşede beliren dosyayı tıklayanız. 

.. image:: /assets/openvpn-howto/images/winopenvpn3.png

4. Karşınıza çıkan pencereden Install Now’ı seçiniz. Seçtikten sonra “Aşağıdaki programın bu bilgisayara yazılım yüklemesine izin vermek istiyor musunuz?” sorusuna Evet cevabını seçerek devam ediniz. 

.. image:: /assets/openvpn-howto/images/winopenvpn4.JPG

5. Karşınıza ``Installing OpenVPN`` penceresi çıkacaktır. Kurulum tamamlanana kadar bekleyiniz. 

.. image:: /assets/openvpn-howto/images/winopenvpn5.JPG

6.	Bu adımdan sonra pencerenize ``OpenVPN Installing Completed`` yazısı geldiğinde Close’u tıklayınız. Masaüstünüzde OpenVPN GUI ikonu belirecektir. Bu ikonu çift tıkladığınızda OpenVPN çalışmaya başlayacaktır. 

  .. image:: /assets/openvpn-howto/images/winopenvpn6.JPG
    :width: 100

----------------------------------------------------------------------
OpenVPN’in TRUBA Bağlantısı İçin Yapılandırılması
----------------------------------------------------------------------

OpenVPN kurulumu tamamlandıktan sonra, TRUBA altyapısına bağlanabilmeniz için OpenVPN sunucusunun yapılandırılması gerekmektedir. 

1. Yapılandırma dosyası için bağlantı aşağıda verilmiştir. Bağlantıya sağ tıklayarak “bağlantıyı farklı kaydediniz” i seçiniz. 

* :download:`OpenVPN genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-genel.ovpn>`

.. note::

  NOT: Kaydedilen dosya adının ``.ovpn`` uzantısı ile bitmesi önemlidir. Bazı sistemlerde ve web tarayıcılarda dosya adı ``.txt`` uzantılı olabilmektedir. Bu durumda ``.txt`` uzantısını ``.ovpn`` ile değiştiriniz. 

2. Masaüstünüzdeki OpenVPN GUI ikonunu çift tıkladığınızda, bilgisayarınızda sağ en alt köşede saat göstergesinin yanında OpenVPN simgesi belirecektir. 

.. image:: /assets/openvpn-howto/images/winopenvpn7.png
  :width: 200

3. Simgeyi sağ tıklayınız ve import file’ı seçiniz. Konum'u seçmeniz gerekmektedir. Konum için indirdiğiniz TRUBA-genel.ovpn dosyasını yerini bulup seçiniz. Pencerenizde “File imported succesfully” belirecektir. 

 .. image:: /assets/openvpn-howto/images/winopenvpn8.png
    :width: 200

4. Bağlantı kurduğunuzda OpenVPN sunucusu sizden kullanıcı adınızı ve parolanızı isteyecektir. Kullanıcı adı ve parolanız arayüz makinesine bağlantı için kullandığınız kullanıcı adı ve parola ile aynıdır. Bu aşamadan sonra artık TRUBA sistemine bağlanabilirsiniz. 

.. _putty:

========================================
PuTTY ile SSH Bağlantısı
========================================
Windows işletim sisteminde TRUBA bilgisayarlarına bağlanmak için aşağıdaki adımları izleyebilirsiniz.

PuTTY, orijinal olarak Windows platformu için açık kaynak bir SSH istemcisidir. Bu uygulamayı bilgisayarınıza indirmek, kurmak ve sonrasında **ssh protokolü** ile bağlanabilmek için aşağıdaki adımları izleyiniz.

**1.**
PuTTY kaynak kodunu https://www.putty.org/ adresinden bilgisayarınıza uygun olan versiyonu seçip indirebilirsiniz.


.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-1.png
   :width: 2000

 
.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-2.png   
   :width: 1000


**2.**  
``.msi`` uzantılı dosyayı kurmak için çift tıklayarak ilerleyiniz. Aşağıdaki ekran görüntüleri sizlere adımlarda yardımcı olacaktır.
 
.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-3.png   
    :width: 2000

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-4.png  
    :width: 1000  

**3.**

Bilgisayarınıza uygulamayı yükledikten sonra açıp, TRUBA bilgisayarlarına bağlanmak için ``Host Name (or Ip address)`` kutucuğuna ``inet`` adresini giriniz. Aşağıdaki ekran görüntüsünde örnek bağlantı ayarları gösterilmiştir.

.. note::

<<<<<<< HEAD:source/2-temel_bilgiler/ssh_baglanti/putty.rst
    Öncelikle, ULAKNET ağı içinde veya dışında olma durumunuz farketmeksizin, :ref:`OpenVPN bağlantısını başarılı bir şekilde sağlamalısınız <open-vpn>`. Sunucu adı yerine :ref:`ARF bağlantı bilgileri <arf_baglanti>` adresinden öğrenebileceğiniz ``ip`` adresini yazmanız gerekmektedir. 
=======
    Öncelikle, ULAKNET ağı içinde veya dışında olma durumunuz farketmeksizin, :ref:`OpenVPN bağlantısını başarılı bir şekilde sağlamalısınız <open-vpn>`. Sunucu adı yerine ``172.16.6.11`` yazmanız gerekmektedir. 
    
    Aynı anda sadece bir tane aktif OpenVPN bağlantınız olmalıdır. Eğer başka bir cihazda OpenVPN bağlantınız varsa, bu bağlantıyı sonlandırmadan yeni bir bağlantı kurmaya çalışmayınız.
>>>>>>> main:source/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/putty.rst


.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-5.png  
    :width: 1000  


<<<<<<< HEAD:source/2-temel_bilgiler/ssh_baglanti/putty.rst
=======

>>>>>>> main:source/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/putty.rst
**4.**
IP adresini girdiğinizde kullanıcı adınızı ve şifrenizi gireceğiniz bir terminal gelecektir. TRUBA tarafından sizlere verilen kullanıcı adı ve şifreyle giriş yapabilirsiniz.


.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/putty-7.png  
    :width: 1000 




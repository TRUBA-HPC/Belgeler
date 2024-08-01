
=====================================================================================================
WinSCP Uygulaması Kurulumu, TRUBA ve Lokal Bilgisayarlar Arasında Dosya Transferi
=====================================================================================================

WinSCP uygulaması, Windows platformu için dosya aktarım protokollerini kullanarak yerel bir bilgisayar ile uzak sunucular arasında dosya kopyalamanıza yardımcı olur. Bu uygulamayı bilgisayarınıza indirmek, kurmak ve sonrasında dosyalarınızı transfer etmek için aşağıdaki adımları izleyiniz.

**1.**
WinSCP Kaynak kodunu https://winscp.net/eng/index.php adresinden bilgisayarınıza **Download Now** kısmına tıklayarak indiriniz.

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-1.png
   :width: 800


**2.**
``.exe`` uzantılı dosyayı bilgisayarınıza yüklemek için aşağıdaki ekran görüntülerinde verilen adımları izleyiniz. ``.exe`` dosyasının bilgisayarınızda değişiklik yapmasına izin verdikten sonra **tüm kullanıcılar için kurulsun** kipini seçiniz. 

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-2.png
   :width: 300

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-3.png
   :width: 200


Sonrasında **Lisans Anlaşması**'nı onaylayınız. Bir sonraki menüde **Kurulum Türü** ekranı sizi karşılayacaktır. Önerilen **Tipik Kurulum** seçeneğini işaretleyiniz.

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-4.png
   :width: 300

Bir sonraki adımda **İlk Kullanıcı Ayarları** ekranı görüntülenecektir. Kurulum yönergesi kullanım kolaylığı açısından ``Commander`` ile devam edecektir. Sizler isterseniz diğer seçenek ile de devam edebilirsiniz.

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-5.png
   :width: 300

Her türlü ayarlamayı tamamladıktan sonra ``Kur`` sekmesine tıklayarak bu uygulamayı bilgisayarımıza yüklemiş olacağız.  

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-6.png
   :width: 300

**3.**
Bu adımda yüklemiş olduğumuz **WinSCP** uygulamasıyla nasıl dosya transferi yapılacağını göstereceğiz. Uygulamayı açtıktan sonra aşağıdaki şekilde gösterildiği gibi sizi **Oturum Aç** menüsü karşılayacaktır. Sunucu adı, size verilen TRUBA kullanıcı adınız ve şifrenizi girdikten sonra oturum açabilirsiniz. 

.. note::

   Öncelikle, ULAKNET ağı içinde veya dışında olma durumunuz farketmeksizin, :ref:`OpenVPN bağlantısını başarılı bir şekilde sağlamalısınız <open-vpn>`. Sunucu adı yerine ``172.16.11.1`` yazmanız gerekmektedir. 
   
..

   ULAKNET ağı dışından (örneğin üniversite kampüsü dışından) bağlantı sağlıyorsanız eğer öncelikle :ref:`OpenVPN bağlantısını sağlamalısınız <open-vpn>`. Bu durumda sunucu adı yerine ``172.16.7.1`` veya ``levrek1.yonetim`` yazmanız gerekmektedir. 

   ULAKNET ağından sunuculara bağlanmak için ise OpenVPN kullanımına gerek yoktur. Bu durumda sunucu adı yerine ``levrek1.ulakbim.gov.tr`` adresini yazmanız gerekmektedir.
   

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-7.png
   :width: 300

Oturum açılınca sizi iki taraflı bir sayfa karşılayacaktır. Bu sayfanın sol tarafında kendi lokal bilgisayarınızdaki dizinler, sağ tarafında ise TRUBA'da size sağlanan ev dizini ve klasörler mevcuttur. Herhangi bir taraftan diğer bir tarafa dosya transferi yapmak için dosyaları bir taraftan diğer tarafa mouse ya da touch pad yardımıyla sürükleyip yapabilirsiniz.  Ayrıca yukarıdaki menü yardımıyla dosyalarınızı silebilir ve tekrardan düzenleyebilirsiniz (yeniden klasör, dosya oluşturma vb.).

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-8.png
   :width: 300

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/winscp/images/winscp-9.png
   :width: 300


 

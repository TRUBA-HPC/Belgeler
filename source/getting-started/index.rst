=============================
VPN Bağlantısı nasıl kurulur?
=============================

Bilgisayarına sabit ve gerçek bir IP adresi tanımlama şansı olmayan kullanıcılar, OpenVPN kullanarak ile TRUBA ağına dahil olabilirler ve kullanıcı arayüzü suncusuna ulaşabilirler. OpenVPN bağlantısı, sadece kullanıcı adı ve parola kullanarak gerçekleştirilebileceği gibi, bunu desteklemeyen versiyonlarda, TRUBA 'dan temin edilecek geçerli bir sertifika ile de gerçekleştirilebilir. 

Kullanıcı adı ve parola ile OpenVPN Erişimi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OpenVPN bağlantısını, herhangi bir sertifikaya ihtiyaç olmadan, TRUBA kullanıcılarının sistem üzerindeki kullanıcı adları ve parolalarını kullanarak gerçekleştirmeleri mümkündür. Kullanıcı adı ve parola kullanarak farklı işletim sistemleri üzerinden bağlantı gerçekleştirmek için openvpn 'in ilgili sürümü indirilerek, ilgili yapılandırma dosyası OpenVPN kurulum dizinindeki config dizinine kopyalanmalıdır. OpenVPN'nin eski sürümleri kullanıcı adı - parola doğrulamasını desteklemediği için, daha önce yüklenmiş olan OpenVPN programlarının da güncellenmesi gerekmektedir. 

* `OpenVPN genel yapılandırma dosyası </assets/openvpn-howto/config-files/truba-genel.ovpn>`__
* `OpenVPN android yapılandırma dosyası </assets/openvpn-howto/config-files/truba-android.ovpn>`__
* `OpenVPN iOS yapılandırma dosyası </assets/openvpn-howto/config-files/truba-ios.ovpn>`__
* `Viscocity genel yapılandırma dosyası </assets/openvpn-howto/config-files/truba-viscosity.ovpn>`__

**Önemli:** Kaydedilen dosya adının ``.ovpn`` ile bitmesi önemlidir. Bazı sistemlerde ve web tarayıcılarda dosya adının sonuna txt eklenebilmektedir.

VPN bağlantısını bu şekilde yaptıktan sonra, kullanıcı arayüzüne aşağıdaki adreslerden herhangi bir ssh istemcisi ile ulaşılabilir.

* levrek1 için **levrek1.yonetim** yada ``172.16.7.1``
* sardalya1 için **sardalya1.yonetim** yada ``172.16.10.1``
* barbun1 için **barbun1.yonetim** yada ``172.16.11.1``

Windows 10'da OpenVPN Kurulumu
------------------------------

Bu wiki belgesini takip edebilmek ve kurulumu tamamlayabilmek için aşağıdaki gereksinimlerin sağlanmış olması gereklidir:

* Kullandığınız bilgisayar Microsoft Windows 10 işletim sistemini çalıştırmalı, ve tüm güncellemeleri ve yamaları yapılmış olmalıdır.
* Kullandığınız bilgisayar üzerinde yönetici haklarına sahip olmanız beklenmektedir.
* Kullanıcının ağ bağlantısında OpenVPN bağlantılarını engelleyen bir güvenlik cihazı ya da yapılandırma bulunmamalıdır.

OpenVPN ile ilgili yapılandırmanın yapılmasından önce işletim sistemine OpenVPN kurulumunu yapmanız gerekmektedir. Eğer  daha önceden sisteminize OpenVPN kuruldu ise, OpenVPN versiyonunun 2.4.0'dan yüksek olması gerekmektedir. Daha eski  OpenVPN sürümleri bu belgedeki yapılandırma adımları ile uyumlu değildir ve bağlantı kurmakta başarısız olacaktır.

OpenVPN'in İnternetten İndirilmesi
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenVPN, yazılımın ana sayfasından, `openvpn.net <https://openvpn.net>`_ adresinden indirilebilmektedir. OpenVPN istemcisinin indirme sayfasına ise `buradan <https://openvpn.net/community-downloads/>`_ ulaşabilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-download-page.png

Karşınıza gelen web sayfasında, en yukarıda belirtilen sürüm her zaman en güncel sürümdür. Bu belgedeki adımlara uygun şekilde kurulum yapabilmek için ekran görüntüsünde de görülen tablonun en alt satırındaki "Installer, Windows Vista and Later" ile belirtilmiş olan .exe dosyasını indirmeniz gerekmektedir. Bu dosyayı indirilip, kaydedildikten sonra dosyayı çalıştırarak kuruluma başlayabilirsiniz.

OpenVPN İstemcisinin Kurulması
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenVPN istemcisinin kurulumunu başlatmak için indirdiğiniz dosyayı çalıştırmanız yeterlidir. İlk adımda programın sistemde değişiklik yapabilmesi için sizden izin istenecektir.

.. image:: /assets/openvpn-howto/images/openvpn-installation-elevation-prompt.png

Kurulumu başlatabilmeniz için çıkan bu uyarıya Evet cevabı vererek devam etmeniz gerekmektedir. Bu adımdan sonra kurulum programı açılacaktır

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-1.png

OpenVPN kurulum yardımcısı sistem dilinden bağımsız olarak İngilizce olarak açılmaktadır. İlk ekranı Next'e basarak geçebilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-2.png

Bir sonraki Ekranda OpenVPN lisans sözleşmesi gösterilecektir. "I Agree" butonuna basarak kabul edebilir ve bir sonraki adıma geçebilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-3.png

Bu adımda ise OpenVPN istemci ile beraber kurulacak olan yan yazılımlar ve yazılım parçaları seçilmektedir. Bu adımda herhangi bir değişiklik yapmadan Next seçeneğini seçerek devam edebilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-4.png

Bu adımda OpenVPN istemcinin nereye kurulacağını belirleyebilirsiniz. Sisteminizde özel bir düzenleme yok ise, bu adımda herhangi bir değişiklik yapmadan, Next seçeneğini seçerek devam edebilirsiniz. Bu adımdan sonra kurulum başlayacaktır.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-5.png

Kurulum sırasında yukarıdaki bir uyarı ile karşılaşabilirsiniz. Bu uyarı, OpenVPN'in sanal ağ bağdaştırıcı sürücüsünü kurup isteyip istemediğinizi sormaktadır. Bu sürücü istemcinin çalışması için gerekli olduğundan Yükle seçeneğini seçmeniz gerekmektedir. Daha sonra istemcinizi güncellerken bu soru ile karşılaşmak istemiyorsanız Her zaman "OpenVPN Technologies, Inc." kaynaklı yazılımlara güven seçeneğini işaretleyebilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-6.png

Sanal ağ bağdaştırıcı sürücüsü de sisteme kurulduktan sonra kurulum tamamlanacaktır. Next seçeneğini seçerek devam edebilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-installation-screen-7.png

Son ekranda ise README dosyasını okuyup istemek istemediğinizi seçtikten sonra Finish'e basarak kurulumdan çıkabilirsiniz.  OpenVPN kurulumu tamamlandıktan sonra, OpenVPN istemcisinin yapılandırılması gerekmektedir. Bir sonraki adımda bu işlemler detaylı şekilde anlatılacaktır. 

OpenVPN İstemcisinin TRUBA Bağlantısı için Yapılandırılması
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenVPN istemcisi kurulduktan sonra TRUBA altyapısına bağlanabilmeniz için gerekli olan yapılandırma dosyasını indirmeniz gerekmektedir. İlgili dosyaya yukarıdaki bağlantıdan ulaşabilirsiniz.

**Not:** Eğer tarayıcınız dosyayı indirmek yerine pencerede açar ise, lütfen bağlantıya sağ-tıklayarak kaydediniz. Firefox için bu seçenek ``Bağlantıyı farklı kaydet...`` dir. İndirdiğiniz dosyayı kullanmak için taşıyabileceğiniz iki konum bulunmaktadır. Bunlardan bir tanesi bağlantıyı sadece sizin kullanmanızı sağlarken, diğeri sistemdeki tüm kullanıcıların kullanmalarına izin vermektedir.

Sizin kullanımınız için (önerilen): ``C:\Kullanıcılar\<kullanıcı-adınız>\OpenVPN\config``

Genel kullanım için: ``C:\Program Files\OpenVPN\config``

Dosyayı kopyaladıktan sonra masaüstünüzde kurulum sırasında
oluşmuş olan OpenVPN GUI bağlantısına çift tıklayarak istemciyi
çalıştırabilirsiniz.

İstemciyi çalıştırdığınız zaman saatin yanında istemcinin simgesi
belirecektir.

.. image:: /assets/openvpn-howto/images/openvpn-system-tray-client.png

Bu simgeye sağ tıkladığınız zaman bir menü açılacaktır. Buradan Bağlanı seçerek bağlantınızı kurabilirsiniz.

.. image:: /assets/openvpn-howto/images/openvpn-system-tray-client-menu.png

Bağlantı kurduğunuzda OpenVPN istemcisi sizden kullanıcı adınızı ve parolanızı isteyecektir. Kullanıcı adı ve parolanız arayüz makinesine bağlantı için kullandığınız kullanıcı ve parola ile aynıdır.

.. image:: /assets/openvpn-howto/images/openvpn-username-and-password.png 

Not: Eğer sisteminize ilk defa OpenVPN kuruyorsanız, Windows Güvenlik Duvarı aşağıdaki gibi bir pencere ile bağlantı izni isteyebilir. Bütün ağ türlerini seçtikten sonra Erişime izin ver seçeneğini seçmeniz gerekmektedir. 

.. image:: /assets/openvpn-howto/images/openvpn-system-tray-client-firewall-prompt.png

Bu noktada OpenVPN bağlantınız kurulmuş olacaktır. Bağlantı başarılı bir şekilde kurulduğunda aşağıdaki gibi bir bildirim gelecektir. Atanan IP kısmı aşağıdaki resim ile farklılık gösterebilir ve her bağlantınızda değişebilir, bu bir problem değildir.

.. image:: /assets/openvpn-howto/images/openvpn-system-tray-client-successful-connection.png
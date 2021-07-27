.. _openvpn-info:

========================================
OpenVPN Bağlantısı Hakkında Genel Bilgi
========================================

Bilgisayarında sabit ve gerçek bir IP adresi tanımlama şansı olmayan kullanıcılar, **OpenVPN** kullanarak TRUBA ağına bağlanabilirler ve kullanıcı arayüzü sunucusuna ulaşabilirler. OpenVPN bağlantısı, sadece kullanıcı adı ve parola kullanarak gerçekleştirilebileceği gibi, bunu desteklemeyen versiyonlarda, TRUBA 'dan temin edilecek geçerli bir sertifika ile de gerçekleştirilebilir.

Kullanıcı Adı ve Parola ile OpenVPN Erişimi
===========================================

OpenVPN bağlantısını, herhangi bir sertifikaya ihtiyaç olmadan, TRUBA kullanıcılarının sistem üzerindeki **kullanıcı adları** ve **parolalarını** kullanarak gerçekleştirmeleri mümkündür. Kullanıcı adı ve parola kullanarak farklı işletim sistemleri üzerinden bağlantı gerçekleştirmek için OpenVPN'in ilgili sürümü indirilerek,  ilgili yapılandırma dosyası OpenVPN kurulum dizinindeki config dizinine kopyalanmalıdır.

.. note:: 
	
	OpenVPN'nin eski sürümleri kullanıcı adı-parola doğrulamasını desteklemediği için, daha önce yüklenmiş olan OpenVPN programlarının da güncellenmesi gerekmektedir.

Aşağıdaki linklerde farklı işletim sistemleri için OpenVPN dosyalarının linkleri mevcuttur. 

* :download:`OpenVPN genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-genel.ovpn>`
* :download:`OpenVPN Android yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-android.ovpn>`
* :download:`OpenVPN iOS yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-ios.ovpn>`
* :download:`Viscocity genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-viscosity.ovpn>`

.. warning::

   Linklere tıklayarak bilgisayarınızda kullandığınız işletim sistemine uygun dosyayı tıklayarak bilgisayarınıza indirip kaydettikten sonra dosyanın uzantısını kontrol ediniz. Kaydedilen dosya adının **.ovpn** ile bitmesi önemlidir. Bazı sistemlerde ve web tarayıcılarda dosya adının sonuna **.txt** uzantısı eklenebilmektedir. 

Sonraki bölümlerde bu farklı işletim sistemlerinde OpenVpn kurulumları ayrıntılı bir şekilde verilecektir. OpenVPN için gerekli kurulumları yaptıktan kullanıcı arayüzüne aşağıda verilen adreslerden herhangi birine **SSH** protokolü ile ulaşabilirsiniz.

* levrek1 için **levrek1.yonetim** ya da ``172.16.7.1``
* sardalya1 için **sardalya1.yonetim** ya da ``172.16.10.1``
* barbun1 için **barbun1.yonetim** ya da ``172.16.11.1``

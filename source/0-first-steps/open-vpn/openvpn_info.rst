.. _open-vpn:

OpenVPN Bağlantısı 
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


.. note::

   OpenVPN aktif iken 

   
   ARF için

      - 172.16.6.11 ile arf-ui1,
      - 172.16.6.12 ile arf-ui2,
      - 172.16.6.13 ile arf-ui3,
      - 172.16.6.14 ile arf-ui4,
      - 172.16.6.15 ile arf-ui5,


  kullanıcı arayüzlerinden birisine bağlanabilirsiniz.
  
  
ARF kullanıcı arayüzlerini kullanırken de diğer kuyruklara iş gönderebilirsiniz. Bu konuda endişelenmenize gerek yoktur.





..
   ULAKNET ağı dışından (örneğin üniversite kampüsü dışından) bağlantı sağlıyorsanız:

   * levrek1 için **levrek1.yonetim** ya da ``172.16.7.1``
   * sardalya1 için **sardalya1.yonetim** ya da ``172.16.10.1``
   * barbun1 için **barbun1.yonetim** ya da ``172.16.11.1``

   **Eğer ULAKNET ağı içinden sunuculara bağlantı sağlamak istiyorsanız OpenVPN bağlantısına gerek yoktur.** 


Kullandığınız işlemciye göre kurulum yapmak için aşağıdaki sayfaları ziyaret edebilirsiniz.

.. toctree::
    :maxdepth: 1

    mac_openvpn.rst
    linux_openvpn.rst
    windows_openvpn.rst
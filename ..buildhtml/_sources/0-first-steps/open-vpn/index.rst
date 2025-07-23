.. _open-vpn:
=================================
OpenVPN Bağlantısı
=================================
OpenVPN, sanal özel ağ (VPN) bağlantısı kurmak için kullanılan bir yazılımdır. OpenVPN, kullanıcıların internet üzerinden güvenli bir şekilde veri iletimi yapmalarını sağlar. Bu sayede kullanıcılar, internet üzerindeki verilerini şifreleyerek daha güvenli bir bağlantı elde edebilirler. OpenVPN, genellikle uzaktan erişim, site-to-site bağlantılar ve güvenli veri iletimi için kullanılır.

.. _openvpn-info:

OpenVPN Bağlantısı Hakkında Genel Bilgi
========================================
TRUBA kullanıcıları, TRUBA bilgisayarlarına erişim sağlamak için **OpenVPN** uygulamasını kullanabilirler. 

Kullanıcılar, **OpenVPN** kullanarak TRUBA ağına bağlanabilirler ve kullanıcı arayüzü sunucusuna ulaşabilirler. OpenVPN bağlantısı, sadece kullanıcı adı ve parola kullanarak gerçekleştirilebileceği gibi, bunu desteklemeyen versiyonlarda, TRUBA'dan temin edilecek geçerli bir sertifika ile de gerçekleştirilebilir.

Kullanıcı Adı ve Parola ile OpenVPN Erişimi
===========================================

OpenVPN bağlantısını, herhangi bir sertifikaya ihtiyaç olmadan, TRUBA kullanıcılarının sistem üzerindeki **kullanıcı adı** ve **parolayı** kullanarak gerçekleştirmeleri mümkündür. Kullanıcı adı ve parola kullanarak farklı işletim sistemleri üzerinden bağlantı gerçekleştirmek için OpenVPN'in ilgili sürümü indirilerek,  ilgili yapılandırma dosyası OpenVPN kurulum dizinindeki config dizinine kopyalanmalıdır.

.. note:: 
	
	OpenVPN'nin eski sürümleri kullanıcı adı-parola doğrulamasını desteklemediği için, daha önce yüklenmiş olan OpenVPN programlarının da güncellenmesi gerekmektedir.

Aşağıdaki linklerde farklı işletim sistemleri için OpenVPN dosyalarının linkleri mevcuttur. 

* :download:`OpenVPN genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-genel.ovpn>`
* :download:`OpenVPN Android yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-android.ovpn>`
* :download:`OpenVPN iOS yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-ios.ovpn>`
* :download:`Viscocity genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-viscosity.ovpn>`

.. warning::

   Linklere tıklayarak bilgisayarınızda kullandığınız işletim sistemine uygun dosyayı tıklayarak bilgisayarınıza indirip kaydettikten sonra dosyanın uzantısını kontrol ediniz. Kaydedilen dosya adının **.ovpn** ile bitmesi önemlidir. Bazı sistemlerde ve web tarayıcılarda dosya adının sonuna **.txt** uzantısı eklenebilmektedir. 

Sonraki bölümlerde bu farklı işletim sistemlerinde OpenVPN kurulumları ayrıntılı bir şekilde verilecektir. OpenVPN için gerekli kurulumları yaptıktan sonra kullanıcı arayüzüne aşağıda verilen adreslerden herhangi birine **SSH** protokolü ile ulaşabilirsiniz. :ref:`Windows işletim sistemi için SSH ile bağlantı sağlama kılavuzlarına ulaşmak için tıklayınız... <ssh-baglanti>`

.. note::

   OpenVPN aktif iken 

      - 172.16.6.11 ile arf-ui1,
      - 172.16.6.12 ile arf-ui2,
      - 172.16.6.13 ile arf-ui3,
      - 172.16.6.14 ile arf-ui4,
      - 172.16.6.15 ile arf-ui5,

  kullanıcı arayüzlerinden birisine bağlanabilirsiniz.

.. note:: 

   Aynı anda sadece bir tane aktif OpenVPN bağlantınız olmalıdır. Eğer başka bir cihazda OpenVPN bağlantınız varsa, bu bağlantıyı sonlandırmadan yeni bir bağlantı kurmaya çalışmayınız.
   
.. toctree::
    :maxdepth: 1

    mac_openvpn.rst
    linux_openvpn.rst
    windows_openvpn.rst

    

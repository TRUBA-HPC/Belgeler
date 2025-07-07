.. _open-vpn:

=======================
OpenVPN Bağlantısı 
=======================

OpenVPN, internet üzerinden güvenli ve şifreli bir bağlantı kurmak için kullanılan açık kaynaklı bir VPN (Virtual Private Network) protokolüdür. Özellikle gizliliği korumak, veri güvenliğini sağlamak ve uzaktaki ağlara erişmek amacıyla kullanılır.

Bilgisayarında sabit ve gerçek bir IP adresi tanımlama şansı olmayan kullanıcılar, **OpenVPN** kullanarak TRUBA ağına bağlanabilirler ve kullanıcı arayüzü sunucusuna ulaşabilirler. OpenVPN bağlantısı, sadece kullanıcı adı ve parola kullanarak gerçekleştirilebileceği gibi, bunu desteklemeyen versiyonlarda, TRUBA 'dan temin edilecek geçerli bir sertifika ile de gerçekleştirilebilir.

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

Kullandığınız işletim sistemine göre kurulum yapmak için aşağıdaki sayfaları ziyaret edebilirsiniz.

* :ref:`mac-openvpn`
* :ref:`linux-openvpn`
* :ref:`windows-openvpn`

Bağlantı Sorunları ve Güncel Çözüm Önerileri
--------------------------------------------

OpenVPN bağlantınızda sorun yaşıyorsanız, lütfen aşağıdaki güncel adımları izleyerek problemi gidermeyi deneyin. Buradaki öneriler, yalnızca bir adet OpenVPN bağlantınız olduğunu varsaymaktadır.

1. **OpenVPN bağlantınızı kontrol edin:**  
   - Bağlantınızın aktif ve yalnızca bir cihazda açık olduğundan emin olun.  
   - OpenVPN’in 2.4 veya daha güncel bir sürümünü kullandığınızdan emin olun.

2. **Farklı bir yöntem deneyin:**  
   - Terminal üzerinden SSH ile bağlantı kurmayı deneyin. Aşağıdaki komut ile ayrıntılı hata mesajı alabilirsiniz:

   .. code-block:: bash

      ssh -vv kullanici_adi@arayuz_ip_adresi

   - Kullanıcı arayüz sunucu ip adreslerine :ref:`ARF bağlantı bilgileri <arf_baglanti>` sayfasından ulaşabilirsiniz.

3. **Başka bir cihazdan bağlanmayı deneyin:**  
   - Sorunun kişisel bilgisayarınızdaki ayarlardan (örneğin kişisel güvenlik duvarı veya antivirüs) kaynaklanıp kaynaklanmadığını anlamak için farklı bir bilgisayardan OpenVPN ve SSH bağlantısı kurmayı deneyin.

4. **Farklı bir ağ kullanın:**  
   - Kullandığınız ağda (örneğin kampüs veya kurum ağı) VPN bağlantılarına kısıtlama uygulanıyor olabilir.  
   - Bilgisayarınızı mobil veri (cep telefonu hotspot) gibi farklı bir internet bağlantısına geçirerek tekrar OpenVPN ile bağlantı kurmayı deneyin.  
   - Eğer mobil veri ile bağlantı sağlanabiliyor, kurum ağında sağlanamıyorsa, sorun büyük ihtimalle ağ kısıtlamalarından kaynaklanmaktadır. Bu durumda kurumunuzun ağ yöneticisiyle iletişime geçerek TRUBA'ya giden OpenVPN bağlantılarına izin verilmesini talep ediniz.

Yukarıdaki adımların çoğu bağlantı sorunlarını çözmektedir. Sorununuz devam ederse, aldığınız hata mesajı ve denediğiniz adımlarla birlikte TRUBA destek ekibiyle iletişime geçebilirsiniz.
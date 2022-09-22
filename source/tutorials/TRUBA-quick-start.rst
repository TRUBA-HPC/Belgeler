=================================================
TRUBA Kümelerini İlk Kez Kullanacaklar İçin
=================================================

TRUBA kümelerini ilk kez kullanacaklar için aşağıdaki adımları dikkatle okumasını, verilen linkleri dikkatli takip etmeleri beklenmektedir. Aksi takdirde
sistemlere giriş yaparken problem yaşayabilir, kendi home dizininizde çalıştırdığınız programlardan ötürü hesabınız askıya alınabilir. Aşağıda kullandığınız işletim sisteminize uygun 
adımları izlediğiniz anda **levrek1.ulakbim.gov.tr**  arayüz sunucusuna bağlanmış olacaksınız. **levrek1.ulakbim.gov.tr** herhangi bir web servis sağlayıcısı değildir. 
Dolayısıyla herhangi bir internet tarayıcısından erişim sağlayamazsınız. Aşağıdaki klavuzların yanında TRUBA kullanımını özetleyen iki adet seminer videomuz bulunmaktadır.
İlgili içeriklere aşağıdaki linklerden ulaşabilirsiniz.

**Yeni başlayanlar için TRUBA**
https://indico.truba.gov.tr/event/12/

**Uzmanına Sorun - (TRUBA)**
https://indico.truba.gov.tr/event/11/

------------------------------------------------------------------
**1.** Linux İşletim Sistemi ile TRUBA Kümelerine Bağlantı Kurma   
------------------------------------------------------------------

Öncelikle TRUBA kümelerine bağlantı kurabilmeniz için OPENVPN bağlantısını kurmanız gerekmektedir. Bunun için aşağıda linki verilen adımları izleyebilirsiniz. 

https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/linux_openvpn.html

Bu adımları izledikten sonra ilk gördüğünüz ekran sizin kendi ev dizininizdir. Nerede olduğunuzu kontrol etmek için ``pwd`` komutuyla kontrol edebilirsiniz (ev-dizininiz=/truba/home/kullanici_adi).
Bu dizinde kullanacağınız uygulamaları **çalıştırmamanız** gerekmektedir. Bu diznde programlarınızı derlerken ``srun`` komutu ile boş sunucu almanız, sonrasında derlemeleri yaparken 
birkaç çekirdek istemeniz gerekmektedir. Aksi takdirde ev-dizinini çok meşgul edeceğiniz için sistem otomatik olarak hesabınızı askıya alacaktır.

Hesaplarınızı çalıştırıken  ``/truba_scratch/kullanici_adi`` dizininde çalıştırmanız beklenmektedir. 

Son olarak kullanacağınız paket programların nasıl derleneceğine ilişkin olarak  https://docs.truba.gov.tr/ adresindeki Uygulama Klavuzları menüsünden ulaşabilirsiniz. TRUBA kümeleri
kuyruk sistemi ile çalışmaktadır. İşlerinizi kuyruğa göndermek için **slurm** betik kullanmalısınız. Yine Uyglama Klavuzları menüsünden pekçok program için slurm betik örneklerine 
ulaşabilirsiniz. 


.. warning:: 

  TRUBA sisteminde ``/truba/sw/scripts/`` dizininin altında sizin için hazırlanmış slurm betik örnekleri mevcuttur. Bu örneklerden birini kendi dizininize kopyalarak 
  kendi kullanıcı adınıza uygun olarak hazılayabilirsiniz. 

-------------------------------------------------------------------
**2.** IOS İşletim Sistemi ile TRUBA Kümelerine Bağlantı Kurma   
-------------------------------------------------------------------

Öncelikle TRUBA kümelerine bağlantı kurabilmeniz için 

https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/mac_openvpn.html adresindeki adımları takip etmeniz gerekmektedir. 

Bu adımları izledikten sonra ilk gördüğünüz ekran sizin kendi ev dizininizdir. Nerede olduğunuzu kontrol etmek için ``pwd`` komutuyla kontrol edebilirsiniz (ev-dizininiz=/truba/home/kullanici_adi).
Bu dizinde kullanacağınız uygulamaları **çalıştırmamanız** gerekmektedir. Burada programlarınızı derlerken ``srun`` komutu ile boş sunucu almanız, sonrasında derlemeleri yaparken 
birkaç çekirdek istemeniz gerekmektedir. Aksi takdirde ev-dizinini çok meşgul edeceğiniz için sistem otomatik olarak hesabınızı askıya alacaktır.

Hesaplarınızı çalıştırıken  ``/truba_scratch/kullanici_adi`` dizininde çalıştırmanız beklenmektedir. 

Son olarak kullanacağınız paket programların nasıl derleneceğine ilişkin olarak  https://docs.truba.gov.tr/ adresindeki Uygulama Klavuzları menüsünden ulaşabilirsiniz. TRUBA kümeleri
kuyruk sistemi ile çalışmaktadır. İşlerinizi kuyruğa göndermek için **slurm** betik kullanmalısınız. Yine Uygulama Klavuzları menüsünden pekçok program için slurm betik örneklerine 
ulaşabilirisiniz. 


.. warning:: 

  TRUBA kümelerinde ``/truba/sw/scripts/`` dizininin altında sizin için hazırlanmış slurm betik örnekleri mevcuttur. Bu örneklerden birini kendi dizininize kopyalarak 
  kendi kullanıcı adınıza uygun olarak hazılayabilirsiniz. 

-------------------------------------------------------------------
**3.** Windows İşletim Sistemi ile TRUBA Kümelerine Bağlantı Kurma   
-------------------------------------------------------------------

Windows işletim sistemi için TRUBA kümelerine bağlantı sağlayabilmeniz için  https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/windows_openvpn.html adresindeki adresindeki adımları takip etmeniz 
gerekmektedir. Bunların yanında ençok kullanılan bağlantı ve dosya aktarım uygulamaları için klavuzlara 

https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/index.html#ssh-ile-baglanti

bağlantısından ulaşabilirsiniz. 

Bu adımları izledikten sonra ilk gördüğünüz ekran sizin kendi ev dizininizdir. Nerede olduğunuzu kontrol etmek için ``pwd`` komutuyla kontrol edebilirsiniz (ev-dizininiz=/truba/home/kullanici_adi).
Bu dizinde kullanacağınız uygulamaları **çalıştırmamanız** gerekmektedir. Burada programlarınızı derlerken ``srun`` komutu ile boş sunucu almanız, sonrasında derlemeleri yaparken 
birkaç çekirdek istemeniz gerekmektedir. Aksi takdirde ev-dizinini çok meşgul edeceğiniz için sistem otomatik olarak hesabınızı askıya alacaktır.

Hesaplarınızı çalıştırıken  ``/truba_scratch/kullanici_adi`` dizininde çalıştırmanız beklenmektedir. 

Son olarak kullanacağınız paket programların nasıl derleneceğine ilişkin olarak  https://docs.truba.gov.tr/ adresindeki Uygulama Klavuzları menüsünden ulaşabilirsiniz. TRUBA kümeleri
kuyruk sistemi ile çalışmaktadır. İşlerinizi kuyruğa göndermek için **slurm** betik kullanmalısınız. Yine Uygulama Klavuzları menüsünden pekçok program için slurm betik örneklerine 
ulaşabilirisiniz. 




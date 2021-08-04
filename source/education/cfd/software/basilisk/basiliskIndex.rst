================
BASILISK Klavuzu
================

*******
Kurulum
*******

Bilgisayariniza `BASILISK`_ programinin Linux versiyonunu kurabilmek icin 
`ORACLE VirtualBox`_ uzerine `Ubuntu`_ kurmak uygun olacaktir. 

VirtualBox kurulumu icin assagidaki adimlar takip edilmelidir:

`VirtualBox`_ sayfasindan uygun versiyonu indirmelisiniz.

.. image:: /assets/cfd-education/basilisk/VB1.png
   :align: center
   :width: 400px

Kurulum dosyasini indirdikten sonra assagidaki adimlari takip etmelisiniz.

.. image:: /assets/cfd-education/basilisk/VB2.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB3.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB4.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB5.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB6.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB7.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB8.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/VB9.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U1.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U2.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U3.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U4.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U5.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U6.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U7.png
   :align: center
   :width: 400px

Yeterli alanınız varsa 20 GB olacak şekilde ayarlamanız önerilir. Burada 
Ubuntu’nun sitesinden indirilen işletim sistemi dosyasını seçiyoruz. *Ubuntu 
Desktop* için ``.iso`` dosyasi indirirken, *LTS (Long Term Support)* ozelliği 
olan bir version secmek dogru olacaktir.

Iso dosyasinin yerini Oracle VM BirtualBox programina assagidaki gibi 
gosterebilirsiniz:

.. image:: /assets/cfd-education/basilisk/U8.png
   :align: center
   :width: 400px

``TAMAM`` diyoruz.

.. image:: /assets/cfd-education/basilisk/U9.png
   :align: center
   :width: 400px

VM VirtualBox kurulduktan sonra ``New`` ‘a tıklıyoruz. Acilan ekranda Ubuntu 
kurulumunu assagidaki gibi gerceklestirebilirsiniz.

.. image:: /assets/cfd-education/basilisk/U10.png
   :align: center
   :width: 400px

Gelen ekranda otomatik olarak Install ubuntu gelebilir ya da reismdeki gibi
olabilir. Ona tıklıyoruz.

.. image:: /assets/cfd-education/basilisk/U11.png
   :align: center
   :width: 400px

İşletim sistemi dilini hangi dilde kullanmak istiyosak seçiyoruz.

.. image:: /assets/cfd-education/basilisk/U12.png
   :align: center
   :width: 400px

Klavye dilini seçiyoruz alttaki boşluğa yazarak klavye dilini 
deneyebilirsiniz.

.. image:: /assets/cfd-education/basilisk/U13.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U14.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U15.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U16.png
   :align: center
   :width: 400px

Bilgisayar ismini hesap ismini ve şifremizi tanımlıyoruz.

.. image:: /assets/cfd-education/basilisk/U17.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/U18.png
   :align: center
   :width: 400px

İşletim Sistemi yükleme ekranı

.. image:: /assets/cfd-education/basilisk/U19.png
   :align: center
   :width: 400px

Yükleme işi tamalandığında ``Restart Now``’a tıklıyoruz.

.. image:: /assets/cfd-education/basilisk/U20.png
   :align: center
   :width: 400px

Görüntü ayarlarını değiştrime zamanı. Masaüstüne sağ tıklıyoruz ``Display Settings`` e basıyoruz.

.. image:: /assets/cfd-education/basilisk/U21.png
   :align: center
   :width: 400px

Resolution’dan istenen ekran kalitesini seçiyoruz.

`EMACS`_ kurma zamanı: Komutu görüldüğü gibi yazıyoruz. Linux uzerinde 
terminalden calisirken dosyalara yasmak icin EMACS programini 
kullanabilirsiniz.

.. image:: /assets/cfd-education/basilisk/E1.png
   :align: center
   :width: 400px

Şifremizi istiyor giriyoruz Klavyemizde ``Enter`` tuşuna basıyoruz.

.. image:: /assets/cfd-education/basilisk/E2.png
   :align: center
   :width: 400px

Klavyemizde ``Y`` tuşuna basıp ``Enter`` tuşuna basıyoruz

.. image:: /assets/cfd-education/basilisk/B1.png
   :align: center
   :width: 400px

Basilisk’I tarball olarak kurmak için gösterilen komutu yazıyoruz.

.. image:: /assets/cfd-education/basilisk/B2.png
   :align: center
   :width: 400px

Yükleme işi tamamlandıktan sonra dosyayı açabilmek için en alttaki komutu 
yazıyoruz.

.. image:: /assets/cfd-education/basilisk/B3.png
   :align: center
   :width: 400px

Compilerı kurma zamanı. Yazılan komutları giriyoruz.

.. image:: /assets/cfd-education/basilisk/B4.png
   :align: center
   :width: 400px

Compilerın kurulma aşaması için make ``-k`` yazıyoruz ancak hata veriyor. 
Verilen hatadaki çözümmleri uygulayalım.

.. image:: /assets/cfd-education/basilisk/B5.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/B6.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/B7.png
   :align: center
   :width: 400px

Tekrar deniyoruz ve yine çalışmıyor.

.. image:: /assets/cfd-education/basilisk/B8.png
   :align: center
   :width: 400px

make komutunu kurabilmek için yukarıdaki kodu yazıyoruz.

.. image:: /assets/cfd-education/basilisk/B9.png
   :align: center
   :width: 400px

Ayrıca Basilisk’I kullanırken ihtiyacımızın olacağı komutları da kuruyoruz.

.. image:: /assets/cfd-education/basilisk/B10.png
   :align: center
   :width: 400px

Her şey hatasız giderse klavede ``Y`` tuşuna basıp ``Enter`` tuşuna basıyoruz.

Kurulum aşamamız bitti.

*********
Başlangıç
*********
Eğitimden daha fazla yararlanabilmek için en azından minimum düzeyde kabuk
komutları bilgisine sahip olmanızı öneririm. Bu konuyla ilgili birçok 
çevrimiçi eğitimden biriyle başlamak isteyebilirsiniz.

.. image:: /assets/cfd-education/basilisk/Bas1.png
   :align: center
   :width: 400px

Bu komutu kullanarak Emacs’I başlatabilirsiniz. Komutun sonundaki ``&`` 
işareti Emacs üzerinden değişiklik yaparken terminale de Emacsı kapatmadan 
erişebilmenizi sağlar.

.. image:: /assets/cfd-education/basilisk/Bas2.png
   :align: center
   :width: 400px

Standard Emacs giriş ekranı.

.. image:: /assets/cfd-education/basilisk/Bas3.png
   :align: center
   :width: 400px

Bu komutla derleyicinin güncel olup olmadığını kontrol edebilirsiniz. Ayrıca
derleyiciyi yüklerken hata yaptıysanız burda da hata mesajı alacaksınız.

**************
İlk Simulasyon
**************
Artik BASILISK programini calistirabiliriz.

.. image:: /assets/cfd-education/basilisk/S1.png
   :align: center
   :width: 400px

Emacs’ın giriş ekranından ``File > Visit New File``’a tıklayın.

.. image:: /assets/cfd-education/basilisk/S2.png
   :align: center
   :width: 400px

Burası bizim ilk kodumuzu kuracağımız dosya. Name ksımının yanına ``bump.c``
yazıp Enter’a basın.

.. image:: /assets/cfd-education/basilisk/S3.png
   :align: center
   :width: 400px

Yukarıdaki gibi önümüze açılan boş sayfaya bu konutu yazın. Tahmin 
edeceğiniz üzere simülasyon yapılırken hesaplamalar *saint-venant* 
prensibiyle yapılacak.

.. image:: /assets/cfd-education/basilisk/S4.png
   :align: center
   :width: 400px

Ozaman ilk simulasyonu yapabiliriz. Terminal’e ``qcc bump.c`` yazdık ama 
çalışmadı çünkü kullanmak istediğimiz fonksiyonlar genelde ``math.h`` 
kütüphanesinin içerisinde. Ayrıca kodda main fonksiyonu tanımlanmadı.

.. image:: /assets/cfd-education/basilisk/S5.png
   :align: center
   :width: 400px

``run()`` komutu simulasyonun çalışmasını sağlayan fonskiyon.

.. image:: /assets/cfd-education/basilisk/S6.png
   :align: center
   :width: 400px

Terminal’e qcc ``bump.c`` yazdık ama çalışmadı çünkü kullanmak istediğimiz 
fonksiyonlar genelde math.h kütüphanesinin içerisinde.

.. image:: /assets/cfd-education/basilisk/S7.png
   :align: center
   :width: 400px

Hatayı düzeltmek için kodun sonuna ``-lm`` yazıyoruz. Math.h kütüphanesi 
gerekmeden kod hatsız bir şekilde compile oluyor.

.. image:: /assets/cfd-education/basilisk/S8.png
   :align: center
   :width: 400px

Terminal’e ``ls`` yazdığımızda içinde bulunduğumuz dosyanın içindeki 
dökümanlar listeleniyor. ``a.out`` diye yeni bir dosya oluşmuş. Hadi onu açalım!

.. image:: /assets/cfd-education/basilisk/S9.png
   :align: center
   :width: 400px

İlk Basilisk simulasyonumuz tamamlandı.

.. image:: /assets/cfd-education/basilisk/S10.png
   :align: center
   :width: 400px

burada ``-O2`` optimizasyonu açar (bu, kodu daha hızlı hale getirir), 
``-Wall`` tüm derleme uyarılarını açar (bu, programınızdaki olası hataları 
yakalamanıza olanak tanır) ve ``-o bump``, derlenen programı bump (a.out 
yerine) olarak yeniden adlandırır. 

*************************
Daha Gelişmiş bir Program
*************************
.. image:: /assets/cfd-education/basilisk/G1.png
   :align: center
   :width: 400px

Burada yaptığımız şey, çözücüye 10 zaman adımı yapması ve ardından 10 zaman
adımından sonra ulaştığı zaman adımı sayısını ve ulaştığı fiziksel zamanı
yazdırması söylenir.

.. image:: /assets/cfd-education/basilisk/G2.png
   :align: center
   :width: 400px

Tekrar derledigimizde,

.. image:: /assets/cfd-education/basilisk/G3.png
   :align: center
   :width: 400px

İlk satır kodumuzdan gelir ve ikinci satır basilisk'in varsayılan çıktısıdır.
Gerçekleştirilen zaman adımlarının sayısını, hesaplama için kullanılan CPU 
zamanını, geçen gerçek zamanı, karşılık gelen hesaplama hızını (gerçek zamana
dayalı olarak) ve çözücü tarafından tahsis edilen toplam alan sayısını verir.

*******************
Başlangıç Koşulları
*******************
aaaa

-------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
.. _BASILISK: http://basilisk.fr/
.. _ORACLE VirtualBox: https://www.virtualbox.org/
.. _Ubuntu: https://ubuntu.com/
.. _VirtualBox: https://virtualbox.org/wiki/Downloads
.. _EMACS: https://www.gnu.org/software/emacs/
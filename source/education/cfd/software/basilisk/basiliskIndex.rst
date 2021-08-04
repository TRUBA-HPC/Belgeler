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
.. image:: /assets/cfd-education/basilisk/K1.png
   :align: center
   :width: 400px

bu, kutumuzu koordinat sisteminin orijininde ortalayacaktır.

.. image:: /assets/cfd-education/basilisk/K2.png
   :align: center
   :width: 400px

``Init event`` sadece simülasyonun başlangıcında gerçekleşecektir (t=0). Olayın
gövdesi içinde, h alanının (Saint-Venant çözücüsünde tanımlandığı ve 
belgelendiği şekliyle sıvı katmanın derinliği) değerlerini ayarlamak için 
Basilisk'e özgü foreach iterator’ı kullanırız. Karakteristik yarıçapı 
1/sqrt(200), genlik 1, sabit derinlik 0.1 olan bir katmanın üstünde olan bir
Gauss tümseği kullanıyoruz. x ve y koordinatları, ``foreach`` operatörü 
tarafından örtük olarak tanımlanan çift değerlerdir.

.. image:: /assets/cfd-education/basilisk/K3.png
   :align: center
   :width: 400px

Tekrar compile edip sonuca bakıyoruz.

.. image:: /assets/cfd-education/basilisk/K4.png
   :align: center
   :width: 400px

Kodumuzu resim çıktısı alabilecek şekilde güncelledik.

.. image:: /assets/cfd-education/basilisk/K5.png
   :align: center
   :width: 400px

Tekrar compile ettiğimizde sonuç garip çıkıyor. Ancak bu çok normal çünkü 
grafiksel olması gereken çıktıyı karakter olarak almaya çalışıyoruz.

.. image:: /assets/cfd-education/basilisk/K6.png
   :align: center
   :width: 400px

Çıktıyı o zaman resim dosyası na dönüştürme zamanı

.. image:: /assets/cfd-education/basilisk/K7.png
   :align: center
   :width: 400px

``.ppm`` şeklindeki resim dosyalarını açabilmek için gerekli kod.

.. image:: /assets/cfd-education/basilisk/K8.png
   :align: center
   :width: 400px

Artık çıktımızı açma zamanı.

.. image:: /assets/cfd-education/basilisk/K9.png
   :align: center
   :width: 400px

Çok küçük olmasına ragmen bir görüntü alabildik. Bunun sebebi grid’in 
otomatik olarak 64x64 seçilmesi yani görüntü kalitemiz küçük. Bunu ilerde 
arttıracağız. Ayrıca 10 timestepi boşluk tuşuna basarak görebiliriz.

.. image:: /assets/cfd-education/basilisk/K10.png
   :align: center
   :width: 400px

Timestep sayısını 10 dan 300 e çıkararak daha uzun bir simulasyon elde 
edebileceğiz.

.. image:: /assets/cfd-education/basilisk/K11.png
   :align: center
   :width: 400px

Compile edip resime dönüştürüp çalıştıralım.

.. image:: /assets/cfd-education/basilisk/K12.png
   :align: center
   :width: 400px

300 tane resimimiz var sürekli boşluk tuşuna basamayız oyüzden animasyon 
haline getirmemiz gerek.

.. image:: /assets/cfd-education/basilisk/K13.png
   :align: center
   :width: 400px

Bu komutu kullanalım.

.. image:: /assets/cfd-education/basilisk/K14.png
   :align: center
   :width: 400px

İlk animasyonumuzu elde ettik.

.. image:: /assets/cfd-education/basilisk/K15.png
   :align: center
   :width: 400px

Zamanın fonksiyonları olarak minimum ve maksimum derinliklerin değişimi ile
ilgilendiğimizi varsayalım.

İlk satırda, s yapısını h alanındaki istatistiklerle dolduran Basilisk'in 
``statsf()`` fonksiyonunu çağırıyoruz. İkinci satırda, standart C dosyası 
``stderr``'de süreyi, minimum ve maksimumu (h) yazmak için standart C fonksiyonu
``fprintf()`` kullanıyoruz. stderr, "standart hata" anlamına gelir ve varsayılan
olarak ekran alınır.

.. image:: /assets/cfd-education/basilisk/K16.png
   :align: center
   :width: 400px

Compile edelim. Bu sefer elimizde istatistik verileri de var. onları da 
log dosyasına atacağız.

.. image:: /assets/cfd-education/basilisk/K17.png
   :align: center
   :width: 400px

Log’u bukomutla açabiliyoruz.

.. image:: /assets/cfd-education/basilisk/K18.png
   :align: center
   :width: 400px

Bu komut sayesinde verilerimizi grafiğe dökebileceğiz.

.. image:: /assets/cfd-education/basilisk/K19.png
   :align: center
   :width: 400px

Bu komutlarla birlikte grafikte x çizgisinin başlığı, y çizgisinin başlığı, 
ve grafiklerin neyi temsil ettiği gösterilecek.

.. image:: /assets/cfd-education/basilisk/K20.png
   :align: center
   :width: 400px

Komutlar yazıldıktan sonra çıkan pencere.

.. image:: /assets/cfd-education/basilisk/K21.png
   :align: center
   :width: 400px

İlk animasyonumuz küçük kalmıştı. ``Init_grid(256)`` sayesinde animasyonumuz 
64x64 grid noktasına değil 256x256 tane grid noktasına sahip olacak (4x4=16
kat daha yüksek çözünürlüklü).

Aynı şekilde compile edip resme çevirip animate komutunu yazıyoruz. Daha 
yüksek çözünürlüklü olduğu için daha büyük bir pencere elde ediyoruz. Ayrıca
bilgisayarın hesaplaması daha uzun sürecek.

.. image:: /assets/cfd-education/basilisk/K22.png
   :align: center
   :width: 400px

Bu komutla birlikte simulasyonun yapılması için harcanan zamanın 16.78 
olduğunu görüyoruz.

.. image:: /assets/cfd-education/basilisk/K23.png
   :align: center
   :width: 400px

Simulasyonun hesaplanma süresini düşürmek adına quadtree grid’inden daha 
basit bir grid olan cartesian grid’e geçiyoruz.

.. image:: /assets/cfd-education/basilisk/K24.png
   :align: center
   :width: 400px

Kütüphane tanımlama kodunu yanlış yere yazdığımdan dolayı hata aldım. En üste
yazılması gerekiyor.

.. image:: /assets/cfd-education/basilisk/K25.png
   :align: center
   :width: 400px

Hata giderildi. Hadi compile edelim!

.. image:: /assets/cfd-education/basilisk/K26.png
   :align: center
   :width: 400px

Burdan anlaşılacağı üzere simülasyonun hesaplanması için harcanan zaman 16.78 den 9.44 e 
düşüyor.

.. image:: /assets/cfd-education/basilisk/K27.png
   :align: center
   :width: 400px

Zaman adımı 3 boyutlu çözünürlük tarafından kontrol edildiğinden, fiziksel sonuçların zaman 
adımı sayısı olarak ifade edilen düzenli aralıklarla çıktısını almak genellikle iyi bir fikir
değildir. Sonuçların fiziksel zaman birimleriyle ifade edilen aralıklarla çıktısını almak 
daha mantıklıdır.

Örneğin, bizim durumumuzda, ilk simülasyonumuzun yaklaşık t=4 (ilk grafiğe bakın) bir süreye
ulaştığını ve oluşturduğumuz 300 görüntünün dalga yayılımının güzel bir animasyonunu elde 
etmek için yeterli olduğunu biliyoruz. Ancak, bu sonuçları daha yüksek çözünürlükte çoğaltmak
istiyorsak, programımızı bu şekilde değiştirmemiz gerekiyor.

.. image:: /assets/cfd-education/basilisk/K28.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/K29.png
   :align: center
   :width: 400px

.. image:: /assets/cfd-education/basilisk/K30.png
   :align: center
   :width: 400px

Piklerin ve süreksizliklerin daha yüksek çözünürlükte kesinlikle daha keskin olduğunu 
görüyoruz. Grafiklerin diğer kısımları oldukça yakın olmasına rağmen, tepelerin genliklerinin
yakınsak (convergant) olup olmadığını görmek için daha da yüksek bir çözünürlük denemek 
isteyebiliriz.

.. image:: /assets/cfd-education/basilisk/K31.png
   :align: center
   :width: 400px

Animasyon ve grafiklerden, incelediğimiz dalgaların karakteristik ölçeklerinin sabit olmadığı
hissini sezgisel olarak alıyoruz. Bazı alanlar çok düzgün ve hiçbir belirgin özelliği yok, 
diğer alanlar ise ince ayrıntılar içeriyor (örneğin etkileşen şoklar). Açıkçası, her yerde 
yüksek çözünürlüğe ihtiyaç duyulmaz ve çözünürlük çözüme uyarlanırsa hesaplama muhtemelen 
daha hızlı yapılabilir. Bu değişken çözünürlüğün de hareketli ayrıntıları takip etmek için 
zaman içinde gelişmesi gerekir.

.. image:: /assets/cfd-education/basilisk/K32.png
   :align: center
   :width: 400px

Basilisk'e çözünürlüğü h alanının (dalgacık tahmini) ayrıklaştırma hatasına göre uyarlamasını
söyledik. Bu uyarlama her zaman adımında (i++) yapılır. Ayrıklaştırma hatası 4e-3 tenda ha 
büyük olduğunda, mesh, maksimum 8 dörtlü ağaç seviyesine kadar iyileştirildi.

.. image:: /assets/cfd-education/basilisk/K33.png
   :align: center
   :width: 400px

Çıkan sonucun kalitesi düştü. Simulasyon hesaplama süresi de düştü.

.. image:: /assets/cfd-education/basilisk/K34.png
   :align: center
   :width: 400px

Bunun yerine bilinear enterpolasyonu kullanmak için output_ppm() fonksiyonunu böyle 
çağırmamız gerekir.

.. image:: /assets/cfd-education/basilisk/K35.png
   :align: center
   :width: 400px

Görüntü kalitesi çok daha iyi.

.. image:: /assets/cfd-education/basilisk/K36.png
   :align: center
   :width: 400px

Simulasyon hesaplama süresi gördüğünüz üzere 1.66 ya düştü.

.. image:: /assets/cfd-education/basilisk/K37.png
   :align: center
   :width: 400px

Peki alınan verilerin kalitesine ne oldu? Bunu gözlemlemek için *gnuplot* kullanalım. Eski 
verileri log.64 diye kaydettik. Yeni veriler log olarak kayıtlı.

.. image:: /assets/cfd-education/basilisk/K38.png
   :align: center
   :width: 400px

Gördüğünüz üzere sonuç çok yakın ama tamamen aynı değil. Hesaplama süresi ve doğruluk 
arasındaki doğru dengeyi bulmak, sayısal simülasyonları kurmanın önemli bir parçasıdır.

Animasyonumuz şimdi iyi görünse de, ilk animasyonda (kısmen) kodlanmış olan ızgara boyutu 
hakkındaki bilgileri kaybettik. Simülasyon sırasında kullanılan ızgaranın bir animasyonunu 
oluşturabilir miyiz?

.. image:: /assets/cfd-education/basilisk/K39.png
   :align: center
   :width: 400px

İlk önce yeni bir skaler alan l ilan edip allocate ediyoruz. Bu alan lokal, otomatik bir 
değişkendir, yani yalnızca images event’i içinde erişilebilir olacaktır. Alan değerlerini 
saklamak için gerekli olan bellek, kod bu fonksiyondan çıktığında otomatik olarak 
boşaltılacaktır.

Daha sonra tüm hücreler üzerinde dolaşıyoruz ve l değerlerini hücrenin düzeyine ayarladık.

Sonraki satır, statik bir değişken, yani görüntülere yapılan çağrılar arasında (otomatik 
değişkenlerin aksine) bellekte tutulan bir değişken bildirir. Bu değişken yalnızca bir kez 
ayarlanır, ilk görüntüler çağrıldığında ve içine şeyler yazacağımız (“w”) grid.ppm adlı yeni
bir dosyaya işaret eder. Bu, standart C fonksiyonu fopen() kullanılarak yapılır.

Terminal’e ``animate grid.ppm`` yazıldığında,

.. image:: /assets/cfd-education/basilisk/K40.png
   :align: center
   :width: 400px

Elde edilen sonuç.

*********************
Macro’ları kullanalım
*********************
Örneğimizin sayısal converge etmesini biraz daha irdelemek iyi bir fikir olacaktır. Bunu 
yapmak için çözünürlüğü değiştirirken aynı kodu çalıştırmamız gerekiyor. Kodu elle 
düzenleyebilir, her referansı çözümleme, yeniden derleme, yeniden çalıştırma vb. olarak 
değiştirebilirdik ama bu oldukça sıkıcı ve hataya açık olurdu. Bunu yapmanın daha iyi bir 
yolu, standart C makrolarını (hazırlık çalışmanız sırasında zaten karşılaşmış olmanız gereken)
kullanmaktır.

Kodumuza bakarsak, çözünürlük veya iyileştirme seviyesinin üç kez gerçekleştiğini görürüz. 
Bir kez output_ppm() argümanı olarak, bir kez ``adapt_wavelet()`` argümanı olarak ve bir kez
de ``main()`` işlevinde ``init_grid()`` argümanı olarak.

Bu üç değeri manuel olarak değiştirmek yerine:

.. image:: /assets/cfd-education/basilisk/K41.png
   :align: center
   :width: 400px

Bu kodları yazabiliriz.

Tek bilmeniz gereken, makro seviyesi her üç yerde de 8 ile değiştirilecektir. Simülasyonun 
çözünürlüğünü değiştirmek istiyorsak, şimdi tek yapmamız gereken dosyanın üstündeki tek 
değeri değiştirmek.

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

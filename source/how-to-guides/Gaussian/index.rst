.. _gaussian-kilavuzu:

=================================
Gaussian Kılavuzu
=================================

Altyapıda Gaussian'ın farklı versiyonları sıkıntısız bir şekilde çalışmaktadır. En yüksek performansı almak için işin gönderileceği işlemciye uygun (AMD, Intel AVX, AVX2 ve AVX512) Gaussian versiyonunu kullanmak önemlidir. Aksi taktirde eski nesil işlemciler ile yeni nesil işlemciler üzerinde çalışan uygulamada sadece frekans hızından kaynaklı bir farklılık hissedilebilir. 

Gaussian'da (tüm versiyonları için) performansı, aynı zamanda diğer kullanıcıların işlerinin performansını, etkileyen bir diğer durum ise işin çalışması sırasında oluşturulan geçici dosyaların hangi dizinde oluşturulacağıdır. **Gaussian yoğun biçimde I/O işlemleri yapan bir uygulamadır.** Bu nedenle geçici dosyalar kullanıcın ev dizininde değil, işin çalıştığı **hesaplama sunucusunun yerel /tmp dizininde** oluşturulmalıdır. Bu şekilde Gaussian'ın I/O işlemlerinden hem diğer kullanıcıların işleri etkilenmeyecek, hem de yerel disklerin erişim hızları yüksek olduğu için Gaussian'ın genel performansı yükselecektir.


Gaussian binary olarak dağıtılan bir paket olduğu için, sadece arşiv paketini açmak kurulum için yeterlidir, herhangi bir derlemeye gerek bulunmamaktadır. Öncelikle Gaussian'ın kurulum dosyalarına sahip olmak ve bunu ev dizine kopyalamış olmak gereklidir. Kurulum herhangi bir dizine yapılabilir. Örnegin adı AS4_111N.TGZ (sizdeki dosyanın adı farklı olabilir) olan Gaussian dosyamızı aşağıdaki örnekte belirtildiği gibi kurabiliriz. 

.. code-block::

    $> cd /truba/home/username
    $> mkdir gaussian
    $> cd gaussian
    $> tar -zxvf AS4_111N.TGZ

Bu komut sonrasında **AS4_111N.TGZ** adındaki gaussian paketi ev dizini içerisinde **g09** dizinine açılmış olacaktır. Sizdeki Gaussian paketinin adı farklı olabilir. **Eğer Gaussian09 yerine Gaussian16 paketi arşivden çıkarılıyorsa g09 yerine g16 dizini oluşturulacaktır.**

Yapılmış bu kurulumu kullanmak için bazı çevre değişkenleri tanımlanmalıdır. Bu tanımlar ``.profile`` (ya da ``.bashrc``) dosyasının içinde yapılabileceği gibi slurm dosyasının içerisinde de yapılabilir. 

.. code-block::

    export g09root=$HOME
    export GAUSS_SCRDIR=/tmp
    . $g09root/g09/bsd/g09.profile

Uygulamayı çalıştırmak için aşağıdaki komut yeterli olacaktır:

.. code-block::

    $g09root/g09/g09 < input_dosyası

**Gaussian16 işin yukarıdaki g09 ifadeleri g16 ile değiştirilmelidir.**    

Gaussian'ı çalıştırmak için örnek betik ve input dosyası **/truba/sw/scripts** dizini içerisinde bulunmaktadır. 


Gaussian uygulaması **$GAUSS_SCRDIR** dizininde (bu durumda **/tmp**) oldukça fazla artık dosya bırakır. Bu artık dosyalar hesaplama sunucusunun yerel diskini çok hızlı bir şekilde doldurur ve yeni işlerin çalışması pek çok durumda mümkün olmayabilir. O nedenle bu dosyaların iş sonunda silinmesi gerekmektedir. Bunun iki yolu bulunmaktadır:

* Gaussian input dosyasında **%nosave** opsiyonu kullanmak (detaylar için Gaussian dökümanlarına bakınız).

* Betik dosyasında 

.. code-block::

    $g09root/g09/g09 < input_dosyası 

satırından sonra

.. code-block::

    find /tmp -maxdepth 1 -user $USER -exec rm -rf '{}' \;

komutunu kullanarak /tmp dizinindeki kullanıcıya ait tüm dosyaların silinmesi. 

.. warning::

    Bu durumda aynı sunucu üzerinde kullanıcının birden fazla işi varsa, çalışmaya devam eden işler zarar görebilir. 

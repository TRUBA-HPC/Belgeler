.. _genelkurulum-kilavuzu:

========================================
TRUBA'da Uygulama/Kütüphane Kurulumu
========================================

Yaygın kullanılmakta olan pek çok uygulamanın/kütüphanenin farklı versiyonlarının kurulumları hali hazırda merkezi dizinlere bulunmaktadır.

.. note::

    /truba/sw/centosX.X/app  --> uygulamalar için 

    /truba/sw/centosX.X/lib  --> kütüphaneler için

    /truba/sw/centosX.X/comp --> derleyiciler için

Merkezi kurulumları kullanabilmek için ilgili yazılımın ve bağlantılı kütüphanelerin modüllerinin "load" edilmesi yeterlidir.Sistemde hali hazırda kurulu olan programlar hakkındaki bilgiye terminalden

.. code-block::

    module available

komutunu yazarak ulaşabilirsiniz. İlgili komutu yazdığınızda TRUBA sisteminde halihazırda kurulu olan derleyiciler, kütüphaneler ve de uygulamalar listelenecektir.

Uygulamaların ve modüllerin isimlendirilme sistematiği ve kullanımı hakkında ayrıntılı bilgi için lütfen :ref:`moduller-truba` dökümanına göz atınız. 

Kullanıcılarımıza merkezi dizinlerdeki kurulumları kullanmalarını öneririz. Ancak kullanılmak istenen yazılım merkezi dizinde kurulu değilse, ya da mevcut kurulum  ihtiyacı karşılamıyorsa (versiyon, derleme seçenekleri vs),  yazılımın kullanıcının kendi ev dizinine, yine kullanıcı tarafından yapılması gerekmektedir.

İnternetten indirilecek yazılımlar binary paket (hazır derlenmiş) ya da kaynak kod olarak dağıtılır.   

Binary paketlerin tekrar derlenmesine ihtiyaç yoktur. Sisteme uygun şekilde derlenmiş paketin indirilerek, paketin çalışması ya da paket kurulum uygulamasının çalıştırılması yeterlidir. Paket açılırken paketlerin kullanıcı ev dizinine açılması, ve kurulumun kullanıcı ev dizinine yapılması gerekmektedir. Her yazılıma göre paket açılması ve uygulamanın kurulması farklılık gösterebilir. O nedenle bu aşamada uygulamaya ait kullanıcı el kitabının takip edilmesi önemlidir.

Kaynak kod olarak dağıtılan uygulamaların mevcut sistem üzerinde, sistemdeki derleyiciler ve kütüphaneler kullanılarak derlenmesi ve kullanıcı ev dizinine yüklenmesi gerekmektedir. Bazı uygulamaların derlenmesi hakkında `TRUBA dökümantasyon sayfamızda <https://docs.truba.gov.tr>`_ ayrıntılı bilgi bulunmaktadır. Bu bilgiler eskimiş, ya da kullanılmak istenen versiyon için uygun olmayabilir, güncel bilgiler için ilgili uygulamanın el kitabı dikkatlice takip edilmelidir. Ancak genel mekanizma tüm uygulama ve versiyonlar için aşağı yukarı aynıdır.

1- kaynak dosya açılılır.  (Genelde ``tar -zxvf  uygulama_adi.tar.gz``)

2- oluşan dizine girilir 

.. code-block::
    cd yeni_oluşan_dizin)

3- Makefile dosyası oluşturulur 

.. code-block::

    ./configure --prefix=/truba/home/kullanici_adi/yukleme_dizini

Bu aşamada kullanıcılacak ek kütüphane ve derleyicilere göre farklı ``configure`` komutunda opsiyonlarının kullanılması söz konusu olabilir. Uygulamanın el kitabına bakılmalıdır.

.. code-block::

    ./configure --help 

komutu ile de kurulum seçenekleri listelenebilir.

4- derlemenin başlatılması

.. code-block::
    make -j 4

5- derlenmiş dosyaların "yukleme_dizini" ne kurulması 

.. code-block::
    make install

Bazı uygulamalar ``make`` yerine ``cmake`` (make'in GUI'li versiyonu) kullanabilir. Uygulama kitapçığına göre kurlum adımlarına devam edilmelidir.

.. warning::

    Sistemde ``yum``, ``apt``, ``apt-get``, ``sudo`` vs gibi komutlarla uygulama kurulması mümkün degildir. Sudo ve paket yöneticileri ile kurulacak tüm uygulamalar kurulum yapılan bilgisayarın yerel diskine kurulacağı için bu kurulumlara hesaplama sunucularının erişmesi mümkün olmayacaktır. 

Temel düzeyde TRUBA kullanıcı eğitimi ve uygulama kurulumu hakkında ayrıca aşağıdaki dökümanlara ve bu konuda daha önce ekibimiz tarafından verilen seminerlere göz atınız.


:ref:`uygulama-kilavuzlari`

:ref:`baslangic-seminerleri`
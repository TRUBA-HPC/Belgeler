.. _sik_kullanilan_linux_komutlari:

=================================================
TRUBA Sisteminde Çok Kullanılan Linux Komutları 
=================================================

Bir TRUBA kullanıcısı olarak, sık kullanılan komutları öğrenmeniz, sistemimiz üzerinde daha
fazla kontrol sahibi olmanızı, daha üretken, daha  hızlı olmanızı ve çok daha fazlasını yapmanızı sağlar. Zaman alan görevleri otomatikleştirmek için komut dosyaları yazabilir ve yalnızca birkaç basit komutla hızla bir şekilde  Git deposundan kod çekebilirsiniz. Sistemimizde en çok kullanılan komutlar aşağıda sıralanmıştır.

**1.** ``ssh``

Çalıştırdığınız işletim sistemine bağlı olarak uzak bir makineyle bağlantı kurmanın birçok yolu vardır. Linux tabanlı makineler için  Secure Shell (SSH) protokolü kullanılır. 
Bu yüzden TRUBA kümelerine bağlantı yapabilmek için ``ssh`` komutunu kullanabilirsiniz. Kullanım şekli aşağıda verildiği gibidir.  
 
.. code-block:: bash
   
   ssh kullanici_adi@172.16.11.1

**2.** ``pwd``

ssh protokolü ile TRUBA'ya başarıyla bağlandıktan sonra, ``pwd`` (present working directory) komutu ile hangi dizinde olduğunuzu kolayca görmek için kullanabilirsiniz. TRUBA kümelerine ilk bağlantıyı yaptıktan sonra komut satırına ``pwd`` yazdığınızda ekranda ``/truba/home/kullanici_adi`` yazdırılacaktır. 

**3.** ``ls``
 
``ls`` komutu kullanarak bulunduğunuz dizindeki dosyaları listeleyebilirsiniz. ``ls`` komutunu bir takım alfabetik tag'lerle kullanarak  bu komutun kullanımını özelleştirebilirisiniz (Ör: ``ls -al``  : Dosya ve dizinleri ayrıntılı listelemek için kullanılır.). Bu alfabetik tag'ler ve anlamlarını 

.. code-block:: bash

  ls --help 

komutuyla inceleyebilirsiniz. 

**3.** ``cd``

Herhangi dizine geçmek istediğiniz zaman kullanabilirsiniz. Örneğin TRUBA sistemine ilk bağlandığınızda içinde bulunduğunuz dizin  **/truba/home/kullanici_adi** ' dir. Hesaplarınızı yapacağınız /truba_scratch dizinine geçmek için aşağıdaki komut satırını kullanabilirsiniz. 

.. code-block:: bash

  cd /truba_scratch/kullanci_adi

Kendi ev-dizininize kolayca dönmek için ``cd ~``, root dizinine geçmek için ``cd /``, bir alt dizine geçmek için ``cd ..`` komutlarını kullanabilirsiniz. 

.. warning::

  Hesaplarınızı TRUBA kümelerine ilk bağlantı kurduğunuz dizin /truba/home/kullanici_adi dizinidir. Lütfen hesaplarınızı bu dizinde yapmayınız. Hesaplarınızı **/truba_scratch/kullanici_adi** 
  dizininde yapmalısınız. 

**4.** ``cp``

Dizinlerdeki dosyaları başka bir isimle aynı dizine kopyalacağınız gibi, başka bir dizine de direkt kopyalayabilirsiniz. Örneğin bir dizindeki job.slurm isimli dosyayı calc.slurm isimli bir dosya
olarak kopyalamak için 

.. code-block:: bash
  
  cp job.slurm calc.slurm 

Kendi ev dizinimizde olan bir dosyayı /truba_scratch/kullanici_adi dizinine kopyalamak için aşağıdaki komut satırını kullanabiliriz. 

.. code-block:: bash
 
  cp job.slurm  /truba_scratch/kullanici_adi

Yukarıdaki örnekler bir dosyayı bir dizine kayıt etmekle ilgiliydi. Bazen direkt dizinleri kopyalamamız gerekir. O zaman ``cp -r dizin_adi kopyalanacagi_adres`` şeklinde kullanabiliriz.


**5.** ``mv``

Dosyalarımızın ve dizinlerimizin isimlerini değiştirmek için kullanabiliriz.

``mv file1 file2`` komutuyla file1 isimli dosyayı file2 ismiyle değiştirebiliriz.  

Bu komutla bir dizindeki bir dosyayı başka bir dizine göndermek için de kullanabiliriz. ``mv job.slurm /truba_scratch/kullanici_adi`` bu komutla job.slurm adlı dosyayı  
**/truba_scratch/kullanici_adi** dizinine göndermiş olduk. Aynı işlemi dizinler için yapmak istersek **-r** eklemeniz gerekmektedir. (``cp -r job1 /truba_scratch/kullanici_adi`` komutuyla job1 adlı dizini /truba_scratch/kullanici_adi dizinine 
taşımış olduk)

.. warning::
 
 Dizin isimlerini değiştirken **-r** kullanmanıza gerek yoktur.

**6.** ``mkdir``

Yeni bir dizin açmak için kullanılır. ``mkdir job1`` komutuyla bulunduğumuz dizinde job1 isimli bir dizin açmış olduk.

**7.** ``touch``

Dosya açmak için kullanılan bir komuttur. ``touch job.slurm`` komutuyla bulunduğumuz dizinde **job.slurm** isimli bir dosya açmış olduk. 


**8.** ``rm``

Dosyaları silmek için kullanılan bir komuttur. ``rm job.slurm`` komutuyla bulunduğumuz dizindeki job.slurm dosyasını silmek için kullanabiliriz. Aynı şekilde dizinleri silmek için **-r** parametresi
ile kullanılabilir. 

Buraya kadar anlatılan komutları bir örnek üzerinde özeteleyelim. Kendi ev dizinimizde öncelikle **ads** adlı bir dizin oluşturalım. Bu dizine girip **co.in** adlı bir dosya oluşturalım. İkinci adım 
olarak bu dizini **/truba_scratch/kullanici_adi** isimli dosyaya kopyalayalım. Üçünücü adım olarak dizinin ismini **ads_co**  olarak değiştirdikten sonra, son olarak oluşturduğumuz co.in adlı dosyayı 
silelim. Bu örnek için aşağıdaki kod bloğunu takip ederek kolayca uygulayabilirsiniz. 

.. code-block:: bash
  
  mkdir ads
  cd ads
  touch co.in
  cd ..
  cp -r ads /truba_scratch/kullanici_adi
  mv  /truba_scratch/kullanici_adi/ads /truba_scratch/kullanici_adi/ads_co
  rm /truba_scratch/kullanici_adi/ads_co/co.in

**9.** ``emacs`` ve ``vim``

Yukarıda bahsedildiği gibi ``touch`` komutu kullanılarak dosya oluşturmayı öğrendik. Bu dosyaların içlerine girmek, değiştirmek hatta yazı yazmak için vim, emacs ya da nano gibi editörler
kullanmanız gerekmektedir. Bu kısımda vim ve emacs editör için sadece dosya açma, kapama ve yapılan değişiklikleri kayıt etme gibi başlangıç düzeyinde olan kısa yollar gösterilecektir. 
Sizler daha fazla kısayol öğrenmek isterseniz, **emacs shorcuts ya da vim shorcuts** gibi anahtar kelimeleri arama motorlarına yazarak  internetten kolayca ulaşabilirsiniz.

.. note::

 emacs editörü kullanarak dosya açmak için ``emacs -nw dosyanin_adi`` komutunu terminale yazarak ``touch`` komutu ile oluşturduğunuz dosyanın içine girebilirsiniz. 
 Dosyada yaptığınız değişiklikleri kaydetmek için klavyenizdeki ``Ctrl+x+s`` tuşlarına basarak yapabilirsiniz. Dosyanızı  ``Ctrl+x+c`` tuşalarına basılı tutarak kapatabilirsiniz.

.. note::

  vim editörü kullanarak dosyalarınızı açmak için ``vim dosyaninin_adi`` komutunu terminalinize yazarak açabilirsiniz. Dosyanızda birtakım değişiklikler yapmak için editörü **insert** moduna geçirmeniz gerekmektedir. Insert modunu açmak için klavyenizde **i** tuşuna basmanız yeterlidir. Bu modu açtığınızdan emin olmak için ekranın sol alt köşesinde modun açık olduğunu kontrol edebilirsiniz.
  Dosyanızda yaptığınız değişiklikleri kaydetmek için Esc tuşuna bastıktan sonra ekranın sol alt köşesinde ``:w`` yazarak yapabilirsiniz.
  Dosyayı kapatmak için tekrar Esc tuşuna bastıktan sonra ``:q`` yazmanız yeterlidir.

.. _tar-kullanimi:

**10.** ``tar``

Terminalinizden sıkıştırılmış arşiv dosyalarını açmak ya da kapatmak için ``tar`` komutu kullanabilirsiniz.  

Elinizde **arsiv_dosya.tar.gz**  isimli bir dosya olduğunu farzedelim. Bu dosyayı ayıklamak için aşağıdaki komutunu kullanabilirsiniz. 

.. code-block:: 
  
  tar -xvzf arsiv_dosya.tar.gz
  
Tar komutu ile dosyalarınızı aşağıdaki gibi arşivleyebilirsiniz. Birden çok dosyayı tek bir arşiv dosyasında birleştirmek için (örneğin, ``arsiv_dosya.tar.gz``), aşağıdaki komutu kullanabilirsiniz

.. code-block::

	tar -cvzf arsiv_dosya.tar.gz dosya1 dosya2


.. note::

	dosya1 ve dosya2'yi birleştirmek istediğiniz dosyaların adlarıyla değiştiriniz.

Bir dizindeki tüm dosyaları tek bir arşiv dosyasında birleştirmek için (örneğin, ``arsiv_dosya.tar.gz``), aşağıdaki komutu kullanabilirsiniz

.. code-block::

	tar -cvzf arsiv_dosya.tar.gz /ilgili/klasor/yolu

.. note:: 

	/ilgili/klasor/yolu ile birleştirmek istediğiniz dosyaları içeren dizinin mutlak yolunu belirtiniz.

Ayrıca terminalden ``man tar`` komutu ile tar komutunun kulllanımı ile ilgili detaylara ulaşabilirsiniz.


**11.** ``scp``
  
Hesaplarınızı tamamladıktan sonra, TRUBA kümelerinden input ve output dosyalarınızı kendi bilgisayarınıza göndermek için ``scp`` komutunu kullanabilirsiniz. Bunun en kolay yolu kendi bilgisayarınızdan terminalinizi açarak, TRUBA kümelerinden ilgili dizindeki dosyaları alabilirsiniz. Dizin kopyalamak için, komutu ``scp -r`` şeklinde kullanmanız gerekmektedir. Aşağıdaki örnekte, /truba_scratch/kullanici_adi/ads_co/co.in adresindeki **co.in** isimli dosyayı kendi bilgisayarınızdaki Desktop klasörüne gönderelim. Öncelikle bilgisayarınızda TRUBA' ya bağlı olmayan bir terminal açarak aşağıdaki komut satırını kopyalayarak yapabilirsiniz. 

.. code-block:: bash 

  scp  kullanici_adi@172.16.11.1: /truba_scratch/kullanici_adi/ads_co/co.in /home/kullanici_adi/Desktop


**12.** ``passwd``

Terminal üzerinden ``passwd`` komutunu kullanarak size TRUBA tarafından sağlanan şifreyi değiştirebilirsiniz. 



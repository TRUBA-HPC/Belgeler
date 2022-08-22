=================
Kaynak Tahsisi 
=================


Her araştırmacıya kullanıcı adı ile birlikte 

* aynı anda kullanılabilecek çekirdek miktarı, 

* çekirdek saat kotası ve 

* disk kotası 

tanımlanmaktadır.

Mevcut eğitim düzeyine göre tanımlanan kotalar aşağıda belirtilmektedir:

- **Lisans Öğrencileri:** Danışmanları birlikte bir projeye dahil olmaları durumunda hesap açılmakta olup, sadece ilgili proje hesabının kaynak miktarlarından faydalanabilmektedirler.

- **Y. Lisans Öğrencileri:** Danışman onaylarından sonra hesapları açılmakta olup, aynı anda 56 çekirdek kullanımı, toplam 200.000 çekirdek saat hesaplama kotası ve 2TByte veri depolama alanı sağlanmaktadır.

.. note::

   Danışmanları ile birlikte bir projeye dahil olmaları ve **ilgili projenin TRUBA kaynaklarında bir proje hesabı bulunması** durumunda, ilgili proje hesabının kaynak miktarlarından da faydalanabilmektedirler.

- **Doktora Öğrencileri ve Akademisyenler:** Hesapları YÖKSİS bilgilerine göre doğrudan açılmaktadır. Aynı anda 168 çekirdek kullanımı, toplam 400.000 çekirdek saat hesaplama kotası ve 2TByte veri depolama alanı sağlanmaktadır.

.. note::

   Araştırmacılar bir projeye dahil olmaları ve **ilgili projenin TRUBA kaynaklarında bir proje hesabı bulunması** durumunda, ilgili proje hesabının kaynak miktarlarından da faydalanabilmektedirler.
   

.. warning::

	Kullanıcının ev dizinlerinin (/truba/home/$USER ve /truba/scratch/$USER) boyutundan bağımsız olarak kullanıcı dizinlerindeki dosya sayısı da Dosya Sistemi'nde aşırı yük yaratmaktadır. Özellikle kurulum dosyalarının (source code) kurulumdan sonra silinmemesi, ya da anaconda gibi uygulamaların merkezi versiyonu yerine kullanıcı ev dizinlerine kurulması dosya sisteminin aşırı dolmasına ve sistem performansının düşmesine neden olmaktadır. 

	Bu sorunlardan dolayı 1 Mayıs 2022 tarihinden itibaren dosya sayısı kotası (inode) uygulanmaya başlanacaktır. Her 1Tbyte disk kotası için 150 000 adet inode kotası tanımlanacaktır. Kullanıcılar 

	.. code-block::

		lfs quota -g $USER /truba
	
	komutu ile kullandığı inode dosya sayısını öğrenebilir. Ayrıca terminalden kullanıcı arayüzüne bağlantı sağladıktan sonra login ekranına dökülen kota bilgilerine ``dosya kotası`` da % olarak eklenmiştir. Bu değerin %100'un altında olması gerekmektedir.

Kullanıcılarımızdan 

	* kullandıkları uygulamaların merkezi versiyonu varsa (module vb.) merkezi versiyonlarını kullanmalarını
	* merkezi versiyonu olmayan uygulamaların kendi ev dizinlerine kurulması gerekiyorsa, kurulum sonrasında kaynak dosyaları silmelerini
	* özellikle ``Anaconda`` kullanıcılarının merkezi Anaconda kurulumunu kullanmalarını ya da ``Anaconda`` yerine ``Miniconda`` kullanmalarını
	* ihtiyaç duymadıklari her türlü dosyayı silmelerini
	* saklanması gereken dosyaları kendi bilgisayarlarına indirmelerini
	* sadece kısa zaman icinde kullanacakları dosyaları sistemde tutmalarını
	* herhangi bir sebepten silemedikleri dosya ve dizinleri "tar" komutu ile arşivleyerek tek bir dosya haline getirmeleri ve mümkünse ilgili arşiv dosyalarını kendi bilgisayarlarına indirmelerini 

önemle rica etmekteyiz. Tar komutunun kullanımı hakkında bilgiye ulaşmak için :ref:`tıklayınız <tar-kullanimi>`.

.. note::

	* Ev dizininizde Miniconda kurulumunu :ref:`miniconda-kurulum` sayfamızdaki yönergeleri takip ederek yapabilirsiniz.

	* Merkezi anaconda kurulumu hesaplama kümeleri için aşağıdaki dizinlerde yer almaktadır:

	Centos 7.3 işletim sistemi kurulu hesaplama kümelerinde: `/truba/sw/centos7.3/lib/anaconda3/` dizini altında `2020.07` ve `2021.11` versiyonları kuruludur. İlgili Anaconda ortamlarını kullanmak için .bashrc dosyanıza aşağıdaki satırı eklemeniz gerekmektedir:
	
	2020.07 versiyonu için:

	.. code-block::

		eval "$(/truba/sw/centos7.3/lib/anaconda3/2020.07/bin/conda shell.bash hook)"

	2021.11 versiyonu için:

	.. code-block::

		eval "$(/truba/sw/centos7.3/lib/anaconda3/2021.11/bin/conda shell.bash hook)"

	Centos 7.9 işletim sistemi kurulu hesaplama kümelerinde ise Anaconda ortamlarını kullanmak için .bashrc dosyanıza aşağıdaki satırı eklemeniz gerekmektedir:
	
	2020.07 versiyonu için:

	.. code-block::

		eval "$(/truba/sw/centos7.9/lib/anaconda3/2020.07/bin/conda shell.bash hook)"

	2021.11 versiyonu için:

	.. code-block::

		eval "$(/truba/sw/centos7.9/lib/anaconda3/2021.11/bin/conda shell.bash hook)"

	Veya terminalden doğrudan ilgili komutu kullanabilirsiniz. Daha sonrasında :ref:`miniconda-kurulum` sayfamızda belirtildiği gibi ihtiyacınız olan sanal ortamları kullanıcı ev dizininize kurabilirsiniz. SLURM betik dosyanızda da benzer şekilde ilgili anaconda versiyonu için olan yukarıdaki komutu yazmanız gerekmektedir.
	
.. _tar-kullanimi:


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


Konu ile ilgili her türlü soru ve sorununuzu ``grid-teknik@ulakbim.gov.tr`` adresine e-posta ile iletebilirsiniz.

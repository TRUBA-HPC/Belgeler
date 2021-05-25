=====================
CodeSaturne Kılavuzu
=====================

Giriş
=====

*CodeSaturne* EDF tarafından hesaplamalı akışkanlar dinamiği (HAD) problemlerini çözmek için geliştirilen ve ücretsiz sunulan açık kaynak bir uygulamadır. 2 boyutlu, 2 boyutlu ve simetrik, 3 boyutlu, sürekli veya süreksiz, düzenli veya türbülanslı, sıkıştırılamaz veya hafifçe genişleyebilen, izotermik veya olmayan akışlar için Navier-Stokes denklemlerini çözer. Reynolds-Ortalamalı modellerden Large-Eddy simülasyonlarına kadar pek çok türbülans modeli mevcuttur. Farklı fizik durumları için gaz, kömür yanışı, yarısaydam radyasyon transferi, Lagrangian modeli ile parçacık takibi, Joule etkisi, hafifçe sıkıştırılabilen akışlar, atmosferik akışlar ve hidrolik makineler için rotor-stator etkileşimleri için modüller bulunur. 

Bu döküman, kullanıcıların *CodeSaturne* ’ü yükleyip kurmalarına yardımcı olmak, temel çalışma prensipleri hakkında bilgi vermek, seri ve paralel işlerin gönderilişini anlatmak ve örneklemek amacıyla oluşturulmuştur.

Kurulum
=======

*CodeSaturne* uygulamasının bir Linux sistemine kurulabilmesi için bazı kütüphanelerin bulunması gerekmektedir. Bu kütüphaneler *CodeSaturne* kurucusunda mevcut bulunmadığından önceden yüklenmelidir. Çoğu Linux sisteminde bulunan bu kütüphanelerin versiyonları 

.. code-block::

   "kütüphane adı" - -version
   
komutu ile kontrol edilebilir.

Ön Gereksinimler
----------------

Zorunlu ön koşullar:

-  C derleyicisi (en az C99 standardıyla uyumlu)

-  Fortran derleyicisi (en az Fortran95 standardıyla uyumlu)

-  Python çeviricisi (Python versiyonu 2.6 ve üstü)

Opsiyonel ön koşullar:

-  MPI (paralel iş gönderimleri için gerekli)

-  PyQt4 veya PyQt5 (Grafiksel Kullanıcı Arayüzü, GUI, için gerekli ve önerilir)

-  Catalyst gibi kütüphaneler için C++ derleyicisi gerekli

-  SALOME platformunun V9 ve üzeri versiyonları için Python 3, daha eski versiyonları için Python 2 gerekli

İndirme ve Kurulum
------------------

*CodeSaturne* içindeki otomatik kurucu vasıtasıyla kolaylıkla kurulabilir. Bunun için öncelikle sıkıştırılmış tar.gz dosyasının *CodeSaturne* websitesindeki *Download* kısmından uygun *CodeSaturne* versiyonu seçilerek indirilmesi gerekmektedir. 

-  https://www.code-saturne.org adresinden istenilen versiyon seçilir ve linke tıklanarak indirilir.

-  Tercihen "CodeSaturne" isminde ayrı bir klasör açılır.

-  İndirlen tar.gz dosyası açılan klasöre taşınır ve buraya çıkartılır.

-  Açılan klasörün içinde "code_saturne.build" isimli yeni bir klasör açılır.

-  "code_saturne.build" klasörüne gidilir ve bu adreste terminal çalıştırılır. Kurulum sırasında karışıklık yaşanmaması adına yükleme işleminin bu şekilde ayrı bir klasörden yapılması önerilir.

-  Bu adreste açılan terminalden indirilen dosyadaki "install_saturne.py" çalıştırılır. Örneğin şu komut kullanılabilir:

.. code-block::

   ../code_saturne-6.3.0/install_saturne.py

-  Kurulum tercihlerinin belirtilmesi için bir setup dosyası oluşacaktır. Bu dosya bir metin düzenleyicisiyle açılarak (nano,emacs vb) istenilen değişiklikler yapılabilir.

-  Setup dosyasının sonunda opsiyonel kütüphaneler bulunmaktadır.

   -  HDF5 kütüphanesi MED için gereklidir, ayrıca CGNS tarafından da kullanılabilir.

   -  CGNS çözüm ağı (mesh) ve görüntüleme dosyalarının yazılması ve okunması için gereklidir.

   -  MED çözüm ağı ve görüntüleme dosyalarının yazılması ve okunması için gereklidir, çoğunlukla SALOME platformu tarafından kullanılır.

   -  SCOTCH çözüm ağı kuyruklarının optimizasyonunda kullanılır, paralel hesaplamalar için.

   -  PARMETIS çözüm ağı kuyruklarının optimizasyonunda kullanılır, paralel hesaplamalar için.

-  Bu kütüphaneler mevcut değilse "use" ve "install" sütunları **yes** olarak düzenlenmelidir.

-  Eğer bu kütüphaneler mevcutsa adresleri "path" sütununda belirecektir ve "install" sütunu **no** olarak bırakılabilir. "use" sütunu **yes** olarak düzenlenmelidir.

-  Mevcut kütüphanelerin adresleri veya versiyonları doğru değilse, "path" kısmına manuel olarak da adresleri girilebilir.

-  Setup dosyası düzenlendikten sonra kaydedilerek çıkılır ve aşağıdaki komut tekrarlanır:

.. code-block::

 ../code_saturne-6.3.0/install_saturne.py

-  *CodeSaturne* kurucusu kurulumu tamamladıktan sonra aşağıdakine benzer bir ekran çıkacaktır. En üstte belirtildiği gibi, *CodeSaturne* ’ün kullanılması için ortam değişkenlerinin güncellenmesi gerekmektedir.

   .. container:: center

      .. image:: /assets/codesaturne/images/codeSaturne1.png
         :alt: image

-  Kullanıcının alttaki iki satırı terminal ekranındaki haliyle
   kopyalayıp yapıştırması yeterlidir.

   .. container:: center

      .. image:: /assets/codesaturne/images/codeSaturne2.png
         :alt: image

-  Bu işlemi her seferinde tekrarlamamak adına bu satırlar .bashrc
   dosyası içine kopyalanıp bu .bashrc dosyası kaynak gösterilebilir.
   Nasıl yapılacağı iki adım sonra gösterilmiştir.

-  Bazı kullanıcılarda
   <**exportLD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"**
   komutunun .bashrc dosyasına eklenmesi gerekebilir.

-  Paralel iş göndeirimi için .bashrc dosyasına "mpi" için bir satır
   eklenmesi ve .bashrc dosyasının kaynak gösterilmesi, "source"
   lanması, gerekebilir. Örnek olarak şu komutlar kullanılabilir;

   -  .bashrc dosyasını nano veya emacs gibi bir metin düzenleyicisi ile
      açılır, örneğin <**nano .bashrc**>.

   -  <**export
      LD_LIBRARY_PATH="/truba/sw/centos7.3/app/codeSaturne/openmpi/gcc-9.2.0/4.0.2/lib:$LD_LIBRARY_PATH**>
      satırı bu dosyanın içine yazılır. "openmpi" adresinin doğru
      olmasına dikkat edilmelidir.

   -  Dosya bu haliyle kaydedilir ve çıkılır.

   -  <**source .bashrc**> komutu ile bu dosya kaynak olarak gösterilir.

Çalıştırma
==========

.. _seri:

Seri İş
-------

.. container:: center

   .. image:: /assets/codesaturne/images/sema.png
      :alt: image

-  :math:`CodeSaturne` 3 temel elemandan oluşur.

   -  **GUI**, yani grafiksel kullanıcı arayüzü, hesaplama ayarlarının
      yapılmasına yarar. Bu ayarlar başka şekilde de yapılabilir ama bu
      konuya daha sonra değinilecektir.

   -  **Solver** modülü numerik çözümü yapan ana programı ifade eder.

   -  **Preprocessor** modülü mesh veya çözüm ağının kullanılmasından
      sorumludur.

-  :math:`CodeSaturne` ile bir iş, veya "case", oluşturmak için
   terminalden **<code_saturne create>** komutunun verilmesi yeterlidir.
   Komutun devamında **-s** eklenip iş ismi, **-c** eklenip
   çalıştıralacak "case" ismi girilebilir. Örneğin, "DENEME" adında bir
   iş klasörü ve çalıştırılacak bir "CASE1" dosyası oluşturmak için
   aşağıdaki komut kullanılabilir: **<code_saturne create -s DENEME -c
   CASE1>**

-  Bu komut girildiği zaman **DENEME** klasörünün içinde **CASE1**,
   **MESH** ve **POST** klasörleri oluşturulur.

-  Çözüm ağı (mesh) dosyalarının **MESH** içine konulması önerilir,
   ancak başka bir konumdan da seçilebilirler. Önemli olan seçilen mesh
   dosyasının uyumlu bir formata sahip olmasıdır. :math:`CodeSaturne`
   pek çok mesh formatını destekler ve spesifik olarak seçilmediği
   takdirde Preprocessor mesh dosyasının uzantısından formatı anlar.
   Örneğin;

   -  CGNS için .cgns

   -  MED için .med

   -  Gmsh için .msh

   -  Simail NOPO için .des

   -  I-deas universal için .unv

   -  EnSight 6 ve Gold için .case

   -  GAMBIT neutral için .neu

   -  STAR-CCM+ için .ccm

-  Çözüm ağı dosyası kullanıcı arayüzü ile seçilebileceği gibi
   <**cs_preprocess "mesh adı"**> komutuyla da çağrılabilir. Bu durumda
   otomatik olarak bir **mesh_input.csm** dosyası oluşturulur ve çözüm
   esnasında kullanılır. Kullanılan çözüm ağı çözüm işleminden önce
   "mesh import" veya "preprocess" işlemleri ile kontrol edilir. Bu
   işlem kullanıcı tarafından da yapılabilir. Örenğin, <**cs_preprocess
   "mesh dosyası adresi"**> komutu kullanılabilir. Bu komut çalışmıyor
   ise "preprocess" modülünün yerinin gösterilmesi gerekmektedir.
   .bashrc dosyasına <**export PATH=/klasörün
   adresi/Code_Saturne/6.3.0/code_saturne-6.3.0/arch/Linux_x86_64/libexec/code_saturne:$PATH**>
   satırının kopyalanması yeterlidir. Adres ve versiyon değişiklikleri
   kullanıcı tarafından göz önünde bulundurulup düzeltilmelidir. Arından
   .bashrc dosyası kaynak gösterilir.

-  **CASE1** içinde **DATA**, **RESU** ve **SRC** klasörleri
   oluşturulur. **RESU** ve **SRC** dosylaları en başta boştur. İş
   çalıştırıldıktan sonra **RESU** klasörü içinde **<YYYYAAGG-ssdd>**
   isminde bir sonuç klasörü bulunabilir. Çözüm ağı, çözüm ve çalıştırma
   ile ilgili .log dosyaları bu adrestedir. :math:`Paraview` vb.
   programlar ile çözüm sonrası işlemler yapılabilmesi için
   **DENEME/CASE1/RESU/postprocessing** dosyası içindeki
   **results_fluid_domain** dosyası kullanılabilir. Tipik bir iş
   dosyasının yapısı aşağıda verilmiştir.

   .. container:: center

      .. image:: /assets/codesaturne/images/structure.png
         :alt: image

-  İşin çalıştırılabilmesi için **DATA** klasörünün içinde
   **code_saturne**, **run.cfg** ve **setup.xml** bulunur.

-  **<code_saturne gui>** komutu ile kullanıcı arayüzü çalıştırılır.

-  :math:`CodeSaturne GUI` kullanılarak istenilen mesh dosyası, akış
   parametreleri, sınır koşulları ve çözüm parametreleri seçildikten ve
   kaydedildikten sonra bu bilgiler **setup.xml** dosyasının içine
   yazılır.

-  :math:`CodeSaturne GUI` kullanılmadan, veya daha gelişmiş ayarlar
   için, **share/code_saturne/user_sources** içindeki **REFERENCE**
   klasöründen **cs_user_scripts.py** dosyası iş dosyası içindeki
   **DATA** klasörüne kopyalanıp istenilen düzenlemeler yapılabilir. Bu
   dosya ile yapılan değişiklikler kullanıcı arayüzü (GUI) ile
   yapılanlara göre daha önceliklidir. Genellikle kullanıcı arayüzü ile
   tanımlanamyan parametrelerin **cs_user_scripts.py** benzeri kullanıcı
   tanımlı dosyalar üzerinden tanımlanması önerilir.

-  Grafiksel kullanıcı arayüzüne (GUI) ek olarak kullanılabilecek
   kullanıcı tarafından tanımlanan fonksiyonların bir kısmı şu
   şekildedir;

   -  Fiziksel model seçimi yapmak için **cs_user_model**

   -  Genel veya değişken bazlı parametrelerin tanımlanması için
      **cs_user_parameters**

   -  Çeşitli alanlar için zaman ayarları için **cs_user_time_moments**

   -  Seçilen sisteme göre doğrusal çözüm seçenekleri için
      **linear_solver**

   -  Değişken bazlı ayarlar veya ana değişkenlere bağlı ikincil
      değişken ayarları için **cs_user_finalize_setup**

-  :math:`cs\_user\_parameters.f90` ile de aynı seçimler yapılabilir.

-  Gerekli ayarlamalar yapılıp kaydedildikten sonra işi çalıştırmak için
   **<code_saturne run>** komutunun verilmesi yeterlidir. Bu komutun
   çalışabilmesi için bir "CASE" klasörünün içinden verilmesi
   gerekmektedir, başka bir adresten verildiği takdirde çalışmayacaktır.
   Örneğin, **CASE1** veya **DATA** adreslerinden verilebilir.

-  :math:`CodeSaturne` grafiksel kullanıcı arayüzü GUI veya yukarıdaki
   **<code_saturne run>** ile çalıştırıldıktan sonra hesaplamalar
   aşağıdaki aşamaları takip eder.

   -  **Stage**

      -  **RESU/<çalıştırma ismi>** oluşturulur.

      -  **DATA** klasöründen **RESU/<çalıştırma ismi>** klasörüne
         belgeler kopyalanır.

      -  Kullanıcı kaynakalrı **SRC** klasöründen **RESU/<çalıştırma
         ismi>** klasörüne kopyalanır ve derlenir.

   -  **Initialize**

      -  Preprocessor kullanılarak çözüm ağları mesh_input’a aktarılır.

      -  run_solver mini-betikleri oluşturulur.

   -  **Compute**

      -  run_solver mini-betikleri çalıştırılır, ortam değişkenleri
         ayarlanır, seri yada paralel(MPI) çalışma komutları verilir.

   -  **Finalize**

      -  Önceki aşamalar tamamlandıktan sonra başlar, kullanıcı
         tarafından tanımlanan dosyaların çıkarımı yapılır.

.. _fonksiyon:

Kullanıcı-Tanımlı Fonksiyonlar
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Genellikle GUI(grafiksel kullanıcı arayüzü) kullanılarak tanımlanan
   ve setup.xml dosyasına yazılan ayarlara ek olarak,
   :math:`CodeSaturne` kullanıcıların daha gelişmiş ayarlar ve modeller
   tanımlamasına "kullanıcı-tanımlı fonksiyonlar" ile olanak tanır. Bu
   fonksiyonlar genellikle grafiksel kullanıcı arayüzüne kıyasla daha
   detaylı ayarlamalar için kullanılır ve oradan yapılan ayarlarla
   birlikte kullanılırlar. Kullanıcı-tanımlı fonksiyonlar ile yapılan
   ayarlar GUI’da da var ise fonksiyonlarda seçilen ayarlar kabul edilir
   ve üzerine yazılır. Bu nedenle, genellikle grafiksel kullanıcı
   arayüzü ile seçilebilen ayarların bu şekilde seçilmesi ve geriye
   kalan daha özel ayarların kullanıcı-tanımlı fonksiyonlara bırakılması
   önerilir.

-  Bahsedilen fonksiyonlar **/klasör adresi/
   Code_Saturne/6.3.0/code_saturne-6.3.0/arch/Linux_x86_64/share/code_saturne/user_sources**
   adresindeki **REFERENCE** klasöründe bulunabilir. Aynı adreste
   **EXAMPLES** klasöründe bu fonksiyonlarla ilgili örnekler
   bulunmaktadır.

-  Ardından istenilen fonksiyonlar "CASE" klasörünün içindeki "SRC"
   klasörüne kopyalanır ve düzenlenebilir.

-  Bu fonksiyonların bir kısmı hesaplama ayarları sırasında, bazıları
   zaman adımlarından önce, bazıları zaman adımları sırasında ve
   bazıları da zaman adımları sonrasında çağrılırlar. Örneğin hesaplama
   ayarları sırasında şu fonksiyonlar çağrılır.

   -  :math:`cs\_user\_model` : Kullanıcının tercih ettiği türleri,
      varyansları ve fiziksel modelleri tanımlamak için kullanılır.
      Diğer bütün fonksiyonlardan önce çağrılır, sistem ayarları ve
      çözüm ağı tanımları hariç. Eşdeğer Fortran fonksiyonu :
      :math:`usppmo`

   -  :math:`cs\_user\_zones`: Hesaplamanın çözüm ağındaki hangi
      alanlarda yapılacağını ayarlamak için kullanılır.

   -  :math:`cs\_user\_parameters` : Genel veya değişken bazlı
      parametrelerin tanımlanmasında, örneğin referans fiziksel
      modellerde ve nümerik ayarlamalarda kullanılır. Eşdeğer Fortran
      fonksiyonu : :math:`usppmo`

   -  :math:`cs\_user\_postprocess\_writers, cs\_user\_postprocess\_meshes`
      : Postprocessing adımı için sonuç formatlarını değiştirmek için
      kullanılır.

   -  :math:`cs\_user\_combustion` : Seçilen yanma modeline (gaz,
      tozlaştırılmış kömür veya ağır yakıt) özel hesaplama seçeneklerini
      ayarlar.

   -  :math:`cs\_atmospheric\_model.f90` : Atmosferik model ayarları ve
      yer özellikleri için çeşitli kullanıcı fonksiyonları içerir.

   -  :math:`cs\_user\_lagr\_model` : "Lagrangian" modeli için fiziksel,
      nümerik ve postprocessing seçeneklerini tanımlar.

   Zaman adımlarından önce aşağıdaki fonksiyonlar çağrılır,

   -  :math:`cs\_user\_mesh\_modify` : Çeşitli çözüm ağı
      modifikasyonları için "preprocessing" aşamsında çağrılır.

   -  :math:`cs\_user\_initialization` : Değişkenlerin ve özelliklerin
      ilk değerlerini atamak için kullanılır.

   Zaman adımları sırasında aşağıdaki fonksiyonlar çağrılır,

   -  :math:`cs\_user\_physical\_properties` : Yoğunluk ve viskozite
      gibi akış özellikllerinin tanımlanması için çağrılır.

   -  :math:`cs\_user\_boundary\_conditions` : Karışık sınır
      koşullarının belirlenmesi için kullanılır. Basit olanlar GUI ile
      tanımlanabilir.

   -  :math:`cs\_user\_source\_terms` : Kompleks kaynak terimleri için
      kullanılır.

   -  :math:`cs\_user\_extra\_operations` : Değişken akış özelliklerinin
      tanımlanması için kullanılır. Her zaman adımında gerekli alanların
      güncellenmesi için çağrılır.

   -  :math:`cs\_user\_lagr\_boundary\_conditions` : Sınır koşullarının
      tanımlanması, değiştirilmesi ve Lagrangian molekülleri için hacim
      enjeksiyonları için kullanılır.

   Zaman adımları sırasında aşağıdaki fonksiyonlar çağrılır,

   -  :math:`cs\_user\_extra\_operations\_finalize` : Zaman adımlarından
      sonra sadece hesaplamanın sonunda yapılması gereken operasyonlar
      için çağrılır, spesifik postprocessing sonuçları gibi.

-  Yukarıda örnekleri verilen fonksiyonlardan gerekenler "CASE"
   klasörünün içindeki "SRC" klasörüne kopyalanıp istenilen düzenlemeler
   yapıldıktan sonra hesaplama sırasında GUI ile tanımlanan ayarlarla
   birlikte kullanılırlar. "SRC" klasöründe bu fonksiyonların derlenme
   sırası için herhangi bir öncelik bulunmamaktadır. Bu durum C veya C++
   kodları için sorun teşkil etmez, ancak Fortran kodları varsa
   :math:`cs\_user\_modules.f90` kodu diğerlerinden önce derlenir.
   Gerekirse, diğer kullanıcı-tanımlı modüller bu kod içinde
   tanımlanabilir.

.. _seri_örnek:

Örnek İş Hazırlama
~~~~~~~~~~~~~~~~~~

-  "DENEME" adında bir iş klasörü ve çalıştırılacak bir "CASE1" dosyası
   oluşturmak için aşağıdaki komut kullanılabilir: **<code_saturne
   create -s DENEME -c CASE1>**

-  Bu komut girildiği zaman **DENEME** klasörünün içinde **CASE1**,
   **MESH** ve **POST** klasörleri oluşturulur.

-  Çözüm ağı (mesh) dosyasının **MESH** içine konulması gerekmektedir.

-  Ardından **CASE1** klasörü içinde **<code_saturne gui>** komutu
   çalıştırılır.

-  Kullanıcı arayüzü içinde öncelikle çözüm ağı yani mesh dosyası
   seçilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/mesh.png
         :alt: image

   Kullanılan :math:`CodeSaturne` versiyonuna bağlı olarak sınırlar
   buradan tanımlanabilir. Bu sınırların doğru tanımlanması sonraki
   adımlardaki "Boundary Conditions" kısmından sınır koşullarının
   girilmesi için önemlidir.

-  Hesaplama özellikleri bölümünden akışın türü, özellikleri, türbülans
   modelleri veya termal modeller seçilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/calc.png
         :alt: image

   .. container:: center

      .. image:: /assets/codesaturne/images/turb.png
         :alt: image

   .. container:: center

      .. image:: /assets/codesaturne/images/thermal.png
         :alt: image

-  Hesaplama özellikleri bölümünden akışa etki eden kuvvetler ve tür
   taşınımı özellikleri de seçilebilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/bodyforce.png
         :alt: image

   .. container:: center

      .. image:: /assets/codesaturne/images/species.PNG
         :alt: image

-  Akışkan özellikleri bölümünden akışkanın cinsine ve ortam koşullarına
   bağlı olan parametreler girilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/fluidproperties.png
         :alt: image

-  "Volume zones" kısmında hız, sıcaklık veya türbülans gibi koşullar
   tanımlanır ve "initialization" yapılır.

   .. container:: center

      .. image:: /assets/codesaturne/images/initalization.png
         :alt: image

-  "Boundary conditions" bölümünde daha önce belirlenmiş sınırlar için
   sınır koşulları tanımlanır. Bunun için "Mesh" kısmında gereken
   sınırlar "Boundary Zones" içinde tanımlanmış olmalıdır.

-  "Time settings" altında çözümün zaman adımları ayarlanır.

   .. container:: center

      .. image:: /assets/codesaturne/images/time.png
         :alt: image

-  "Numerical parameters" kısmında nümerik parametreler ve çeşitli
   yöntemler görülebilir. "Equation parameters-clipping" kısmında çözüm
   için bazı minimum ve maksimum değerler tanımlanabilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/numerical.png
         :alt: image

   .. container:: center

      .. image:: /assets/codesaturne/images/equation.png
         :alt: image

-  "Postprocessing" bölümünde çözümün sonuç dosyalarına yazılması ile
   ilgili tercihler seçilir.

   .. container:: center

      .. image:: /assets/codesaturne/images/post.png
         :alt: image

-  "Run computation" kısmından işlemci sayısı seçimi yapılır ve "save"
   kısmında kaydedilir. Böylelikle yapılan tercihler ve ayarlar **DATA**
   içindeki **setup.xml** dosyasına yazılır.

   .. container:: center

      .. image:: /assets/codesaturne/images/run.png
         :alt: image

-  :math:`CodeSaturne` bu arayüz üzerinden çalıştırılabileceği gibi
   **CASE1** klasörü içinden **<code_saturne run>** komutu girilerek de
   çalıştırılabilir.

TRUBA sunucusunda :math:`CodeSaturne GUI` (Grafiksel Kullanıcı Arayüzü)
kullanılamadığından komutların terminalden girilmesi gerekmektedir.
Yukarıda anlatıldığı gibi kullanıcı tanımlı dosyalar üzerinden bütün
ayarların yapılması ve kodun çalıştırılması mümkündür. Kullanım
rahatlığı açısından TRUBA sunucuna bağlanmadan kullanıcı arayüzü
vasıtasıyla iş klasörünün oluşturulması istenilen seçimlerin yapılıp
**setup.xml** içine kaydedilmesi önerilir. Oluşturulan iş klasörü bir
dosya aktarım programı, örneğin Filezilla, yardımı ile TRUBA sunucusuna
taşınabilir. Klasördeki **CASE** veya **DATA** alt-klasörlerinin içinden
**<code_saturne run>** komutunun çalıştırılması yeterlidir. İş
tamamlandıktan sonra **RESU** içinde bulunan sonuç dosyaları görüntüleme
programlarında kullanılmak üzere, dosya transfer programı yardımıyla,
tekrar kullanıcının bilgisayarına taşınabilir.

Paralel İş
----------

TRUBA sunucusunda :math:`CodeSaturne GUI` (Grafiksel Kullanıcı Arayüzü)
kullanılamadığından komutların terminalden girilmesi gerekmektedir. Çoğu
adım seri iş oluşturma ile benzerlik gösterdiğinden daha detaylı anlatım
için `2.1 <#seri>`__ incelenebilir.

-  :math:`CodeSaturne` ile paralel bir iş, veya "case", oluşturmak için
   terminalden **<code_saturne create>** komutunun verilmesi yeterlidir. Komutun devamında **-s** eklenip iş ismi, **-c** eklenip çalıştıralacak "case" ismi girilebilir. Örneğin, "DENEME_paralel_4" adında bir iş klasörü ve çalıştırılacak bir "CASE1" dosyası oluşturmak için aşağıdaki komut kullanılabilir: 

.. code-block::

   code_saturne create -s DENEME_paralel_4 -c CASE1

-  Bu komut girildiği zaman **DENEME** klasörünün içinde **CASE1**, **MESH** ve **POST** klasörleri oluşturulur.

-  Çözüm ağı (mesh) dosyalarının **MESH** içine konulması önerilir, ancak başka bir konumdan da seçilebilirler. Önemli olan seçilen mesh dosyasının uyumlu bir formata sahip olmasıdır. *CodeSaturne* pek çok mesh formatını destekler ve spesifik olarak seçilmediği takdirde Preprocessor mesh dosyasının uzantısından formatı anlar.
   
  Örneğin;

   -  CGNS için .cgns

   -  MED için .med

   -  Gmsh için .msh

   -  Simail NOPO için .des

   -  I-deas universal için .unv

   -  EnSight 6 ve Gold için .case

   -  GAMBIT neutral için .neu

   -  STAR-CCM+ için .ccm

-  Çözüm ağı dosyası kullanıcı arayüzü ile seçilebileceği gibi <**cs_preprocess "mesh adı"**> komutuyla da çağrılabilir. Bu durumda otomatik olarak bir **mesh_input.csm** dosyası oluşturulur ve çözüm esnasında kullanılır. Kullanılan çözüm ağı çözüm işleminden önce "mesh import" veya "preprocess" işlemleri ile kontrol edilir. Bu işlem kullanıcı tarafından da yapılabilir. Örenğin, <**cs_preprocess "mesh dosyası adresi"**> komutu kullanılabilir. Bu komut çalışmıyor ise "preprocess" modülünün yerinin gösterilmesi gerekmektedir. ".bashrc" dosyasına 

.. code-block::  
  export PATH=/klasörünadresi/Code_Saturne/6.3.0/code_saturne-6.3.0/arch/Linux_x86_64/libexec/code_saturne:$PATH

satırının kopyalanması yeterlidir. Adres ve versiyon değişiklikleri kullanıcı tarafından göz önünde bulundurulup düzeltilmelidir. Ardından ".bashrc" dosyası kaynak gösterilir.

-  **CASE1** içinde **DATA**, **RESU** ve **SRC** klasörleri oluşturulur. **RESU** ve **SRC** dosylaları en başta boştur. İş çalıştırıldıktan sonra **RESU** klasörü içinde **<YYYYAAGG-ssdd>** isminde bir sonuç klasörü bulunabilir. Çözüm ağı, çözüm ve çalıştırma ile ilgili .log dosyaları bu adrestedir. *Paraview* vb. programlar ile çözüm sonrası işlemler yapılabilmesi için **DENEME/CASE1/RESU/postprocessing** dosyası içindeki **results_fluid_domain** dosyası kullanılabilir. Tipik bir iş dosyasının yapısı aşağıda verilmiştir.

-  İşin çalıştırılabilmesi için **DATA** klasörünün içinde **code_saturne**, **run.cfg** ve **setup.xml** bulunur.

-  **<code_saturne gui>** komutu ile kullanıcı arayüzü çalıştırılır.

-  *CodeSaturne GUI* kullanılarak istenilen mesh dosyası, akış parametreleri, sınır koşulları ve çözüm parametreleri seçildikten ve kaydedildikten sonra bu bilgiler **setup.xml** dosyasının içine yazılır.

-  *CodeSaturne GUI* kullanılmadan, veya daha gelişmiş ayarlar için, **share/code_saturne/user_sources** içindeki **REFERENCE** klasöründen **cs_user_scripts.py** dosyası iş dosyası içindeki **DATA** klasörüne kopyalanıp istenilen düzenlemeler yapılabilir. Bu dosya ile yapılan değişiklikler kullanıcı arayüzü (GUI) ile yapılanlara göre daha önceliklidir. Genellikle kullanıcı arayüzü ile tanımlanamyan parametrelerin **cs_user_scripts.py** benzeri kullanıcı tanımlı dosyalar üzerinden tanımlanması önerilir.

-  Grafiksel kullanıcı arayüzüne (GUI) ek olarak kullanılabilecek kullanıcı tarafından tanımlanan fonksiyonların bir kısmı şu şekildedir;

   -  Fiziksel model seçimi yapmak için **cs_user_model**

   -  Genel veya değişken bazlı parametrelerin tanımlanması için **cs_user_parameters**

   -  Çeşitli alanlar için zaman ayarları için **cs_user_time_moments**

   -  Seçilen sisteme göre doğrusal çözüm seçenekleri için **linear_solver**

   -  Değişken bazlı ayarlar veya ana değişkenlere bağlı ikincil değişken ayarları için **cs_user_finalize_setup**

-  :math:`cs\_user\_parameters.f90` ile de aynı seçimler yapılabilir. Kullanıcı-tanımlı fonksiyonlar ile ilgili bilgi için bkz. `2.1.1 <#fonksiyon>`__

-  Gerekli ayarlamalar yapılıp kaydedildikten sonra işi çalıştırmak için **<code_saturne run -n "kullanılacak çekirdek sayısı">** komutunun verilmesi yeterlidir. Bu komutun çalışabilmesi için bir "CASE" klasörünün içinden verilmesi gerekmektedir, başka bir adresten verildiği takdirde çalışmayacaktır. Örneğin, **CASE1** veya **DATA** adreslerinden verilebilir.

Kullanıcı-Tanımlı Fonksiyonlar
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kullanıcı-tanımlı fonksiyonlar GUI ile yapılan ayarları ve daha gelişmiş ayarları yapmak için kullanılır. Seri ve paralel modlarda kullanılabilirler. `2.1.1 <#fonksiyon>`__ kısmında anlatılmıştır.

Örnek İş Hazırlama
~~~~~~~~~~~~~~~~~~

Bu kısımda 4 çekirdek kullanarak paralel iş göndermenin nasıl yapılacağı anlatılmaktadır. Çoğu kısım seri iş ile benzerlik taşıdığından daha detaylı anlatım için `2.1.2 <#seri_örnek>`__ kısmında bulunan figürler incelenebilir.

-  "DENEME_paralel_4" adında bir iş klasörü ve çalıştırılacak bir "CASE1" dosyası oluşturmak için aşağıdaki komut kullanılabilir:

.. code-block::

   code_saturne create -s DENEME_paralel_4 -c CASE1

-  Bu komut girildiği zaman **DENEME_paralel_4** klasörünün içinde  **CASE1**, **MESH** ve **POST** klasörleri oluşturulur.

-  Çözüm ağı (mesh) dosyasının **MESH** içine konulması gerekmektedir.

-  Ardından **CASE1** klasörü içinde

.. code-block::
   code_saturne gui
  
komutu çalıştırılır.

-  Kullanıcı arayüzü içinde öncelikle çözüm ağı yani mesh dosyası seçilir. Kullanılan :math:`CodeSaturne` versiyonuna bağlı olarak sınırlar buradan tanımlanabilir. Bu sınırların doğru tanımlanması sonraki adımlardaki "Boundary Conditions" kısmından sınır koşullarının girilmesi için önemlidir.

-  Hesaplama özellikleri bölümünden akışın türü, özellikleri, türbülans modelleri veya termal modeller seçilir. Etkiyen kuvvetler, corilois veya yer çekimi vs. ve tür taşınımı gibi özellikler de buradan tanımlanabilir.

-  Akışkan özellikleri bölümünden akışkanın cinsine ve ortam koşullarına bağlı olan parametreler girilir.

-  "Volume zones" kısmında hız, sıcaklık veya türbülans gibi koşullar tanımlanır ve "initialization" yapılır.

-  "Boundary conditions" bölümünde daha önce belirlenmiş sınırlar için sınır koşulları tanımlanır.

-  "Time settings" altında çözümün zaman adımları ayarlanır.

-  "Numerical parameters" kısmında nümerik parametreler ve çeşitli yöntemler görülebilir. "Equation parameters-clipping" kısmında çözüm için bazı minimum ve maksimum değerler tanımlanabilir.

-  "Postprocessing" bölümünde çözümün sonuç dosyalarına yazılması ile ilgili tercihler seçilir.

-  "Run computation" kısmından işlemci sayısı seçimi yapılır ve "save" kısmında kaydedilir. Böylelikle yapılan tercihler ve ayarlar **DATA** içindeki **setup.xml** dosyasına yazılır.

-  *CodeSaturne* bu arayüz üzerinden 4 çekirdek seçilerek çalıştırılabileceği gibi **CASE1** klasörü içinden 

.. code-block::

   code_saturne run -n 4
   
komutu girilerek de 4 çekirdek kullanılarak çalıştırılabilir.


TRUBA sunucusunda *CodeSaturne GUI* (Grafiksel Kullanıcı Arayüzü) kullanılamadığından komutların terminalden girilmesi gerekmektedir. Yukarıda anlatıldığı gibi kullanıcı tanımlı dosyalar üzerinden bütün ayarların yapılması ve kodun çalıştırılması mümkündür. Kullanım rahatlığı açısından TRUBA sunucuna bağlanmadan kullanıcı arayüzü vasıtasıyla iş klasörünün oluşturulması istenilen seçimlerin yapılıp **setup.xml** içine kaydedilmesi önerilir. Oluşturulan iş klasörü bir dosya aktarım programı, örneğin Filezilla, yardımı ile TRUBA sunucusuna taşınabilir. Klasördeki **CASE** veya **DATA** alt-klasörlerinin içinden **<code_saturne run>** komutunun çalıştırılması yeterlidir. İş tamamlandıktan sonra **RESU** içinde bulunan sonuç dosyaları görüntüleme programlarında kullanılmak üzere, dosya transfer programı yardımıyla, tekrar kullanıcının bilgisayarına taşınabilir.

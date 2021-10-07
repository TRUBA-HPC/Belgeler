===========
Çalıştırma
===========

.. _is_gonderimi:

--------------
İş Gönderimi
--------------

Çözüm Ağı Oluşturma
----------------------

NekMesh yapısı yüksek mertebeli çözüm ağlarını direkt olarak CAD
definasyonlarından alma kabiliyetine sahiptir.^Normalde bu özellik aktif
değildir. Bu nedenle kurulum esnasında Nektar++ **NEKTAR_USE_MESHGEN**
opsiyonu ile birlikte derlenmelidir. Bu işlemin nasıl yapılacağı
:ref:`nektar-kurulum` kısmında açıklanmıştır. CAD yazılımları için
OpenCascade modülünün de kullanıma hazır olması gerekmektedir. Bu modül
Nektar++ kurulurken kurulabileceği gibi hazırda bulunuyorsa kurulmaması,
bulunmasa da ayrıca kurulması önerilir. Aksi takdirde yüklenmesi fazla
zaman alacaktır. 

Yöntemler
^^^^^^^^^^^

Çözüm ağı oluşturma, özellikle de yüksek mertebeli
çözüm ağlarını oluşturma, işlemleri oldukça karmaşık yapılı olduğundan
NekMesh bu aşamaları sıra sıra yapar ve bu sırada kullanıcının
etkileşimde bulunmasına gerek duymaz. Bu aşamalar şöyle sıralanabilir:

-  Çözüm ağları elemanlarının boyutlarının tanımlanması ve
   sınıflandırılması

-  Doğrusal ve büyük elemanlı çözüm ağlarının oluşturulması

-  Optimize edilmiş yüksek mertebeli çözüm ağlarının yüzey geometrisi
   üzerinde oluşturulması

Bu aşamalar daha geniş biçimde açıklanacaktır. 

CAD Etkileşimleri
^^^^^^^^^^^^^^^^^^^

Bütün temel fikirlerin altında, NekMesh çözüm ağı oluşturucusunun son çözüm ağını yüksek kalite
ve mertebede oluşturması ve altında yatan geometriye olabildiğince iyi
şekilde adapte etmesi yatar. Bu bağlamda, sistemin CAD çıktı
dosyalarından geometrik bilgileri kolay ve doğru bir biçimde
okuyabilmesi amaçlanır. Bu amaçla da NekMesh içinde üçüncü parti
yazılımlardan biri olan OpenCascade bulunur. Bu yazılım oldukça kapsamlı
ve büyük boyutlu olduğundan dolayı Nektar++, süreyi ve karmaşıklığı
azaltmak adına sadece gerekli rutinleri ve modülleri ayrıca
yükleyebilir. Bu sayede çoğu işlem OpenCascade ile yapılacağından daha
kısa sürede yapılabilir. 

Otomatik Çözüm Ağı Sınıflandırılması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yüksek mertebeli çözüm ağlarının oluşturulmasındaki temel sıkıntılardan biri de uyumlu geniş veya büyük
elemanlı doğrusal çözüm ağı elemanlarının oluşturulmasıdır. Kullanıcının
bu elemanları tüm çözüm alanı için tanımlanması oldukça zordur. NekMesh
bu sorunu büyük ve küçük elemanlar arasında seviyeli ve pürüzsüz bir
geçiş sağlayarak çözmeyi amaçlar. Genel olarak, hesaplama alanı sekize
bölünür ve her kısım küçük bölümleri temsil eder. Ayrıca eğimli
yüzeylerin olduğu bölümler de kendi içlerinde bölünerek daha isabetli ve
doğru çözüm ağı oluşturulmasına yardımcı olurlar. Geometrik eğimlerin ve
farklı yüzeylerin çözüm ağı boyutlandırma parametresi haline geldiği
durumlarda ise, daha komplike ve ileri seviyedeki durumlar, uyumlu
olmayan (non-conforming) altıgen yüzeyli çözüm ağlarının kullanılması
uygun olacaktır. 

Doğrusal Çözüm Ağı Oluşturulması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Klasik ve geleneksel olarak ticari uygulama
paketlerinde de bulunan çözüm ağı oluşturma mekanizmalarının aksine,
Nektar++ uygulaması daha alışılmamış ve eski bir yöntem olan 0 boyuttan
3 boyuta doğru giden, aşağıdan yukarıya doğru düşünülebilecek bir
mekanizmayı benimser. Bu sayede direkt olarak 3 boyutta çalışan
algoritmalara kıyasla daha yüksek ve istenilen bir garanti ve kararlılık
seviyesine ulaşır. Bu bağlamda, ilk olarak 0 boyuttaki noktalar yani
çözüm ağı elemanlarının köşeleri oluşturulur. Daha sonra 1 boyuttaki
eğriler kullanılarak bu noktalar arasındaki bağlantı oluşturulur. Bu
köşeler ve eğriler arasında 2 boyutlu parametreler ile oluşturulan
düzlemler ile farklı farklı yüzeyler oluşturulur. Sınırlar ve yüzeyler
ile tanımlanan hacimler ise en son 3 boyutlu halde tanımlanır. Daha
sağlam ve kararlı bir algoritma için, 2 boyuttaki çözüm ağları Triangle
kütüphanesi ile ve 3 boyutlu olanlar TetGen kütüphanesi ile oluşturulur.
Bunların ikisi de Delaunay bazlı çözüm ağı oluşturucularıdır. Diğer ek
modüller ve kütüphaneler gibi bunlar da Nektar++ ile otomatik olarak
indirilir ve kurulurlar. 

Yüksek Mertebeli Yüzey Oluşturucular
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yüksek mertebeli boğum-düğüm noktalarının
eklenmesi ve çözüm ağlarının kıvrılıp bükülmeleri çözüm ağlarının
oluşturulmasını zorlaştıran etkenlerdendir. Herhangi bir çözüm ağı
oluşturma yönteminin bu sorunu çözdüğü %100 olarak kanıtlanamasa da,
NekMesh oldukça iyi bir şekilde yüksek mertebeli kıvrılan çözüm ağları
yeterli kararlılık ile oluşturabilir. En çok geliştirilecek alanlardan
biridir. Yüksek mertebeli çözüm ağlarının oluşturulmasındaki en önemli
adımlarından biri yüksek mertebeli boğum noktalarının tanımlanmasıdır.
Burada çözüm ağı oluşturucusunun yüksek isabet oranı ile çalışması
oldukça kritiktir. Aksi takdirde çözümün isabetliliği önemli ölçüde
etkilenir ve düşer. Bunun için NekMesh boğum noktalarının optimizasyonu
için CAD yüzey parametrelerini kullanır ve üçgenel yüzeylerin mümkün
olan en düşük eğrilik ve yamulma ile oluşturulduğundan emin olur. Bu
Newton-tipi optimizasyon ve minimizasyon aşamaları için Gauss-Seidel
matris çözme yöntemi kullanılır. 

Çözüm Ağı Düzeltmeleri
^^^^^^^^^^^^^^^^^^^^^^^^

Kıvrık veya bükük elemanlar geçersiz
elemanlara yol açabilir, özellikle Euler tipi yani dörtyüzlü çözüm
ağlarında bu durum görülür. Nektar++ içinde bu durumları çözmek için üç
farklı yöntem kullanır. İlk olarak geçersiz yüzeylerdeki eğimli
yüzeyleri elimine eder, ancak bu durumda geometrik isabet azalır.
<**NekMesh -m linearise:invalid invalidMesh.xml validMesh.xml**> komutu
ile bu durumun etkisi azaltılabilir. Alternatif olarak çözüm ağı
noktaları deforme edilebilir ancak bu durum hesaplama süresini uzatır ve
çok verimli bir yöntem değildir. Fakat, doğrusal elastik çözücülerde
kullanılabilir. Son ve en yararlı yöntem ise Değişken Optimizasyon
modülünü eğimli ara noktalar ve alanlar için kullanmaktır. Daha fazla
bilgi `Nektar++ sitesindeki kullanıcı rehberinden <https://www.nektar.info/community/documentation/>`_ öğrenilebilir.

Manuel Olarak Çözüm Ağı Oluşturma
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Çözüm ağı oluşturma aşağıdaki komutla gerçekleştirilebilir. 

.. code-block::

   NekMesh session.mcf mesh.xml

Buradaki "session.mcf" çözüm ağı dosyasının
adını temsil etmektedir. Aşağıdaki `şema <#mesh_sema>`__, 2 boyutlu
bir NACA kanadının çözüm ağı dosyasını örnekler.

.. figure:: /assets/Nektar-howto/images/mesh_sema.PNG
   :name: mesh_sema

   Çözüm Ağı Yapısı

Tüm durumlar için çözüm ağı iki parçalı bilgiye ve dört parametreye ihtiyaç duyar. İlk olarak CAD dosyasını belirlemek ister. Yukarıdaki örnekte bu 4 basamaklı bir sayıdır, NACA oluşturucusundan dolayı. Diğer durumlarda STEP veya GEO formatında dosyalara ihtiyaç duyar. Sonrasında oluşturulacak çözüm ağının tipi seçilir. Üç boyut için ``EULER`` veya ``BndLayer``, iki boyut için ``2D`` veya ``2DBndLayer`` seçilir. ``EULER`` seçildiği takdirde sadece dörtyüzlü çözüm ağı elemanları kullanılır. Sınır tabakası için ise tek katmanlı prizma
tabakaları yerleştirilir. Otomatik çözüm ağı oluşturma sistemi pürüzsüz
bir geçiş ve düzgün bir şeklide küçültülmüş çözüm ağı için üç
parametreye ihtiyaç duyar. ``MinDelta`` en küçük elemanın boyutunu, ``MaxDelta`` ise en büyük elemanın boyutunu belirlemek için kullanılır. ``EPS`` ise hassasiyeti belirten eğrilik parametresidir ve 0 ile 1 arasında değerler alır, eğri yüzeyler üzerindeki elemanların boyutlarını kontrol eder. ``Order`` ise çözüm ağının oluşturulduğu polinom derecesini belirler. Sınır tabakaları için ek birkaç parametre daha gerekebilir.

.. figure:: /assets/Nektar-howto/images/boundarylayer.PNG
   :name: mesh_boundary_layer

   Örnek Çözüm Ağı Dosyası

Gmsh tarafından kullanılan GEO formatı bir kullanıcı arayüzüne (GUI)
ihtiyaç duymaksızın çözüm ağı oluşturma operasyonlarının yürütülmesine
olanak tanır. Basit halde en temel fonksiyonlar şöyle listelenebilir:

-  ``\\`` yorumlar için

-  ``Point`` noktalar için

-  ``Line`` doğrular için

-  ``Spline`` noktalar arası eğriler için

-  ``BSpline`` Bezier eğrileri için

-  ``Ellipse`` Çembersel yaylar ve elipsler için

-  ``LineLoop`` Çembersel yaylar ve çemberler için

-  ``PlaneSurface`` Doğru döngüleri için

-  Düzlem yüzeyleri için

Çözüm Parametrelerini Ayarlama
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Çözüm ağı oluşturulduktan sonra çözüm parametreleri ve çözücü seçimi ile
çözücü ayarları yapılmalıdır. Nektar++ üzerinde problemi tanımlamak için
üç temel basamak vardır. Öncelikle çözüm ağı oluşturulur, ardından
genişleme tabanları ayarlanır. Başlangıç koşullarının konfigürasyonu,
sınır koşulları ve gerekli parametreler bu adımların ardından
tanımlanır. Bu bölümde bu adımların üzerinde durulacaktır. 

Çözüm Ağı Formatını Dönüştürme
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ön işlemlerin ilki Nektar++ ile uyumlu bir formatta çözüm ağı hazırlamaktır. Bu çözüm
ağının etrafında oluşturulacağı geometri öncelikle açık kaynak çözüm ağı
oluşturucularından Gmesh ile oluşturulabilir. Fakat, çözüm ağı çıktı
formatı Nektar++ ile uyumlu olmadığından başka bir formata
dönüştürülmesi gerekmektedir. Bu durumda <**NekMesh**> rutinin bu ön
işlem sırasında çalıştırılması gerekir. Bu komut iki girdi gerektirir;
Gmsh tarafından oluşturulan ".msh" uzantılı dosya ismi ve NekMesh’in
oluşturacağı Nektar++ ile uyumlu olan ".xml" dosyasının adı. Örnek komut
şu şekildedir:

.. code-block::

   NEK/eskidosya_mesh.msh yenidosya_mesh.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun
çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil
eder. 2 boyuttaki simülasyonlar için çözüm ağının ``GEOMETRY`` etiketi altındaki 6 alt bölüm ile tanımlanması gerekmektedir. ``VERTEX`` etiketi köşe noktalarının uzaydaki koordinatlarını içerir. ``EDGE`` bu köşeleri bağlayan doğruları kapsar. ``ELEMENT`` ise çözüm ağı elemanlarını tanımlar.``CURVED`` ise eğriler üzerinde kontrol noktalarını tanımlamak için kullanılır. Eğer eğri kenarlar veya yüzeyler yoksa bu etiket göz ardı edilebilir. ``COMPOSITE`` çözümün alt alanlarını ve denklem setlerinin çözüleceği yerleri tanımlar. Sınır koşulları için de kompozit alanlar kullanılabilir. Son etiket olan ``DOMAIN`` ise tüm çözüm alanının ve kompozit alanlarının bütünlüğünü sağlar. Aşağıdaki görsel geometri tanımlarının özetini içerir.

.. figure:: /assets/Nektar-howto/images/geometry.PNG
   :name: geometri

   Geometri tanımları

Genişleme Tabanları
^^^^^^^^^^^^^^^^^^^^

Kompozit veya alt alanların kullanımı için genişleme tabanları
tanımlanabilir. Örneği yukarıdaki şekil `32 <#expansions>`__ içinde
bulunabilir. Burada tek kompozit ve 3 temel denklem (NUMMODES) için
örnekleme yapılmıştır.

.. figure:: /assets/Nektar-howto/images/expansion.PNG
   :name: expansions

   Genişleme tabanları tanımı

Çözüm Parametrelerinin Tanımlanması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu noktada çözümde baz alınacak değerler tanımlanır. Örnek olarak
aşağıdaki şekil incelenebilir. Bu şekilde çözücünün kullanırken ihtiyaç
duyacağı sabitler ve parametreler problem tanımlamasına uygun bir
şekilde ifade edilir.

.. figure:: /assets/Nektar-howto/images/parameters.PNG
   :name: parametre

   Çözüm parametreleri

Çözücü Ayarları
^^^^^^^^^^^^^^^^^^

Problemin çözücü ile nasıl çözüleceğini belirlemek için bazı ayarlar
tanımlanır. Örneğin, bir akış problemi durumunda bunlar akışkan
viskozitesi, ısı iletimi ve Navier Stokes içindeki denklem tipleri
olabilir. Sıkıştırılabilir akışlarda genelde süreksiz projeksiyon
metotları, örneğin discontinuos Galerkin (DG), kullanıldığı için ``Projection``
kısmının "DisContinuous" olarak ayarlanması gerekmektedir. Taşınım,
difüzyon, problem, zaman integrasyonu ve viskozite tipleri aşağıdaki
düzende seçilir.

.. figure:: /assets/Nektar-howto/images/solver.PNG
   :name: cozucu_parametre

Değişkenler
~~~~~~~~~~~~~

Çözüm değişkenleri tanımlanır. 2 boyut için örnek şu şekildedir. Farklı
problemler ve çözücüler için aşağıdaki değişkenler ve başlıklar
farklılık gösterebilir. Kullanıcının duruma uygun değişkenler seçmesi ve
bunları tanımlaması önem arz etmektedir.

.. figure:: /assets/Nektar-howto/images/variables.PNG
   :name: degiskenler


Sınır koşullarının değişkenlerden ziyade akılara uygulandığı
hatırlanmalıdır. 

Sınır Koşulları
~~~~~~~~~~~~~~~~~

Sınır bölgeleri ``BOUNDARY REGIONS`` içinde tanımlanır. 2 boyut için örnek
şu şekildedir.

.. figure:: /assets/Nektar-howto/images/boundaryregions.PNG
   :name: sinir_bolge

Ardından ``BOUNDARY CONDITIONS`` içinde sınr koşulları tanımlanır. Hangi sınır için
tanımlandıkları bir önceki bölüm olan sınır bölgeleri kısmında ifade
edilmiştir.

.. figure:: /assets/Nektar-howto/images/boundaryconditions.PNG
   :name: sinir_kosul

   Sınır koşulları

Sürekli projeksiyon sıkıştırılamaz akış çözücüsünde desteklenmediğinden
ötürü Dirichlet ve Neumann tipindeki sınır koşulları da desteklenmez.
Başlangıç koşulları şu şekilde tanımlanabilir.

.. figure:: /assets/Nektar-howto/images/functions.PNG
   :name: baslangic_kosul


Çözücüyü Çalıştırma ve Sonuç Görüntüleme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Duruma uygun çözücünün seçilerek komuta yazılması ve ardından da ilgili
".xml" dosyasının belirtilmesi gerekmektedir.

.. code-block::

   NEK/ÇözücüAdı dosyaadı.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun
çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil
eder. TRUBA sunucusunda bu adres şu şekildedir:

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/

Çözüm işlemi sırasında belirli adımlarda ".chk" dosyaları basılır.
Ayrıca çözüm sonunda bu dosyaların hepsindeki bilgiyi içeren bir son
".fld" dosyası basılır. Bu dosyalardaki bilgileri Paraview veya VisIt
gibi görüntüleme yazılımları tarafından okunabilecek duruma getirmek
için ".vtu" formatına çevirmek gerekmektedir. Bu çevirme işlemi için
gerekli olan altyapı Nektar++ içinde **FieldConvert** ismiyle mevcuttur.
Çevirme işlemi için şu komut kullanılabilir:

.. code-block::

   NEK/FieldConvert eskidosya.xml eskidosya.fld yenidosya.vtu

Oluşturulan ".vtu" uzantılı dosya bahsi geçen yazılımlar tarafından
okunur ve çözüm sonuçları incelenebilir.

.. _seri_ornek:

Seri Örnek İş Hazırlama
--------------------------

Sıkıştırılabilir akış çözücüsü ile Navier Stokes denklemlerini çözme
amacında bir örnek aşağıda verilmiştir. Bu örnekte kullanılan dosyalar
http://doc.nektar.info/tutorials/5.0.2/cfs/CylinderSubsonic_NS/cfs-CylinderSubsonic
\_NS.tar.gz adresinden indirilebilir. Bu dosya içindeki "tutorial"
klasörü kullanılacaktır. Ayrıca çözüm sonrası işlemler için ParaView
veya VisIt uygulamaları kullanılabilir. Bu örnekteki amaç bir silindirin
üstünden geçen akışı sıkıştırılabilir Navier Stokes denklemleri ile
simüle etmektir. Akış parametreleri :math:`M_{infty}=0.2`,
:math:`Re_{L=1}=200`, :math:`Pr=0.72` olarak verilmiştir. Basınç
:math:`P_{\infty}=101325 Pa` ve yoğunluk :math:`\rho = 1.225 kg/m^3`
olarak bilinmektedir.

.. _seri_ornek_problem:

Problem Tanımı
^^^^^^^^^^^^^^^^

Akış ve hesaplama alanı [-10 20] x [-10 10] olarak seçilmiştir ve çözüm
ağı 639 dörtyüzlü elemandan oluşmaktadır. Sınır koşulları
"kaydırmazlık", "yüzeydeki eş sıcaklık" ve "uzak alan" sınır koşulları
olarak uygulanmıştır. `Aşağıdaki şekil <#problem>`__ çözüm ağını
gösterir ve buradan da düzensiz bir çözüm ağı kullanıldığı görülebilir.
Çözüm ağı katı cismin etrafında daha sık bir şekilde örülmüşken
uzaklaştıkça seyrekleşmeye başlar. Bu, cismin etrafındaki sınır
koşullarını doğru tanımlayabilmek ve buradaki sınır tabakası
etkileşimlerinin akışa etkisini doğru yakalamak içindir.

.. figure:: /assets/Nektar-howto/images/problem.PNG
   :name: problem

   Örnekteki problemin açıklaması

Sıkıştırılamaz akış çözücüsü (Compressible Flow Solver) için sınır
koşulları akılara uygulanmaktadır. Euler denklemlerinde, uzak nokta
sınır koşulları için akılar Riemann çözücüsü ile hesaplanır. Riemann
çözüsünde sınır koşullarını uygulamak bazı ara veya hayalet noktaların
kullanımını gerektirir. Euler denklemlerinin karakteristik doğruları
dikkate alınır. Viskoz etkilerin dikkate alınmasına gerek olmayan
durumlarda Navier Stokes denklemlerindeki taşınım akıları da Euler
denklemlerindeki uzak nokta sınır tabakaları ile ifade edilebilir veya
modellenebilir. Bu aşamadan sonra çözüm parametreleri tanımlanacak,
çözücü koşturulacak ve sonuçların görüntülenmesi yapılacaktır.

Ön İşlemler ve Çözüm Ağı Oluşturma
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nektar++ üzerinde problemi tanımlamak için üç temel basamak vardır.
Öncelikle çözüm ağı oluşturulur, ardından genişleme tabanları ayarlanır.
Başlangıç koşullarının konfigürasyonu, sınır koşulları ve gerekli
parametreler bu adımların ardından tanımlanır. Bu bölümde ve sıradaki
bölümlerde bu adımların üzerinde durulacaktır.

Çözüm Ağı Oluşturma
^^^^^^^^^^^^^^^^^^^^

Ön işlemlerin ilki Nektar++ ile uyumlu bir formatta çözüm ağı
hazırlamaktır. Bu çözüm ağının etrafında oluşturulacağı geometri
öncelikle açık kaynak çözüm ağı oluşturucularından Gmesh ile
oluşturulabilir. Fakat, çözüm ağı çıktı formatı Nektar++ ile uyumlu
olmadığından başka bir formata dönüştürülmesi gerekmektedir. Bu durumda
<**NekMesh**> rutinin bu ön işlem sırasında çalıştırılması gerekir. Bu
komut iki girdi gerektirir; Gmsh tarafından oluşturulan ".msh" uzantılı
dosya ismi ve NekMesh’in oluşturacağı Nektar++ ile uyumlu olan ".xml"
dosyasının adı. Örnek komut şu şekildedir:

.. code-block::

   NEK/eskidosya_mesh.msh yenidosya_mesh.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun
çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil
eder. TRUBA sunucusunda bu adres şu şekildedir:

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/

Bu örnekte verilen dosya .xml formatında olduğundan herhangi bir dönüşüme gerek yoktur. 2 boyuttaki
simülasyonlar için çözüm ağının ``GEOMETRY`` etiketi altındaki 6 alt bölüm ile tanımlanması gerekmektedir.
``VERTEX`` etiketi köşe noktalarının uzaydaki koordinatlarını içerir. ``EDGE`` bu köşeleri bağlayan doğruları
kapsar. ``ELEMENT`` ise çözüm ağı elemanlarını tanımlar. ``CURVED`` ise eğriler üzerinde kontrol noktalarını
tanımlamak için kullanılır. Eğer eğri kenarlar veya yüzeyler yoksa bu etiket göz ardı edilebilir. ``COMPOSITE``
çözümün alt alanlarını ve denklem setlerinin çözüleceği yerleri tanımlar. Sınır koşulları için de kompozit alanlar
kullanılabilir. Son etiket olan ``DOMAIN`` ise tüm çözüm alanının ve kompozit alanlarının bütünlüğünü sağlar.
Aşağıdaki figürler bu geometri tanımlarının iç yüzlerini örnekler ve genel yapıları hakkında fikir vermeyi amaçlar.
Ekran görüntüsünde ilk 10-20 satır alındığından bu bilgiler dosyaların tamamını kapsamamaktadır.

.. figure:: /assets/Nektar-howto/images/vertex_ornek.PNG
   :name: kose1

   Köşe tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/edge_ornek.PNG
   :name: kenar1

   Kenar tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/element_ornek.PNG
   :name: eleman1

   Eleman tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/curved_ornek.PNG
   :name: egri1

   Eğri tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/composite_ornek.PNG
   :name: kompozit

   Kompozit alan tanımlama örnekleri

Genişleme Tabanları
^^^^^^^^^^^^^^^^^^^^

Kompozit veya alt alanların kullanımı için genişleme tabanları
tanımlanabilir. Örneği `aşağıdaki şekil <#alan_ve_genisleme1>`__ içinde bulunabilir. Burada tek kompozit ve
3 temel denklem (NUMMODES) için örnekleme yapılmıştır.

.. figure:: /assets/Nektar-howto/images/domain_and_expansions_ornek.PNG
   :name: alan_ve_genişleme1

   Alan ve genişleme tabanları tanımlama örnekleri

Çözüm Parametrelerinin Tanımlanması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu noktada çözümde baz alınacak değerler tanımlanır. Örnek olarak
aşağıdaki şekil incelenebilir.

.. figure:: /assets/Nektar-howto/images/parameters_ornek.PNG
   :name: parametre_ornek

   Çözüm parametreleri örneği

Çözücü Ayarları
~~~~~~~~~~~~~~~

Problemin çözücü ile nasıl çözüleceğini belirlemek için bazı ayarlar
tanımlanır. Akış problemi örneğinde bunlar akışkan viskozitesi, ısı
iletimi ve Navier Stokes içindeki denklem tipleri olabilir.
Sıkıştırılabilir akışlarda genelde süreksiz projeksiyon metotları,
örneğin discontinuos Galerkin (DG), kullanıldığı için ``Projection`` kısmının
"DisContinuous" olarak ayarlanması gerekmektedir. Taşınım, difüzyon,
problem, zaman integrasyonu ve viskozite tipleri aşağıdaki düzende
seçilir.

Değişkenler & Sınır Bölgeleri
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Çözüm değişkenleri tanımlanır ve sınır bölgeleri şu şekilde
tanımlanabilir.

.. figure:: /assets/Nektar-howto/images/solver_and_boundary_info.PNG
   :name: cozucu_degisken

   Çözücü ayarları örneği

Sınır Koşulları
^^^^^^^^^^^^^^^^

Ardından ``BOUNDARY CONDITIONS`` içinde sınır koşulları tanımlanır. Hangi sınır için
tanımlandıkları bir önceki bölüm olan sınır bölgeleri kısmında ifade
edilmiştir.

.. figure:: /assets/Nektar-howto/images/boundaryconditions_ornek.PNG
   :name: sinir_kosul_cozumagi

   Sınır koşulları örneği

Sürekli projeksiyon sıkıştırılamaz akış çözücüsünde desteklenmediğinden
ötürü Dirichlet ve Neumann tipindeki sınır koşulları da desteklenmez.
Başlangıç koşulları şu şekilde tanımlanabilir.

.. figure:: /assets/Nektar-howto/images/functions_ornek.PNG
   :name: baslangic_kosul-2

   Başlangıç koşulları örneği

Son olarak, çözümdeki dalgalanmaları azaltmak ve akış süreksizliklerini
temsil edebilmek adına yapay viskozite temeline dayanan bir şok yakalama
tekniği kullanılır. Bunun için ``SOLVER_INFO`` bölümünde
``ShockCaptureType`` kısmı düzenlenmelidir.

.. _cozucuyu-calistirma-ve-sonuc-goruntuleme-1:

Çözücüyü Çalıştırma ve Sonuç Görüntüleme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sıkıştırılamaz akış çözücüsü (Comperessible Flow Solver) sonuna çözeceği
problemi ihtiva eden dosyanın adı eklenerek şu komutla çalıştırılabilir.
<**NEK/CompressibleFlowSolver dosyaadı.xml**> Yukarıdaki komutta bulunan
"NEK" kısaltması Nektar++ kodunun çalıştırılacak olan "executable"
dosyalarının bulunduğu adresi temsil eder. TRUBA sunucusunda bu adres şu
şekildedir:

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/CompressibleFlowSolver
   CylinderSubsonic_NS.xml

Çözüm işlemi sırasında belirli adımlarda ".chk" dosyaları basılır.
Ayrıca çözüm sonunda bu dosyaların hepsindeki bilgiyi içeren bir son
".fld" dosyası basılır. Bu dosyalardaki bilgileri Paraview veya VisIt
gibi görünteleme yazılımları tarafından okunabilecek duruma getirmek
için ".vtu" formatına çevirmek gerekmektedir. Bu çevirme işlemi için
gerekli olan altyapı Nektar++ içinde **FieldConvert** ismiyle mevcuttur.
Çevirme işlemi için şu komut kullanılabilir:

.. code-block::

   NEK/FieldConvert eskidosya.xml eskidosya.fld yenidosya.vtu

Örnek durum için şu komut yeterlidir.

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/FieldConvert
   CylinderSubsonic_NS.xml CylinderSubsonic_NS.fld
   CylinderSubsonic_NS.vtu

Oluşturulan ".vtu" uzantılı dosya bahsi geçen yazılımlar tarafından
okunur ve çözüm sonuçları incelenebilir. Çözüm sonucunda basınç değişimi
için aşağıdaki şekile benzer bir sonuç beklenmektedir.

.. figure:: /assets/Nektar-howto/images/pressure.PNG
   :name: basinc_sonuc

   Basınç dağılımı

Yukarıdaki şekilden de görülebileceği gibi basınç ön tarafta hız
düşmesinden dolayı daha yüksektir, ve sonradan düşmeye başlar.
Silindirin devamında akış basıncıyla aynı duruma gelir. Bu beklenen bir
sonuçtur ve kullanıcıların da benzer sonuçlar elde etmeleri
beklenmektedir.

Paralel Örnek İş Hazırlama
----------------------------

İşlemlerin cihazdaki başka çekirdekleri kullanarak daha hızlı bir
şekilde tamamlanmasına olanak sağlayan paralel çalıştırma Nektar++
tarafından desteklenmektedir. Bu özelliğin kullanılması için Nektar++
derlenirken ``NEKTAR_USE_MPI`` seçeneği "ON" olarak ayarlanmalıdır. Ardından komut verme
kısmında işlemci sayısı seçilerek daha önce belirtilen işlemler
tekrarlanabilir. Kılavuz tutarlılığı açısından bu işlemler bu bölümde de
tekrarlanmıştır. Kullanılacak dosyalar :ref:`seri_ornek` kısmı ile,
problem tanımı da :ref:`seri_ornek_problem` kısmı ile aynıdır.

.. _on-islemler-ve-cozum-agi-olusturma-1:

Ön İşlemler ve Çözüm Ağı Oluşturma
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nektar++ üzerinde problemi tanımlamak için üç temel basamak vardır.
Öncelikle çözüm ağı oluşturulur, ardından genişleme tabanları ayarlanır.
Başlangıç koşullarının konfigürasyonu, sınır koşulları ve gerekli
parametreler bu adımların ardından tanımlanır. Bu bölümde ve sıradaki
bölümlerde bu adımların üzerinde durulacaktır.

Çözüm Ağı Oluşturma
^^^^^^^^^^^^^^^^^^^^

Ön işlemlerin ilki Nektar++ ile uyumlu bir formatta çözüm ağı
hazırlamaktır. Bu çözüm ağının etrafında oluşturulacağı geometri
öncelikle açık kaynak çözüm ağı oluşturucularından Gmesh ile
oluşturulabilir. Fakat, çözüm ağı çıktı formatı Nektar++ ile uyumlu
olmadığından başka bir formata dönüştürülmesi gerekmektedir. Bu durumda
<**NekMesh**> rutinin bu ön işlem sırasında çalıştırılması gerekir. Bu
komut iki girdi gerektirir; Gmsh tarafından oluşturulan ".msh" uzantılı
dosya ismi ve NekMesh’in oluşturacağı Nektar++ ile uyumlu olan ".xml"
dosyasının adı. Örnek komut şu şekildedir:

.. code-block::

   NEK/eskidosya_mesh.msh yenidosya_mesh.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun
çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil
eder. TRUBA sunucusunda bu adres şu şekildedir:

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/

Verilen dosya .xml olduğu için bu örnekte herhangi bir dönüşüm yapmaya gerek yoktur. 2 boyuttaki
simülasyonlar için çözüm ağının GEOMETRY etiketi altındaki 6 alt bölüm ile tanımlanması gerekmektedir. ``VERTEX`` etiketi köşe noktalarının uzaydaki koordinatlarını içerir. ``EDGE`` bu köşeleri bağlayan doğruları kapsar. ``ELEMENT`` ise çözüm ağı elemanlarını tanımlar. ``CURVED`` ise eğriler üzerinde kontrol noktalarını tanımlamak için kullanılır. Eğer eğri kenarlar veya yüzeyler yoksa bu etiket göz ardı edilebilir. ``COMPOSITE`` çözümün alt alanlarını ve denklem setlerinin çözüleceği yerleri tanımlar. Sınır koşulları için de kompozit alanlar kullanılabilir. Son etiket olan ``DOMAIN`` ise tüm çözüm alanının ve kompozit alanlarının bütünlüğünü sağlar. Aşağıdaki figürler bu geometri tanımlarının iç yüzlerini örnekler ve genel yapıları hakkında fikir vermeyi amaçlar. Ekran görüntüsünde ilk 10-20 satır alındığından bu bilgiler dosyaların tamamını kapsamamaktadır.

.. figure:: /assets/Nektar-howto/images/vertex_ornek.PNG
   :name: kose2

   Köşe tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/edge_ornek.PNG
   :name: kenar2

   Kenar tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/element_ornek.PNG
   :name: eleman2

   Eleman tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/curved_ornek.PNG
   :name: egri2

   Eğri tanımlama örnekleri

.. figure:: /assets/Nektar-howto/images/composite_ornek.PNG
   :name: kompozit-2

   Kompozit alan tanımlama örnekleri

Genişleme Tabanları
^^^^^^^^^^^^^^^^^^^^

Kompozit veya alt alanların kullanımı için genişleme tabanları tanımlanabilir. Örneği `aşağıdaki şekil <#alan_ve_genisleme2>`__ içinde bulunabilir. Burada tek kompozit ve 3 temel denklem (NUMMODES) için örnekleme yapılmıştır.

.. figure:: /assets/Nektar-howto/images/domain_and_expansions_ornek.PNG
   :name: alan_ve_genisleme2

   Alan ve genişleme tabanları tanımlama örnekleri

Çözüm Parametrelerinin Tanımlanması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu noktada çözümde baz alınacak değerler tanımlanır. Örnek olarak
aşağıdaki şekil incelenebilir.

.. figure:: /assets/Nektar-howto/images/parameters_ornek.PNG
   :name: parametre_ornek-2

   Çözüm parametreleri örneği

.. _çözüm-parametrelerini-ayarlama-1:

Çözüm Parametrelerini Ayarlama
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Çözüm ağı oluşturulduktan sonra çözüm parametreleri ve çözücü seçimi ile
çözücü ayarları yapılmalıdır. Nektar++ üzerinde problemi tanımlamak için
üç temel basamak vardır. Öncelikle çözüm ağı oluşturulur, ardından
genişleme tabanları ayarlanır. Başlangıç koşullarının konfigürasyonu,
sınır koşulları ve gerekli parametreler bu adımların ardından
tanımlanır. Bu bölümde bu adımların üzerinde durulacaktır. 

Çözüm Ağı Formatını Dönüştürme
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ön işlemlerin ilki Nektar++ ile uyumlu bir formatta çözüm ağı hazırlamaktır. Bu çözüm
ağının etrafında oluşturulacağı geometri öncelikle açık kaynak çözüm ağı
oluşturucularından Gmesh ile oluşturulabilir. Fakat, çözüm ağı çıktı
formatı Nektar++ ile uyumlu olmadığından başka bir formata
dönüştürülmesi gerekmektedir. Bu durumda <**NekMesh**> rutinin bu ön
işlem sırasında çalıştırılması gerekir. Bu komut iki girdi gerektirir;
Gmsh tarafından oluşturulan ".msh" uzantılı dosya ismi ve NekMesh’in
oluşturacağı Nektar++ ile uyumlu olan ".xml" dosyasının adı. Örnek komut
şu şekildedir:

.. code-block::

   NEK/eskidosya_mesh.msh yenidosya_mesh.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil eder. 2 boyuttaki simülasyonlar için çözüm ağının ``GEOMETRY`` etiketi altındaki 6 alt bölüm ile tanımlanması gerekmektedir. ``VERTEX`` etiketi köşe noktalarının uzaydaki koordinatlarını içerir. ``EDGE`` bu köşeleri bağlayan doğruları kapsar. ``ELEMENT`` ise çözüm ağı elemanlarını tanımlar. ``CURVED`` ise eğriler üzerinde kontrol noktalarını tanımlamak için kullanılır. Eğer eğri kenarlar veya yüzeyler yoksa bu etiket gözardı edilebilir. ``COMPOSITE`` çözümün alt alanlarını ve denklem setlerinin çözüleceği yerleri tanımlar. Sınır koşulları için de kompozit alanlar kullanılabilir. Son etiket olan ``DOMAIN`` ise tüm çözüm alanının ve kompozit alanlarının bütünlüğünü sağlar. Aşağıdaki görsel geometri tanımlarının özetini içerir.

.. figure:: /assets/Nektar-howto/images/geometry.PNG
   :name: geometri-2

   Geometri tanımları

Genişleme Tabanları
^^^^^^^^^^^^^^^^^^^^^

Kompozit veya alt alanların kullanımı için genişleme tabanları
tanımlanabilir. Örneği `yukarıdaki şekil <#expansions>`__ içinde
bulunabilir. Burada tek kompozit ve 3 temel denklem (NUMMODES) için
örnekleme yapılmıştır.

.. figure:: /assets/Nektar-howto/images/expansion.PNG
   :name: expansions-2

   Genişleme tabanları tanımı

Çözüm Parametrelerinin Tanımlanması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu noktada çözümde baz alınacak değerler tanımlanır. Örnek olarak
aşağıdaki şekil incelenebilir. Bu şekilde çözücünün kullanırken ihtiyaç
duyacağı sabitler ve parametreler problem tanımlamasına uygun bir
şekilde ifade edilir.

.. figure:: /assets/Nektar-howto/images/parameters.PNG
   :name: parametre_ornek-3

   Çözüm parametreleri

Çözücü Ayarları
^^^^^^^^^^^^^^^^

Problemin çözücü ile nasıl çözüleceğini belirlemek için bazı ayarlar
tanımlanır. Örneğin, bir akış problemi durumunda bunlar akışkan
viskozitesi, ısı iletimi ve Navier Stokes içindeki denklem tipleri
olabilir. Sıkıştırılabilir akışlarda genelde süreksiz projeksiyon
metodları, örneğin discontinuos Galerkin (DG), kullanıldığı için ``Projection``
kısmının "DisContinuous" olarak ayarlanması gerekmektedir. Taşınım,
difüzyon, problem, zaman integrasyonu ve viskozite tipleri aşağıdaki
düzende seçilir.

.. figure:: /assets/Nektar-howto/images/solver.PNG
   :name: cozucu_ayar

   Çözücü ayarları

Değişkenler
^^^^^^^^^^^^

Çözüm değişkenleri tanımlanır. 2 boyut için örnek şu şekildedir. Farklı
problemler ve çözücüler için aşağıdaki değişkenler ve başlıklar
farklılık gösterebilir. Kullanıcının duruma uygun değişkenler seçmesi ve
bunları tanımlaması önem arz etmektedir.

.. figure:: /assets/Nektar-howto/images/variables.PNG
   :name: degiskenler-2

   Değişkenler

Sınır koşullarının değişkenlerden ziyade akılara uygulandığı hatırlanmalıdır. 

Sınır Koşulları
^^^^^^^^^^^^^^^^

Sınır bölgeleri ``BOUNDARY REGIONS`` içinde tanımlanır. 2 boyut için örnek
şu şekildedir.

.. figure:: /assets/Nektar-howto/images/boundaryregions.PNG
   :name: sinir_bolge-2

   Sınır bölgeleri

Ardından ``BOUNDARY CONDITIONS`` içinde sınır koşulları tanımlanır. Hangi sınır için
tanımlandıkları bir önceki bölüm olan sınır bölgeleri kısmında ifade
edilmiştir.

.. figure:: /assets/Nektar-howto/images/boundaryconditions.PNG
   :name: sinir_kosul_cozucu

   Sınır koşulları

Sürekli projeksiyon sıkıştırılamaz akış çözücüsünde desteklenmediğinden
ötürü Dirichlet ve Neumann tipindeki sınır koşulları da desteklenmez.
Başlangıç koşulları şu şekilde tanımlanabilir.

.. figure:: /assets/Nektar-howto/images/functions.PNG
   :name: baslangic_kosul-3

   Başlangıç koşulları

.. _cozucuyu-calistirma-ve-sonuc-goruntuleme-2:

Çözücüyü Çalıştırma ve Sonuç Görüntüleme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sıkıştırılamaz akış çözücüsü (Comperessible Flow Solver) sonuna çözeceği
problemi ihtiva eden dosyanın adı eklenerek şu komutla çalıştırılabilir.

.. code-block::

   NEK/mpirun -np "işlemcisayısı"CompressibleFlowSolver
   dosyaadı.xml

Yukarıdaki komutta bulunan "NEK" kısaltması Nektar++ kodunun
çalıştırılacak olan "executable" dosyalarının bulunduğu adresi temsil
eder. TRUBA sunucusunda bu adres şu şekildedir:

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/

4 işlemci kullanıldığı durumu varsayarsak,

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/mpirun
   -np 4 CompressibleFlowSolver CylinderSubsonic_NS.xml

Çözüm işlemi sırasında belirli adımlarda ".chk" dosyaları basılır.
Ayrıca çözüm sonunda bu dosyaların hepsindeki bilgiyi içeren bir son
".fld" dosyası basılır. Bu dosyalardaki bilgileri Paraview veya VisIt
gibi görüntüleme yazılımları tarafından okunabilecek duruma getirmek
için ".vtu" formatına çevirmek gerekmektedir. Bu çevirme işlemi için
gerekli olan altyapı Nektar++ içinde **FieldConvert** ismiyle mevcuttur.
Çevirme işlemi için şu komut kullanılabilir:

.. code-block::

   NEK/FieldConvert eskidosya.xml eskidosya.fld yenidosya.vtu

Örnek durum için şu komut yeterlidir.

.. code-block::

   /truba/sw/centos7.3/app/nektar++/5.0.2-gcc-9.2/nektar-v5.0.2/build/dist/bin/FieldConvert
   CylinderSubsonic_NS.xml CylinderSubsonic_NS.fld
   CylinderSubsonic_NS.vtu

Oluşturulan ".vtu" uzantılı dosya bahsi geçen yazılımlar tarafından
okunur ve çözüm sonuçları incelenebilir. Çözüm sonucunda basınç değişimi
için aşağıdaki şekile benzer bir sonuç beklenmektedir.

.. figure:: /assets/Nektar-howto/images/pressure.PNG
   :name: cozucu-basinc_sonuc

   Basınç dağılımı

Yukarıdaki şekilden de görülebileceği gibi basınç ön tarafta hız
düşmesinden dolayı daha yüksektir, ve sonradan düşmeye başlar.
Silindirin devamında akış basıncıyla aynı duruma gelir. Bu beklenen bir
sonuçtur ve kullanıcıların da benzer sonuçlar elde etmeleri
beklenmektedir.

TRUBA sunucusunda GUI (Grafiksel Kullanıcı Arayüzü) kullanılamadığından
komutların terminalden girilmesi gerekmektedir. Çoğu adım seri iş
oluşturma ile benzerlik gösterdiğinden daha detaylı anlatım için
:ref:`is_gonderimi` ve :ref:`seri_ornek` bölümleri incelenebilir. 

TRUBA sunucusunda GUI (Grafiksel Kullanıcı Arayüzü) kullanılamadığından
komutların terminalden girilmesi gerekmektedir. Kullanım rahatlığı
açısından TRUBA sunucuna bağlanmadan kullanıcı arayüzü vasıtasıyla iş
klasörünün oluşturulması ve istenilen seçimlerin yapılıp
**ProblemAdı.xml** içine kaydedilmesi önerilir. Oluşturulan iş klasörü
bir dosya aktarım programı, örneğin Filezilla, yardımı ile TRUBA
sunucusuna taşınabilir. Ardından <**NEK/ÇözücüAdı dosyaadı.xml**>
komutunun çalıştırılması yeterlidir. İş tamamlandıktan sonra sonuç
dosyaları görüntüleme programlarında kullanılmak üzere, yine bir dosya
transfer programı yardımıyla, tekrar kullanıcının bilgisayarına
taşınabilir.
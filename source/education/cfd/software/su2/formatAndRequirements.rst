************************************************
<<<<<<< HEAD:source/education/cfd/software/su2/formatAndRequirements.rst
2 - |SU2| Çözüm Ağı Formatları ve Gereksinimleri
=======
2 - SU2 çözüm ağı formatları ve gereksinimleri
>>>>>>> arassaygin-ODTU-updates-3-8-21:source/education/CFD/SU2/formatAndRequirements.rst.rst
************************************************
SU2 ile HAD çözümleri almak için belirli formatlarda ve belirli koşulları 
sağlayan çözüm ağları belirli formatlarda verilmelidir. Bu ağların Teknik 
özellikleri ve format gereksinimleri ayrı ayrı açıklanmıştır.

**Ağ gereksinimleri**

SU2 hem iki boyutlu hem de üç boyutlu analizler gerçekleştirebilmektedir. 
Dolayısı ile iki tür ağ d girdi olarak kabul edilebilmektedir. Aynı şekilde, 
eksenel simetrik çözümler de alınabilmektedir. Bu tür analizler için hem 
simetri (dönüş) eksenini hem de iki boyutlu bir ağ sağlamalısınız.

SU2 sadece tam bağlı (İng. *conformal*) yapısal olmayan ağ tipleri ile çözüm
alabilir. Bu ağ tiplerinde kabul edilen hücre tipleri şunlardır:

* 2 boyut için üçgen (TRI)
* 2 boyut için dörtgen (QUAD)
* 3 boyut için düzgün dört yüzlü (TETRAHEDRON)
* 3 boyut için düzgün altı yüzlü (HEXAHEDRON)
* 3 boyut için dörtgen tabanlı piramit
* 3 boyut için üçgen prizma

SU2 sadece yapısal olmayan ağları kabul etmektedir. Yapısal ağ formatlarını
yapısal olmayana çevirerek kullanabilirsiniz.

SU2 yukarıda belirtilen yapısal ağ hücrelerinin karışımından oluşturulan 
ağları kullanabilir. Ancak karışım ağlarda hücreler tam bağlı olmalıdır. Yani 
hücrelerin dikdörtgen yüzeyleri diğer hücrenin eş boyutlu sadece bir dikdörtgen
yüzüne, üçgen yüzleri de eş boyutlu sadece bir üçgen yüzlere bağlanmalıdır. 

SU2 sadece konformal ağlar kullanabilir. Bunun anlamı, asılı düğüm noktası 
içeren (İng. *Hanging Node*) ağların kullanılamamasıdır.

SU2 sadece belirli hücre tipleri kullanan hücre-temelli formatları 
kullanabilmektedir. yüzey-temelli formatlar kullanılamaz. Dolayısı ile 
polihedral veya kartezyen formatlar kullanılamamaktadır.

.. note::
    Bu formatların kullanılabilmesi için ülkemizde özelleşmiş SU2 sürümleri
    geliştirilmiştir. Eğer SU2'yi bu ağ formatları ile kullanmak isterseniz
    bu özelleşmiş sürümlere yönelmeniz gerekecektir.

Eğer ağ üretimini *OpenFOAM* veya *FLUENT* gibi yüzey temelli formatlar ile 
gerçekleştiriyorsanız, bazı ağ tiplerini CGNS'e çevirerek kullanabilirsiniz.

2.1 - Ağ Formatları
===================
2.1.1 -  SU2 formatı
----------------------
Gittikçe popüler olan SU2 formatı hücre temelli bir formattır ve benzeri 
formatlarla büyük benzerlik gösterir. Buna göre verilmesi gereken ilk bilgi 
boyut bilgisidir. Boyu bilgisi koordinat girişini de etkileyecektir.

.. code-block:: text

   NDIME=3

Ardından düğüm sayısını ve takiben verdiğiniz sayı kadar koordinat girişini 
:math:`x`, :math:`y`, ve gerekirse :math:`z` koordinatları olarak vermelisiniz.
Dolayısı ile SU2 sizden N :subscript:`dim` x N :subscript:`node` sayısı kadar
koordinat rakamı beklemektedir. Bu koordinatlar boşluk karakterleri ve yeni 
satır ile verilebilir.

.. code-block:: text

   NPOIN = 15447
   0.00000000000000 0.00000000000000
   1.00000000000000 0.00000000000000
   ...

Yukarıdaki örnek 2 boyutlu bir ağ içindir. Üç boyut için tabii ki üçüncü 
koordinat bilgisini vermelisiniz.

Elemanların (hücrelerin) tanımlanması için öncelikle eleman sayısı verilir. 
Ardından, eleman tanımlanmasına geçilir. Bu amaçla, her hücre için önce 
eleman tipi ilgili sayı kodu, ardından elemanı tanımlayan düğüm noktaları 
girilir. eleman tipleri için sayı kodları aşağıdaki gibidir:

========================  ===
       eleman tipi         #
========================  ===
Doğru parçası              3
Üçgen (TRI)                5
Dörtgen (QUAD)             9
Düzgün dört yüzlü (TET)    10
Düzgün altı yüzlü (HEX)    12
Üçgen prizma               13
Dörtgen tabanlı piramit    14
========================  ===

.. code-block:: text

    NELEM = 8 
    10 0 1 2 3
    10 2 1 3 5
    ...

Burada dikkat edilmesi gereken hususlar şunlardır:

* Eleman koordinat eksenleri için indeks 0'dan başlar. eğer fortran gibi 
  indeksin 1'den başladığı bir dilden işlem yapıyorsanız, veya tecplot gibi 
  formatlara alışıksanız, bu ayrıntıya dikkat etmelisiniz.
* Her eleman için düğümlerin veriliş sırasının önemi vardır. her elemanın köşe
  noktaları belirli bir düzende ve pozitif hacim verecek şekilde
  düzenlenmelidir. 
* Eleman girişi için SU2, *VTK* formatı ile aynı sıralamayı kullanmaktadır.
  VTK ağ formatı dokümanına buradan erişebilirsiniz.
* Bir boyutlu elemanlara sınır şartlarında ihtiyaç duyacağız.
* Eleman marker'ları vtk ile aynı olsa da her VTK eleman tipine erişim 
  olmayabilir. iki proje birbirinden tamamen bağımsızdır. sadece yukarıda 
  verilen (veya güncel \SU2 dokümanında olan) eleman tiplerini kullanın.

Sınır şartları için *MARKER* anahtar kelimesi kullanılmaktadır. her sınır 
şartı yüzeyi belli bir isim ile isimlendirilmelidir. bu isim tag olarak 
geçecektir. ardından her sınır şartının kaç elemandan oluştuğunu 
belirtmelisiniz. ardından yüzey eleman girişleri gelmelidir. eleman girişleri
tüm normalleri uygun yöne bakacak şekilde yukarıdaki tabloda verilen şekilde 
vermelisiniz.

.. code-block:: text

 NMARK=2
 MARKER_TAG=walls
 MARKER_ELEMS=4
 1 0 1 2
 ...
 MARKER_TAG=pff
 ...

2.1.2 - CGNS formatı
--------------------
CGNS HAD yazılımları arasında kol çözüm ağı paylaşılabilmesi için oluşturulmuş
ve açık bir forum tarafından idame ettirilen açık standart bir veri formatıdır.
Açık kaynak veya özel, hemen hemen tüm ağ üreteçleri tam bağlı ağlarını CGNS 
formatına aktarabilmektedir. Polihedra ve tam bağlı olmayan Kartezyen ağlar ise
bu formatta saklanamazlar. Ancak, SU2 bu tür ağları kullanamadıkları için 
bu durum özellikle bir sorun teşkil etmemektedir.

CGNS iki formatta çözüm ağı saklayabilmektedir. Birincisi (çok bloklu da dahil)
yapısal ağlardır. Diğeri ise yapısal olmayan ağlardır. Eğer yapısal bir ağ 
üretmişseniz, ağı yapısal olmayan formatta saklayarak SU2'ya aktarmalısınız.
CGNS'e yapısal olmayan formatta aktarılan tüm ağlar SU2 tarafından 
kullanılabilecektir.

CGNS ağları kullanmak için SU2 CGNS desteği ile kurulmuş olması gerekmektedir
. Bunun için şu adımları izlemeniz gerekmektedir.

* Linux bilgisayarınızda CGNS kütüphanesinin (cgns-lib) ve geliştirme 
  paketlerinin (cgns-dev) bulunması gerekmektedir. Her Linux sürümü için 
  bulunabilen bu kütüphaneleri, paket olarak kurabileceğiniz gibi, kaynak 
  dosyalarını da indirip kullanabilirsiniz.
* SU2 sadece ADF destekli CGNS kütüphanesini kullanabilmektedir. CGNS 
  kütüphanenizin ADF desteklediğine emin olun.
* Meson derleme betiklerine -Denable-cgns opsiyonunun açık olduğuna ve 
  betiklerin cgns başlık (header) dosyalarına ve de kütüphanelerine erişimi olduğuna emin olun.
* SU2 yazılımını bu opsiyonlarla (gerekirse en baştan) derleyin

Bunun ardından, analiz konfigürasyon dosyasında ``MESH_FORMAT=CGNS`` ifadesi
kullanarak CGNS formatındaki ağları kullanabilirsiniz.
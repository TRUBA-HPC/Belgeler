.. |check_| raw:: html

    <input checked=""  disabled="" type="checkbox">

.. _nektar-kurulum:

===================
Nektar++ Kurulum
===================

Nektar++ uygulamasının bir Linux sistemine kurulabilmesi için bazı
kütüphanelerin bulunması gerekmektedir. Bu kütüphanelerin bazıları,
tablodaki ilk 7 modül, Nektar++ kurucusunda mevcut bulunmadığından
önceden yüklenmelilerdir. Çoğu Linux sisteminde bulunan bu
kütüphanelerin versiyonları terminal üzerinden ``kütüphane adı -
-version`` komutu ile kontrol edilebilir.

-------------------
Ön Gereksinimler
-------------------

**Zorunlu ön koşullar:**

-  C++ derleyicisi (en az C++11 standardıyla uyumlu)

-  CMake (en az versiyon 2.8.11) (kullanıcı arayüzü için)

-  BLAS (veya MKL, ACML, OpenBLAS)

-  LAPACK

-  Boost (en az versiyon 1.56) (iostream ile derlemek için)

-  TinyXML (XML girdi dosyalarının okunması için)

-  Scotch (çözüm ağı kuyruklarının optimizasyonunda kullanılır, paralel
   hesaplamalar için)


**Opsiyonel ön koşullar:**

-  METIS

-  FFTW (en az versiyon 3.0) (yüksek performanslı FFT ler için)

-  ARPACK (en az versiyon 2.0) (Arnoldi algoritmaları için)

-  MPI (OpenMPI, MPICH, Intel MPI vs.) (paralel iş gönderimleri için)

-  GSMPI (paralel hesaplama için)

-  HDF5 (büyük ölçekli paralel girdi ve çıktı dosyaları için) (CMake versiyon 3.1 gerektirir)

-  OpenCascade CE (çözüm ağı oluşturulması ve optimize edilmesi için)

-  PETSc (alternatif doğrusal çözücüler)

-  PT-Scotch (MPI kullanıldığı durumlar için)

-  Tetgen (3 boyutlu çözüm ağlarının oluşturulması için)

-  Triangle (2 boyutlu çözüm ağlarının oluşturulması için)

-  VTK (en az versiyon 5.8) (alan sonuç dosyalarını VTK formatına dönüştürmek için, sadece çözüm ağı dosyaları için önerilir, zorunlu değil)

.. _indirme:

İndirme ve Kurulum
------------------

Nektar++ içindeki otomatik kurucu vasıtasıyla kolaylıkla kurulabilir.
Bunun için öncelikle sıkıştırılmış tar.gz dosyasının Nektar++ web
sitesindeki ``Downloads/Source Codes`` kısmından uygun Nektar++
versiyonu seçilerek indirilmesi gerekmektedir. İndirilen ``tar.gz`` dosyası
istenilen klasöre koyulduktan sonra;

-  https://www.nektar.info/downloads/ adresinden istenilen versiyonun
   kaynak kodu seçilir ve linke tıklanarak indirilir.

-  Tercihen "Nektar++" isminde ayrı bir klasör açılır.

-  İndirilen tar.gz dosyası açılan klasöre taşınır ve buraya çıkartılır.
   Örneğin, 5.0.2 versiyonu için şu komut kullanılır: ``tar -zxvf
   nektar++-5.0.2.tar.gz``

-  Açılan klasörün içinde ``build`` isimli yeni bir klasör açılır.

-  ``build`` klasörüne gidilir ve bu adreste terminal çalıştırılır.
   Kurulum sırasında karışıklık yaşanmaması adına yükleme işleminin bu
   şekilde ayrı bir ``build`` klasöründen yapılması önerilir.

-  Bu adreste açılan terminalden ``cmake``, veya daha gelişmiş bir
   kurulum için ``ccmake ../`` komutları girilir.

-  Kurulum tercihlerinin belirtilmesi için ``ccmake`` komutunun
   girilmesi ve bu şekilde devam edilmesi gerekmektedir.

-  Son üç adım şu şekilde özetlenebilir.

.. code-block::

   mkdir -p build && cd build

   ccmake ../

-  ``ccmake`` komutu girildikten sonra bir CMake arayüzü açılır ve
   burda ``c`` tuşuna basılarak konfigürasyon yapılandırılır.

-  Ardından Nektar++ kodunun istenilen komponentleri seçilir. "Enter"
   tuşu ile burdaki seçim "ON/OFF" şeklinde yapılır. Nektar++
   komponentleri **NEKTAR_BUILD\_** ön ekiyle başlar ve ihtiyaç
   duyulmayan çözücüleri kuruluma eklememek kurulum işlemini önemli
   ölçüde hızlandıracaktır.

-  **NEKTAR_USE\_** ön eki ile başlayan opsiyonel modüller ve
   kütüphaneler seçilir.

-  Sistemde bulunmayan ve gerekli olan modüller ve üçüncü parti
   kütüphaneler **THIRDPARTY_BUILD\_** ön eki ile belirtilmiştir ve
   sistemde bulunmadığı takdirde buradan seçilerek yüklenebilir.

-  **CMAKE_INSTALL_PREFIX** kısmı düzenlenerek kurulum adresi
   tanımlanabilir. Farklı bir işlem yapılmadığı sürece "build" adresi
   içindeki "dist" alt klasörüne yüklenecektir.

-  Tekrar <**c**> tuşuna basılarak konfigürasyon yapılandırılır. Bu
   aşamada hata oluşursa **THIRDPART_BUILD\_** kısmının incelenmesi
   gerekmektedir.

-  Hatasız bir şekilde devam edildiği durumda ``g`` tuşu ile yükleme
   ve yapılandırma dosyalarının oluşturulması sağlanır.

-  Ardından CMake arayüzünden çıkılır.

-  ``make install`` komutu ile kod çalıştırılır ve kurulum başlatılır.

-  Kurulum sırasında eksik olan gerekli üçüncü parti kütüphaneler
   Nektar++ tarafından "build" klasörü içerisine indirilir ve kurulur.

-  Kurulum işlemi ``make -jx install`` komutu ile x sayısı kadar
   çekirdek kullanılarak paralel bir şekilde de gerçekleştirilebilir.
   Örneğin 4 çekirdekli bir cihaz için ``make j4 install`` komutu
   kurulumu önemli ölçüde hızlandıracaktır.

-  Kurulumu test etmek için ``ctest`` komutu girilir. Nektar++ 400’den
   fazla test koşturur ve her çözücünün doğru çalıştığından emin olur.

``ccmake ../`` komutu verildiğinde aşağıdaki ekran karşımıza çıkar. Bu
ekrandan istenilen modüllerin seçilip kurulması için **c** ye ve arından
**g** ye basılarak, en son da **make install** komutu girilerek yukarıda
anlatıldığı gibi kurulması gerekmektedir.

.. figure:: /assets/Nektar-howto/images/ccmake.PNG
   
   CCMake ekranı


--------------------------
Nektar++ Komponentleri
--------------------------

CMake arayüzünde seçilebilecek komponentler şu şekilde listenebilir:

-  **NEKTAR_BUILD_DEMOS** Demo programları derler ve test kısımları için
   kullanılır.

-  **NEKTAR_BUILD_DOC** Doxygen dokümantasyonunu derler.

-  **NEKTAR_BUILD_LIBRARY** Nektar++ kütüphanelerini derler ve tüm diğer
   aşamalar için gereklidir.

-  **NEKTAR_BUILD_PYTHON** Python paketlerinin Nektar++ koduna
   yüklenmesi için gereklidir. Kurulum sonrasında <**make
   nekpy-install-user**> komutunun girilmesini gerektirir.

-  **NEKTAR_BUILD_SOLVERS** Nektar++ bünyesindeki çözücüleri derler.

-  **NEKTAR_BUILD_TESTS** Nektar++ testlerini derler.

-  **NEKTAR_BUILD_TIMINGS** Programların kullandığı zamanlama
   operasyonlarını ayarlar.

-  **NEKTAR_BUILD_UNIT_TESTS** Kütüphanedeki temel fonksiyonların
   testlerini yürütür.

-  **NEKTAR_BUILD_UTILITIES** Çözüm öncesi ve sonrası (pre- ve
   postprocessing) için datalara uygun çevirme operasyonlarını yapar.

CMake arayüzünde seçilebilecek üçüncü parti kütüphaneler şu şekilde
listenebilir:

-  **NEKTAR_USE_ARPACK** Doğrusal stabilite analizleri için gerekli
   programları ve fonksiyonları sağlar.

-  **NEKTAR_USE_CCM** Star-CCM uygulamasından gelecek ccm dosyalarının
   okunmasını sağlar. Bu uygulamadan gelecek çözüm ağı dosyalarının
   okunması için gereklidir.

-  **NEKTAR_USE_CWIPI** CWIPI kütüphanesini kullanarak farklı çözücüler
   arasında işlem arası iletişimi sağlar.

-  **NEKTAR_USE_FFTW** Hızlı Fourier Dönüşümü, Fast Fourier
   Transformation (FFT), için gereklidir. Homojen koordinat yönlü
   alanlar için kullanılır.

-  **NEKTAR_USE_HDF5** Yüksek sayıdaki işlemler için HDF5’ın kullanımını
   sağlar. Paralel işlemler için MPI desteği gerektirir.

-  **NEKTAR_USE_MESHGEN** NekMesh özelliğinin CAD geometrilerinden çözüm
   ağı yaratmasını sağlar.

-  **NEKTAR_USE_TETGEN** Üç boyutlu dörtyüzlü çözüm ağları için
   gereklidir.

-  **NEKTAR_USE_TRIANLGE** İki boyutlu üçgensel çözüm ağları için
   gereklidir.

-  **NEKTAR_USE_TINYXML** XML dosyalarının okunması ve yazılması için
   kullanılır.

-  **NEKTAR_USE_METIS** SCOTCH benzeri ve ona alternatif olarak çözüm
   ağı kuyruklarını ayarlar.

-  **NEKTAR_USE_MPI** Paralel işlemler için gereklidir.

-  **NEKTAR_USE_PETSC** Doğrusal sistemlerin çözümü için kullanılır.

-  **NEKTAR_USE_PYTHON3** Python3 arayüzlerinin kullanımını sağlar.

-  **NEKTAR_USE_SCOTCH** Çözüm ağı ve çözüm kuyruklarının
   optimizasyonunda kullanılır. Windows benzeri sistemler bu özelliği
   desteklemediği için devre dışı bırakılabilir.

-  **NEKTAR_USE_BLAS_LAPACK** Linux sistemlerinde sistemde olan BLAS ve
   LAPACK modüllerinin kullanılması önerilir. Devre dışı olarak
   kalabilir.

-  **NEKTAR_USE_VTK** VTK kütüphanelerinin kullanımını sağlar. Zorunlu
   değil opsiyoneldir.


+-----------------+-------------+-----------+-----------+-----------+-----------------------------------------+
|                        **Kurulum Özellikleri**                                                              |
+=================+=============+===========+===========+===========+=========================================+
| Kütüphane       | Gereksinim  | Sistem    | Kullanıcı | Otomatik | Açıklama                                 |
| / Modül         |             |           |           |          |                                          |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| C++ derleyicisi | |check_|    | |check_|  |           |          | gcc, icc vs için (en az C++11)           |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| CMake           | |check_|    | |check_|  | |check_|  |          | Ncurses GUI için opsiyonel               |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| BLAs            | |check_|    | |check_|  | |check_|  | |check_| | veya MKL, ACML, OpenBLAS                 |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| LAPACK          | |check_|    | |check_|  | |check_|  | |check_| |                                          |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| Boost           | |check_|    | |check_|  | |check_|  | |check_| | Iostream ile derlenme için               |                       
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| TinyXML         | |check_|    | |check_|  | |check_|  | |check_| | XML girdi dosyaları için                 |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| Scotch          | |check_|    | |check_|  | |check_|  | |check_| | Çok düzeyli kullanımlar için             |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| METIS           |             | |check_|  | |check_|  | |check_| | Alternatif çözüm ağı kuyrukları için     |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| FFTW            |             | |check_|  | |check_|  | |check_| | Yüksek performanslı FFTW'ler için        |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| ARPACK          |             | |check_|  | |check_|  | |check_| | Arnoldi algoritmaları için               |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| MPI             |             | |check_|  | |check_|  |          | Paralel hesaplar için (OpenMPI vs.)      |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| GSMPI           |             |           |           | |check_| | Paralel çalıştırmalar için               |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| HDF5            |             | |check_|  | |check_|  | |check_| | Büyük ölçekli paralel hesaplar için      |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| OpenCascade CE  |             | |check_|  | |check_|  | |check_| | Çözüm ağı optimizasyonu                  |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| PETSc           |             | |check_|  | |check_|  | |check_| | Alternatif doğrusal çözücüler için       |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| PT-Scotch       |             | |check_|  | |check_|  | |check_| | MPI durumlarında gerekli                 |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| Tetgen          |             | |check_|  | |check_|  | |check_| | 3D çözüm ağları için gerekli             |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| Triangle        |             | |check_|  | |check_|  | |check_| | 2D çözüm ağları için gerekli             |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+
| VTK             |             | |check_|  | |check_|  |          | VTK formatında çözüm ağları için         |
+-----------------+-------------+-----------+-----------+----------+------------------------------------------+


Veri Kapsamları
===============

OpenMP paylaşımlı hafıza üzerine tasarlanmış bir sistemdir.
Dolayısıyla veriler genelde iş parçacıkları arasında paylaşılır. Fakat
yazdığımız programa bağlı olarak bu her zaman istenilen davranış
olmayabilir.

OpenMP bu duruma çare olarak aşağıda listelenen yapıları sunmaktadır.

-  private
-  firstprivate
-  lastprivate
-  shared
-  threadprivate
-  copyin
-  default
-  reduction

Aşağıda bu yapıların anlamları ve kullanım örnekleri yer almaktadır.

private
-------

Örnek:

.. code:: cpp

   int x,y;
   #pragma omp parallel private(x,y) // Bu şekilde bir ya da daha fazla değişken belirtilebilir
   {
     //...
   }

Yukarıdaki örnekte gösterildiği gibi, her iş parçacığı belirtilen değişkenin tipinde yeni yaratılmış bir
değişkene sahip olur. Bu durumda iş parçacıkları arasında bu değişken
yönünden herhangi bir bağlantı yoktur ve birbirinden bağımsızdır.

Private olarak tanımlanmış değişkenlerin ilk değerleri ile ilgili bir
varsayım yapmak doğru olmaz çünkü derleyiciler arasında bu açıdan
farklılıklar olması doğaldır. Dolayısıyla bu tarz değişkenlerle işlem
yapmadan önce değer verildiğinden emin olmak gereklidir. Eğer değişkenin
ilk değeri önem arzediyorsa ``firstprivate`` kullanmak daha doğru
olabilir. Aşağıda da anlatılacağı gibi bu durumda parçacıkların değişkenlerinin ilk değeri orjinal 
değişkenin değerinden alınır. Nesne tabanlı programlama'da bu yeni nesnelerin
orjinal nesneden kopyalanarak yaratılacağı anlamına gelir. 

Benzer şekilde paralel blok sonlandıktan sonra private değişkenlerin son
değerleri blok dışındaki kodda kullanılamaz. Bunun için ``lastprivate``
veya ``reduction`` kullanılabilir.

firstprivate
------------

Private ile benzerdir. Tek farkı değişkenlerin ilk değerlerini önceki
değerden alınmasıdır.

Örnek:

.. code:: cpp

   int x = 5;
   #pragma omp parallel firstprivate(x)
   {
       // x bu alandaki her iş parçacığı için 5 değerine sahiptir.
   }
   // x hala private olduğu için üstteki blok içerisindeki hiçbir değişiklik buraya yansımaz.

lastprivate
-----------

Private ile benzerdir. Tek fark, değişkenin son yenilemedeki değeri
kodun kalanına yansıtılır. ``firstprivate`` ile aynı anda
kullanılabilir.

Örnek:

.. code:: cpp

   int x=5;
   #pragma omp parallel for firstprivate(x) lastprivate(x)
   for(int i = 0; i < 5; i++){
       x += i; 
   }
   // Parallel kısım sonlandığında x = 9 olacaktır.
   // Çünkü en son yinelemede i = 4 olacaktır, firstprivate nedeniyle x = 5 ve lastprivate nedeniyle iki değerin toplamı kodun kalanına yansayacaktır.

shared
------

Aksi belirtilmedikçe OpenMP’deki çoğu direktif ``shared`` yani verilerin
paylaşılmasını kullanmaktadır. Fakat programcının bu varsayımı
değiştirmesi durumunda ``shared`` direktifi kullanılarak belirli
değişkenler paylaşımlı hale getirilebilir.

threadprivate
-------------

Private direktifine benzemekle beraber, aşağıda listelenen farklara
sahiptir.

-  Ana iş parçacığı yeni bir değişken ya da bir kopyaya değil değişkenin
   kendisine sahip olur.
-  Birden fazla paralel alanda kullanılması durumunda her thread için
   önceki değerini korur. Aşağıdaki durumlar haricinde:

   -  OpenMP’nin “dynamic thread adjustment” sisteminin açık olması.

      -  ``omp_set_dynamic(0);`` şeklinde kodun içinde kapatılabilir.
      -  ``OMP_DYNAMIC = FALSE <program>`` şeklinde kodun çalıştırılması sırasında kapatılabilir..

   -  İş parçacığı sayısının alanlar arasında farklılık göstermesi.

copyin
------

Firstprivate’da olduğu gibi değişkenin ilk değeri tüm iş parçacıkları
için kopyalanır. Daha sonra ``threadprivate`` gibi davranış gösterir.
Bu da doğru şartlar altında paralel alanlar arasında değerlerin korunmasını sağlar.

default
-------

Blok içinde varsayılan veri kapsamını ayarlar. Üstte verilen
kapsamlarda belirtilmemiş tüm değişkenler bu kapsama uyarlar.

C/C++ için iki seçenekten biri kullanılabilir: ``shared`` veya ``none``.
- ``shared`` olması durumunda ayrıca belirtilmemiş tüm değişkenler
paylaşılır. - ``none`` olması durumunda sadece üstteki kapsamlarda
belirtilmiş değişkenler blok içerisinde kullanılabilir. - Task bölümünde
göreceğimiz gibi, ``task`` direktifi kullanıldığında ``firstprivate``
kapsamı da kullanılabilir.

Bazı derleyiciler bunların dışında seçenekler de sunabilir fakat OpenMP
standartında belirtilmediği için kullanmak kodun başka platformlarda
kullanılabilirliğini düşürebilir.

reduction
---------

``reduction(işlem:değişken)`` şeklinde kullanılır.

Değişken tüm iş parçacıkları için ``private`` gibi çalışır. Alanın
sonunda tüm değerler belirtilen işlem kullanılarak tek bir değere
indirgenir.

İşlem: - standart aritmetik operasyonlar ``(+, *, -, /)`` - binary
operasyonlar (``<<, >>`` hariç) ``(&, |, ^)`` - boolean
operasyonlar ``(&&, ||)`` olabilir.

Örnek:

.. code:: cpp

   // a dizisindeki sayıların toplamını hesaplar
   // Her iş parçacığı lokal olarak dizinin bir kısmını topladıktan sonra
   // bu lokal sonuçlar toplama işlemi ile tek bir sonuca indigenir
   // N = |a| 
   int toplam = 0;
   #pragma omp parallel for shared(sum, a) reduction(+: sum)
   for (int i = 0; i < N; i++)
   {
       toplam += a[i]
   }

İş Paylaşımı
============

Giriş
-----

C++ ile OpenMP kullanımı aşağıdaki örnekte basit bir şekilde
gösterilmiştir.

.. code:: cpp

   int main(){

       // Tek iş parçacığı

   #pragma omp parallel 
   {
       // Birden fazla iş parçacığı
   }

       // Tek iş parçacığı
   }

Burada ``#pragma omp parallel`` bloğu dışındaki kısımlar tamamıyla
standard C++ kodundan ibarettir. Bu bloğun içinde ise OpenMP ile paralel
programlama gerçekleştirilebilir.

OMP For
-------

``#pragma omp for`` direktifi kullanılarak standard C/C++ for döngüleri
paralel hale getirilebilir. Bu durumda döngünün içindeki kod birden
fazla iş parçacığı tarafından bazıları paralel olacak şekilde
çalıştırılacaktır.

Aşağıdaki örnekte bu direktif kullanılarak iki rastgele sayılardan
oluşan dizi (İngilizce: array) paralel olarak çarpılmıştır.

.. code:: cpp

   #include <stdlib.h> // srand ve rand fonksiyonları
   #include <time.h> // time fonksiyonu

   #define N 1000


   int main(){

       // Diziler 
       int a[N],b[N],c[N];

       // Rastgele sayıların dizilere konması
       srand(time(NULL));
       for(int i=0; i<N; i++){
           a[i] = rand();
           b[i] = rand();
       }

   // Paralel blok
   #pragma omp parallel 
   {

   // Dizilerin paralel olarak çarpımı
   #pragma omp for
       for(int i=0; i<N; i++){
           c[i] = a[i]*b[i];
       }
   }
   }

Eğer parallel blok içerisinde başka bir işlem yapılmayacaksa (üstteki
örnekte olduğu gibi), iki direktif ``#pragma omp parallel for`` şeklinde
birliştirilebilir

Aşağıda aynı örnek bu kısayol kullanılarak verilmiştir.

.. code:: cpp

   #include <stdlib.h> // srand ve rand fonksiyonları
   #include <time.h> // time fonksiyonu

   #define N 500000

   int main(){

       // Diziler 
       int a[N],b[N],c[N];

       // Rastgele sayıların dizilere konması
       srand(time(NULL));
       for(int i=0; i<N; i++){
           a[i] = rand();
           b[i] = rand();
       }

   // Paralel blok
   #pragma omp parallel for
       for(int i=0; i<N; i++){
           c[i] = a[i]*b[i];
       }
   }

Matris çarpımı sıklıkla kullanılan ve çoğu zaman paralel programlama
kullanılmadan istenilen hıza erişemeyen bir işlemdir. Aşağıda bu işlemi
gösteren bir örnek verilmiştir. Matrisler C++ standard kütüphanesinin
parçası olan ``vector`` veri yapısı kullanılarak temsil edilmişlerdir.

.. code:: cpp


   #include <vector>
   #include <stdlib.h> // srand ve rand fonksiyonları
   #include <time.h> // time fonksiyonu

   // 2 boyutlu tam sayı tutan vector yapısını Matris adıyla kullanabilmek için
   #define Matris std::vector<std::vector<int>>

   #define N 500000

   int main(){

   Matris a(N);
   Matris b(N);
   Matris c(N);

   // Matrislerin boyutlarının NxN olarak ayarlanması ve a,b matrislerinin rastgele sayılar ile doldurulması
   srand(time(NULL));
   for(int i=0; i<N; i++){
       vector<int> temp(N);
       a[i] = temp;
       b[i] = temp;
       c[i] = temp;
       
       for(int j=0; j<N; j++){
           a[i][j] = rand();
           b[i][j] = rand();
       }
       
   }

   // Matrislerin parallel olarak çarpımı
   #pragma omp parallel for
       for (int i=0; i<m; i++){
           for (int j=0; j<n; j++){
                c[i][j]=0;
                for (int k=0; k<p; k++){
                       c[i][j] += b[i][k] * a[k][j];
                }
           }
       }
   }

Bazı önemli detaylar: - Yinelemeler (İngilizce: iteration) arasında
herhangi bir sıralama olması beklenemez. Bir diğer değişle döngü
beklenenden farklı bir sırada çalıştırılabilir. - An itibariyle OpenMP
şartnamesine göre sadece “canonical loop form” yani ``for(...;...;...)``
şeklindeki looplar desteklenmekte. Yani C++11 ile birlikle gelen
``for(... : ...)`` şeklindeki looplar bu direktif ile kullanılamaz. -
OpenMP 5 ile birlikte ``loop`` adında benzer bir direktif eklenmiştir.
An itibariyle Truba’da yüklü olan derleyeciler OpenMP 5’i desteklemediği
için bu direktif dökümantasyona dahil edilmemiştir. - Yukarıda verilen
örneklerde iş parçacıkları veriyi (bu durumda a,b,c dizilerini)
paylaşmaktadır. Yani bütün threadler aynı dizilere erişmekte ve
değiştirmektedir. Bu veri kapsamları bölümünde daha detaylı
açıklanacaktır. - Genelde döngünün yenileme sayısı iş parçacığı
sayısından fazla olacağından dolayı bir iş dağıtımı gerekli olacaktır.
Bu durumda varsayılan davranış derleyiciler arasında değişiklik
göstermektedir ve iş dağıtımı bölümünde daha detaylı açıklanacaktır.

OMP Sections
------------

``omp for`` direktifinde tüm iş parçacıkları ``for`` döngüsünün içinde
yer alan aynı kodu çalıştırmaktadır. Eğer bu iş parçacıklarının farklı
görevleri yerine getirmelerini istersek ``sections`` direktifini
kullanabiliriz.

Genel kullanım aşğıdaki örnekte gösterilmiştir.

.. code:: cpp

   int main()
   {
   #pragma omp parallel
   {    

   #pragma omp sections
   {
   #pragma omp section
   fonksiyon_1();
               
   #pragma omp section
   fonksiyon_2();
   }

   }
   return 0;
   }

``for`` direktifinde olduğu gibi ``parallel`` ve ``sections`` beraber
kullanılabilir (``#pragma omp parallel sections``).

Aşağıdaki örnek ``for`` örneklerinde olduğu gibi iki dizinin çarpımını
hesaplar. Fakat ek olarak bir iş parçacığı çarpımı hesaplarken bir
diğeri aynı dizelerin toplamını hesaplamaktadır.

.. code:: cpp

   #include <iostream>
   #include <stdlib.h>
   #include <time.h>

   #define N 500000

   int main(){

       // Diziler 
       int a[N],b[N],c[N],d[N];

       // Rastgele sayıların dizilere konması
       srand(time(NULL));
       for(int i=0; i<N; i++){
           a[i] = rand();
           b[i] = rand();
       }

   #pragma omp parallel sections
       {
           #pragma omp section 
           {
               std::cout << "Çarpma işlemi başlangıç" << std::endl;
               for(int i=0; i<N; i++){
                   c[i] = a[i]*b[i];
               }
               std::cout << "Çarpma işlemi son" << std::endl;
           }

           #pragma omp section 
           {
               std::cout << "Toplama işlemi başlangıç" << std::endl;
               for(int i=0; i<N; i++){
                   d[i] = a[i]+b[i];
               }
               std::cout << "Toplama işlemi son" << std::endl;
           }
       }

   }

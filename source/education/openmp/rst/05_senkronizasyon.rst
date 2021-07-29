Senkronizasyon
==============

Master
------

``#pragma omp master`` şeklinde belirtilen bloklar sadece master (ana)
iş parçacığı tarafından çalıştırılır. Diğer tüm iş parçacıkları bu alanı
atlar.

Single
------

``#pragma omp master`` şeklinde belirtilen bloklar sadece tek bir iş
parçacığı tarafından çalıştırılır. ``Master``\ ’ın aksine bu ana iş
parçacığı olmak zorunda değildir.

Critical
--------

``#pragma omp critical`` şeklinde belirtilen bloklar aynı anda sadece
bir iş parçacığı tarafından çalıştırılır.

Opsiyonel olarak bu alanlara ``#pragma omp critical <isim>`` şeklinde
isim verilebilir. Bu durumda bu iki alan tek bir alanmış gibi korunur.
Yani eğer iki alan aynı isme sahipse bir iş parçacığı alanlardan birinde
ise diğer alana giriş mümkün olmaz.

Barrier
-------

``#pragma omp barrier`` şeklinde kullanılır. Kodun bu noktasın gelen bir
iş parçacığı diğer tüm iş parçacıkları buraya ulaşmadan devam edemez.

Atomic
------

``#pragma omp atomic <işlem-tipi>`` şeklinde kullanılır. ``Critical``
ile benzer olmakla beraber, bir blok değil sadece tek bir satırdan önce
olacak şekilde kullanılabilir. Bu satır da aşağıda belirtilen işlem
formlarından birine uymalıdır.

İşlem Tipi:

-  read

.. code:: cpp

   v = x;

-  write

.. code:: cpp

   x = expr;

-  update (işlem tipi belirtilmediği halde varsayılan)

.. code:: cpp

   x++; 
   x--; 
   ++x; 
   --x; 
   x binop= expr; 
   x = x binop expr; 
   x = expr binop x;

binop şu işlemlerden biri olabilir: ``+, *, -, /, &, ^, |, <<, or >>``

Örnek (1’den N’e kadar sayıların ortalamasını alan bir fonksiyon) :

.. code:: cpp

   void ortalama(int N) {
       double toplam = 0;

       double start = omp_get_wtime();
       omp_set_num_threads(16);
       #pragma omp parallel
       {
           double avg;
           int id = omp_get_thread_num();
           int nthreads = omp_get_num_threads();
        
           // Her thre
           for (int i = id; i < N; i+=nthreads) {
               lokal_toplam += i;
           }
           #pragma omp atomic
           toplam += lokal_toplam;
       }
       double time = omp_get_wtime() - start;
       double avg = toplam / N;

       std::cout << "Zaman: " << time  << std::endl;
       std::cout << "Sonuç: " << avg  << std::endl;
   }

Ordered
-------

``#pragma omp for ordered`` şeklinde belirtilen döngülerde
``#pragma omp ordered`` şeklinde kullanılabilir. Belirtilen blok
döngünün paralel olmayan haliyle aynı sırada çalıştırılır.

Kullanım Şekli:

.. code:: cpp

   #pragma omp for ordered
   for(int i=0; i<10;i++){
       // Sırası önemli olmayan kod

       #pragma omp ordered
       {
           // Doğru sırada çalışması gereken kod
       }
       
       // Sırası önemli olmayan kod

   }

Örnek:

.. code:: cpp

   #include <iostream>

   #define NUM_THREADS 4

   int main(){

       // Ordered kullanılmayan bir döngü
       // Çıktının sıralaması ön görülemez
       #pragma omp parallel for num_threads(NUM_THREADS)
       for(int i=0; i<10; i++){
           std::cout << "Döngü: " << i << std::endl;    
       }

       // Ordered kullanulan bir döngü
       // Çıktı 0,1,...9 sırasında olması beklenilir
       #pragma omp parallel for ordered num_threads(NUM_THREADS)
       for(int i=0; i<10; i++){
           #pragma omp ordered
           std::cout << "Döngü: " << i << std::endl;    
       }

   }

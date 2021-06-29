OpenMP Senkronizasyon
=====================

Master
------

``#pragma omp master`` şeklinde belirtilen bloklar sadece master (ana)
iş parçacığı tarafından çalıştırılır. Diğer tüm iş parçacıkları bu alanı
atlar.

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

TODO: CAPTURE

binop şu işlemlerden biri olabilir: ``+, *, -, /, &, ^, |, <<, or >>``

Ordered
-------

``#pragma omp for ordered`` şeklinde belirtilen döngülerde
``#pragma omp ordered`` şeklinde kullanılabilir. Belirtilen blok
döngünün paralel olmayan haliyle aynı sırada çalıştırılır.

Örnek:

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

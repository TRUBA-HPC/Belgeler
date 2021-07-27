OpenMP İş Dağıtımı
==================

Programcı tarafından tanımlanmış işlerin iş parçacıkları arasında
dağıtılması için OpenMP çeşitli değişik stratejiler kullanabilir.

Bu strateji programcı tarafından belirtilmezse, kullanılan strateji
makineden makineye değişiklik gösterebilir. Bu sebeple eğer programın
doğruluğu ya da performansı açısından önemliyse belirtilmesi önerilir.

Çoğu stratejide bir parça boyutu belirtilebilir. Bu opsiyonel olup,
belirtilmediği takdirde OpenMP tarafından otomatik olarak seçilir.

Static
------

``schedule (static,<parça boyutu>)`` şeklinde kullanılabilir. İş
verildiği sıraya göre parça boyutunda parçalara bölünür.

Örnek:

.. code:: cpp

   // Bu durumda ilk iş parçacığı i=0,1,2,3,4
   // ikinci iş parçacığı i=5,6,7,8,9
   // üçüncü iş parçacığı i=10,11,12,13,14
   // dördüncü iş parçacığı i=15,16,17,18,19
   // yinelemelerini çalıştıracaktır.
   #pragma omp parallel for schedule(static,5) num_threads(4)
   for(int i=0; i<20; i++){
       // kod
   }

::

   schedule(static):
   ****************
                   ****************
                                   ****************
                                                   ****************

   schedule(static, 4):   
   ****            ****            ****            ****            
       ****            ****            ****            ****        
           ****            ****            ****            ****    
               ****            ****            ****            ****


   schedule(static, 8):
   ********                        ********
           ********                        ********
                   ********                        ********
                           ********                        ********

Dynamic
-------

``schedule (dynamic,<parça boyutu>)`` şeklinde kullanılabilir. Görevler
yine parça boyutuna göre bölünecektir. Fakat ``static`` stratejinin
aksine bu parçalar boşta olan iş parçacıklarından birine verilecektir.
Yani görevlerini hızlı bitiren iş parçacıklarına, daha fazla görev
verilebilir. Dolayısıyla görevlerin iş yükü arasında ciddi farklar
olduğu durumlarda bu strateji daha etkili olacaktır.

::

   schedule(dynamic):     
   *   ** **  * * *  *      *  *    **   *  *  * *       *  *   *  
     *       *     *    * *     * *   *    *        * *   *    *   
    *       *    *     * *   *   *     *  *       *  *  *  *  *   *
      *  *     *    * *    *  *    *    *    ** *  *   *     *   * 

   schedule(dynamic, 8):  
                   ********                                ********
                           ********        ********                
   ********                        ********        ********        
           ********  

Guided
------

``schedule (guided,<parça boyutu>)`` şeklinde kullanılabilir. Çalışma
şekli ``dynamic`` ile benzerlik gösterir. Fakat parça boyutu sabit
değildir. Programcı tarafından belirtilen parça boyutu, minimum parça
boyutu olarak kullanılır (son parça daha küçük olabilir). Parça boyutu
``kalan görev sayısı / iş parçacığı sayısı`` olarak hesaplanır. Yani
başta büyük parça boyutu ile başlar ve zamanla düşer.

::

   schedule(guided):      
                               *********                        *  
                   ************                     *******  ***   
                                        *******                   *
   ****************                            *****       **    * 

   schedule(guided, 4):
                                        *******
                   ************                     ****    ****
                               *********
   ****************                            *****    ****    ***

Auto
----

``schedule (auto)`` şeklinde kullanılabilir. Üstteki stratejilerden
birininin derleyici ya da program tarafından seçilip kullanılmasına
sebep olur.

Runtime
-------

``schedule (runtime)`` şeklinde kullanılabilir. Kodun içinde
``omp_set_schedule(<strateji>);`` şeklinde ya da kodun dışında
``export OMP_SCHEDULE=<strateji>`` şeklinde tanımlanan stratejiyi
kullanır.

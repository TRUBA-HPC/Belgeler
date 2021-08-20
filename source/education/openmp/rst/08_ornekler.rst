Örnekler
========

Bu bölüm değişik kullanım alanlarını gösteren kısa örnekler
içermektedir.

Ortalama
--------

``atomic`` kullanarak 1’den N’e kadar olan tam sayıların ortalamasını
alan bir fonksiyonu senkronizasyon bölümünde görmüştük.

.. code:: cpp

   void ortalama(int N) {
       double toplam = 0;

       double start = omp_get_wtime();
   ;
       #pragma omp parallel
       {
           double avg;
           int id = omp_get_thread_num();
           int nthreads = omp_get_num_threads();
        
           // N = 10 ve iş parçacığı sayısı 4 olduğunu düşünürsek
           // İş parçacağı 1: 1,5,9
           // İş parçacağı 2: 2,6
           // İş parçacağı 3: 3,7
           // İş parçacağı 4: 4,10
           // sayılarını toplayacaktır        
           for (int i = id+1; i <= N; i+=nthreads) {
               lokal_toplam += i;
           }
        
           // Her iş parçacığı işlemi tamamladıktan sonra
           // Kendi sonucunu atomic olarak global sonuca ekler
           #pragma omp atomic
           toplam += lokal_toplam;
       }
       double time = omp_get_wtime() - start;
       double avg = toplam / N;

       std::cout << "Zaman: " << time  << std::endl;
       std::cout << "Sonuç: " << avg  << std::endl;
   }

Aynı işlem ``reduction`` kullanılarak da gerçekleştirilebilir.

.. code:: cpp

   void  ortalama_reduction(int N) {

       double toplam = 0;

       double start = omp_get_wtime();

       #pragma omp parallel for reduction(+:toplam)
       for (int i = 0; i < N; i++) {
           toplam += i;
       }

       double time = omp_get_wtime() - start;
       double avg = toplam / N;

       std::cout << "Zaman: " << time  << std::endl;
       std::cout << "Sonuç: " << avg  << std::endl;

Bu kod üzerinde farklı iş dağıtımı modelleri denenebilir.

.. code:: cpp

   void  ortalama_reduction(int N, std::string method) {

       double toplam = 0;

       double start = omp_get_wtime();
                                                        
       if(method == "static"){
           #pragma omp parallel for reduction(+:toplam) schedule(static)
           for (int i = 0; i < N; i++) {
               toplam += i;
           }    
       }
                                                        
       if(method == "dynamic"){
           #pragma omp parallel for reduction(+:toplam) schedule(dynamic)
           for (int i = 0; i < N; i++) {
               toplam += i;
           }    
       }
                                                        
       if(method == "dynamic 1000"){
           #pragma omp parallel for reduction(+:toplam) schedule(dynamic, 1000)
           for (int i = 0; i < N; i++) {
               toplam += i;
           }    
       }
                                                        
       if(method == "auto"){
           #pragma omp parallel for reduction(+:toplam) schedule(auto)
           for (int i = 0; i < N; i++) {
               toplam += i;
           }    
       }

       double time = omp_get_wtime() - start;
       double avg = toplam / N;

       std::cout << "Zaman: " << time  << std::endl;
       std::cout << "Sonuç: " << avg  << std::endl;

İş dağıtımı ayrıca ``runtime`` seçeneği kullanılarak komutlar aracılığı
ile de (çok daha kolay bir şekilde) değiştirilebilir. Ayrıca kodun
içinden ``omp_set_schedule(dynamic,1000)`` şeklinde değiştirilebilir.

.. code:: cpp

   #include <iostream>
   #include <omp.h>

   void  ortalama_reduction(int N) {

       double toplam = 0;

       double start = omp_get_wtime();

       #pragma omp parallel for reduction(+:toplam) schedule(runtime)
       for (int i = 0; i < N; i++) {
           toplam += i;
       }

       double time = omp_get_wtime() - start;
       double avg = toplam / N;

       std::cout << "Zaman: " << time  << std::endl;
       std::cout << "Sonuç: " << avg  << std::endl;
   }

   int main(){
       ortalama_reduction(1000000);    
   }

.. code:: bash

   g++ main.cpp -fopenmp -o test
   OMP_SCHEDULE="DYNAMIC,1000" ./test

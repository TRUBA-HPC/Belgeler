Temel Kullanım
==============

-  OpenMP hem C/C++ hem Fortran derleyicileri ile kullanılabilir. Bu
   dokümenda C++ ile kullanımını gözden geçireceğiz.
-  Bu bölümün amacı halihazırda var olan kodumuzu OMP direktifleri
   aracılığı ile en az eforu göstererek hızlandırmaktır.

C++ “pragma”
------------

-  C++’da ``pragma`` direktifi derleyiciye kodun kendisinin dışında
   ekstra bilgi vermek için kullanılan bir standarttır.
-  ``#pragma ...`` şeklinde kullanılır.
-  Biz bu direktifi derleyiciye OpenMP özelliklerini kullanmasını
   belirtmek için ``#pragma omp ...`` şeklinde kullanacağız.

C++ OpenMP Kodu Derlemek
------------------------

-  OpenMP standartı ``gcc``, ``clang``, ``msvc`` gibi popüler bir çok C/C++
   derleyicisi tarafından desteklenir.

   -  Derleyiceler arasında OpenMP açısından bazı farklar olması
      doğaldır.

-  Bu doküman TRUBA’da yüklü olan ``gcc`` (C++ için ``g++`` olarak
   çağırılır.) derleyecisini kullanmaktadır.

-  TRUBA'ya giriş yaptığımızda yüklü ``gcc`` versiyonunun 4.8 olduğunu
   görüyoruz. (Haziran,2021 itibariyle)
-  Bu bazı örnekler için yeterli olmakla birlikte yeni C++ ve OpenMP
   özelliklerini desteklememekte. Dolayısıyla yeni bir versiyonun modül
   sistemiyle yüklenmesi önerilir.
-  ``module avail`` komutu kullanılarak çevre modülü (ing.,
   environment module) sistemi kullanılarak yüklenebilecek ``gcc``
   versiyonları görüntülenebilir.
-  Daha sonra ``module load <seçilen modül>`` şekline bu modüller
   yüklenebilir.
-  Örneğin: ``module load centos7.3/comp/gcc/9.2`` kullanılarak
   ``gcc 9.2`` yüklenebilir.

-  C++ kodunu OpenMP özellikleri ile birlikte derlemek için derleme komutuna
   ``-fopenmp`` eklemek yeterlidir.

   -  Farklı derleyecilerde bu terim değişiklik gösterebilir. Örneğin
      Intel’in ``icc`` derleyicisinde ``-openmp`` şeklindedir.

-  Örnek (C++14, OpenMP ve 3.seviye optimizasyon):

.. code:: bash

   g++ main.cpp -o main -fopenmp -O3 -std=c++14

TRUBA üzerinde Slurm ile OpenMP kodu çalıştırmak
------------------------------------------------

Aşağıda örnek bir slurm dosyası verilmiştir.

.. code:: bash

   #!/bin/bash

   # TRUBA hesap adı
   #SBATCH --account=<hesap adı>

   # Programın adı
   #SBATCH --job-name=openmp_test

   # Kullanılacak iş kuyruğu
   # https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/hesaplamakumeleri.html
   #SBATCH --partition=short

   # Programın süreceği maximum süre (Gün-Saat:Dakika:Saniye formatında)
   # Bu örnekte 1 dakika olarak ayarlanmış
   # Eğer program bu süreyi aşarsa, sistem tarafından durdurulur
   #SBATCH --time=0-00:01:00

   # Çıktı ve hataların yazılacağı dosyaların belirlenmesi
   #SBATCH --output=output.txt
   #SBATCH --error=error.txt

   #Daha önceden yüklenmiş olabilecek modüllerin çıkarılması
   module purge

   #Kullandığımız gcc versiyonunun yüklenmesi
   module load centos7.3/comp/gcc/9.2

   #Kodun derlenmesi
   g++ test.cpp -O3 -fopenmp -o openmp_test

   # Thread sayısını belirleyen bir kod
   # Bu dosyayı sbatch ile çalıştırırken -c <iş parçacığı sayısı> belirtilerek
   # iş parçacağı sayısı değiştirilebilir
   if [-n "$SLURM_CPUS_PER_TASK"];
   then
           omp_threads=$SLURM_CPUS_PER_TASK
   else
           omp_threads=1
   fi

   # Kodun belirlenen sayıda iş parçacığı ile çalıştırılması
   OMP_NUM_THREADS=$omp_threads ./openmp_test

Bu dosya ``openmp_example.slurm`` adıyla kaydedildikten sonra
``sbatch -c <iş parçacağı sayısı> openmp_example.slurm`` şeklinde
çalıştırılabilir. Programın çıktıları ``output.txt`` adlı bir dosyaya
yazılacaktır.

OpenMP CUDA ve MPI gibi başka sistemlerle birlikte kullanılabilir. Bu
durumlarda bu diğer sistemlerin dokümanlarındaki slurm örneklerine
de bakılması önerilir.

OpenMP ile kodun süresini ölçmek
--------------------------------

OpenMP kodun çalışmasının ne kadar zaman sürdüğünü ölçmek için
kullanılabilecek bazı fonksiyonlar sunar. Bunların kullanımı aşağıdaki
örnekte göstererilmiştir. 

.. code:: cpp

   #include <iostream>
   #include <omp.h>

   int main(){

       double start,end,time;
       
       start = omp_get_wtime();
       // Ölçmek istenilen kod
       end = omp_get_wtime();
       time = end - start;

       std::cout << "Süre: " << time << " saniye" << std::endl;
   }

Alternatif olarak ``chrono`` adlı C++ standart kütüphanesi de zamanlama için kullanılabilir.

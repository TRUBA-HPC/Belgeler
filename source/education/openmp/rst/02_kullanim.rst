OpenMP Kullanımı
================

-  OpenMP hem C/C++ hem Fortran derleyicileri ile kullanılabilir. Bu
   dökümentasyonda C++ ile kullanımını gözden geçireceğiz.
-  Bu bölümün amacı hali hazırda var olan kodumuzu OMP direktifleri
   aracılığı ile en az eforu göstererek hızlandırmak.

C++ “pragma”
------------

-  C++’da ``pragma`` direktifi derleyiciye kodun kendisinin dışında
   ekstra bilgi vermek için kullanılan bir standartdır.
-  ``#pragma ...`` şeklinde kullanılır.
-  Biz bu direktifi derleyiciye OpenMP özelliklerini kullanmasını
   belirtmek için ``#pragma omp ...`` şeklinde kullanacağız.

C++ OpenMP kodu derlemek
------------------------

-  OpenMP standartı gcc,clang,msvc gibi popüler bir çok C/C++
   derleyicisi tarafından desteklenir.

   -  Derleyiceler arasında OpenMP açısından bazı farklar olması
      doğaldır.

-  Bu dokümentasyon Truba’da yüklü olan ``gcc`` (C++ için ``g++`` olarak
   çağırılır.) derleyecisini kullanacaktır.

-  Trubaya giriş yaptığımızda yüklü ``gcc`` versiyonunun 4.8 olduğunu
   görüyoruz. (Haziran,2021 itibariyle)

-  Bu bazı örnekler için yeterli olmakla birlikte yeni C++ ve OpenMP
   özelliklerini desteklememekte. Dolayısıyla yeni bir versiyonun modül
   sistemiyle yüklenmesi önerilir.

-  ``module avail gcc`` komutu kullanılarak çevre modülü (İngilizce:
   environment module) sistemi kullanılarak yüklenebilecek ``gcc``
   versiyonları görüntülenebilir.

-  Daha sonra ``module load <gcc versiyonu>`` şekline bu modüller
   yüklenebilir.

-  Örneğin: ``module load centos7.3/comp/gcc/9.2`` kullanılarak
   ``gcc 9.2`` yüklenilebilir.

-  C++ kodunu OpenMP özellikleri ile birlikte compile etmek için komuta
   ``-fopenmp`` eklemek yeterlidir.

-  Örnek (C++14, OpenMP ve 3.seviye optimizasyon):

.. code:: bash

   g++ main.cpp -o main -fopenmp -O3 -std=c++14

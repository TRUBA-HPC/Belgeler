# Task

Task ilk olarak OpenMP 3.0'da standart hale getirilmiş bir direktiftir. Tasklar sayesinde daha önceden tanımlanan direktifler ile paralel hale getirilemeyen birçok şeyi paralel hale getirmek mümkün olmuştur.

Bir iş parçacığı task direktifiyle karşılaştığında, bu direktifin içindeki kod bloğundan bir görev oluşturulur. 

İş parçacığı bu görevi hemen yerine getirebildiği gibi daha sonra ve/veya başka bir iş parçacığı tarafından yerine getirilecek şekilde ayırması da mümkündür. Bir diğer deyişle, görevin ne zaman yerine getirileceği öngörülemez. Bu sebepten ötürü birçok durumda `taskwait` ve `barrier` senkronizasyon yapılarından birinin kullanımı gereklidir. 

Fibonacci sayılarının hesaplanmasını gösteren bir örnek:

```cpp
#include <omp.h>
#include <iostream>

int fib(int n)
{
  int i, j;

  // Fibonacci Dizisi:  0 1 1 2 3 5 8 13 21 34 ...
  // İlk 3 sayıyı özel durum olarak kabul ediyoruz yani
  // fib(1) = 0, fib(2) = fib(3) = 1 
  // Genel formül: fib(n) = fib(n-1) + fib(n-2)
  if (n==1) {  
    return 0;
  } else if (n == 2 || n == 3) {
    return 1;
  } else {
    #pragma omp task shared(i) firstprivate(n)
    i=fib(n-1);

    #pragma omp task shared(j) firstprivate(n)
    j=fib(n-2);

    #pragma omp taskwait
    return i+j;
  }
}

int main()
{

  // Kullanıcıdan girdi alınması  
  int n = 0;
  std::cout << "n = ";
  std::cin >> n;
  std::cout << std::endl;

  // Paralel blok  
  #pragma omp parallel shared(n) num_threads(4)
  {
    // fib() fonksiyonunun sadece tek bir thread tarafından çağırılması için single direktifi kullanılmış.
    // Bu sayede fonksiyon içindeki task direktifleri sadece bir defa göreve çevrilecektir.  
    #pragma omp single
    std::cout << "Sonuç: " << fib(n) << std::endl;
  }
}
```

## Taskwait ve Barrier


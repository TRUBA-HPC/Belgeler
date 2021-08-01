# Temel Kullanım

- OpenMP hem C/C++ hem Fortran derleyicileri ile kullanılabilir. Bu dökümentasyonda C++ ile kullanımını gözden geçireceğiz.
- Bu bölümün amacı hali hazırda var olan kodumuzu OMP direktifleri aracılığı ile en az eforu göstererek hızlandırmak.

## C++ "pragma"

- C++'da `pragma` direktifi derleyiciye kodun kendisinin dışında ekstra bilgi vermek için kullanılan bir standartdır.
- `#pragma ...` şeklinde kullanılır.
- Biz bu direktifi derleyiciye OpenMP özelliklerini kullanmasını belirtmek için `#pragma omp ...` şeklinde kullanacağız.

## C++ OpenMP kodu derlemek

- OpenMP standartı gcc,clang,msvc gibi popüler bir çok C/C++ derleyicisi tarafından desteklenir.
	- Derleyiceler arasında OpenMP açısından bazı farklar olması doğaldır.
- Bu dokümentasyon Truba'da yüklü olan `gcc` (C++ için `g++` olarak çağırılır.) derleyecisini kullanacaktır.


- Trubaya giriş yaptığımızda yüklü `gcc` versiyonunun 4.8 olduğunu görüyoruz. (Haziran,2021 itibariyle)
- Bu bazı örnekler için yeterli olmakla birlikte yeni C++ ve OpenMP özelliklerini desteklememekte. Dolayısıyla yeni bir versiyonun modül sistemiyle yüklenmesi önerilir.
- `module avail gcc` komutu kullanılarak çevre modülü (İngilizce: environment module) sistemi kullanılarak yüklenebilecek `gcc` versiyonları görüntülenebilir.
- Daha sonra `module load <gcc versiyonu>` şekline bu modüller yüklenebilir. 
- Örneğin: `module load centos7.3/comp/gcc/9.2` kullanılarak `gcc 9.2` yüklenilebilir. 


- C++ kodunu OpenMP özellikleri ile birlikte compile etmek için komuta `-fopenmp` eklemek yeterlidir.
	- Farklı derleyecilerde bu terim değişiklik gösterebilir. Örneğin Intel'in `icc` derleyicisinde `-openmp` şeklindedir.

- Örnek (C++14, OpenMP ve 3.seviye optimizasyon):

``` bash
g++ main.cpp -o main -fopenmp -O3 -std=c++14
```

## Truba üzerinde Slurm ile OpenMP kodu çalıştırmak

Aşağıda örnek bir slurm dosyası verilmiştir.

``` bash
#!/bin/bash

# Truba hesap adı
#SBATCH --account=<hesap adı>

# Programın adı
#SBATCH --job-name=openmp_test

# Kullanılacak bölümün adı
#SBATCH --partition=short

# Programın süreceği maximum süre (Gün-Saat:Dakika:Saniye formatında)
# Bu örnekte 1 dakika olarak ayarlanmış
#SBATCH --time=0-00:01:00

# Çıktı ve hataların yazılacağı dosyaları belirle
#SBATCH --output=output.txt
#SBATCH --error=error.txt

#Daha önceden yüklenmiş olabilecek modülleri çıkar
module purge

#Kullandığımız gcc versiyonunu yükle
module load centos7.3/comp/gcc/9.2

#Kodu derle
g++ test.cpp -O3 -fopenmp -o openmp_test

# Thread sayısını belirleyici kod
# Bu dosyayı sbatch ile çalıştırırken -c <iş parçacığı sayısı> belirtilerek
# iş parçacağı sayısı değiştirilebilir
if [-n "$SLURM_CPUS_PER_TASK"];
then
    	omp_threads=$SLURM_CPUS_PER_TASK
else
    	omp_threads=1
fi

# Kodu önceden belirlenen sayıda iş parçacığı ile çalıştır
OMP_NUM_THREADS=$omp_threads ./openmp_test
```

Bu dosya `openmp_example.slurm` adıyla kaydedildikten sonra `sbatch -c <iş parçacağı sayısı> openmp_example.slurm` şeklinde çalıştırılabilir. Programın çıktıları `output.txt` adlı bir dosyaya yazılacaktır.

OpenMP CUDA ve MPI gibi başka sistemlerle birlikte kullanılabilir. Bu durumlarda bu diğer sistemlerin dökümentasyonlarındaki slurm örneklerine de bakılması önerilir.

## OpenMP ile kodu zamanlamak

OpenMP kodun çalışmasının ne kadar zaman sürdüğünü ölçmek için kullanılabilecek bazı fonksiyonlar sunar. Bunların kullanımı aşağıdaki örnekte göstererilmiştir.

```cpp
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
```

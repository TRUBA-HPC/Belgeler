# İş Paylaşımı

## Giriş

C++ ile OpenMP kullanımı aşağıdaki örnekte basit bir şekilde gösterilmiştir.

``` cpp
int main(){

	// Tek iş parçacığı

#pragma omp parallel 
{
	// Birden fazla iş parçacığı
}

	// Tek iş parçacığı
}
```

Burada `#pragma omp parallel` bloğu dışındaki kısımlar tamamıyla standard C++ kodundan ibarettir. Bu bloğun içinde ise OpenMP ile paralel programlama gerçekleştirilebilir.

## OMP For

`#pragma omp for` direktifi kullanılarak standard C/C++ for döngüleri paralel hale getirilebilir. Bu durumda döngünün içindeki kod birden fazla iş parçacığı tarafından bazıları paralel olacak şekilde çalıştırılacaktır. 

Aşağıdaki örnekte bu direktif kullanılarak iki rastgele sayılardan oluşan dizi (İngilizce: array) paralel olarak çarpılmıştır.

```cpp
#include <stdlib.h> // srand ve rand fonksiyonları
#include <time.h> // time fonksiyonu

#define N 1000


int main(){

	// Diziler 
	int a[N],b[N],c[N];

	// Rastgele sayıların dizilere konması
	srand(time(NULL));
	for(int i=0; i<N,i++){
		a[i] = rand();
		b[i] = rand();
	}

// Paralel blok
#pragma omp parallel 
{

// Dizilerin paralel olarak çarpımı
#pragma omp for
	for(int i=0; i<N, i++){
		c[i] = a[i]*b[i];
	}
}
}
```

Eğer parallel blok içerisinde başka bir işlem yapılmayacaksa (üstteki örnekte olduğu gibi), iki direktif `#pragma omp parallel for` şeklinde birliştirilebilir

Aşağıda aynı örnek bu kısayol kullanılarak verilmiştir.

```cpp
#include <stdlib.h> // srand ve rand fonksiyonları
#include <time.h> // time fonksiyonu

#define N 1000


int main(){

	// Diziler 
	int a[N],b[N],c[N];

	// Rastgele sayıların dizilere konması
	srand(time(NULL));
	for(int i=0; i<N,i++){
		a[i] = rand();
		b[i] = rand();
	}

// Paralel blok
#pragma omp parallel for
	for(int i=0; i<N, i++){
		c[i] = a[i]*b[i];
	}
}
```

Bazı önemli detaylar:
- Yinelemeler (İngilizce: iteration) arasında herhangi bir sıralama olması beklenemez. Bir diğer değişle döngü beklenenden farklı bir sırada çalıştırılabilir.
- An itibariyle OpenMP şartnamesine göre sadece "canonical loop form" yani `for(...;...;...)` şeklindeki looplar desteklenmekte. Yani C++11 ile birlikle gelen `for(... : ...)` şeklindeki looplar bu direktif ile kullanılamaz.
- OpenMP 5 ile birlikte `loop` adında benzer bir direktif eklenmiştir. An itibariyle Truba'da yüklü olan derleyeciler OpenMP 5'i desteklemediği için bu direktif dökümantasyona dahil edilmemiştir.
- Yukarıda verilen örneklerde iş parçacıkları veriyi (bu durumda a,b,c dizilerini) paylaşmaktadır. Yani bütün threadler aynı dizilere erişmekte ve değiştirmektedir. Bu veri kapsamları bölümünde daha detaylı açıklanacaktır.
- Genelde döngünün yenileme sayısı iş parçacığı sayısından fazla olacağından dolayı bir iş dağıtımı gerekli olacaktır. Bu durumda varsayılan davranış derleyiciler arasında değişiklik göstermektedir ve iş dağıtımı bölümünde daha detaylı açıklanacaktır.

## OMP Sections

`omp for` direktifinde tüm iş parçacıkları `for` döngüsünün içinde yer alan aynı kodu çalıştırmaktadır. Eğer bu iş parçacıklarının farklı görevleri yerine getirmelerini istersek `sections` direktifini kullanabiliriz.

Genel kullanım aşğıdaki örnekte gösterilmiştir.

``` cpp
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
```

`for` direktifinde olduğu gibi `parallel` ve `sections` beraber kullanılabilir (`#pragma omp parallel sections`).


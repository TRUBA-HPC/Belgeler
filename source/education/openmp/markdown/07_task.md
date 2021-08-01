# Task

Task ilk olarak OpenMP 3.0'da standart hale getirilmiş bir direktiftir. Tasklar sayesinde daha önceden tanımlanan direktifler ile paralel hale getirilemeyen birçok şeyi paralel hale getirmek mümkün olmuştur.

Bir iş parçacığı task direktifiyle karşılaştığında, bu direktifin içindeki kod bloğundan bir görev oluşturulur. 

İş parçacığı bu görevi hemen yerine getirebildiği gibi daha sonra ve/veya başka bir iş parçacığı tarafından yerine getirilecek şekilde ayırması da mümkündür. Bir diğer deyişle, görevin ne zaman yerine getirileceği öngörülemez. Bu sebepten ötürü birçok durumda `taskwait` ve `barrier` senkronizasyon yapılarından birinin kullanımı gereklidir. 

Ağaç veri yapısı üzerinde gezen bir örnek:

```cpp
struct Node {
	Node *right;
	Node *left;
};

void islem_yap(Node * node){
	// Her düğüm'de (node) yapılacak bir işlem
	// ...
}

void gez(Node * root){
	if (p->left){
#pragma omp task
		gez(p->left);
	}

	if (p->right){
#pragma omp task
		gez(p->right);
	}

	islem_yap(p);
}

```

`taskwait` direktifine ulaşan bir görev kendisinin tüm kardeş görevleri (bir diğer deyişle, kendisiyle birlikte yaratılmış tüm görevler) bitmeden ilerlemez. 
Bu direktifi kullanarak ağacı gezme eyleminin "postorder" yani önce yapraklardan başlayıp köke doğru ilerleyecek şekilde olması sağlanabilir.


```cpp
struct Node {
	Node *right;
	Node *left;
};

void islem_yap(Node * node){
	// Her düğüm'de (node) yapılacak bir işlem
	// ...
}

void gez(Node * root){
	if (p->left){
#pragma omp task
		gez(p->left);
	}

	if (p->right){
#pragma omp task
		gez(p->right);
	}

#pragma omp taskwait

	islem_yap(p);
}

```

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
    #pragma omp task shared(i) 
    i=fib(n-1);

    #pragma omp task shared(j) 
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

`sections` ve `for` direktiflerinin aksine varsayılan veri kapsamı `firstprivate`'dır. Dolaysıyla üstteki kodda `n` değişkeni firstprivate olarak kullanılmıştır.

`taskwait` direktifi sayesinde `return i+j;` satırı çalışmadan önce i ve j değerlerinin hesaplanmış olduğundan emin oluyoruz.


## Untied

Normal şartlar altında oluşturulan her görev tek bir iş parçacığına atanır ve o görev tamamlanana kadar iş parçacığı sadece bu görev üzerinde çalışır. 
Bu her zaman istediğimiz davranış olmayabilir. `untied` terimini kullanarak bu sistemi değiştirebiliriz.

Örnek üzerinde inceleyelim. Aşağıda bir `for` döngüsü aracılığı ile çok sayıda görev yaratılması gösterilmiştir. 

``` cpp
void foo(){
	// Herhangi bir görev kodu
	// ...
}

int main(){
	int N = 100000;
#pragma omp parallel
	{
#pragma omp single
		{
			for(int i=0; i<N; i++){
				#pragma omp task
				foo();
			}
		}
	}

}
```

Bu durumda bir iş parçacığı görevleri yaratırken diğerleri onları çalıştırır. 
Fakat eğer yaratılan görev sayısı çok fazla olursa bu görev yaratan iş parçacığı, görevleri çalıştırmaya başlayabilir.
Eğer görev yaratan iş parçacığının üstlendiği bu görev çok uzun sürerse görev yaratımı durabilir ve iş parçacıkları boş kalabilir.
Eğer görev yaratımını `untied` olarak tanımlarsak, görev yaratımını boşta kalan herhangi bir iş parçacığı devralabilir.

``` cpp
void foo(){
	// Herhangi bir görev kodu
	// ...
}

int main(){
	int N = 100000;
#pragma omp parallel
	{
#pragma omp single
		{
#pragma omp task untied
			for(int i=0; i<N; i++){
				#pragma omp task
				foo();
			}
		}
	}

}
```

## Mergeable

Eğer yaratmak istediğimiz görevin veri kapsamı, görevin yaratıldığı alan ile aynı ise `mergeable` terimi kullanılabilir.
Bu durumda OpenMP "merged task" yaratmayı tercih edebilir ve bizim bakış açımızdan sanki task direktifi hiç orada değilmiş gibi olur. 

Örnek:

``` cpp
#include <iostream>

int main(){
	int x = 2;
#pragma omp task shared(x) mergeable
	x++;
#pragma omp taskwait
	std::cout << x << std::endl; // Sonuç 3 olacaktır
}
```

Eğer bu örnekde x değişkeni `shared` olarak belirtilmemiş olsaydı, görevin yaratıldığı alan ve görevin kendisinin veri kapsamları farklı olacaktı.
Dolayısıyla sonucun kaç çıkacağından tam olarak emin olamayacaktık.

``` cpp
#include <iostream>

int main(){
	int x = 2;
#pragma omp task shared(x) mergeable
	x++;
#pragma omp taskwait
	std::cout << x << std::endl; // Sonuç eğer "merged task" yaratılmışsa 3, aksi takdirde 2
}
```


## Taskyield

Senkronizasyon kısmında `critical` kod bloklarını anlatmıştık. 
Taskler için `taskyield` direktifi kullanılarak daha verimli kritik alanlar yaratılabilir.

```cpp
#include <omp.h>

// Kilidin yaratılması
omp_lock_t kilit; 
omp_init_lock(&kilit);


void kritik_islem(){
	//...
}

void normal_islem(){
	//...
}

int main(){
	for(int i=0; i<100; i++) {
		#pragma omp task
		{
			normal_islem();

			while(!omp_test_lock(&kilit)){
				#pragma omp taskyield
			}
			kritik_islem();
			omp_unset_lock(&kilit);
		}
	}
	
}
```

## Priority

`#pragma omp task priority(4)` şeklinde kullanılır. Negatif olmayan bir tam sayı değeri alabilir.
Bu şekilde yüksek sayılar verdiğimiz görevlerin daha önemli olduğunu ve daha öncelikli çalıştırılamaları gerektiğini belirtilmemiş oluyoruz.

## If

`#pragma omp task if(koşul)` şeklinde kullanılır.

Koşul doğru olduğu takdirde normal bir task direktifi şeklinde çalışır.
Koşul yanlış olduğunda görev anında sanki task direktifi yokmuş gibi çalıştırılır.

## Final

`#pragma omp task final(koşul)`

`if(!koşul)` ile benzer bir anlama gelir. (Yani `if(0)` ve `final(1)` benzer şekilde çalışır)

Asıl fark iç içe birden fazla task direktifi olunca ortaya çıkar. Aşağıdaki örneklerde bu fark gösterilmiştir.

```cpp
#pragma omp task if(0)
{
	foo(); // Anında çalıştırılır

	#pragma omp task
	bar();  // Normal task direktifi gibi çalışır
}
```

```cpp
#pragma omp task final(1)
{
	foo(); // Anında çalıştırılır

	#pragma omp task
	bar();  // Anında çalıştırılır
}
```

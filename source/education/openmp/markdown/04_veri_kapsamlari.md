# OpenMP Veri Kapsamları

OpenMP paylaşımlı hafıza üzerine dizayn edilmiş bir sistemdir. Dolayısıyla veriler genelde iş parçacıkları arasında paylaşılır. Fakat yazdığımız programa bağlı olarak bu her zaman istenilen davranış olmayabilir. 

OpenMP bu duruma çare olarak aşağıda listelenen yapıları sunmaktadır.

- private
- firstprivate
- lastprivate
- shared
- default
- reduction
- copyin

Aşağıda bu yapıların anlamları ve kullanım örnekleri yer almaktadır.


## private

Örnek:

```cpp
int x,y;
#pragma omp parallel private(x,y) // Bu şekilde bir ya da daha fazla değişken belirtilebilir
{
  //...
}
```

Her iş parçacığı belirtilen değişkenin tipinde yeni yaratılmış bir değişkene sahip olur. Bu durumda iş parçacıkları arasında bu değişken yönünden herhangi bir bağlantı yoktur ve hepsi bağımsız işlem yaparlar.

Private olarak tanımlanmış değişkenlerin ilk değerleri ile ilgili bir varsayım yapmak doğru olmaz çünkü derleyiciler arasında bu açıdan farklılıklar olması doğaldır. Dolayısıyla bu tarz değişkenlerle işlem yapmadan önce değer verildiğinden emin olmak gereklidir. Eğer değişkenin ilk değeri önem arzediyorsa `firstprivate` kullanmak daha doğru olabilir.

Benzer şekilde paralel blok sonlandıktan sonra private değişkenlerin son değerleri blok dışındaki kodda kullanılamaz. Bunun için `lastprivate` veya `reduction` kullanılabilir.


## firstprivate

Private ile benzerdir. Tek farkı değişkenlerin ilk değerlerinin önceki değerlerinden alınmasıdır.

Örnek:

```cpp
int x=5;
#pragma omp parallel firstprivate(x)
{
	// x bu alandaki her iş parçacığı için 5 değerine sahiptir.
}
```

## lastprivate

Private ile benzerdir. Tek fark, değişkenin son yenilemedeki değeri kodun kalanına yansıtılır. `firstprivate` ile aynı anda kullanılabilir.

Örnek:

```cpp
int x=5;
#pragma omp parallel for firstprivate(x) lastprivate(x)
for(int i=0; i<5; i++){
	x += i; 
}
// Parallel kısım sonlandığında x=9 olacaktır.
// Çünkü en son yinelemede i=4 olacaktır, firstprivate nedeniyle x=5 ve lastprivate nedeniyle iki değerin toplamı kodun kalanına yansayacaktır.
```


## shared

Aksi belirtilmedikçe OpenMP'deki çoğu direktif "shared" yani verilerin paylaşılmasını kullanmaktadır. Fakat programcının bu varsayımı 

# OpenMP Veri Kapsamları

OpenMP paylaşımlı hafıza üzerine dizayn edilmiş bir sistemdir. Dolayısıyla veriler genelde iş parçacıkları arasında paylaşılır. Fakat yazdığımız programa bağlı olarak bu her zaman istenilen davranış olmayabilir. 

OpenMP bu duruma çare olarak aşağıda listelenen yapıları sunmaktadır.

- private
- firstprivate
- lastprivate
- shared
- threadprivate
- copyin
- default
- reduction

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

Aksi belirtilmedikçe OpenMP'deki çoğu direktif "shared" yani verilerin paylaşılmasını kullanmaktadır. Fakat programcının bu varsayımı değiştirmesi durumunda `shared` direktifi kullanılarak belirli değişkenler paylaşımlı hale getirilebilir.

## threadprivate

Private direktifine benzer olmakla beraber, aşağıda listelenen farklara sahiptir.

- Ana iş parçacığı yeni bir değişken ya da bir kopyaya değil değişkenin kendisine sahip olur.
- Birden fazla paralel alanda kullanılması durumunda her thread için önceki değerini korur. Aşağıdaki durumlar haricinde:
	- OpenMP'nin "dynamic thread adjustment" sisteminin açık olması.
		- `omp_set_dynamic(0);` şeklinde kodun içinde kapatılabilir.
		- `export OMP_DYNAMIC=FALSE` şeklinde kodun dışından (terminalden) kapatılabilir.
	- İş parçacığı sayısının alanlar arasında farklılık göstermesi.

## copyin

Firstprivate'da olduğu gibi değişkenin ilk değeri tüm iş parçacıkları için kopyalanır. Daha sonra `threadprivate` gibi davranış gösterir. Yani doğru şartlar altında paralel alanlar arasında değerler korunur.

## default

Blok içinde varsayılan veri kapsamını ayarlar. Yani üstte verilen kapsamlarda belirtilmemiş tüm değişkenler bu kapsama uyarlar. 

C/C++ için iki seçenekten biri kullanılabilir: `shared` veya `none`.
- `shared` olması durumunda ayrıca belirtilmemiş tüm değişkenler paylaşılır.
- `none` olması durumunda sadece üstteki kapsamlarda belirtilmiş değişkenler blok içerisinde kullanılabilir.

Bazı derleyiciler bunların dışında seçenekler de sunabilir fakat OpenMP şartnamesinde belirtilmediği için kullanmak kodun başka platformlarda kullanılabilirliğini düşürebilir.

## reduction

`reduction(işlem:değişken)` şeklinde kullanılır.

Değişken tüm iş parçacıkları için `private` gibi çalışır. Alanın sonunda tüm değerler belirtilen işlem kullanılarak tek bir değere indirgenir.

İşlem:
- standart aritmetik operasyonlar olabilir `(+,*,-,/)`
- binary operasyonlar olabilir (`<<,>>` hariç) `(&,|,^)`
- boolean operasyonlar olabilir `(&&,||)`


================
Hadoop MapReduce
================
Büyük veri yazılımları içeren `Apache Hadoop`_ açık kaynak yazılım
projesinin en önemli bileşenlerinden ilki *MapReduce*, diğeri ise
*HDFS* (Hadoop Distributed File System) dağıtık dosya sistemi
modülüdür. MapReduce, büyük boyutlu veriyi bilgisayar kümeleri
üzerinde paralel olarak işlemek üzere uygulama yazabileceğimiz bir
programlama modeli ve bu uygulamayı çalıştırabileceğimiz bir ortam
sunar. MapReduce denildiğinde ilk olarak Hadoop akla gelse de,
büyük veri işleme ve analiz araçlarının birçoğu MapReduce 
yaklaşımını izlemektedirler. 

MapReduce modeli, fonksiyonel programlama dünyasından gelen *Map*
(eşle) ve *Reduce* (indirge) isminde iki görev içerir. Map, bir
veri kümesini alıp başka bir veri kümesine dönüştürür. Reduce ise,
Map görevinin çıktısını alıp işleyerek, daha küçük bir sonuca
indirger. MapReduce adının sıralamasından da anlaşılacağı üzere,
Map görevi her zaman Reduce işleminden önce gerçekleştirilir.
MapReduce modelinin en büyük avantajı, görevleri hesaplama
düğümleri üzerine dağıtma, ölçeklendirme, görevleri çalıştırma,
sonuçları alma gibi işlemlerin MapReduce ortamı tarafından otomatik
olarak yapılmasıdır. Kullanıcıya düşen sorumluluk ise Map ve Reduce
görevlerini kodlamaktır. 

Map görevi, kendisine verilen ``<K1,V1>`` anahtar-değer ikilisini
işleyerek ``<K2,V2>`` anahtar-değer ikililerinden oluşan bir 
liste, yani ``List(<K2,V2>)`` üretir. MapReduce uygulamasına girdi
olarak HDFS dosyası veya klasörü verildiyse, buradaki dosya veya
dosyalar bloklara bölünür ve her bir blok ``<blok kimliği, blok 
içeriği>`` ikilisi olarak ayrı bir Map görevine iletilir (blok 
kimliği sistem tarafından otomatik olarak üretilir).

Map görevlerinin çıktısı olan ``<K2,V2>`` anahtar-değer ikilileri,
sistem tarafından anahtarlarına göre ``<K2,List(V2)>`` yapısında
gruplanırlar. Bu sırada gruplar da aralarında anahtarlara göre 
sıralanmış olurlar. Bu işlemlerin gerçekleştiği aşamaya *Karıştırma
& Sıralama* (*Shuffling & Sorting*) aşaması denir.

Oluşturulan ``<K2,List(V2)>`` gruplarından her biri bir Reduce 
görevine iletilir. Bu görev de kendisine verilen ``V2`` 
değerlerinden oluşan listeyi işleyerek ``List(<K3,V3>)`` 
listesini oluşturur ve bu liste sonuçların tutulduğu HDFS 
klasöründe ayrı bir dosya içine yazılır. 

Burada anlatılan girdi-çıktı yapıları aşağıdaki tablodaki gibi 
özetlenebilir:

+-------------+--------+-------------+
|Girdi        |Görev   |Çıktı        |
+=============+========+=============+
|<K1,V1>      |Map     |List(<K2,V2>)|
+-------------+--------+-------------+
|<K2,List(V2)>|Reduce  |List(<K3,V3>)|
+-------------+--------+-------------+

MapReduce uygulamasına verilen dosya veya dosyaların bloklara 
bölünmesi ile elde edilen blok sayısı kadar Map görevi sistem 
tarafından oluşturulur ve görevlerin her biri ayrı bir bloku 
işlemek için çalıştırılır. Sistemde geçerli olan varsayılan blok
büyüklüğü (*blocksize*) kullanıcı tarafından değiştirilebilir. Bu 
değişiklik, çalışacak Map görevi sayısını etkileyebilecektir.
Reduce görevlerinin sayısı (*mapreduce.job.reduces*) ise kullanıcı
tarafından belirlenebilir; varsayılan değeri 1’dir. 

Bu noktada “kelime sayma” örneği ile ilerleyebiliriz. İçinde
meyve isimleri bulunan aşağıdakine benzer bir dosyada hangi
kelimenin kaç kez geçtiğini MapReduce ile bulmaya çalışalım:

+------------------------+
| elma armut elma erik   |
|                        |
| çilek elma armut armut |
|                        |
| erik çilek erik erik   |
+------------------------+

Bu amaçla, dosya içeriğini işlemek üzere önce Map görevini 
yazalım:

.. code-block:: cpp

 public void map(LongWritable key, Text value, Context con) 
                    throws IOException, InterruptedException {          
    String line = value.toString();
    String[] words=line.split(",");
    for(String word: words) {
        Text outputKey = new Text(word.toUpperCase().trim());
        IntWritable outputValue = new IntWritable(1);
        con.write(outputKey, outputValue);
    }
 }
              
Map görevi kendisine verilen ``<blok kimliği, blok içeriği>``
ikilisini alıp, blok içeriğini kelimelerine ayıracak ve her bir 
kelime için ``<kelime, 1>`` ara çıktısını üretecektir. Örneğin, 
kullanılan blok boyutu gereğince girdi dosyamızın

.. list-table::
    :align: left
    :widths: 5 5 5  
    
    * - elma armut elma erik
      - çilek elma armut armut
      - erik çilek erik erik
  
şeklinde üç bloka ayrılacağını varsayarsak, çalıştırılacak üç Map
görevi tarafından

.. list-table::
   :align: left
   :widths: 5 5 5  

   * - <elma, 1>
       
       <armut, 1>
       
       <elma, 1>
       
       <erik, 1>
     
     - <çilek, 1>
       
       <elma, 1>
       
       <armut, 1>
       
       <armut, 1>
     
     - <erik, 1>
       
       <çilek, 1>
     
       <erik, 1>
     
       <erik, 1>

ara çıktıları üretilecektir.  

Örneğimiz için Reduce görevi sayısını da iki olarak tanımladığımızı
varsayarsak, bu ara çıktılar Karıştırma & Sıralama aşaması 
tarafından meyve ismi anahtar alanına göre aşağıdaki şekilde 
gruplanıp sıralanabilecektir: 

.. list-table::
   :align: left
   :widths: 5 5

   * - <armut, List(1, 1, 1)>
       
       <çilek, List(1, 1)>
     
     - <elma, List(1, 1, 1)>
       
       <erik, List(1, 1, 1, 1)>

Bu grupları işlemek üzere Reduce görevini de şu şekilde 
yazabiliriz: 

.. code-block:: cpp

 public void reduce(Text word, Iterable<IntWritable> values, Context con) 
                           throws IOException, InterruptedException {
    int sum = 0;
    for(IntWritable value: values) 
        sum += value.get();
    con.write(word, new IntWritable(sum));
 }

Bu görev, kendisine verilen her bir grup için anahtara yani meyve
ismine karşılık gelen 1 değerlerinin toplamını bulup aşağıdaki 
sonucu üretecektir: 

.. list-table::
   :align: left
   :widths: 5 5

   * - <armut, 3>
       
       <çilek, 2>
     
     - <elma, 3>
       
       <erik, 4>

Map ve Reduce dışında, uygulama geliştirici dilerse *Combiner* ve 
*Partitioner* işlevlerini de kodlayabilir. Bunlardan ilki, her bir 
Map görevinin bitiminde, Map çıktısını toparlamak amacıyla ilgili
Map ile aynı düğüm üzerinde çalıştırılır. Bu açıdan Combiner 
işlevine yerel toparlayıcı veya indirgeyici de denir. Bu örnekte, 
Reducer için kullandığımız kodun aynısını Combiner için de 
kullanabiliriz. Bu durumda, her bir Map görevinin ara çıktısı 
anında Combiner işlevine aktarılacak ve aşağıdaki sonuçlar elde 
edilecektir: 

.. list-table::
   :align: left
   :widths: 5 5 5  

   * - <elma, 2>
       
       <armut, 1>
       
       <erik, 1>
     
     - <çilek, 1>
       
       <elma, 1>
       
       <armut, 2>
     
     - <erik, 3>
       
       <çilek, 1>

Buradan da anlaşılacağı üzere, 1 sayılarını toplama işinin bir 
kısmı hemen Map bitiminde yerel olarak gerçekleştirilecek; 
böylece sonrasında işlenecek ve taşınacak verinin hacmi bir 
miktar küçülmüş olacaktır.

Bu ara çıktıların Karıştırma & Sıralama aşamasında işlenmesi ile 
de, Reducer görevlerine iletilmek üzere şu sonuçlar elde edilmiş 
olacaktır:

.. list-table::
   :align: left
   :widths: 5 5

   * - <armut, List(1, 2)>
       
       <çilek, List(1, 1)>
     
     - <elma, List(2, 1)>
       
       <erik, List(1, 3)>

Bu grupların Reduce görevleri tarafından işlenmesinin ardından, 
yukarıdaki ile aynı sonuçlar elde edilmiş olacaktır:

.. list-table::
   :align: left
   :widths: 5 5

   * - <armut, 3>
       
       <çilek, 2>
     
     - <elma, 3>
       
       <erik, 4>

Partitioner ise, varsa Combiner işlevi, yoksa doğrudan Map görevi
çıktısı olan ``<K2, V2>`` ikililerinin girdi olarak hangi Reducer
görevine iletileceğini belirler. Varsayılan Partitioner olarak

*hash(key) mod ToplamReduceGöreviSayısı*

tanımına sahip “Hash Partitioner” kullanılmakta olup, çözüme 
katkısı olacak özel durumlar dışında yeni bir Partitioner 
tanımlamaya gerek yoktur. 

MapReduce uygulamaları tipik olarak burada anlatıldığı şekilde 
HDFS üzerinde tutulan dosya içeriklerini işlerler. Bununla 
birlikte, bu uygulamaların (farklı dosya sistemleri, veri 
tabanları, veri toplama araçları gibi) başka ortamlardan veri alıp
işleyecek şekilde kodlanmaları da mümkündür.

.. _Apache Hadoop: https://hadoop.apache.org
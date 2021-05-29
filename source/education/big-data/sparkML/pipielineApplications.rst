**************************************
3 - Veri Hattı (Pipeline) Uygulamaları 
**************************************

MLlib, birden çok algoritmayı tek bir işlem hattında veya iş akışında 
birleştirmeyi kolaylaştırmak için makine öğrenimi algoritmaları için 
uygulama işleme arayüzlerini (API) standartlaştırır. Veri hattı kavramı
çoğunlukla scikit-learn projesinden ilham alınarak oluşturulan Pipeline
API altındaki temel yapılar şunlardır.

.. glossary::

 Veri Çerçevesi (DataFrame)
   *Pipeline ML API*, çeşitli veri türlerini tutabilen bir *ML* veri kümesi
   olarak Spark SQL altındaki DataFrame yapısını kullanır. Örneğin, bir 
   DataFrame, metin verisini, özellik vektörlerini, gerçek etiketleri ve
   tahminleri depolayan farklı sütunlara sahip olabilir.
 
 Dönüştürücü (Transformer)
   Transformer, bir DataFrame'i başka bir DataFrame'e dönüştürebilen bir 
   algoritmadır. Örneğin, bir ML modeli, özelliklere sahip bir DataFrame'i
   tahminlerle bir DataFrame'e dönüştüren bir Transformer'dır.

 Tahminci (Estimator)
   Estimator, bir Transformer üretmek için bir DataFrame'e sığabilen bir
   algoritmadır. Örneğin, bir öğrenme algoritması, bir DataFrame üzerinde
   eğitim yapan ve bir model üreten bir Estimetor’dır.

 Veri Hattı (Pipeline)
   Bir Pipeline, bir ML iş akışını belirtmek için birden çok Transformer’ı
   ve Estimator’ı birbirine bağlar.

 Parametre
   Tüm Transformer ve Estimator’lar parametreleri belirtmek için ortak 
   bir API paylaşır.

Makine öğrenmede, verileri işlemek ve bilgi çıkarımı için yaygın olarak bir
dizi algoritma çalıştırılır. Örneğin, basit bir metin belgesi işleme iş
akışı birkaç aşama içerebilir:

* Her belgenin metnini kelimelere bölün.
* Her belgenin sözcüklerini sayısal bir özellik vektörüne dönüştürün.
* Özellik vektörlerini ve etiketlerini kullanarak bir tahmin modeli öğrenin.

MLlib, bu şekildeki bir iş akışını Pipeline olarak ifade eder. Pipeline
bir dizi *PipelineStages* (Transformer ve Estimator) içerir. Bu aşamalar
sırayla çalıştırılır ve DataFrame girdisi her aşamadan geçerken 
dönüştürülür. Transformer aşamaları için DataFrame'de transform() yöntemi
çağrılır. Estimator aşamaları için fit() metodu, bir Transformer üretmek 
için çağrılır ve bu Transformer'ın transform () metodu, DataFrame üzerinde
uygulanır.

Çoğu zaman, daha sonra kullanmak üzere bir modeli veya bir veri akışını
diske kaydetmek gerekir. Spark 1.6'da, Pipeline API'sine bir model 
içe/dışa aktarma işlevi eklenmişti. Spark 2.3'ten itibaren, spark.ml 
ve pyspark.ml'deki DataFrame tabanlı API, tanımlanmış bu model aktarma 
işlevlerini kapsamaktadır.

Örnekler için bu `bağlantıya <http://spark.apache.org/docs/latest/ml-pipeline.html#pipeline>`_ ulaşabilirsiniz.
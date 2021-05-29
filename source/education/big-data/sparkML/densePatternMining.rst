**************************
8 - Sık Örüntü Madenciliği
**************************
Sık öğeleri, öğe kümelerini, alt dizileri veya diğer alt yapılar üzerinde 
örüntü tespiti veri madenciliğinde aktif bir araştırma konusu olan büyük 
ölçekli veri kümelerinin analizi için yoğun olarak kullanılmaktadır. 

Spark ML altında `sık öğe kümelerinin`_ bulunmasına yönelik olarak
*FP-Growth* metodu, sık dizilerin tespiti içinse *PrefixSpaem* metodu
sunulmaktadır. 

Örnek olarak Scala dili ile spark.ml’deki FP-Growth fonskiyonun kullanımı 
aşağıda sunulmaktadır.

.. code-block:: scala

 import org.apache.spark.ml.fpm.FPGrowth

 val dataset = spark.createDataset(Seq(
   "1 2 5",
   "1 2 3 5",
   "1 2")
 ).map(t => t.split(" ")).toDF("items")

 val fpgrowth = new FPGrowth().setItemsCol("items").setMinSupport(0.5).setMinConfidence(0.6)
 val model = fpgrowth.fit(dataset)

 // Display frequent itemsets.
 model.freqItemsets.show()

 // Display generated association rules.
 model.associationRules.show()

 // transform examines the input items against all the association rules and summarize the consequents as prediction
 model.transform(dataset).show()

.. _sık öğe kümelerinin: http://spark.apache.org/docs/latest/ml-frequent-pattern-mining.html
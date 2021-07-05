********************************
6 - Gözetimsiz Öğrenme Metotları 
********************************
Sınıflandırma ve regreasyon gibi gözetimli öğrenme modellerinin yanı sıra 
gözetimsiz öğrenme metotları da makine öğrenmesi uygulamaları içinde sıkça 
kullanılmaktadır. Sınıflandırma ve regrasyon analizinden farklı olarak 
gözetimsiz öğrenme yöntemlerinde bir eğitim verisi ile tahmin modeli 
oluşturulmamaktadır.

Spark MLlib’de K-Means gibi yaygın olarak kullanılan `kümeleme`_ metodunun
yanı sıra çizge kümeleme için *Power Iteration Clustering* (*PIC*), hiyerarşik 
kümeleme için *Bisecting k-means* yöntemlerini ve *Latent Dirichlet allocation* 
(*LDA*) ve *Gaussian Mixture Model* (GMM) metotları sunulmaktadır. 

Scala’da k-means metodunun örnek bir kullanımı aşağıda sunulmuştur.

.. code-block:: scala

 import org.apache.spark.ml.clustering.KMeans
 import org.apache.spark.ml.evaluation.ClusteringEvaluator

 // Loads data.
 val dataset = spark.read.format("libsvm").load("data/mllib/sample_kmeans_data.txt")

 // Trains a k-means model.
 val kmeans = new KMeans().setK(2).setSeed(1L)
 val model = kmeans.fit(dataset)

 // Make predictions
 val predictions = model.transform(dataset)

 // Evaluate clustering by computing Silhouette score
 val evaluator = new ClusteringEvaluator()

 val silhouette = evaluator.evaluate(predictions)
 println(s"Silhouette with squared euclidean distance = $silhouette")

 // Shows the result.
 println("Cluster Centers: ")
 model.clusterCenters.foreach(println)

----------

Bu Türkçe notlar Prof. Pınar KARAGÖZ tarafından kaynak olarak Apache
Spark `web sitesindeki`_ bilgilerden faydalanılarak hazırlanmıştır.
Scala kodlama örnekleri aynı kaynaktan alınmıştır. 

----------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _kümeleme: http://spark.apache.org/docs/latest/ml-clustering.html
.. _web sitesindeki: http://spark.apache.org/docs/latest/ml-guide.html
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
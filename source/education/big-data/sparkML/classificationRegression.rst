******************************
5 - Sınıflandırma ve Regrasyon
******************************
Girdi olarak veri üzerinde gözetimli öğrenme ile model oluşturarak veri
etiketi ya da hedef öznitelik değeri tahmini makine öğrenme çalışmalarının
başında gelmektedir. Bu amaçla Spark MLlib’de çeşitli metotlar sunulmaktadır.
Karar destek makinası (*SVM*), Karar Ağacı (decision tree), çok katmanlı 
perseptron sınıflandırıcı (*MLP*) gibi fonksiyonlar bunlara örnek olarak 
olarak verilebilir. 

Desteklenen `sınıflandırma`_ metotları arasında sıkça kullanılan bir algoritma
olan *Naif Bayes* (*Naive Bayes*) sınıflandırıcı özellikle belge sınıflandırma 
problemlerinde başarıyla uygulanamaktadır. Spark MLlib’de bu algoritmanın 
*Multinomial naive Bayes*, *Complement naive Bayes*, *Bernoulli naive Bayes*
and *Gaussian naive Bayes* alt çeşitleri desteklenmektedir. 

Aşağıdak Scala dili ile örnek bir Naif Bayes sınıflandırıcı metotu 
kullanımı sunulmaktadır.

.. code-block:: scala

 import org.apache.spark.ml.classification.NaiveBayes
 import org.apache.spark.ml.evaluation.MulticlassClassificationEvaluator

 // Load the data stored in LIBSVM format as a DataFrame.
 val data = spark.read.format("libsvm").load("data/mllib/sample_libsvm_data.txt")

 // Split the data into training and test sets (30% held out for testing)
 val Array(trainingData, testData) = data.randomSplit(Array(0.7, 0.3), seed = 1234L)

 // Train a NaiveBayes model.
 val model = new NaiveBayes()
  .fit(trainingData)

 // Select example rows to display.
 val predictions = model.transform(testData)
 predictions.show()

 // Select (prediction, true label) and compute test error
 val evaluator = new MulticlassClassificationEvaluator()
  .setLabelCol("label")
  .setPredictionCol("prediction")
  .setMetricName("accuracy")
 val accuracy = evaluator.evaluate(predictions)
 println(s"Test set accuracy = $accuracy")

----------

Bu Türkçe notlar Prof. Pınar KARAGÖZ tarafından kaynak olarak Apache
Spark `web sitesindeki`_ bilgilerden faydalanılarak hazırlanmıştır.
Scala kodlama örnekleri aynı kaynaktan alınmıştır. 

----------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _sınıflandırma: http://spark.apache.org/docs/latest/ml-classification-regression.html
.. _web sitesindeki: http://spark.apache.org/docs/latest/ml-guide.html
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
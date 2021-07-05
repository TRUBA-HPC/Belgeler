**********************************
1 - Temel İstatistik Fonksiyonları
**********************************
Spark MLlib’de desteklenen temel `istatistik`_ fonksiyonlarını korelasyon hesaplama, 
hipotez testi ve özetleme başlıkları altında toplayabiliriz.

1.1 - Korelasyon
================
İki veri dizisi arasındaki korelasyonu hesaplaması yaygın olarak uygulanan 
istatistiksel bir işlemdir. *Spark.ml*'de desteklenen korelasyon yöntemleri şu anda 
*Pearson* ve *Spearman*'ın korelasyonudur. Spark.ml kapsamındaki Korelasyon işlemi 
belirtilen yöntemi kullanarak (Pearson ya da Spearman korelasyonu) girdi vektörleri 
için korelasyon matrisini hesaplar. Çıktı, girdi vektörlerinin korelasyon matrisini
içeren bir Veri Çerçevesi olacaktır.

1.2 - Hipotez Testi
===================
Hipotez testi, elde edilen bir sonucun tesadüfi olup olmadığını, diğer bir deyişle
sonucun istatistiksel olarak anlamlı olup olmadığını belirlemek için kullanılan bir
araçtır. spark.ml halen Pearson *Ki-kare* (Chi-square) (χ :superscript:`2`) bağımsızlık testlerini
desteklemektedir. 

Ki-kare testi, etikete karşı her öznitelik için veri etiket özniteliğine karşı 
Pearson'ın bağımsızlık testini uygular. Her özellik için, (özellik, etiket) çiftleri,
üzerinde Ki-kare istatistiğinin hesaplandığı bir olasılık matrisi oluşturur. Ki-kare
testinin uygulanabilmesi için etiket ve diğer öznitelik değerleri kategorik olmalıdır.

Örneğin Scala ile örnek bir uygulama aşağıda sunulmuştur.

.. code-block:: scala
   
 import org.apache.spark.ml.linalg.{Vector, Vectors}
 import org.apache.spark.ml.stat.ChiSquareTest
 
 val data = Seq(
  (0.0, Vectors.dense(0.5, 10.0)),
  (0.0, Vectors.dense(1.5, 20.0)),
  (1.0, Vectors.dense(1.5, 30.0)),
  (0.0, Vectors.dense(3.5, 30.0)),
  (0.0, Vectors.dense(3.5, 40.0)),
  (1.0, Vectors.dense(3.5, 40.0))
 )
 
 val df = data.toDF("label", "features")
 val chi = ChiSquareTest.test(df, "features", "label").head
 println(s"pValues = ${chi.getAs[Vector](0)}")
 println(s"degreesOfFreedom ${chi.getSeq[Int](1).mkString("[", ",", "]")}")
 println(s"statistics ${chi.getAs[Vector](2)}")

1.3 - Özetleme (Summarizer)
===========================
Summarizer kütüphanesi ile girdi olarak verilen bir Veri Çerçevesi 
vektör sütun özet istatistikleri sağlanır. Sütun bazında maksimum,
minimum, ortalama, toplam, varyans, standart sapma ve sıfır olmayan 
değerlerin sayısı ve toplam sayım değerleri sunulmaktadır. 

.. code-block:: scala

 import org.apache.spark.ml.linalg.{Vector, Vectors}
 import org.apache.spark.ml.stat.Summarizer

 val data = Seq(
  (Vectors.dense(2.0, 3.0, 5.0), 1.0),
  (Vectors.dense(4.0, 6.0, 7.0), 2.0)
 )

 val df = data.toDF("features", "weight")

 val (meanVal, varianceVal) = df.select(metrics("mean", "variance")
    .summary($"features", $"weight").as("summary"))
    .select("summary.mean", "summary.variance")
    .as[(Vector, Vector)].first()

 println(s"with weight: mean = ${meanVal}, variance = ${varianceVal}")

 val (meanVal2, varianceVal2) = df.select(mean($"features"), variance($"features"))
    .as[(Vector, Vector)].first()

 println(s"without weight: mean = ${meanVal2}, sum = ${varianceVal2}")

----------

Bu Türkçe notlar Prof. Pınar KARAGÖZ tarafından kaynak olarak Apache
Spark `web sitesindeki`_ bilgilerden faydalanılarak hazırlanmıştır.
Scala kodlama örnekleri aynı kaynaktan alınmıştır. 

----------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _istatistik: http://spark.apache.org/docs/latest/ml-statistics.html
.. _web sitesindeki: http://spark.apache.org/docs/latest/ml-guide.html
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png


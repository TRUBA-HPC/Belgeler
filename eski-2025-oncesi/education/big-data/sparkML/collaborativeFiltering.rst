***************************************************
7 - İşbirlikçi Filtreleme (Collaborative Filtering)
***************************************************
İşbirlikçi `filtreleme`_ sıklıkla kullanılan tavsiye sistemi metotlarından 
biridir. Bu teknik, bir kullanıcı-ürün (user-item) matrisinin eksik 
girişlerini doldurmayı amaçlar. spark.ml tarafından desteklenen işbirlikçi 
filtreleme metodunda kullanıcılar ve ürünler sınırlı sayıda gizli faktör 
kümesiyle tanımlanarak eksik girdileri tahmin edilir. spark.ml, bu gizli 
faktörleri öğrenmek için alternatif en küçük kareler (*ALS*) algoritmasını 
kullanır.

Scala ile örnek bir uygulama aşadağıda sunulmuştur. 

.. code-block:: scala

 import org.apache.spark.ml.evaluation.RegressionEvaluator
 import org.apache.spark.ml.recommendation.ALS

 case class Rating(userId: Int, movieId: Int, rating: Float, timestamp: Long)
 def parseRating(str: String): Rating = {
   val fields = str.split("::")
   assert(fields.size == 4)
   Rating(fields(0).toInt, fields(1).toInt, fields(2).toFloat, fields(3).toLong)
 }

 val ratings = spark.read.textFile("data/mllib/als/sample_movielens_ratings.txt")
   .map(parseRating)
   .toDF()
 val Array(training, test) = ratings.randomSplit(Array(0.8, 0.2))

 // Build the recommendation model using ALS on the training data
 val als = new ALS()
   .setMaxIter(5)
   .setRegParam(0.01)
   .setUserCol("userId")
   .setItemCol("movieId")
   .setRatingCol("rating")
 val model = als.fit(training)

 // Evaluate the model by computing the RMSE on the test data
 // Note we set cold start strategy to 'drop' to ensure we don't get NaN evaluation metrics
 model.setColdStartStrategy("drop")
 val predictions = model.transform(test)
 
 val evaluator = new RegressionEvaluator()
   .setMetricName("rmse")
   .setLabelCol("rating")
   .setPredictionCol("prediction")
 val rmse = evaluator.evaluate(predictions)
 println(s"Root-mean-square error = $rmse")
 
 // Generate top 10 movie recommendations for each user
 val userRecs = model.recommendForAllUsers(10)
 // Generate top 10 user recommendations for each movie
 val movieRecs = model.recommendForAllItems(10)
 
 // Generate top 10 movie recommendations for a specified set of users
 val users = ratings.select(als.getUserCol).distinct().limit(3)
 val userSubsetRecs = model.recommendForUserSubset(users, 10)
 
 // Generate top 10 user recommendations for a specified set of movies
 val movies = ratings.select(als.getItemCol).distinct().limit(3)
 val movieSubSetRecs = model.recommendForItemSubset(movies, 10)

----------

Bu Türkçe notlar Prof. Pınar KARAGÖZ tarafından kaynak olarak Apache
Spark `web sitesindeki`_ bilgilerden faydalanılarak hazırlanmıştır.
Scala kodlama örnekleri aynı kaynaktan alınmıştır. 

.. _filtreleme: http://spark.apache.org/docs/latest/ml-collaborative-filtering.html 
.. _web sitesindeki: http://spark.apache.org/docs/latest/ml-guide.html

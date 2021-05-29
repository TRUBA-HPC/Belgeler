****************
9 - Model Seçimi 
****************
Gözetimli makine öğrenmesi uygulamalarında önemli bir aşama oluşturulan 
`modelin tahmin performansının`_ değerlendirilmesidir.  Bu değerlendirme modelin 
tahmin başarısının ortaya konmasının yanı sıra model için en uygun parametre 
değerlerinin seçimi, diğer bir deyişle parametre değerleri için ince ayar 
yapılması (*hyper-parameter tuning*) için de kullanılır. 

Spark MLlib, bu amaçla tahminleme başarısının ölçümü için metrikler içeren 
*Evaluator* paketini sunar. Evaluator paketi kullanılan Estimator’ın 
çeşidine göre farklı metrikler içerir (*RegressionEvaluator* ya da 
*MulticlassClassificationEvaluator* gibi)

Model seçimi için kullanılan bir diğer fonksiyon da *CrossValidator* 
fonksiyonudur. CrossValidator verilen girdi veri kümesini alt kısımlara 
ayırarak eğitim ve test alt kümeleri oluşturur. 

CrossValidator’ın yanı sıra spark.ml’de sunulan bir diğer fonksiyon 
*TrainValidationSplit* fonksiyonudur. Bu fonksiyon CrossValidator’dan 
farklı olarak hiper-parametre ayarlamaya yönelik olarak kullanılmaktadır. 
Hiper-parametre ayarlamaya belirlenen Estimator  üzerinde uygulanabildiği 
gibi belirlenen Pipeline için de uygulanabilmektedir. 

.. _modelin tahmin performansının: http://spark.apache.org/docs/latest/ml-tuning.html
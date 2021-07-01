===========================
Spark ile Makine Öğrenmesi
===========================

*Apache* Açık Kaynak Yazılım Kuruluşu’nın projelerinden biri olan `Spark`_, 
büyük veri işlemek üzere geliştirilmiş bir analiz motorudur. *SQL* ve yapısal 
veri işleme (*Spark SQL*), makine öğrenmesi (*MLlib*), çizge işleme (*GraphX*)
için de araçlar sunmaktadır. *Java*, *Scala*, *Python* ve *R* dilleri ile 
kullanılabilen API’ler sunmaktadır. 

`Spark 1.2`_ sürümünden itibaren makine öğrenmesi için kütüphane sunmaktadır.
Ancak Spark 2.0’dan itibaren Spark `MLlib`_ ile makine öğrenmesi paketini 
yenileyerek *DataFrame* (Veri Çerçevesi) tabanlı bir yapıya geçmiştir.
(DataFrame veriyi bir tablo - ya da eşit uzunlukta vektörler kümesi - olarak 
modelleyen bir veri yapısıdır)

*Spark MLlib* ana hatlarıyla şu işlevleri sağlar:

* Makine öğrenmesi algoritmaları: Sınıflandırma, kümeleme, regrasyon teknikleri ve işbirlikçi filtreleme öneri algoritması
* Öznitelik çıkartma, değiştirme, boyut azaltma ve boyut seçme yöntemleri
* Makine öğrenmesi çözümleri için veri hattı (*pipeline*) tanımlama yöntemleri
* Algoritma ve modellerin saklanması


.. toctree::
   :caption: İçerik
   :maxdepth: 1
   :titlesonly:

   generalStatisticFunctions.rst
   dataSources.rst
   pipielineApplications.rst
   attribute.rst
   classificationRegression.rst
   learningMethods.rst
   collaborativeFiltering.rst
   densePatternMining.rst
   modelSelection.rst

----------

Bu Türkçe notlar Prof. Pınar KARAGÖZ tarafından kaynak olarak Apache
Spark `web sitesindeki`_ bilgilerden faydalanılarak hazırlanmıştır.
Scala kodlama örnekleri aynı kaynaktan alınmıştır. 

----------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _Spark: https://spark.apache.org/docs/latest/
.. _Spark 1.2: https://spark.apache.org/docs/1.2.2/ml-guide.html
.. _MLlib: http://spark.apache.org/docs/latest/ml-guide.html
.. _web sitesindeki: http://spark.apache.org/docs/latest/ml-guide.html
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
***************************************************************
4 - Öznitelik Çıkartımı, Öznitelik Dönüşümü ve Öznitelik Seçimi
***************************************************************
Spark MLlib’de veri `öznitelikleri`_ ile ilişkin olarak sunulan işlemler
ana hatlarıyla şöyledir:

.. glossary::
 Çıkarma
   Ham verilerden öznitelikleri çıkarma

 Dönüşüm
   Öznitelikleri ölçekleme, dönüştürme veya değiştirme

 Seçim
   Daha büyük bir öznitelik kümesinden bir alt küme seçme

 Yerellik Duyarlı Karma (Locality Sensitive Hashing (LSH))
    Bu algoritma sınıfı, öznitelik dönüşümünün farklı yönlerini diğer
    algoritmalarla birleştirir. 

Spark MLlib altında yukardaki her işlem başlığı için çeşitli metotlar sunulur.

Öznitelik çıkarmaya yönelik olarak *TF-IDF*, *Word2Vec*, *CountVectorizer*
ve *FeatureHashing* metotlarını sağlar. Bu metotların her biri girdi
olarak verilen veriden bir vektör oluşturmayı hedefler. Örneğin,
FeatureHashing bir dizi kategorik veya sayısal özniteliği, belirtilen
boyuttaki bir öznitelik vektörüne yansıtır.

Öznitelik dönüşümü için farklı tipte veriler üzerinde uygulanmak üzere 
geniş bir yelpazede metotlar sunulmaktadır. Örneğin metin verilerini sözcük
ve diğer alt birimlere ayrıştırmak üzere Tokenizer metodu, sözcükleri 
elemek üzere *StopWordsRemover* metodu bulunmaktadır. Diğer bir örnek 
olarak sayısal veriler üzerinde uygulanmak üzere *MinMaxScaler* metodu 
sunulmuştur.  

Öznitelik seçimi için VectorSlicer gibi verilen bir vektörün belirtilen alt
kısmını çeken metotların yanı sıra *ChiSqSelector* givi Ki-kare testi gibi
istatistiksel yaklaşımlara dayanan metotlar da desteklenmektedir.

.. _öznitelikleri: http://spark.apache.org/docs/latest/ml-features.html

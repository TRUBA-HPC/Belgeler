.. _veri_yük:

================================
Veri Yükleme ve Önişlem Uygulama
================================

Nöral ağlar metin dosyaları, JPEG veya CSV dosyaları gibi işlenmemiş veri üzerinde çalışamazlar.
Nöral ağlar, üzerinde çalışmak için, halihazırda **standardize** ve **vektörize** edilmiş veriye ihtiyaç duymaktadır. 

- Metin dosyaları string tensörü olarak okunmalı, kelimelere ayrılmalı ve bu kelimeler indekslenerek integer tensörlerine dönüştürülmelidir.
- Resim dosyaları integer tensörü olarak okunmalı, kayar nokta gösterimine dönüştürülüp 0 ile 1 arasında küçük değerlere dönüştürülmelidir.
- CSV dosyaları sayısal değerleri kayar nokta tensörlerine, kategori değerleri indekslenerek tam sayı tensörlerine dönüştürülüp okunmalıdır. Ardından her bir sütun için değerler ortalamaları 0, varyasyon 1'e yakın olacak şekilde normalize edilmelidir.


Veri Yükleme
============
Keras modelleri 3 tip girdiyi kabul etmektedir:

- **NumPy dizileri**, veri belleğe sığacak boyuttaysa verimli bir şekilde kullanılabilir.
- **TensorFlow Dataset objeleri**, belleğe sığmayan, internet üzerinden veya diskten okunacak veriler için yüksek kullanılabilecek yüksek performanslı bir veri yapısıdır.
- **Python generator fonksiyonları**, sayı dizileri yaratmak için kullanılabilir. (``keras.utils.Sequence`` sınıfı gibi)
  
Keras modeli eğitilmeye başlanmadan önce, girdinin bu formatlardan birine dönüştürüldüğünden emin olunmalıdır. 
Eğer eldeki verinin boyutu büyükse veya GPU(lar) üzerinde işlem yapılacaksa **Dataset** objeleri kullanmak daha yüksek performans sağlayacaktır.
**Dataset** objeleri;

- GPU üzerinde işlem yapılırken verinin asenkron olarak CPU üzerinde işlenmesi 
- Verinin modele girdi olarak verilmesinden önce GPU belleğine kopyalanarak bir önceki veri paketi işlendiğinde bellekte hazır olması.

gibi performansa büyük etki eden özellikler sunmaktadır. 

Keras, diskte bulunan ham verileri **Dataset** objelerine çevirmek için önceden tanımlı fonksiyonlar sunmaktadır:

- ``tf.keras.preprocessing.image_dataset_from_directory`` fonksiyonu ile çok sayıda alt dosya içinde sınıflandırılmış resim dosyası **Dataset** objesine döüştürülebilir.
- ``tf.keras.preprocessing.text_dataset_from_directory`` fonksiyonu ile çok sayıda alt dosya içinde sınıflandırılmış metin dosyası **Dataset** objesine döüştürülebilir.
- ``tf.data.experimental.make_csv_dataset`` fonksiyonu ile CSV dosyalarından veri okunabilir.

Örnek: Diskteki Resim Dosyalarının **Dataset** objesi olarak okunması:
######################################################################
Aşağıda gösterildiği gibi, farklı klasörler altında toplanmış bir dosya düzeniniz olduğunu varsayalım:

.. code-block:: 

    main_directory/
    ...class_a/
    ......a_image_1.jpg
    ......a_image_2.jpg
    ...class_b/
    ......b_image_1.jpg
    ......b_image_2.jpg

Bu durumda:

.. code-block:: python

    # Dataset objesi yaratma
    dataset = keras.preprocessing.image_dataset_from_directory(
    'path/to/main_directory', batch_size=64, image_size=(200, 200))

    # Okunan veriyi görmek için Dataset objesi içindeki veri grupları üzerinde gezip bastırabiliriz.
    for data, labels in dataset:
    print(data.shape)  # (64, 200, 200, 3)
    print(data.dtype)  # float32
    print(labels.shape)  # (64,)
    print(labels.dtype)  # int32

Bu kod parçasının bastırdığı isimler okunan klasörlerin ana klasör içerisindeki sırası olacaktır.
İsimler ``class_names=['class_a', 'class_b']`` parametresi eklenerek manuel olarak da verilebilir.

Örnek: Diskteki Metin Dosyalarının **Dataset** objesi olarak okunması:
######################################################################

.. code-block:: python

    dataset = keras.preprocessing.text_dataset_from_directory(
    'path/to/main_directory', batch_size=64)

    # Okunan veriyi görmek için Dataset objesi içindeki veri grupları üzerinde gezip bastırabiliriz.
    for data, labels in dataset:
    print(data.shape)  # (64,)
    print(data.dtype)  # string
    print(labels.shape)  # (64,)
    print(labels.dtype)  # int32


Okunan Veriye Önişlem Uygulama
==============================
Okunan veri string/int/float veri tipinde bir NumPy array'i veya **Dataset** objesi olarak elde edildikten sonra, veri üstünde **önişlem** uygulanabilir.
Bu bağlamda **önişlem** şunlardan birisi olabilir:

- String verisinin tokenizasyonu ve tokenlerin indekslenmesi
- (Feature) Normalizasyon
- Verinin küçük değerlere ölçeklenmesi. (Genel olarak, nöral ağlara girdi olarak verilecek verinin 0'a yakın olması beklenir. Bu veriler ya ortalaması 0, varyansı 1 olacak şekle getirilmeli ya da ``[0, 1]`` aralığında olmalıdır.)

**İdeal bir makine öğrenmesi modeli uçtan-uca olmalıdır.** Yani, önişleme modelin tasarlanmasından önce uygulanacak bir işlemler dizisi değil, modelin bir parçası olarak kabul edilmelidir. Bu şekilde, oluşturulan modeller farklı ortamlara çok daha rahat uyarlanabilir. 

Keras preprocessing katmanları
##############################

Keras üzerinde, oluşturacağımız modelin bir parçası haline getirebileceğimiz önişlem adımları **önişleme katmanları** kullanılarak tamamlanabilir.

- String tipindeki veri ``TextVectorization``
- (Feature) normalizasyon ``Normalization``

katmanları ile oluşturulacak modelin içine dahil edilmiş bir şekilde yazılabilir. 
Bazı önişleme katmanları, işledikleri veriye dair bilgi tutmaktadır:

- ``TextVectorization`` kelimeleri veya tokenleri tam sayılara çeviren bir indekslenerek
- ``Normalization`` değerlerin ortalamasını ve varyansını
  
bilgi olarak saklamaktadır. Bu bilgiye ``layer.adapt(veri)`` şeklinde erişilebilir.

Örnek: String verisinin indekslenmiş kelimelere dönüştürülmesi
##############################################################

.. code-block:: python

    from tensorflow.keras.layers.experimental.preprocessing import TextVectorization

    # `string` tipinde örnek girdi verisi
    training_data = np.array([["This is the 1st sample."], ["And here's the 2nd sample."]])

    # TextVectorization katmanı objesinin yaratılması. Bu obje token indeksleri veya yoğun token gösterimi (multi-hot veya TF-IDF)
    # döndürecek şekilde özelleştirilebilir. 
    vectorizer = TextVectorization(output_mode="int")

    # `adapt` fonksiyonunun girdi verisi üzerinde çağırılması ile veri üzerinde bir sözlük
    # (vocabulary) yaratılabilir. Bu fonksiyon daha önce görülmemiş bir veri geldiğinde tekrar kullanılabilir.
    vectorizer.adapt(training_data)

    # `adapt` fonksiyonu çağırıldıktan sonra önişleme katmanı gördüğü bütün n-gram'ları tam sayı olarak indeksleyebilir. 
    # Daha önce görülmemiş n-gram'lar "out-of-vocabulary" olarak indekslenir.
    integer_data = vectorizer(training_data)
    print(integer_data)

.. code-block:: console

    tf.Tensor(
    [[4 5 2 9 3]
    [7 6 2 8 3]], shape=(2, 5), dtype=int64)


Örnek: String verisinin one-hot encoded bigram'lara dönüştürülmesi
##################################################################

.. code-block:: python

    from tensorflow.keras.layers.experimental.preprocessing import TextVectorization

    # Example training data, of dtype `string`.
    training_data = np.array([["This is the 1st sample."], ["And here's the 2nd sample."]])
    ##`output_mode` parametresi ile çıktı tipi, `ngram` parametresi ile kombine edilecek token'lerin uzunluğu seçilebilir. 
    vectorizer = TextVectorization(output_mode="binary", ngrams=2)
    vectorizer.adapt(training_data)

    integer_data = vectorizer(training_data)
    print(integer_data)

.. code-block:: console

    tf.Tensor(
    [[0. 1. 1. 1. 1. 0. 1. 1. 1. 0. 0. 0. 0. 0. 0. 1. 1.]
    [0. 1. 1. 0. 0. 1. 0. 0. 0. 1. 1. 1. 1. 1. 1. 0. 0.]], shape=(2, 17), dtype=float32)

Örnek: Değer Normalizasyonu (Feature Normalization)
###################################################

.. code-block:: python

    from tensorflow.keras.layers.experimental.preprocessing import Normalization

    # Değerleri [0, 255] aralığında olan örnek resim verisi
    training_data = np.random.randint(0, 256, size=(64, 200, 200, 3)).astype("float32")

    normalizer = Normalization(axis=-1)
    normalizer.adapt(training_data)

    normalized_data = normalizer(training_data)
    print("var: %.4f" % np.var(normalized_data))
    print("mean: %.4f" % np.mean(normalized_data))


.. code-block:: console

    var: 1.0000
    mean: -0.0000


Örnek: Resim dosyalarının kırpılması ve ölçeklenmesi
####################################################
``Rescaling`` ve ``CenterCrop`` katmanları girdi verisine dair bilgi tutmadığından, bu katmanlar için ``adapt()`` fonksiyonunu çağırmaya gerek yoktur.

.. code-block:: python

    from tensorflow.keras.layers.experimental.preprocessing import CenterCrop
    from tensorflow.keras.layers.experimental.preprocessing import Rescaling

    # Değerleri [0, 255] aralığında olan örnek resim verisi
    training_data = np.random.randint(0, 256, size=(64, 200, 200, 3)).astype("float32")

    # Resimlerin merkezi değişmeden 150x150 boyutuna getirilmesi
    cropper = CenterCrop(height=150, width=150)
    # RGB değerlerinin [0, 1] aralığına ölçeklenmesi
    scaler = Rescaling(scale=1.0 / 255)

    output_data = scaler(cropper(training_data))
    print("shape:", output_data.shape)
    print("min:", np.min(output_data))
    print("max:", np.max(output_data))

.. code-block:: console

    shape: (64, 150, 150, 3)
    min: 0.0
    max: 1.0


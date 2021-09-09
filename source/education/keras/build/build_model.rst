========================
Modellerin Oluşturulması
========================

Bir "katman", basitçe girdi-çıktı arasında verinin manipüle edilmesi olarak düşünülebilir. Veri Yükleme ve Önişlem Uygulama bölümünde bahsedilen ölçekleme ve kırpma katmanları gibi).
"Model" ise katmanlardan oluşan bir yönlü tekrarsız çizgedir (directed acyclic graph). Model aynı zamanda veriye maruz bırakılmak suretiyle öğrenebilen birden fazla alt katmandan oluşan bir büyük katman olarak da düşünülebilir.

Keras modellerini oluşturmanın en işlevsel yolu fonksiyonel arayüzü kullanmaktır (Functional API). Fonksiyonel arayüz ile model inşa etmek için öncelikle girdi verisinin boyutları ve opsiyonel olarak tipi belirtilmelidir. 
Eğer girdi verisinin boyutları değişkenlik gösteriyorsa, boyut ``None`` olarak seçilmelidir. Örneğin, 200x200 boyutunda bir RGB resminin boyutları ``(200, 200, 3)`` olarak seçilmelidir. Eğer farklı boyutlarda resimler kullanılacaksa, boyut ``(None, None, 3)`` olarak seçilmelidir. 

.. code-block:: python
    
    # Girdi verisinin herhangi bir boyutta gelebilecek RGB resimlerinden
    # oluşması durumunda girdilerin tanımlanması
    inputs = keras.Input(shape=(None, None, 3))

Girdi(ler) tanımlandıktan sonra girdilerin üstüne dönüşüm katmanları (transformation layers) eklenebilir.

.. code-block:: python

    from tensorflow.keras import layers

    # Resimlerin merkezi değiştirilmeden 150x150 boyutuna kırpılması
    x = CenterCrop(height=150, width=150)(inputs)
    # Değerlerin [0, 1] aralığında ölçeklenmesi
    x = Rescaling(scale=1.0 / 255)(x)

    # Convolution ve pooling katmanlarının uygulanması
    x = layers.Conv2D(filters=32, kernel_size=(3, 3), activation="relu")(x)
    x = layers.MaxPooling2D(pool_size=(3, 3))(x)
    x = layers.Conv2D(filters=32, kernel_size=(3, 3), activation="relu")(x)
    x = layers.MaxPooling2D(pool_size=(3, 3))(x)
    x = layers.Conv2D(filters=32, kernel_size=(3, 3), activation="relu")(x)

    # Global average pooling ile final çıktı değerlerinin elde edilmesi
    x = layers.GlobalAveragePooling2D()(x)

    # Modelden elde edilen çıktının kategori tahmini verecek olan classifier'a verilmesi
    num_classes = 10
    outputs = layers.Dense(num_classes, activation="softmax")(x)


Katmanları ardı ardına uygulamak suretiyle modeli oluşturacak yönlü tekrarsız çizge tamamlandığında ``Model`` objesi yaratılabilir.

.. code-block:: python

    model = keras.Model(inputs=inputs, outputs=outputs)

Bu ``Model`` objesi basitçe alt katmanları olan büyük bir katman gibi davranacaktır. Bu ``Model`` aşağıda görülebileceği gibi veri paketleri için çağırılabilir.

.. code-block:: python

    # Ragele veri yaratma
    data = np.random.randint(0, 256, size=(64, 200, 200, 3)).astype("float32")
    # Verinin 'Model' üzerine gönderilmesi
    processed_data = model(data)
    # Model çıktısının boyutları
    print(processed_data.shape)

.. code-block:: console

    (64, 10)

``Model`` objesinin içinde verinin her bir katmanda nasıl bir değişime uğradığı konsola bastırılabilir. Bu özellik hata ayıklamak için oldukça kullanışlıdır.
Her bir katman için çıktının boyutlarına *paket boyutu* (batch size) bilgisinin de dahil edildiği gözden kaçırılmamalıdır. Paket boyutu, bir katmanın çıktı verisinde kaç veri noktası olduğunu belirtir. 
``None`` modelin katmanlarının bir seferde girdi-çıktı olarak herhangi sayıda veri noktası kullanabileceği anlamına gelir. 

.. code-block:: python

    model.summary()

.. code-block:: console

    Model: "model"
    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    input_1 (InputLayer)         [(None, None, None, 3)]   0         
    _________________________________________________________________
    center_crop_1 (CenterCrop)   (None, 150, 150, 3)       0         
    _________________________________________________________________
    rescaling_1 (Rescaling)      (None, 150, 150, 3)       0         
    _________________________________________________________________
    conv2d (Conv2D)              (None, 148, 148, 32)      896       
    _________________________________________________________________
    max_pooling2d (MaxPooling2D) (None, 49, 49, 32)        0         
    _________________________________________________________________
    conv2d_1 (Conv2D)            (None, 47, 47, 32)        9248      
    _________________________________________________________________
    max_pooling2d_1 (MaxPooling2 (None, 15, 15, 32)        0         
    _________________________________________________________________
    conv2d_2 (Conv2D)            (None, 13, 13, 32)        9248      
    _________________________________________________________________
    global_average_pooling2d (Gl (None, 32)                0         
    _________________________________________________________________
    dense (Dense)                (None, 10)                330       
    =================================================================
    Total params: 19,722
    Trainable params: 19,722
    Non-trainable params: 0
    _________________________________________________________________

Fonksiyonel arayüz kullanılarak birden fazla girdi veya çıktı istenen modeller kolaylıkla oluşturulabilir. Örneğin girdi olarak bir resim *ve* bu resim hakkında veri modele verilebilir veya 
çıktı olarak bir resmin kategorik tahmini ve bir kullanıcının bu resme tıklama ihtimali alınabilir. 


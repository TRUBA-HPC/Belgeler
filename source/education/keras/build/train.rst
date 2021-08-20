=====================
Modellerin Eğitilmesi
=====================
Bu noktaya kadar 

- Girdi verisinin önişleme tabi tutularak model içinde işlenmeyye uygun hale getirilmesi
- Model katmanlarının yaratılması ve ``Model`` objesinin yaratılması 

konularına değindik. Bu kısımda modeli elimizdeki veriyle nasıl eğiteceğimize değineceğiz.

``Model`` objesi içinde önceden tanımlanmış eğitme döngüsü olan ``fit()`` fonksiyonunu barındırmaktadır. ``fit()`` fonksiyonu girdi olarak ``Dataset`` objelerini,
Python generator fonksiyonlarını ve NumPy dizilerini kabul etmektedir. 

``fit()`` fonksiyonu çağırılmadan önce optimizasyon ve kayıp fonksiyonları da ayrıca belirtilmelidir. Bu fonksiyonlar ``compile()`` fonksiyonuna parametre olarak verilir.
Bununla birlikte modelin derlenmesi tamamlanmış olur.

.. code-block:: python

    model.compile(optimizer=keras.optimizers.RMSprop(learning_rate=1e-3),
    loss=keras.losses.CategoricalCrossentropy())

Kayıp ve optimizasyon fonksiyonları string olarak da tanımlanabilir. Bu durumda varsayılan parametleri kullanılacaktır.

.. code-block:: python

    model.compile(optimizer='rmsprop', loss='categorical_crossentropy')

Model bir kez derlendikten sonra eğitilmeye başlanabilir. NumPy dizisi kullanan bir eğitme sekansı aşağıda görülebilir.

.. code-block:: python

    # Modele verilecek veri NumPy dizisiyken değerler ve değerlere ait kategoriler iki ayrı dizi olarak verilmiştir.
    model.fit(numpy_array_of_samples, numpy_array_of_labels,
    batch_size=32, epochs=10)

Modeli eğitmede kullanılacak verinin yanısıra iki önemli parametre daha ``fit()`` fonksiyonuna verilmedilir. Bunlar bir seferde kullanılacak veri noktası sayısı (batch size) ve 
verinin üzerinde kaç iterasyon yapılacağı (epoch) verileridir.

.. code-block:: python

    # Modele değerler ve değerlere ait kategorileri içeren tek bir 'Dataset' objesi verilmiştir.
    model.fit(dataset_of_samples_and_labels, epochs=10)

``Dataset`` objesi veri noktaları hali hazırda paketler (batch) halinde tuttuğundan ``fit()`` fonksiyonuna ayriyeten ``batch_size`` parametresi verilmemiştir.

Aşağıda MNIST sayılar veri setini öğrenebilen bir örnek model gösterilmiştir.

.. code-block:: python

    # Verinin NumPy dizileri olarak alınıp test ve train olarak parçalara ayrılması
    (x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()

    # Model katmanlarının hazırlanması
    # Girdi 28x28 boyutunda bir resim, aynı zamanda RGB matrisi olarak düşünülebilir
    inputs = keras.Input(shape=(28, 28))
    # Matris içindeki değerlerin [0, 1] aralığına ölçeklenmesi
    x = layers.experimental.preprocessing.Rescaling(1.0 / 255)(inputs)
    # 28x28 boyutundaki matrislerin 784 elemanlı bir diziye dönüştürülmesi
    x = layers.Flatten()(x)
    x = layers.Dense(128, activation="relu")(x)
    x = layers.Dense(128, activation="relu")(x)
    outputs = layers.Dense(10, activation="softmax")(x)
    model = keras.Model(inputs, outputs)
    model.summary()

    # Modelin derlenmesi
    model.compile(optimizer="adam", loss="sparse_categorical_crossentropy")

    # Modelin 1 epoch ve NumPy dizisi ile eğitilmesi 
    batch_size = 64
    print("Fit on NumPy data")
    history = model.fit(x_train, y_train, batch_size=batch_size, epochs=1)

    # Modelin 1 epoch ve Dataset objesi ile eğitilmesi
    dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train)).batch(batch_size)
    print("Fit on Dataset")
    history = model.fit(dataset, epochs=1)

.. code-block:: console

    Model: "model_1"
    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    input_2 (InputLayer)         [(None, 28, 28)]          0         
    _________________________________________________________________
    rescaling_2 (Rescaling)      (None, 28, 28)            0         
    _________________________________________________________________
    flatten (Flatten)            (None, 784)               0         
    _________________________________________________________________
    dense_1 (Dense)              (None, 128)               100480    
    _________________________________________________________________
    dense_2 (Dense)              (None, 128)               16512     
    _________________________________________________________________
    dense_3 (Dense)              (None, 10)                1290      
    =================================================================
    Total params: 118,282
    Trainable params: 118,282
    Non-trainable params: 0
    _________________________________________________________________
    Fit on NumPy data
    938/938 [==============================] - 1s 940us/step - loss: 0.4771
    Fit on Dataset
    938/938 [==============================] - 1s 942us/step - loss: 0.1138

``fit()`` fonksiyonu, eğitim sırasında değişenlerin kaydını tutan bir "geçmiş" objesi döndürmektedir. ``history.history`` sözlüğü her epoch için metrikleri tutmaktadır.
Bu örnekte 1 epoch ve yalnızca kayıp metriği olduğu için tek bir kayıp değeri döndürecektir.

.. code-block:: python

    print(history.history)

.. code-block:: console

    {'loss': [0.11384169012308121]}


Performans Metriklerinin İzlenmesi
##################################
Model eğitilirken, *accuracy*, *precision*, *recall* gibi performans metriklerinin gözlemlenebiliyor olması faydalı olacaktır. Bu metriklerin yalnızca eğitme sırasında değil, doğrulama (validation) sırasında da gözlemlenmesi gerekir.


Performans Metrikleri
*********************

Modelin derlenmesi aşamasında ``compile()`` fonksiyonuna aşağıda görülebileceği gibi bir metrik listesi verilebilir.

.. code-block:: python

    model.compile(
    optimizer="adam",
    loss="sparse_categorical_crossentropy",
    metrics=[keras.metrics.SparseCategoricalAccuracy(name="acc")],
    )
    history = model.fit(dataset, epochs=1)

.. code-block:: console

    938/938 [==============================] - 1s 929us/step - loss: 0.0835 - acc: 0.9748


Doğrulama Verisinin ``fit()`` Fonksiyonuna gönderilmesi
*******************************************************

Doğrulama verisi ``fit()`` fonksiyonuna parametre olarak verilip modelin eğitilmesi sırasında performans verileri gözlemlenebilir. Bu durumda, her bir epoch sonunda doğrulama verisinin performansı konsolda gösterilecektir.

.. code-block:: python

    # Test verisi içinden doğrulama verisi seçilmesi
    val_dataset = tf.data.Dataset.from_tensor_slices((x_test, y_test)).batch(batch_size)
    # validation_data parametresi ile doğrulama verisi seçilebilir
    history = model.fit(dataset, epochs=1, validation_data=val_dataset)


.. code-block:: console

    938/938 [==============================] - 1s 1ms/step - loss: 0.0563 - acc: 0.9829 - val_loss: 0.1041 - val_acc: 0.9692


**Callbacks** ile Kontrol Noktalarının Oluşturulması
####################################################

Eğitilmesi birkaç dakikadan uzun sürecek modellerde, eğitilen modeli belli aralıklarla kayıt etmek olası hata durumlarında zaman kaybını engellemek için önemlidir. 
Eğer eğitim sırasında hata ile karşılaşılırsa, kayıtlı kontrol noktalarından biri kullanılıp eğitim ileri sarılabilir. Bu yaklaşım ayrıca bilgisayarlardan bir veya daha fazlasının
hata verme ihtimali her zaman bulunan dağıtık hesaplama yöntemi için de önemlidir. 

**callbacks**, ``fit()`` fonksiyonu tarafından modelin eğitilmesi sırasında iki noktada çağırılabilir:

- Her veri paketinin (batch) başında ve sonunda 
- Her epoch'un başında ve sonunda

Aşağıda **callbacks** kullanılarak modelin her epoch'da kaydedilmesi görülebilir.

.. code-block:: python

    callbacks = [
    keras.callbacks.ModelCheckpoint(
        filepath='path/to/my/model_{epoch}',
        save_freq='epoch')
    ]
    model.fit(dataset, epochs=2, callbacks=callbacks)

**Callbacks** ayrıca modelin eğitilmesinin tamamen otomatik hale getirilmesi, eğitim bitince kullanıcıya mail gönderilmesi gibi pek çok amaçla da kullanılabilir.

**TensorBoard** ile Modelin Eğitilmesi Sürecinin İzlenmesi
##########################################################

Tensorboard, Tensorflow kurulumu ile birlikte gelen, eğitim sürecinin tarayıcı üzerinden daha ergonomik bir şekilde takip edilebilmesini sağlayan bir araçtır.

Tensorboard'un ``fit()`` fonksiyonu ile birlikte kullanılabilmesi için, ``fit()`` fonksiyonuna parametre olarak Tensorboard girdilerinin nerede tutulduğunu belirten 
bir **callbacks** objesi verilmesi yeterlidir. 

.. code-block:: python

    callbacks = [
        keras.callbacks.TensorBoard(log_dir='./logs')
    ]
    model.fit(dataset, epochs=2, callbacks=callbacks)

Daha sonra, ayrı bir terminalden tensorboard aracı başlatılabilir:

.. code-block:: bash

    tensorboard --logdir=./logs

Tensorboard aracının TRUBA cluster'ı üzerinde nasıl kullanıldığı TRUBA Üzerinde Modellerin Çalıştırılması bölümünde detaylı bir biçimde anlatılmıştır.

``fit()`` Fonksiyonu Tamamlandıktan Sonra Test Performansının Ölçülmesi ve Yeni Veri Üzerinde Tahmin Yapma
##########################################################################################################

Modelin eğitimi tamamlandığı zaman ``evaluate()`` fonksiyonu ile performans metrikleri görülebilir.

.. code-block:: python
    
    #Doğrulama veri setinin evaluate fonksiyonu ile modele verilmesi 
    loss, acc = model.evaluate(val_dataset) 
    print("loss: %.2f" % loss)
    print("acc: %.2f" % acc)

.. code-block:: console

    157/157 [==============================] - 0s 688us/step - loss: 0.1041 - acc: 0.9692
    loss: 0.10
    acc: 0.97

Modelin eğitimi tamamlandıktan sonra ``predict()`` fonksiyonu ile tahminlerden oluşan bir NumPy dizisi elde edilebilir.

.. code-block:: python

    predictions = model.predict(val_dataset)
    print(predictions.shape)

.. code-block:: console

    (10000, 10)


Birden Fazla GPU ile Eğitim Sürecinin Hızlandırılması
#####################################################

Keras, ``tf.distribute`` arayüzü ile birden fazla GPU ve dağıtık hesaplama kullanımına olanak sağlamaktadır. Eğer birden fazla GPU kullanılacaksa 
aşağıdaki yol izlenerek model bu GPU'ların hepsi üzerinde aynı anda eğitilebilir.

- Bir ``tf.distribute.MirroredStrategy`` objesi yaratın
- Modeli oluşturma ve derleme adımlarını bu objenin scope'u içerisinde tamamlayın
- ``fit()`` ve ``evaluate()`` fonksiyonlarını önceden olduğu gibi kullanabilirsiniz.

.. code-block:: python

    # Bir MirroredStrategy objesi yaratın.
    strategy = tf.distribute.MirroredStrategy()

    # Obje için bir scope açın
    with strategy.scope():
    # Bir değişken yaratan her satır bu scope'un altına yazılmalıdır. 
    # Bu satırlar model objesinin kendisinin yaratılması, derlenmesi veya 
    # callbacks tanımları olabilir.
        model = Model(...)
        model.compile(...)

    # Model erişim sağlanabilen bütün cihazlar kullanılarak eğitilecektir.
    train_dataset, val_dataset, test_dataset = get_dataset()
    model.fit(train_dataset, epochs=2, validation_data=val_dataset)

    # Modelin performans değerlendirmesi de bütün cihazlar kullanılarak yapılacaktır.
    model.evaluate(test_dataset)   

TRUBA bilgisayarı üzerinde birden fazla GPU'nun nasıl kullanılacağı TRUBA Üzerinde Modellerin Çalıştırılması bölümünde detaylı bir biçimde anlatılmıştır.


Önişleme Adımlarının CPU ve GPU Arasında Asenkronize Şekilde Paylaşılması
#########################################################################

Veri Yükleme ve Önişleme bölümünde resim önişlemeyi ve direkt olarak modelimizin içerisine eklemiştik. Modelin içine dahil edilmiş ön işleme adımları GPU destekli normalizasyon ve kırpma gibi bazı iş yüklerinde 
verimli olsa dahi ``TextVectorization`` gibi işlerde GPU tarafından yürütülmeye uygun olmamakta ve modelin performansını önemli ölçüde düşürebilmektedir. Bu gibi durumlarda asenkron önişleme eğitim sürecini önemli
ölçüde hızlandırabilir.

Asenkron önişleme uygulandığı zaman, modelin veri önişleme katmanları CPU üzerinde tamamlanmakta, hazır olan veri paketleri GPU'da işlenmek üzere önceden 
GPU belleğine kopyalanmakta ve sıraya alınmaktadır. Bu yöntemle ön işleme adımlarının eğitim sürecini bloke etmesinin önüne geçilmekte ve GPU'dan tam verim alınabilmektedir.

Asenkron önişleme uygulamak için veri pipeline'ının arasına bir ``dataset.map`` fonksiyonu eklemek yeterlidir.

.. code-block:: python

    # `string` tipinde örnek veri
    samples = np.array([["This is the 1st sample."], ["And here's the 2nd sample."]])
    labels = [[0], [1]]

    # TextVectorization katmanının hazırlanması
    vectorizer = TextVectorization(output_mode="int")
    vectorizer.adapt(samples)

    # Asenkron önişleme:
    # Önce bir dataset objesi yaratın
    dataset = tf.data.Dataset.from_tensor_slices((samples, labels)).batch(2)
    # Veriye TextVectorization uygulanması
    dataset = dataset.map(lambda x, y: (vectorizer(x), y))
    # 2 boyutundaki paketler halinde önceden GPU belleğine kopyalanması 
    dataset = dataset.prefetch(2)

    # Modelin girdisi tam sayı dizileri olacaktır
    inputs = keras.Input(shape=(None,), dtype="int64")
    x = layers.Embedding(input_dim=10, output_dim=32)(inputs)
    outputs = layers.Dense(1)(x)
    model = keras.Model(inputs, outputs)

    model.compile(optimizer="adam", loss="mse", run_eagerly=True)
    model.fit(dataset)


.. code-block:: console

    1/1 [==============================] - 0s 13ms/step - loss: 0.5028

    <tensorflow.python.keras.callbacks.History at 0x147777490>


Yukarıda verilen kodu ``TextVectorization`` işleminin modelin bir parçası olduğu versiyon ile karşılaştırabilirsiniz. 


.. code-block:: python

    # Our dataset will yield samples that are strings
    dataset = tf.data.Dataset.from_tensor_slices((samples, labels)).batch(2)

    # Our model should expect strings as inputs
    inputs = keras.Input(shape=(1,), dtype="string")
    x = vectorizer(inputs)
    x = layers.Embedding(input_dim=10, output_dim=32)(x)
    outputs = layers.Dense(1)(x)
    model = keras.Model(inputs, outputs)

    model.compile(optimizer="adam", loss="mse", run_eagerly=True)
    model.fit(dataset)


.. code-block:: console

    1/1 [==============================] - 0s 16ms/step - loss: 0.5258

    <tensorflow.python.keras.callbacks.History at 0x1477b1910>

Modeller CPU üzerinde eğitilirken iki yaklaşım arasında performans farkı görülmeyecektir. Ancak modeller GPU kullanılarak eğitiliyorsa asenkron önişlem
eğitim için gereken süreyi önemli ölçüde düşürmektedir. 

Asenkron önişlemin TRUBA bilgisayarı üzerinde nasıl kullanılacağı TRUBA Üzerinde Modellerin Çalıştırılması bölümünde detaylı bir biçimde anlatılmıştır.

Hyperparameter Optimizasyonu ile En Verimli Modelin Bulunması
#############################################################

Üzerinde çalışılan model tamamlandıktan sonra, hyperparameter araması yapılarak katman sayısı, nöral ağ mimarisi vb. seçimler için en iyi seçenekler bulunabilir.

Hyperparameter araması için ``Keras Tuner`` kullanılmaktadır. 

Öncelikle, model tanımı tek bir ``hp`` parametresi alan bir fonksiyonun içine koyulmalıdır. Bu fonksiyonun içinde, optimize edilmek istenen her
değer hyperparameter arama metodları ``hp.Int()`` veya ``hp.Choice()`` ile değiştirilmelidir. 

.. code-block:: python

    def build_model(hp):
        inputs = keras.Input(shape=(784,))
        x = layers.Dense(
        units=hp.Int('units', min_value=32, max_value=512, step=32), activation='relu'))(inputs)
        outputs = layers.Dense(10, activation='softmax')(x)
        model = keras.Model(inputs, outputs)
        model.compile(
        optimizer=keras.optimizers.Adam(
            hp.Choice('learning_rate',
                    values=[1e-2, 1e-3, 1e-4])),
        loss='sparse_categorical_crossentropy',
        metrics=['accuracy'])
    return model

Bu fonksiyon derlenmiş bir model döndürmelidir. Bu adım tamamlandıktan sonra, optimizasyon hedefini ve diğer arama parametlerini içeren bir ``tuner`` objesi
tanımlanmalıdır.

.. code-block:: python

    import keras_tuner

    tuner = keras_tuner.tuners.Hyperband(
        build_model,
        objective='val_loss',
        max_epochs=100,
        max_trials=200,
        executions_per_trial=2,
        directory='my_dir')

Bu adım da tamamlandıktan sonra, ``fit()`` fonksiyonu ile aynı parametleri alan ``search()`` fonksiyonu ile hyperparameter araması başlatılabilir. 

.. code-block:: python

    tuner.search(dataset, validation_data=val_dataset)

Arama tamamlandığı zaman, en iyi modeller görüntülenebilir:

.. code-block:: python

    models = tuner.get_best_models(num_models=2)

Veya sonuçların özeti görülebilir:

.. code-block:: python

    tuner.results_summary()



=====================================================
Uçtan Uca Örnek 1: TRUBA Üzerinde Metin Sınıflandırma
=====================================================

Bu örnekte, bir metin sınıflandırman örneği anlatılmış ve TRUBA bilgisayarı üzerinde nasıl çalıştırılabileceği gösterilmiştir.

Verinin Elde Edilmesi
#####################

Kullanılacak veriyi terminal üzerinden indirip hazır hale getirebilirsiniz:

.. code-block:: bash

    curl -O https://ai.stanford.edu/~amaas/data/sentiment/aclImdb_v1.tar.gz
    tar -xf aclImdb_v1.tar.gz

.. code-block:: console

    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
   100 80.2M  100 80.2M    0     0  45.3M      0  0:00:01  0:00:01 --:--:-- 45.3M


aclImdb klasöründe ``train`` ve ``test`` alt klasörleri bulunmaktadır. ``aclImdb/train/pos`` ve ``aclImdb/train/neg`` klasörlerinin her birinde olumlu veya 
olumsuz görüşler içeren incelemeler bulunmaktadır. 

.. code-block:: bash

    cat aclImdb/train/pos/6248_7.txt

.. admonition:: Çıktı
    :class: dropdown, information

    .. code-block:: console

        Being an Austrian myself this has been a straight knock in my face. Fortunately I don't live nowhere near the place where this movie takes place but unfortunately it portrays everything that the rest of Austria hates about Viennese people (or people close to that region). And it is very easy to read that this is exactly the directors intention: to let your head sink into your hands and say "Oh my god, how can THAT be possible!". No, not with me, the (in my opinion) totally exaggerated uncensored swinger club scene is not necessary, I watch porn, sure, but in this context I was rather disgusted than put in the right context.<br /><br />This movie tells a story about how misled people who suffer from lack of education or bad company try to survive and live in a world of redundancy and boring horizons. A girl who is treated like a whore by her super-jealous boyfriend (and still keeps coming back), a female teacher who discovers her masochism by putting the life of her super-cruel "lover" on the line, an old couple who has an almost mathematical daily cycle (she is the "official replacement" of his ex wife), a couple that has just divorced and has the ex husband suffer under the acts of his former wife obviously having a relationship with her masseuse and finally a crazy hitchhiker who asks her drivers the most unusual questions and stretches their nerves by just being super-annoying.<br /><br />After having seen it you feel almost nothing. You're not even shocked, sad, depressed or feel like doing anything... Maybe that's why I gave it 7 points, it made me react in a way I never reacted before. If that's good or bad is up to you!


Sadece ``pos`` ve ``neg`` klasörlerine ihtiyacımız olduğu için geri kalan dosyaları silebiliriz.

.. code-block:: bash

    rm -r aclImdb/train/unsup    


Verinin Okunması
################


Elimizdeki veri seti hali hazırda yapılandırılmış olduğundan ``tf.keras.preprocessing.text_dataset_from_directory`` fonksiyonunu kullanarak 
kategori değerleri verilmiş bir ``tf.data.Dataset`` objesi elde edebiliriz. 

Bunu ayrıca training (eğitme), validation (doğrulama) ve test veri setlerini yaratmak için de kullanabiliriz. Validation ve training veri setlerini ``train`` klasörünün 
%80'ini training, %20'sini validation olmak üzere ayıralım. Validation veri setine sahip olmak, eğittiğimiz modelin parametlerini optimize edebilmemiz için gereklidir. Ancak
hiperparametreler seçilip modelin kullanıma sunulmasından önce training ve validation setlerinin tamamını modeli eğitmek için kullanmak modelin performansını arttıracaktır.

``validation_split`` ve ``subset`` parametleri veri setlerini ayırmak için kullanılırken ``seed`` parametresi için de rasgele seçilmiş bir değer iki veri seti için de 
kullanılmalı ya da ``shuffle=False`` parametresi de ``tf.keras.preprocessing.text_dataset_from_directory`` fonksiyonuna verilmelidir. Aksi halde ``train`` ve ``test`` veri setlerinin
aynı verileri kullanıp diskteki verilerin bir kısmını hiç okumaması durumuyla karşılaşılabilir.


.. code-block:: python

    import text_dataset ##Notu kontrol edin
    import tensorflow as tf
    import numpy as np

    batch_size = 32
    raw_train_ds = tf.keras.preprocessing.text_dataset_from_directory(
    "aclImdb/train",
    batch_size=batch_size,
    validation_split=0.2,
    subset="training",
    seed=1337, 
    )

    raw_val_ds = tf.keras.preprocessing.text_dataset_from_directory(
    "aclImdb/train",
    batch_size=batch_size,
    validation_split=0.2,
    subset="validation",
    seed=1337,
    )

    raw_test_ds = tf.keras.preprocessing.text_dataset_from_directory(
    "aclImdb/test", batch_size=batch_size
    )

    print(
    "Number of batches in raw_train_ds: %d"
    % tf.data.experimental.cardinality(raw_train_ds)
    )

    print(
    "Number of batches in raw_val_ds: %d" % tf.data.experimental.cardinality(raw_val_ds)
    )

    print(
    "Number of batches in raw_test_ds: %d"
    % tf.data.experimental.cardinality(raw_test_ds)
    )

.. admonition:: Çıktı
    :class: dropdown, information

    .. code-block:: console

        Found 25000 files belonging to 2 classes.
        Using 20000 files for training.
        Found 25000 files belonging to 2 classes.
        Using 5000 files for validation.
        Found 25000 files belonging to 2 classes.
        Number of batches in raw_train_ds: 625
        Number of batches in raw_val_ds: 157
        Number of batches in raw_test_ds: 782



.. note::
    ``tf.keras.preprocessing.text_dataset_from_directory`` fonksiyonu eğitimde kullanılan Keras versiyonunda bilinen bir bug içerdiğinden ``text_dataset.py``
    klasöre kopyalanıp kullanılmıştır. `Kullanılan dosya bu adreste bulunabilir <https://github.com/tensorflow/tensorflow/blob/v2.5.0/tensorflow/python/keras/preprocessing/
    text_dataset.py#L26-L171>`_
    

.. code-block:: python

    # Okunan verinin eğitim için kullanılmasından önce, bir kısmının kontrol edilmesi 
    # oluşabilecek hataları önlemek için önemlidir. Okunan tensörler .numpy() fonksiyonu ile görülebilir.
    for text_batch, label_batch in raw_train_ds.take(1):
    for i in range(5):
        print(text_batch.numpy()[i])
        print(label_batch.numpy()[i])

.. admonition:: Çıktı
    :class: dropdown, information
    
    .. code-block:: console

        b'I\'ve seen tons of science fiction from the 70s; some horrendously bad, and others thought provoking and truly frightening. Soylent Green fits into the latter category. Yes, at times it\'s a little campy, and yes, the furniture is good for a giggle or two, but some of the film seems awfully prescient. Here we have a film, 9 years before Blade Runner, that dares to imagine the future as somthing dark, scary, and nihilistic. Both Charlton Heston and Edward G. Robinson fare far better in this than The Ten Commandments, and Robinson\'s assisted-suicide scene is creepily prescient of Kevorkian and his ilk. Some of the attitudes are dated (can you imagine a filmmaker getting away with the "women as furniture" concept in our oh-so-politically-correct-90s?), but it\'s rare to find a film from the Me Decade that actually can make you think. This is one I\'d love to see on the big screen, because even in a widescreen presentation, I don\'t think the overall scope of this film would receive its due. Check it out.'
        1
        b'First than anything, I\'m not going to praise I\xc3\xb1arritu\'s short film, even I\'m Mexican and proud of his success in mainstream Hollywood.<br /><br />In another hand, I see most of the reviews focuses on their favorite (and not so) short films; but we are forgetting that there is a subtle bottom line that circles the whole compilation, and maybe it will not be so pleasant for American people. (Even if that was not the main purpose of the producers) <br /><br />What i\'m talking about is that most of the short films does not show the suffering that WASP people went through because the terrorist attack on September 11th, but the suffering of the Other people.<br /><br />Do you need proofs about what i\'m saying? Look, in the Bosnia short film, the message is: "You cry because of the people who died in the Towers, but we (The Others = East Europeans) are crying long ago for the crimes committed against our women and nobody pay attention to us like the whole world has done to you".<br /><br />Even though the Burkina Fasso story is more in comedy, there is a the same thought: "You are angry because Osama Bin Laden punched you in an evil way, but we (The Others = Africans) should be more angry, because our people is dying of hunger, poverty and AIDS long time ago, and nobody pay attention to us like the whole world has done to you".<br /><br />Look now at the Sean Penn short: The fall of the Twin Towers makes happy to a lonely (and alienated) man. So the message is that the Power and the Greed (symbolized by the Towers) must fall for letting the people see the sun rise and the flowers blossom? It is remarkable that this terrible bottom line has been proposed by an American. There is so much irony in this short film that it is close to be subversive.<br /><br />Well, the Ken Loach (very know because his anti-capitalism ideology) is much more clearly and shameless in going straight to the point: "You are angry because your country has been attacked by evil forces, but we (The Others = Latin Americans) suffered at a similar date something worst, and nobody remembers our grief as the whole world has done to you".<br /><br />It is like if the creative of this project wanted to say to Americans: "You see now, America? You are not the only that have become victim of the world violence, you are not alone in your pain and by the way, we (the Others = the Non Americans) have been suffering a lot more than you from long time ago; so, we are in solidarity with you in your pain... and by the way, we are sorry because you have had some taste of your own medicine" Only the Mexican and the French short films showed some compassion and sympathy for American people; the others are like a slap on the face for the American State, that is not equal to American People.'
        1
        b'Blood Castle (aka Scream of the Demon Lover, Altar of Blood, Ivanna--the best, but least exploitation cinema-sounding title, and so on) is a very traditional Gothic Romance film. That means that it has big, creepy castles, a headstrong young woman, a mysterious older man, hints of horror and the supernatural, and romance elements in the contemporary sense of that genre term. It also means that it is very deliberately paced, and that the film will work best for horror mavens who are big fans of understatement. If you love films like Robert Wise\'s The Haunting (1963), but you also have a taste for late 1960s/early 1970s Spanish and Italian horror, you may love Blood Castle, as well.<br /><br />Baron Janos Dalmar (Carlos Quiney) lives in a large castle on the outskirts of a traditional, unspecified European village. The locals fear him because legend has it that whenever he beds a woman, she soon after ends up dead--the consensus is that he sets his ferocious dogs on them. This is quite a problem because the Baron has a very healthy appetite for women. At the beginning of the film, yet another woman has turned up dead and mutilated.<br /><br />Meanwhile, Dr. Ivanna Rakowsky (Erna Sch\xc3\xbcrer) has appeared in the center of the village, asking to be taken to Baron Dalmar\'s castle. She\'s an out-of-towner who has been hired by the Baron for her expertise in chemistry. Of course, no one wants to go near the castle. Finally, Ivanna finds a shady individual (who becomes even shadier) to take her. Once there, an odd woman who lives in the castle, Olga (Cristiana Galloni), rejects Ivanna and says that she shouldn\'t be there since she\'s a woman. Baron Dalmar vacillates over whether she should stay. She ends up staying, but somewhat reluctantly. The Baron has hired her to try to reverse the effects of severe burns, which the Baron\'s brother, Igor, is suffering from.<br /><br />Unfortunately, the Baron\'s brother appears to be just a lump of decomposing flesh in a vat of bizarre, blackish liquid. And furthermore, Ivanna is having bizarre, hallucinatory dreams. Just what is going on at the castle? Is the Baron responsible for the crimes? Is he insane? <br /><br />I wanted to like Blood Castle more than I did. As I mentioned, the film is very deliberate in its pacing, and most of it is very understated. I can go either way on material like that. I don\'t care for The Haunting (yes, I\'m in a very small minority there), but I\'m a big fan of 1960s and 1970s European horror. One of my favorite directors is Mario Bava. I also love Dario Argento\'s work from that period. But occasionally, Blood Castle moved a bit too slow for me at times. There are large chunks that amount to scenes of not very exciting talking alternated with scenes of Ivanna slowly walking the corridors of the castle.<br /><br />But the atmosphere of the film is decent. Director Jos\xc3\xa9 Luis Merino managed more than passable sets and locations, and they\'re shot fairly well by Emanuele Di Cola. However, Blood Castle feels relatively low budget, and this is a Roger Corman-produced film, after all (which usually means a low-budget, though often surprisingly high quality "quickie"). So while there is a hint of the lushness of Bava\'s colors and complex set decoration, everything is much more minimalist. Of course, it doesn\'t help that the Retromedia print I watched looks like a 30-year old photograph that\'s been left out in the sun too long. It appears "washed out", with compromised contrast.<br /><br />Still, Merino and Di Cola occasionally set up fantastic visuals. For example, a scene of Ivanna walking in a darkened hallway that\'s shot from an exaggerated angle, and where an important plot element is revealed through shadows on a wall only. There are also a couple Ingmar Bergmanesque shots, where actors are exquisitely blocked to imply complex relationships, besides just being visually attractive and pulling your eye deep into the frame.<br /><br />The performances are fairly good, and the women--especially Sch\xc3\xbcrer--are very attractive. Merino exploits this fact by incorporating a decent amount of nudity. Sch\xc3\xbcrer went on to do a number of films that were as much soft corn porn as they were other genres, with English titles such as Sex Life in a Woman\'s Prison (1974), Naked and Lustful (1974), Strip Nude for Your Killer (1975) and Erotic Exploits of a Sexy Seducer (1977). Blood Castle is much tamer, but in addition to the nudity, there are still mild scenes suggesting rape and bondage, and of course the scenes mixing sex and death.<br /><br />The primary attraction here, though, is probably the story, which is much a slow-burning romance as anything else. The horror elements, the mystery elements, and a somewhat unexpected twist near the end are bonuses, but in the end, Blood Castle is a love story, about a couple overcoming various difficulties and antagonisms (often with physical threats or harms) to be together.'
        1
        b"I was talked into watching this movie by a friend who blubbered on about what a cute story this was.<br /><br />Yuck.<br /><br />I want my two hours back, as I could have done SO many more productive things with my time...like, for instance, twiddling my thumbs. I see nothing redeeming about this film at all, save for the eye-candy aspect of it...<br /><br />3/10 (and that's being generous)"
        0
        b"Michelle Rodriguez is the defining actress who could be the charging force for other actresses to look out for. She has the audacity to place herself in a rarely seen tough-girl role very early in her career (and pull it off), which is a feat that should be recognized. Although her later films pigeonhole her to that same role, this film was made for her ruggedness.<br /><br />Her character is a romanticized student/fighter/lover, struggling to overcome her disenchanted existence in the projects, which is a little overdone in film...but not by a girl. That aspect of this film isn't very original, but the story goes in depth when the heated relationships that this girl has to deal with come to a boil and her primal rage takes over.<br /><br />I haven't seen an actress take such an aggressive stance in movie-making yet, and I'm glad that she's getting that original twist out there in Hollywood. This film got a 7 from me because of the average story of ghetto youth, but it has such a great actress portraying a rarely-seen role in a minimal budget movie. Great work."
        1



Verinin Hazırlanması
####################

Veriyi kontrol ettiğimiz kısma dikkat edilirse, metin verisinin içinde ``<br />`` etikletlerinin olduğu görülebilir. Veriyi işleyebilmek için bunların veri setinden 
temizlenmesi gerekmektedir. 

.. code-block:: python 

    from tensorflow.keras.layers.experimental.preprocessing import TextVectorization
    import string
    import re

    def custom_standardization(input_data):
        lowercase = tf.strings.lower(input_data)
        stripped_html = tf.strings.regex_replace(lowercase, "<br />", " ")
        return tf.strings.regex_replace(
            stripped_html, "[%s]" % re.escape(string.punctuation), ""
        )


    # Model parametleri.
    max_features = 20000
    embedding_dim = 128
    sequence_length = 500


    # <br /> etiketlerini temizlemek için yazdığımız için custom_standardization() 
    # fonksiyonu verinin vektörize edileceği katmanda kullanılabilir. 
    # Bu katmanda elimizdeki metin verisini normalize edip, bölüp tam sayılara dönüştürmemiz gerekmektedir.
    vectorize_layer = TextVectorization(
        standardize=custom_standardization,
        max_tokens=max_features,
        output_mode="int",
        output_sequence_length=sequence_length,
    )
    # Elimizdeki veriyi bir sözlüğe (vocab) dönüştürelim.

    # Kategori değerlerinin silinip 
    # sadece metinden oluşan bir veri setinin elde edilmesi.
    text_ds = raw_train_ds.map(lambda x, y: x)
    
    # adapt() fonksiyonunu bu veri seti üzerinde çağırmak, kelimeleri indeksleyerek bir sözlük üretecektir:
    vectorize_layer.adapt(text_ds)


Veriyi Vektörize Etme Seçenekleri
#################################

Veriyi eğitim için kullanmadan önce vektörize etmemiz gerektiğinden bahsetmiştik. Veriyi vektörize etmek için elimizde iki seçenek bulunmaktadır:

**1: Vektörizasyonun Modelin Bir Parçası Olarak Tanımlanması**
Vektörizasyon katmanını modelin bir parçası yaparak ``string`` veri tipinde girdi alan bir model elde edilebilir.

.. code-block:: python

    text_input = tf.keras.Input(shape=(1,), dtype=tf.string, name=text)
    x = vectorize_layer(text_input)
    x = layers.Embedding(max_features + 1, embedding_dim)(x)
    ...

**2: Vektörizasyonun Veri Setine Uygulanması**
Elimizdeki metin verisi indekslenerek girdi olarak tam sayı dizisi bekleyen bir modele verilebilir. 

İlk seçenekle ikinci seçenek arasındaki en büyük fark, ikinci seçeneğin CPU ve GPU işlemcileri arasında asenkron işleme ve transfer yapmaya müsaade etmesidir.
Eğer modelimizi GPU kullanarak eğitmek istiyorsak, vektörizasyon işlemi için ikinci seçeneği kullanmak büyük performans artışı sağlayacaktır.

.. code-block:: python

    def vectorize_text(text, label):
        text = tf.expand_dims(text, -1)
        return vectorize_layer(text), label


    # Verinin vektörize edilmesi
    train_ds = raw_train_ds.map(vectorize_text)
    val_ds = raw_val_ds.map(vectorize_text)
    test_ds = raw_test_ds.map(vectorize_text)

    # Vektörize edilmiş verinin asıl hesaplama (fit) adımı başlamadan önce GPU belleğine kopyalanması.
    train_ds = train_ds.cache().prefetch(buffer_size=10)
    val_ds = val_ds.cache().prefetch(buffer_size=10)
    test_ds = test_ds.cache().prefetch(buffer_size=10)

Modelin Oluşturulması
#####################

.. code-block:: python

    from tensorflow.keras import layers

    # Girdi uzunluğu belli olmayan bir tam sayı dizisi 
    inputs = tf.keras.Input(shape=(None,), dtype="int64")

    # Embedding katmanının eklenmesi
    x = layers.Embedding(max_features, embedding_dim)(inputs)
    x = layers.Dropout(0.5)(x)

    # Conv1D + global max pooling
    # Conv1D ve global max pooling katmanlarının eklenmesi
    x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
    x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
    x = layers.GlobalMaxPooling1D()(x)

    # We add a vanilla hidden layer:
    # Hidden layer'ın eklenmesi
    x = layers.Dense(128, activation="relu")(x)
    x = layers.Dropout(0.5)(x)

    # Çıktı katmanı, bu katmandan sadece 1 veya 0 değerleri elde etmek istediğimiz için bu örnek için ayrı bir 'classifier' katmanına ihtiyaç duyulmamaktadır.
    # Bunun yerine çıkan değer sigmoid aktivasyon fonksiyonu ile belirlenmektedir.
    predictions = layers.Dense(1, activation="sigmoid", name="predictions")(x)

    model = tf.keras.Model(inputs, predictions)

    # Modelin derlenmesi
    model.compile(loss="binary_crossentropy", optimizer="adam", metrics=["accuracy"])

Modelin Eğitilmesi
##################

.. code-block:: python

    epochs = 3
    model.fit(train_ds, validation_data=val_ds, epochs=epochs)

.. admonition:: Çıktı
    :class: dropdown, information
    
    .. code-block:: console

        Epoch 1/3
        625/625 [==============================] - 32s 51ms/step - loss: 0.6288 - accuracy: 0.5835 - val_loss: 0.3283 - val_accuracy: 0.8610
        Epoch 2/3
        625/625 [==============================] - 31s 50ms/step - loss: 0.2808 - accuracy: 0.8859 - val_loss: 0.3005 - val_accuracy: 0.8796
        Epoch 3/3
        625/625 [==============================] - 31s 50ms/step - loss: 0.1450 - accuracy: 0.9467 - val_loss: 0.3795 - val_accuracy: 0.8726
    
        <tensorflow.python.keras.callbacks.History at 0x137444c90>


Modelin Başarısının Değerlendirilmesi
#####################################

.. code-block:: python

    model.evaluate(test_ds)

.. admonition:: Çıktı
    :class: dropdown, information
    
    .. code-block:: console

        782/782 [==============================] - 7s 9ms/step - loss: 0.3999 - accuracy: 0.8650

        [0.39986345171928406, 0.8649600148200989]



TRUBA Üzerinde Birden Fazla GPU ile Çalışmak
############################################

TRUBA üzerinde hazırladığımız modelin birden fazla GPU ile çalışabilmesi için daha önce de bahsedildiği gibi sadece **model değişkenlerinin** strategy scope'u içerisinde yaratılması yeterlidir.

Öncelikle TensorFlow için GPU kullanımını aktive edin:

.. code-block:: python

    os.environ['TF_XLA_FLAGS'] = '--tf_xla_enable_xla_devices'
    # Bu satırla kaç adet GPU'nun kullanıma hazır olduğunu görebilirsiniz.
    print("GPUs: ", len(tf.config.experimental.list_physical_devices('GPU')))

Bir **strategy** objesi yaratın:

.. code-block:: python

    strategy = tf.distribute.MirroredStrategy()
    # Verinin kaç kopyasını oluşturduğunuzu bu satır ile görebilirsiniz.
    # Bu satırın çıktısının GPU ile aynı olmaması durumunda loss fonksiyonu yanlış sonuç döndürecektir.
    print("Number of devices: {}".format(strategy.num_replicas_in_sync))

Bir model değişkeni içeren her satırı yarattığınız objenin scope'unda yazın:

.. code-block:: python
    
    with strategy.scope():
                                                  
        inputs = tf.keras.Input(shape=(None,), dtype="int64")
                                                                         
        x = layers.Embedding(max_features, embedding_dim)(inputs)
        x = layers.Dropout(0.5)(x)
                                                           
        x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
        x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
        x = layers.GlobalMaxPooling1D()(x)
                                                         
        x = layers.Dense(128, activation="relu")(x)
        x = layers.Dropout(0.5)(x)
          
        predictions = layers.Dense(1, activation="sigmoid", name="predictions")(x)

        model = tf.keras.Model(inputs, predictions)
              
        model.compile(loss="binary_crossentropy", optimizer="adam", metrics=["accuracy"])


BETİK DOSYASININ HAZIRLANMASI
#############################

İşinizi kuyruğa göndermek için hazırlamanız gereken betik dosyası aşağıdaki gibidir:

.. code-block:: bash

    #!/bin/bash
    #SBATCH -J text_gpu             #sırada görünmek üzere kuyruğa yolladığınız işe bir isim verin
    #SBATCH -A kullanıcı_adınız     #kullanıcı adınızı girin
    #SBATCH -p akya-cuda            #işin yollanacağı kuyruğu girin
    #SBATCH --nodes=1               #işin toplamda çalışacağı node sayısını girin
    #SBATCH --ntasks=1              #toplam iş parçacığı sayısını girin. Bu örnekte bir node üzerinde bir iş parçacığı çalıştıracağız.
    #SBATCH --gres=gpu:2            #toplam kaç adet GPU istediğinizi girin
    #SBATCH --cpus-per-task=1       #iş parçacığı başına kaç çekirdek istediğinizi girin
    #SBATCH --time=00:15:00         #işin çalışacağı maksimum süreyi girin, bu değeri doğru girmek önemlidir, aksi halde işiniz kuyrukta askıda kalabilir.

    module purge #Olası hataları önlemek için bütün ortam modüllerini temizleyin
    eval "$(/truba/home/ftasyaran/miniconda3/bin/conda shell.bash hook)" #Conda komutlarını aktif hale getirin
    conda activate tf-gpu-env #Yarattığınız conda ortamını aktive edin 
    module load centos7.9/lib/cuda/11.4 #CUDA modülünü yükleyin

    python3 text_classification_gpu.py 

Bu örnekte anlatılan kodun tamamını aşağıda bulabilirsiniz:

.. code-block:: python

    """                                                                                            
    Title: Text classification from scratch                                                        
    Authors: Mark Omernick, Francois Chollet                                                       
    Date created: 2019/11/06                                                                       
    Last modified: 2021/08/10 ~ For this education material                                                                      
    Description: Text sentiment classification starting from raw text files.                       
    """                                                                                           


    import text_dataset
    import tensorflow as tf
    import numpy as np

    import os

    from tensorflow.keras.layers.experimental.preprocessing import TextVectorization
    import string
    import re

    from tensorflow.keras import layers

    os.environ['TF_XLA_FLAGS'] = '--tf_xla_enable_xla_devices'
    print("GPUs: ", len(tf.config.experimental.list_physical_devices('GPU')))                                                                                                                                               

    from tensorflow.python.client import device_lib
    print(device_lib.list_local_devices())
                                                                 
    strategy = tf.distribute.MirroredStrategy()
    print("Number of devices: {}".format(strategy.num_replicas_in_sync))

    batch_size = 32
    raw_train_ds = tf.keras.preprocessing.text_dataset_from_directory(
        "aclImdb/train",
        batch_size=batch_size,
        validation_split=0.2,
        subset="training",
        seed=1337,
    )

    raw_val_ds = tf.keras.preprocessing.text_dataset_from_directory(
        "aclImdb/train",
        batch_size=batch_size,
        validation_split=0.2,
        subset="validation",
        seed=1337,
    )

    raw_test_ds = tf.keras.preprocessing.text_dataset_from_directory(
        "aclImdb/test", batch_size=batch_size
    )

    print(
        "Number of batches in raw_train_ds: %d"
        % tf.data.experimental.cardinality(raw_train_ds)
    )

    print(
        "Number of batches in raw_val_ds: %d" % tf.data.experimental.cardinality(raw_val_ds)
    )

    print(
        "Number of batches in raw_test_ds: %d"
        % tf.data.experimental.cardinality(raw_test_ds)
    )
                                                
    def custom_standardization(input_data):
        lowercase = tf.strings.lower(input_data)
        stripped_html = tf.strings.regex_replace(lowercase, "<br />", " ")
        return tf.strings.regex_replace(
            stripped_html, "[%s]" % re.escape(string.punctuation), ""
        )
                                                                          
    max_features = 20000
    embedding_dim = 128
    sequence_length = 500
                                                      
    vectorize_layer = TextVectorization(
        standardize=custom_standardization,
        max_tokens=max_features,
        output_mode="int",
        output_sequence_length=sequence_length,
    )
                                                 
    text_ds = raw_train_ds.map(lambda x, y: x)                                                                          
    vectorize_layer.adapt(text_ds)

    def vectorize_text(text, label):
        text = tf.expand_dims(text, -1)
        return vectorize_layer(text), label

    train_ds = raw_train_ds.map(vectorize_text)
    val_ds = raw_val_ds.map(vectorize_text)
    test_ds = raw_test_ds.map(vectorize_text)
            
    train_ds = train_ds.cache().prefetch(buffer_size=10)
    val_ds = val_ds.cache().prefetch(buffer_size=10)
    test_ds = test_ds.cache().prefetch(buffer_size=10)


    with strategy.scope():
                                                    
        inputs = tf.keras.Input(shape=(None,), dtype="int64")
                                                                    
        x = layers.Embedding(max_features, embedding_dim)(inputs)
        x = layers.Dropout(0.5)(x)
                                                           
        x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
        x = layers.Conv1D(128, 7, padding="valid", activation="relu", strides=3)(x)
        x = layers.GlobalMaxPooling1D()(x)
                                                       
        x = layers.Dense(128, activation="relu")(x)
        x = layers.Dropout(0.5)(x)
             
        predictions = layers.Dense(1, activation="sigmoid", name="predictions")(x)

        model = tf.keras.Model(inputs, predictions)

        model.compile(loss="binary_crossentropy", optimizer="adam", metrics=["accuracy"])

    epochs = 3
    model.fit(train_ds, validation_data=val_ds, epochs=epochs)
    model.evaluate(test_ds)

    


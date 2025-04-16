==========================================
Keras Nöral Ağına Kuantum Katmanı Eklemek
==========================================
		
.. warning::
    Belgenin geri kalanda ev dizinine Miniconda kurulumu yapılmış kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :ref:`miniconda-kurulum` takip ederek yapabilirsiniz. 

    Merkezi anaconda kullanımı hakkındaki bilgiye ulaşmak için :ref:`tıklayınız... <merkezi-anaconda>`.
    
Mevcut shell oturumunuzda conda’nın temel ortamını etkinleştirin:

.. code-block:: bash
    
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

Conda kullanarak sanal ortam yaratın ve yarattığınız ortamı aktifleştirin.

.. code-block:: bash
    
    conda create --name qnn-keras-env
    conda activate qnn-keras-env
    conda list


.. warning::
    Adımları takip edebilmek için gerekli olan Tensorflow paketini yüklemek için :ref:`deep-learning-virtual-env`  PennyLane paketinin kurulumu için de :ref:`qcomp_setup`  sayfasına göz atabilirsiniz.
    
.. warning::
    Ayrıca gerekli olan scikit-learn kütüphanesini aşağıdaki gibi kurabilirsiniz.
    
    .. code-block:: bash
    
       pip install -U scikit-learn

.. note::
    İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz:

    .. code-block:: bash

        conda deactivate
        conda remove -n qnn-keras-env--all
        conda create --name qnn-keras-env
        conda activate qnn-keras-env

Klasik Keras Katmanlarından oluşan bir nöral ağ oluşturma
==========================================================

Burada PennyLane kütüphanesindeki bir Quantum Node'un nasıl Keras kütüphanesindeki bir layer olarak eklendiğine yönelik bir örnek gösteriliyor. Keras hakkında detaylı bilgi için :ref:`keras_intro` eğitim materyaline bakabilirsiniz.

Aşağıdaki gibi kuantum katmanı içermeyen ikili sınıflandırmada kullanabileceğimiz 2 katmanlı bir network oluşturabiliriz.

.. code-block:: python

    import tensorflow as tf

    tf.keras.backend.set_floatx('float64')

    layer_1 = tf.keras.layers.Dense(2)
    layer_2 = tf.keras.layers.Dense(2, activation="softmax")

    model = tf.keras.Sequential([layer_1, layer_2])
    model.compile(loss="mae")

Şimdi bu katmanlı yapının içine nasıl kuantum katmanı da ekleyebileceğimizi göreceğiz.

Veri Kümesini Hazırlama
==================================

Burada kolay anlaşılması için basit bir veri kümesi olan ``scikit-learn`` içindeki ``make_moons`` veri kümesini kullanarak ikili sınıflandırma yapacağız.

.. code-block:: python

    import numpy as np
    from sklearn.datasets import make_moons

    # Rastgele sayılar için tohum değerlerini belirleme
    np.random.seed(42)
    tf.random.set_seed(42)

    X, y = make_moons(n_samples=200, noise=0.1)
    y_hot = tf.keras.utils.to_categorical(y, num_classes=2)  # one-hot encoding ile kodlanmış etiketler


Quantum Node Oluşturma
======================

PennyLane kütüphanesi içindeki herhangi bir cihaz, operasyon veya ölçüm Quantum Node oluştururken kullanılabilir. Ancak, Quantum Node'u keras katmanına çevirebilmemiz için Quantum Node ``inputs`` isimli bir argümana sahip olmalı ve ayrıca diğer bütün argümanları array veya tensör olmalıdır. Bu diğer argümanlar eğitilebilir ağırlık olarak kullanılacak. Biz ``templates`` modülündeki ``default.qubit`` simülatorünü ve operasyonları kullanrak 2 kübit bulunan bir node oluşturuyoruz.

.. note::
    Templates hakkında daha fazla bilgi için `dokümantasyon <https://pennylane.readthedocs.io/en/latest/introduction/templates.html>`_ sayfasını ziyaret edebilirsiniz.


.. code-block:: python

    import pennylane as qml

    n_qubits = 2
    dev = qml.device("default.qubit", wires=n_qubits)

    @qml.qnode(dev)
    def qnode(inputs, weights):
        qml.AngleEmbedding(inputs, wires=range(n_qubits))
        qml.BasicEntanglerLayers(weights, wires=range(n_qubits))
        return [qml.expval(qml.PauliZ(wires=i)) for i in range(n_qubits)]


Quantum Node'u Keras Katmanına Çevirme
=========================================

Bu işlem için Quantum Node'a argüman olarak gelen tüm eğitilebilir ağırlıkların şeklini belirtmemiz gerekiyor. Bu işlem için bir dictionary argüman isimlerini onların şekillerine map'leyen bir dictionary kullanabiliriz.

.. code-block:: python

    n_layers = 6
    weight_shapes = {"weights": (n_layers, n_qubits)}

Bizim örneğimizdeki ``weights`` argümanının şekli (n_layers, n_qubits) olarak ``BasicEntanglerLayers()`` 'a aktarıldı. Dictionary'mizi oluşturduktan sonra kolay bir şekilde Quantum Node'umuzu bir Keras katmanına çevirebiliriz.


.. code-block:: python

    qlayer = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)

Sıralı Hibrit Model Oluşturma
==============================

Sayfanın en başındaki iki katmanlı network yapısının arasına kuantum katmanı eklenmiş halini aşağıdaki gibi oluşturabiliriz:

#. 2 nöronlu tamamen bağlı klasik katman
#. Bizim 2 kübitlik Quantum Node'dan çevirerek oluşturduğumuz kuantum katman
#. Başka bir tane daha 2 nöronlu tamamen bağlı klasik katman
#. Olasılık vektörüne çevirmek için ``softmax`` aktivasyonu


.. code-block:: python

    clayer_1 = tf.keras.layers.Dense(2)
    clayer_2 = tf.keras.layers.Dense(2, activation="softmax")
    model = tf.keras.models.Sequential([clayer_1, qlayer, clayer_2])

Burada clayer'lar klasik katmanları qlayer ise kuantum katmanını gösteriyor. Böylece iki klasik katman arasına bir kuantum katmanını eklemiş olduk.

Sıralı Modeli Eğitme
=====================

Biz bu örnek için standart ``SGD optimizer`` 'ını ve ``mean absolute error`` loss function'ını kullanarak modelimizi eğiteceğiz ancak bu seçimlerin farklı kombinasyonları da tabii ki kullanılabilir.

.. code-block:: python

    opt = tf.keras.optimizers.SGD(learning_rate=0.2)
    model.compile(opt, loss="mae", metrics=["accuracy"])

    fitting = model.fit(X, y_hot, epochs=6, batch_size=5, validation_split=0.25, verbose=2)

Sıralı Model Kodunun Tam Hali
=============================

``sequential_qnn.py``

.. code-block:: python

    import tensorflow as tf
    import pennylane as qml
    import numpy as np
    from sklearn.datasets import make_moons

    tf.keras.backend.set_floatx('float64')

    # Rastgele sayılar için tohum değerlerini belirleme
    np.random.seed(42)
    tf.random.set_seed(42)

    X, y = make_moons(n_samples=200, noise=0.1)
    y_hot = tf.keras.utils.to_categorical(y, num_classes=2)  # one-hot encoding ile kodlanmış etiketler

    n_qubits = 2
    dev = qml.device("default.qubit", wires=n_qubits)

    # Quantum Node oluşturma
    @qml.qnode(dev)
    def qnode(inputs, weights):
        qml.AngleEmbedding(inputs, wires=range(n_qubits))
        qml.BasicEntanglerLayers(weights, wires=range(n_qubits))
        return [qml.expval(qml.PauliZ(wires=i)) for i in range(n_qubits)]

    n_layers = 6
    weight_shapes = {"weights": (n_layers, n_qubits)}

    # Quantum Node'u kuantum katmanına çevirme
    qlayer = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)

    # Klasik katmanları oluşturarak modeli yaratma 
    clayer_1 = tf.keras.layers.Dense(2)
    clayer_2 = tf.keras.layers.Dense(2, activation="softmax")
    model = tf.keras.models.Sequential([clayer_1, qlayer, clayer_2])

    # Modeli eğitme
    opt = tf.keras.optimizers.SGD(learning_rate=0.2)
    model.compile(opt, loss="mae", metrics=["accuracy"])
    fitting = model.fit(X, y_hot, epochs=6, batch_size=5, validation_split=0.25, verbose=2)



Sıralı Olmayan Hibrit Model Oluşturma
=====================================

Sıralı katmanlar kullanarak oluşturulan modeller yaygın ve işlevli olsa da bazı durumlarda biz modelin nasıl inşa edildiği hakkında daha fazla kontrole sahip olmak isteriz. Örneğin, bazı durumlarda bi katmandaki çıktıları birden fazla katmana dağıtmak isteyebiliriz. Bunun için sıralı olmayan modelleri kullanabiliriz.


Biz aşağıdaki yapıdaki bir hibrit model oluşturmak istiyoruz:

#. 4 nöronlu tamamen bağlı klasik katman
#. Önceki klasik katmanın ilk 2 nöronuyla bağlı 2 kübitlik kuantum katman
#. Önceki klasik katmanın son 2 nöronuyla bağlı 2 kübitlik kuantum katman
#. Önceki kuantum katmanlarının kombinasyonundan 4 boyutlu bir girdi alan 2 nöronlu tamamen bağlı klasik katman
#. Olasılık vektörüne çevirmek için ``softmax`` aktivasyonu


.. code-block:: python

    # Katmanları tanımlama
    clayer_1 = tf.keras.layers.Dense(4)
    qlayer_1 = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)
    qlayer_2 = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)
    clayer_2 = tf.keras.layers.Dense(2, activation="softmax")

    # Modeli oluşturma
    inputs = tf.keras.Input(shape=(2,))
    x = clayer_1(inputs)
    x_1, x_2 = tf.split(x, 2, axis=1)
    x_1 = qlayer_1(x_1)
    x_2 = qlayer_2(x_2)
    x = tf.concat([x_1, x_2], axis=1)
    outputs = clayer_2(x)

    model = tf.keras.Model(inputs=inputs, outputs=outputs)

Sıralı Olmayan Modeli Eğitme
=============================

Biz bu örnek için de standart ``SGD optimizer`` 'ını ve ``mean absolute error`` loss function'ını kullanarak modelimizi eğiteceğiz ancak bu seçimlerin farklı kombinasyonları da tabii ki kullanılabilir.

.. code-block:: python

    opt = tf.keras.optimizers.SGD(learning_rate=0.2)
    model.compile(opt, loss="mae", metrics=["accuracy"])

    fitting = model.fit(X, y_hot, epochs=6, batch_size=5, validation_split=0.25, verbose=2)


Sıralı Olmayan Model Kodunun Tam Hali
=====================================

``nonsequential_qnn.py``

.. code-block:: python

    import tensorflow as tf
    import pennylane as qml
    import numpy as np
    from sklearn.datasets import make_moons

    tf.keras.backend.set_floatx('float64')

    # Rastgele sayılar için tohum değerlerini belirleme
    np.random.seed(42)
    tf.random.set_seed(42)

    X, y = make_moons(n_samples=200, noise=0.1)
    y_hot = tf.keras.utils.to_categorical(y, num_classes=2)  # one-hot encoding ile kodlanmış etiketler

    n_qubits = 2
    dev = qml.device("default.qubit", wires=n_qubits)

    # Quantum Node oluşturma
    @qml.qnode(dev)
    def qnode(inputs, weights):
        qml.AngleEmbedding(inputs, wires=range(n_qubits))
        qml.BasicEntanglerLayers(weights, wires=range(n_qubits))
        return [qml.expval(qml.PauliZ(wires=i)) for i in range(n_qubits)]

    n_layers = 6
    weight_shapes = {"weights": (n_layers, n_qubits)}

    # Katmanları tanımlama
    clayer_1 = tf.keras.layers.Dense(4)
    qlayer_1 = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)
    qlayer_2 = qml.qnn.KerasLayer(qnode, weight_shapes, output_dim=n_qubits)
    clayer_2 = tf.keras.layers.Dense(2, activation="softmax")

    # Modeli oluşturma
    inputs = tf.keras.Input(shape=(2,))
    x = clayer_1(inputs)
    x_1, x_2 = tf.split(x, 2, axis=1)
    x_1 = qlayer_1(x_1)
    x_2 = qlayer_2(x_2)
    x = tf.concat([x_1, x_2], axis=1)
    outputs = clayer_2(x)

    model = tf.keras.Model(inputs=inputs, outputs=outputs)

    opt = tf.keras.optimizers.SGD(learning_rate=0.2)
    model.compile(opt, loss="mae", metrics=["accuracy"])

    fitting = model.fit(X, y_hot, epochs=6, batch_size=5, validation_split=0.25, verbose=2)

sbatch Kullanarak Kuyruğa İş Gönderme
======================================
Yukarda hazırladığımız python dosyalarını kuyruğa nasıl gönderebileceğimizi göreceğiz.

Kuyruğa iş göndermek için bir `slurm betiği <https://slurm.schedmd.com/sbatch.html>`_ hazırlayın: ``qnn-job.sh``

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p debug                 # Kuyruk adi: Bu gibi deneme kodlari için debug kuyrugunu kullaniyoruz 
    #SBATCH -C akya-cuda             # Kisitlama: GPU bulunan bir sunucuyu  verdiğinizden emin olun.
    #SBATCH -A [USERNAME]            # Kullanici adi
    #SBATCH -J sequential_qnn        # Gonderilen isin ismi
    #SBATCH -o sequential_qnn.out    # Ciktinin yazilacagi dosya adi
    #SBATCH --gres=gpu:1             # Her bir sunucuda kac GPU istiyorsunuz? Kumeleri kontrol edin.
    #SBATCH -N 1                     # Gorev kac node'da calisacak?
    #SBATCH -n 1                     # Ayni gorevden kac adet calistirilacak?
    #SBATCH --cpus-per-task 10       # Her bir gorev kac cekirdek kullanacak? Kumeleri kontrol edin.
    #SBATCH --time=0:15:00           # Sure siniri koyun.
    #SBATCH --error=slurm-%j.err     # Hata dosyasi

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate qnn-keras-env
    python sequential_qnn.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

.. note::
    En alttaki ``python sequential_qnn.py`` yerine ``python nonsequential_qnn.py`` yazarak sıralı olmayan hibrit modeli de kuyruğa gönderebilirdik.

.. warning::
    Kodun GPU'da çalıştığından emin olmak için :ref:`deep-learning-virtual-env` 'daki örnek kodu çalıştırarak Tensorflow'un CUDA cihazını görüp görmediğini kontrol edin.

İşi kuyruğa gönderin.

.. code-block:: bash

    sbatch qnn-job.sh

Gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat sequential_qnn.out




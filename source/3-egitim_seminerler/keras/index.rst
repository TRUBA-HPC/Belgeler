.. _keras-index:

=====
Keras
=====

**Keras**, python dili ile yazılmış, **TensorFlow** platformunun üstüne inşa edilmiş bir makine öğrenmesi ve derin öğrenme programlama arayüzüdür.
Bu eğitim materyalinde **Keras**'ın kullandığı veri tiplerinden **TRUBA** üzerinde birden fazla GPU'da makine öğrenmesi modelleri eğitmeye adım adım Keras kullanımı gösterilecektir.
Bu eğitim materyali makine öğrenmesi ve derin öğrenme modellerinin kullanımı ile optimize edilmesi ve TRUBA bilgisayarı üzerinde bu modellerin çalıştırılması olmak üzere iki ana başlık altında toplanmıştır.

Bu materyalde kullanılan örneklerde ``python 3.8.11``, ``conda 4.10.3``, ``tensorflow-gpu 2.5.0`` sürümleri kullanılmıştır. 
**Keras** arayüzü **Tensorflow** platformunun bir parçası olduğu için **Tensorflow** kurulumu ile birlikte otomatik olarak kullanıma hazır olacaktır. 
**Keras** iş yüklerinin TRUBA sunucuları üzerinde CPU ve GPU kullanılarak nasıl çalıştırılacağı her bir uçtan uca örnek için detaylı olarak gösterilmiş ve betik dosyaları ilgili örneklerde paylaşılmıştır.

**Tensorflow** platformunun TRUBA üzerinde nasıl aktif hale getirileceği :ref:`deep-learning-virtual-env` bölümünde anlatılmıştır.

.. toctree::
    :maxdepth: 2
    :titlesonly:
    :caption: Keras ile Makine Öğrenmesi Modellerinin Oluşturulması ve Eğitilmesi

    build/data_load_preprocess.rst
    build/build_model.rst
    build/train.rst

.. toctree::
    :maxdepth: 2
    :titlesonly:
    :caption: TRUBA Üzerinde Modellerin Çalıştırılması

    run/how_to_run.rst
    Examples/ete1.rst
    Examples/ete3.rst

Bu eğitimde kullanılan materyaller https://keras.io/examples/nlp/ adresinden alınmıştır.




=================
GREASY Kılavuzu
=================


Greasy, BSC tarafından geliştirilen ve prensip olarak paralel simülasyonların dağıtımını kolaylaştırmak için tasarlanmış bir yardımcı yazılımdır (https://github.com/BSC-Support-Team/GREASY). Bir grup farklı görevi paralel olarak çalıştırabilir, bunları zamanlayabilir ve mevcut kaynakları kullanarak çalıştırabilir. Örneğin, uygulamanız seri bir program olduğunda ve farklı parametrelerle çok sayıda örnek çalıştırmanız gerektiğinde kullanmak için ideal bir araçtır. Greasy tüm bu ayrı işleri paketler ve mümkün olduğunca çok sayıda görevi paralel olarak çalıştırmak için verilen kaynakları (SLURM betik dosyasında talep edilen kaynakları) kullanır. Bu görevler bittikçe, Greasy kaynak bekleyen görevleri başlatmaya devam edecektir.

Greasy'nin temel ilkelerinden birisi kullanıcı için iş sürecini basitleştirmek olduğundan, çalıştırılmak istenilen görev listesi sadece bir metin dosyasındaki görevlerin bir listesidir. İlgili dosyadaki her satır Greasy tarafından çalıştırılacak bir görev haline gelir. Kullanıcı, görevler arasındaki bağımlılıkları yönetebilir veya istenirse başarısızlık durumunda bir görevi yeniden çalıştırabilir.

Greasy varsayılan olarak bir yapılandırma dosyası ile kolayca yapılandırılabilir ve ayrıca ortam değişkenleri kullanılarak her bir iş için özelleştirilebilir. Ayrıca, çalışmanızın ilerlemesinin ne olduğunu takip etmek için tüm Greasy eylemlerinin kaydedileceği bir log sistemi sağlar.

Mevcut durumda TRUBA'daki ARF hesaplama kümesinde yer alan orfoz sunucularında farklı görevleri yürütmeniz gerektiğinde ilgili yazılımı kullanabilirsiniz. 

* ARF kümesine bağlantı için :ref:`arf_baglanti` sayfasını inceleyebilirsiniz.

Terminalden ARF kullanıcı arayüzüne bağlantı sağladıktan sonra  

.. code-block:: bash

    module available

komutunu yazdığınızda ARF kümesinde kurulu olan temel programlar listelenecektir.  İlgili programlar arasında Greasy için aşağıdaki modülün de listede yer aldığını göreceksiniz:


.. code-block:: bash

    lib/greasy/greasy

.. note::

    Özel olarak sadece Greasy programına ait modülleri görüntülemek isterseniz terminalde

    .. code-block:: bash

        module avail |& grep greasy

    veya

    .. code-block:: bash

        module avail 2>&1 | grep greasy

    komutlarından birisini yazabilirsiniz.

.. note::

    /arf/sw/scripts/greasy dizini altında yer alan örnek SLURM betik dosyasını ve *.txt* uzantılı olarak verilen iş dosyasını inceleyebilirsiniz.



----------

.. note::

    İlgili içerik BSC tarafından hazırlanan Greasy dokümantasyon sayfasından derlenmiştir:

    - https://www.bsc.es/user-support/greasy.php

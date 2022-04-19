.. _miniconda-kurulum:

===============================
Ev Dizinine Anaconda Kurulumu
===============================

Miniconda indirin:

.. code-block:: bash

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh

.. note::
    Miniconda, Anaconda'nın yalnızca conda, Python, bağlı oldukları paketleri ve pip, zlib ve diğer birkaçını da içeren az sayıda başka yararlı paketi içeren küçük, önyükleme sürümüdür.

Kurulum yaparken:

* /truba/home/... ile başlayan kurulum lokasyonunu değiştirmeyin.
* ``conda init`` komutunu çalıştırmayın.

Bittikten sonra script'i silebilirsiniz:

.. code-block:: bash

    rm Miniconda3-latest-Linux-x86_64.sh

Conda'yı güncelleyin.

.. code-block:: bash
    
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda update conda

Bu adımdan sonra kullanacağınız kütüphalenerin kurulumunu conda sanal ortamına yapabilirsiniz:

.. code-block:: bash
    
    conda create --name new-virtual-env # Yeni sanal ortam yaratın.
    conda activate new-virtual-env # Sanal ortamı aktifleştirin.
    conda list # Sanal ortamda yüklü olan kütüphaneleri listeleyin.

.. note::
    Sanal ortam kullanarak belirli bir Python sürümü için bir Python kurulumu ve bir dizi ek paket içeren bağımsız bir dizin ağacı yaratabilirsiniz. Bu sayede farklı uygulamalarınız için farklı sanal ortamlar yaratarak çakışan gereksinimlerin oluşmasını önlersiniz.

---------------------------------------------
Anaconda Sanal Ortamı Kullanılan Uygulamalar
---------------------------------------------


* :doc:`Jupyter Notebook <jupyter>`
* :doc:`Derin Öğrenme <../deep-learning/virtual-env>`
* :doc:`Apache Spark <../data-analytics/spark>`

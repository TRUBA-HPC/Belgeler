.. _anaconda-miniconda-kurulum:


================================
Anaconda ve Miniconda Kullanımı
================================


Bu belge TRUBA altyapısında `conda <https://conda.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.
Bu kılavuz aşağıdakileri kapsamaktadır:

.. grid:: 2

    .. grid-item-card::  :ref:`merkezi_anaconda`
        :text-align: center
    .. grid-item-card:: :ref:`miniconda-kurulum`
        :text-align: center


.. _merkezi_anaconda:

Merkezi Anaconda Kullanımı
--------------------------

Merkezi anaconda kurulumu hesaplama kümeleri için aşağıdaki dizinlerde yer almaktadır:

.. code-block::

    eval "$(/truba/sw/centos7.3/lib/anaconda3/2020.07/bin/conda shell.bash hook)"
    eval "$(/truba/sw/centos7.3/lib/anaconda3/2021.11/bin/conda shell.bash hook)"
    eval "$(/truba/sw/centos7.9/lib/anaconda3/2020.07/bin/conda shell.bash hook)"
    eval "$(/truba/sw/centos7.9/lib/anaconda3/2021.11/bin/conda shell.bash hook)"

Farklı anaconda platformlarının bulunması, içerisinde bulunan python ve diğer paketlerin farklı versiyonlarına kullanıcılar tarafından ihtiyaç duyulmasından kaynaklı oluşturulmuştur.

İlgili Anaconda ortamlarını kulllanıcı arayüzlerinde ve hesaplama sunucularında aktif olması isteniliyorsa ``.bashrc`` dosyanıza ihtiyaç duyduğunuz satırı eklemeniz gerekmektedir.

Ayrıca, sadece ihtiyaç duyulan zamanlarda aktif edilmek istenilirse terminalde doğrudan ilgili komutu kullanabilirsiniz. SLURM betik dosyanızda da benzer şekilde ilgili anaconda versiyonu için olan yukarıdaki komutu yazmanız gerekmektedir.

.. note::
    Kullanıcılar özelinde merkezi kurulum ihitiyaçları karşılamadığı durumda kendi ev dizinlerine anaconda kurulum sağlamak yerine :ref:`miniconda-kurulum` tecih edilmelidir. Bir başka öneri ise merkezi anaconda kullanılarak yeni bir sanal ortam oluşturmaktır. Önerilen çözümler ile ihtiyaç duyulan paketlerin sağlanması sonucunda inode problemi ile karşılaşılması engellenmektedir.

İlgili komut çalıştırdıktan sonra sanal ortam hakkında bilgi edinmek için  ``conda info`` ve ``conda list`` ile env bilgisine ve içerisinde bulunan paketlerin versiyonlarına erişim sağlayabilirsiniz.

.. _miniconda-kurulum:

Ev Dizinine Miniconda Kurulumu
------------------------------

Miniconda, Anaconda'nın yalnızca conda, Python, bağlı oldukları paketleri ve pip, zlib ve diğer birkaçını da içeren az sayıda başka yararlı paketi içeren küçük, önyükleme sürümüdür.

Miniconda indirmek ve kurulumu başlatmak için:

.. code-block:: bash

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh

.. note::


Kurulum yaparken:

* /truba/home/... ile başlayan kurulum lokasyonunu değiştirmeyin.
* ``conda init`` komutunu çalıştırmayın.

Bittikten sonra script'i silebilirsiniz:

.. code-block:: bash

    rm Miniconda3-latest-Linux-x86_64.sh

Conda'yı güncellemek için:

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


Anaconda Sanal Ortamı Kullanılan Uygulamalar
---------------------------------------------


* :doc:`Jupyter Notebook <jupyter>`
* :doc:`Derin Öğrenme <../deep-learning/virtual-env>`
* :doc:`Apache Spark <../data-analytics/spark>`

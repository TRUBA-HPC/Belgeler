===============================
Ev dizinine Anaconda kurulumu
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
Anaconda sanal ortamı kullanılan uygulamalar
---------------------------------------------

.. toctree::
    :maxdepth: 1

    ../deep-learning/index.rst

=============================================================================
OpenOnDemand arayüzünde Jupyter kullanmak için Anaconda yapılandırması
=============================================================================

OpenOnDemand arayüzünde Jupyter kullanmak için hesaplama sunucularında Anaconda yüklemesini merkezi dosya sisteminde kurulu olan python modülü ile gerçekleştirebilirsiniz:

.. code-block:: bash
    
    module load centos7.3/comp/python/3.6.5-gcc
    /truba/sw/src/Anaconda3-2020.07-Linux-x86_64.sh # Sorulan sorulara '"yes"' seçeneğiyle ile yanıt verin.

Her loginde bu ayarların geçerli olması için bu ayarların ``.profile`` ve ``.bash_profile`` dosyalarında olması gerekir.

.. code-block:: bash

    touch .bash_profile # Eğer yoksa .bash_profile dosyası yaratın.

``.bash_profile`` dosyasının içeriğini düzenleyin:

.. code-block:: bash

    module load centos7.3/comp/python/3.6.5-gcc
    export PATH="$PATH:/truba/home/$USER/anaconda3/bin"

``.profile`` dosyasını sembolik olarak ``.bash_profile`` dosyasına bağlayın:

.. code-block:: bash

    rm .profile
    ln -s .profile .bash_profile

Logout olup login olduktan sonra ayarların doğruluğunu test edin:

.. code-block:: bash

    jupyter notebook

Jupyter notebook logout olup login olduktan sonra çalışıyorsa OpenOnDemand arayüzünde Jupyter kullanabilirsiniz. ``ctrl+c`` kullanarak notebook'u kapatın.
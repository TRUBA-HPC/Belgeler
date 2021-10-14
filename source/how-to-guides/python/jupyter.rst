.. _jupyter-anaconda:

===================================
Jupyter Notebook ile Çalışma
===================================

------------------------------------------------------------------------------------------------------
Open OnDemand Arayüzünde Jupyter Kullanmak için Anaconda Yapılandırması
------------------------------------------------------------------------------------------------------

Open OnDemand arayüzünde Jupyter kullanmak için hesaplama sunucularında Anaconda yüklemesini merkezi dosya sisteminde kurulu olan python modülü ile gerçekleştirebilirsiniz:

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

Jupyter notebook logout olup login olduktan sonra çalışıyorsa Open OnDemand arayüzünde Jupyter kullanabilirsiniz. ``ctrl+c`` kullanarak notebook'u kapatın.

Farklı sanal ortamdaki Kernel'ı kullanma
===========================================

Bağlanmak istediğiniz Anaconda veya Miniconda sanal ortamına ipykernel ve jupyter paketlerini yükledikten sonra Jupyter arayüzünde Kernel > Change kernel menüsünden ilgili sanal ortama geçiş yapabilirsiniz.

--------------------------------------------------------------------
Anaconda Sanal Ortamına Jupyter Kurulumu
--------------------------------------------------------------------


Jupyter notebook ile kümelerde interaktif çalışma
=====================================================

.. warning::

    TRUBA tipi Yüksek Başarımlı Hesaplama altyapılarında limitli miktarda kaynak pek çok kullanıcı tarafından paylaşımlı olarak kullanılmaktadır. Bu nedenle bu bölümde anlatılan bilgileri kullanarak uzun süreli kaynak tahsis edip bu kaynakları etkili bir şekilde kullanmamak (örneğin interaktif işi sonlandırmadan bilgisayar başından ayrılmak) doğru değildir.


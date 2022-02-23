.. _jupyter-anaconda:

===================================
Jupyter Notebook ile Çalışma
===================================

Bu belge TRUBA altyapısında bulunan kümelerde Jupyter Notebook kullanımı kolaylaştırmak için oluşturulmuştur.

.. warning::

    Bu belgede anlatılan bilgiler arayüz sunucuları hariç sunucularda interaktif çalışma içindir. Arayüz sunucuları çok sayıda kullanıcı tarafından paylaşıldığı için bu sunucularda Jupyter Notebook kullanarak interaktif iş çalıştırılmaması gerekmektedir.

------------------------------------------------------------------------------------------------------
Open OnDemand Arayüzünde Jupyter Kullanmak için Anaconda Yapılandırması
------------------------------------------------------------------------------------------------------

Open OnDemand arayüzünde Jupyter kullanmak için Anaconda yüklemenizi kullanabilirsiniz.

.. warning::
    
    Belgenin geri kalanda ev dizinine Miniconda kurulumu yapılmış kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :doc:`Python Kılavuzu'nu <anaconda>` takip ederek yapabilirsiniz.

Her loginde conda'nın (Miniconda) temel ortamını etkinleştirmek için ev dizininizde bulunan ``.bash_profile`` dosyasına şu satırı ekleyin.

.. note::

    Eğer ev dizininizde ``.bash_profile`` dosyası yoksa dosyayı yaratın. Ayrıca ``.profile`` ve ``.bashrc`` dosyalarını sembolik olarak ``.bash_profile`` dosyasına bağlamanız gerekebilir.

    .. code-block:: bash

        touch .bash_profile
        rm .profile .bashrc
        ln -s .bash_profile .profile
        ln -s .bash_profile .bashrc

.. code-block:: bash
    :caption: .bash_profile

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

Logout olup login olduktan sonra conda temel ortamının aktif olması gerekir. Temel ortamda yüklü olan paketleri görüntülemek için:

.. code-block:: bash

    conda list

Temel ortama Jupyter Notebook yükleyin.

.. code-block:: bash

    conda install -c conda-forge notebook

Yükleme tamamlandıktan sonra Open OnDemand arayüzünde Interactive Apps menüsünden Jupyter Notebook uygulaması başlatabilirsiniz.

..  
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

Bağlanmak istediğiniz Anaconda veya Miniconda sanal ortamına ipykernel ve jupyter paketlerini yükledikten sonra sanal ortamı Jupyter Notebook'da kullanmak için ``ipython kernel install`` komutunu kullanabilirsiniz.

.. code-block:: bash

    conda create --name jupyter-test-env
    conda activate jupyter-test-env
    conda install -c conda-forge notebook
    ipython kernel install --name "jupyter-test-env" --user

Jupyter arayüzünde Kernel > Change kernel menüsünden ilgili sanal ortama geçiş yapabilirsiniz veya yeni bir notebook başlatırken eklediğiniz Kernel'i seçebilirsiniz.

----------------------------------------------------------
Jupyter Notebook ile kümelerde interaktif çalışma
----------------------------------------------------------

.. warning::

    TRUBA tipi Yüksek Başarımlı Hesaplama altyapılarında limitli miktarda kaynak pek çok kullanıcı tarafından paylaşımlı olarak kullanılmaktadır. Bu nedenle bu bölümde anlatılan bilgileri kullanarak uzun süreli kaynak tahsis edip bu kaynakları etkili bir şekilde kullanmamak (örneğin interaktif işi sonlandırmadan bilgisayar başından ayrılmak) doğru değildir.

Henüz yoksa, aşağıdaki komut satırını kullanarak bir yapılandırma dosyası oluşturun:

.. code-block:: bash

    jupyter notebook --generate-config

Oluşturulan yapılandırma dosyasını düzenleyerek aşağıdaki satırları değiştirin.

.. code-block:: bash
    :caption: jupyter_notebook_config.py

    c.NotebookApp.allow_origin = '0.0.0.0'
    c.NotebookApp.ip = '0.0.0.0'

`srun <https://slurm.schedmd.com/srun.html>`_ kullanarak interaktif çalışmak için bir kümeden kaynak talep edin:

.. code-block:: bash

    srun -p barbun -n 1 -c 4 --time 1:00:00 --pty /bin/bash

Jupyter'in çalıştığı makinenin ismini öğrenin: ``[HOSTNAME]``

.. code-block:: bash

    hostname

Notebook başlatmak istediğiniz sanal ortama geçiş yapın ve notebook başlatın.

.. code-block:: bash
    
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)" # Bu satır .bash_profile dosyanızda tanımlı değilse çalıştırın.
    conda activate jupyter-test-env
    jupyter notebook

.. note::

    URL'deki port numarasını ``[PORT]`` ve token'i not edin.

Jupyter Notebook'a erişmek için yeni bir terminal kullanarak ssh tüneli oluşturun:

.. code-block:: bash

    ssh -N -L 8888:[HOSTNAME]:[PORT] 172.16.7.1

Web tarayıcınızda http://localhost:8888 üzerinden Jupyter Notebook'a token kullanarak giriş yapabilirsiniz.
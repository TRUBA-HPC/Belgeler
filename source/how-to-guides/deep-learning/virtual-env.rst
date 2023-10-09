.. _deep-learning-virtual-env:

===============================
Sanal Ortam Kullanarak Çalışma
===============================

TRUBA altyapısında Anaconda kullanarak yarattığınız sanal ortama CUDA yükleyebilirsiniz.

.. note::
    Sanal ortam kullanarak belirli bir Python sürümü için bir Python kurulumu ve bir dizi ek paket içeren bağımsız bir dizin ağacı yaratabilirsiniz. Bu sayede farklı uygulamalarınız için farklı sanal ortamlar yaratarak çakışan gereksinimlerin oluşmasını önlersiniz.

--------------------------
Kütüphanelerin Kurulumu
--------------------------

.. warning::
    Belgenin geri kalanda ev dizinine Miniconda kurulumu yapılmış kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :doc:`Python Kılavuzu'nu <../python/anaconda>` takip ederek yapabilirsiniz.

Mevcut shell oturumunuzda conda'nın temel ortamını etkinleştirin:

.. code-block:: bash
    
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

Conda kullanarak sanal ortam yaratın ve yarattığınız ortamı aktifleştirin.

.. code-block:: bash
    
    conda create --name dl-env
    conda activate dl-env
    conda list

Çalışmanız için gerekli paketleri kurun.

Tensorflow için:

.. code-block:: bash

    conda install python=3.11 -y
    conda install -c conda-forge cudatoolkit=11.5 -y
    conda install -c conda-forge cudnn=8.8 -y
    pip install nvidia-tensorrt
    pip install tensorflow

PyTorch için:

.. code-block:: bash

    conda install -y python=3.8 pytorch torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge

.. note::
    Yüklediğiniz kütüphanelerin versiyonlarının uyumlu olmasına dikkat edin:
    
    * `Tensorflow için test edilmiş yapılandırmalar <https://www.tensorflow.org/install/source#gpu>`_
    * `PyTorch başlangıç kılavuzu <https://pytorch.org/get-started/locally/#start-locally>`_ (Compute platform: CUDA, OS: Linux)

.. note::
    İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz:

    .. code-block:: bash

        conda deactivate
        conda remove -n dl-env --all
        conda create --name dl-env
        conda activate dl-env

----------------------------------------------
sbatch Kullanarak Kuyruğa İş Gönderme
----------------------------------------------

Örnek kod hazırlayın: **print_gpu.py**

.. code-block:: python

    import tensorflow as tf
    print(tf.__version__)
    print(tf.config.list_physical_devices('GPU'))

Kuyruğa iş göndermek için bir `slurm betiği <https://slurm.schedmd.com/sbatch.html>`_ hazırlayın: **submit-tensorflow-job.sh**

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p akya-cuda        # Kuyruk adi: Uzerinde GPU olan kuyruk olmasina dikkat edin.
    #SBATCH -A [USERNAME]       # Kullanici adi
    #SBATCH -J print_gpu        # Gonderilen isin ismi
    #SBATCH -o print_gpu.out    # Ciktinin yazilacagi dosya adi
    #SBATCH --gres=gpu:1        # Her bir sunucuda kac GPU istiyorsunuz? Kumeleri kontrol edin.
    #SBATCH -N 1                # Gorev kac node'da calisacak?
    #SBATCH -n 1                # Ayni gorevden kac adet calistirilacak?
    #SBATCH --cpus-per-task 10  # Her bir gorev kac cekirdek kullanacak? Kumeleri kontrol edin.
    #SBATCH --time=1:00:00      # Sure siniri koyun.

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate dl-env
    python print_gpu.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

.. warning::
    GPU kullanan işleri gönderirken toplam çekirdek sayısını işi gönderdiğiniz kümeye ve kullanacağınız GPU sayısına göre belirlemeniz gerekmektedir. İlgili bilgi :ref:`GPU Kılavuzu'nda <core-gpu-count>` bulunmaktadır.

İşi kuyruğa gönderin.

.. code-block:: bash

    sbatch submit-tensorflow-job.sh

Gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat print_gpu.out
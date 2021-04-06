======================================
Sanal ortam yaratarak nasıl çalışılır?
======================================

TRUBA altyapısında Anaconda kullanarak yarattığınız sanal ortama CUDA yükleyebilirsiniz.

.. note::
    Sanal ortam kullanarak belirli bir Python sürümü için bir Python kurulumu ve bir dizi ek paket içeren bağımsız bir dizin ağacı yaratabilirsiniz. Bu sayede farklı uygulamalarınız için farklı sanal ortamlar yaratarak çakışan gereksinimlerin oluşmasını önlersiniz.


Başlamadan önce:

* Anaconda `kurulum dökümanına <https://docs.conda.io/projects/continuumio-conda/en/latest/user-guide/install/linux.html>`_ göz atın.
* NVIDIA GPU ile çalışmak için `uyumlu Python, Tensorflow, CUDA ve cuDNN versiyonlarını <https://www.tensorflow.org/install/source#gpu>`_ öğrenin.
* sbatch ile `kuyruğa iş gönderme dökümanına <https://slurm.schedmd.com/sbatch.html>`_ bakın.

-----------------------------------
Ev dizinine nasıl Anaconda kurulur?
-----------------------------------

.. note::
    Miniconda, Anaconda'nın yalnızca conda, Python, bağlı oldukları paketleri ve pip, zlib ve diğer birkaçını da içeren az sayıda başka yararlı paketi içeren küçük, önyükleme sürümüdür.

Miniconda indirin:

.. code-block:: bash

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh

Kurulum yaparken:

* /truba/home/... ile başlayan kurulum lokasyonunu değiştirmeyin.
* ``conda init`` komutunu çalıştırmayın.

Bittikten sonra script'i silebilirsiniz:

.. code-block:: bash

    rm Miniconda3-latest-Linux-x86_64.sh


Conda'yı güncelleyin. Bundan sonraki komutlarda ``[USERNAME]`` yertutucusunu kendi kullanıcı adınızla değiştirin.

.. code-block:: bash
    
    eval "$(/truba/home/[USERNAME]/miniconda3/bin/conda shell.bash hook)"
    conda update conda

Conda kullanarak sanal ortam yaratın (tf-gpu) ve yarattığınız ortamı aktifleştirin.

.. code-block:: bash
    
    conda create --name tf-gpu
    conda activate tf-gpu
    conda list

Çalışmanız için gerekli paketleri kurun.

.. code-block:: bash

    conda install python=3.8
    conda install -c anaconda cudatoolkit=10.1
    conda install -c anaconda cudnn=7.6
    pip install tensorflow-gpu==2.3

.. note::
    Python, Tensorflow, CUDA ve cuDNN versiyonlarını `öğrenin <https://www.tensorflow.org/install/source#gpu>`_.


.. note::
    İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz:

    .. code-block:: bash

        conda deactivate
        conda remove -n tf-gpu --all
        conda create --name tf-gpu
        conda activate tf-gpu

----------------------------------------------
sbatch kullanarak kuyruğa nasıl iş gönderilir?
----------------------------------------------

Örnek kod hazırlayın: **print_gpu.py**

.. code-block:: python

    import tensorflow as tf
    print(tf.__version__)
    print(tf.config.list_physical_devices('GPU'))

Kuyruğa iş göndermek için bir `slurm betiği <https://slurm.schedmd.com/sbatch.html>`_ hazırlayın: **tensorflow-env.sh**

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p akya-cuda      # Kuyruk adi: Uzerinde GPU olan kuyruk olmasina dikkat edin.
    #SBATCH -A [USERNAME]     # Kullanici adi
    #SBATCH -J print_gpu      # Gonderilen isin ismi
    #SBATCH -o print_gpu.out  # Ciktinin yazilacagi dosya adi
    #SBATCH --gres=gpu:1      # Kac GPU istiyorsunuz? Maksimum sayiyi kontrol edin.
    #SBATCH -N 1              # Gorev kac node'da calisacak?
    #SBATCH -n 1              # Ayni gorevden kac adet calistirilacak?
    #SBATCH -c 8              # Her bir gorev kac cekirdek kullanacak?
    #SBATCH --time=1:00:00    # Sure siniri koyun.

    eval "$(/truba/home/[USERNAME]/miniconda3/bin/conda shell.bash hook)"
    conda activate tf-gpu
    python print_gpu.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

İşi kuyruğa gönderin.

.. code-block:: bash

    sbatch tensorflow-env.sh

Gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat print_gpu.out
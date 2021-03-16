==============================
Container imajları ile çalışın
==============================

TRUBA kuyruklarında Singularity kullanarak container imajları çalıştırabilirsiniz.

.. note::
    `Singularity <https://sylabs.io/guides/3.7/user-guide/introduction.html#introduction-to-singularity>`_, karmaşık uygulamaların YBH kümelerinde taşınabilir ve tekrarlanabilir şekilde çalıştırılmasını sağlar. Singularity kullanarak `Sylabs Cloud Library <https://cloud.sylabs.io/library>`_'deki ve `Docker Hub <https://hub.docker.com/>`_'daki imajları çalıştırabilirsiniz.

Başlamadan önce:

* Singularity kullanıcı kılavuzunun `GPU ile ilgili kısmını <https://sylabs.io/guides/3.7/user-guide/gpu.html>`_ inceleyin.
* levrek1 arayüz sunucusuna ssh ile bağlanın. ``hostname`` komutunun çıktısı ``levrek1.yonetim`` olmalıdır.

------------------------------
sbatch ile kuyruğa iş gönderin
------------------------------

DockerHub'daki `tensorflow imajlarından <https://hub.docker.com/r/tensorflow/tensorflow>`_ uygun etiketli (gpu) birini seçin ve `singularity pull <https://sylabs.io/guides/3.7/user-guide/cli/singularity_pull.html>`_ kullanarak indirin:

.. code-block:: bash

    singularity pull docker://tensorflow/tensorflow:latest-gpu

Örnek python kodu hazırlayın: **print_gpu.py**

.. code-block:: python

    import tensorflow as tf
    print(tf.__version__)
    print(tf.config.list_physical_devices('GPU'))

Kuyruğa iş göndermek için bir `slurm betiği <https://slurm.schedmd.com/sbatch.html>`_ hazırlayın: **tensorflow-gpu.sh**

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p akya-ai        # Kuyruk adi: Uzerinde GPU olan kuyruk olmasina dikkat edin.
    #SBATCH -A [USERNAME]     # Kullanici adi
    #SBATCH -J print_gpu      # Gonderilen isin ismi
    #SBATCH -o print_gpu.out  # Ciktinin yazilacagi dosya adi
    #SBATCH --gres=gpu:1      # Kac GPU istiyorsunuz? Maksimum sayiyi kontrol edin.
    #SBATCH -N 1              # Gorev kac node'da calisacak?
    #SBATCH -n 1              # Ayni gorevden kac adet calistirilacak?
    #SBATCH -c 8              # Her bir gorev kac cekirdek kullanacak?
    #SBATCH --time=0:01:00    # Sure siniri koyun.

    # NVIDIA GPU kullanmak icin --nv opsiyonunu kullanin.
    singularity run --nv tensorflow_latest-gpu.sif python print_gpu.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

İşi kuyruğa gönderin:

.. code-block:: bash

    sbatch tensorflow-gpu.sh

Kuyruğa gönderdiğiniz işleri kontrol edin:

.. code-block:: bash

    squeue

İş bittikten sonra output dosyasını terminalde görüntüleyin: 

.. code-block:: bash

    cat print_gpu.out

---------------------------------------------------------
salloc ile Jupyter Notebook kullanarak interaktif çalışın
---------------------------------------------------------

Jupyter ve gpu etiketli tensorflow docker imajlarından birini indirin:

.. code-block:: bash

    singularity pull docker://tensorflow/tensorflow:latest-gpu-jupyter

`salloc <https://slurm.schedmd.com/salloc.html>`_ kullanarak üzerinde GPU bulunan kuyruklardan tahsis talep edin:

.. code-block:: bash

    salloc -c 8 --gres=gpu:1 -p akya-ai --time 1:00:00

.. note::
    ``--gres=gpu:1`` parametresindeki rakamı daha fazla gpu talep etmek için değiştirebilirsiniz.

Talebinizin durumunu görüntüleyin.

.. code-block:: bash

    squeue

.. note::
    Terminal çıktısında ``[JOBID]``'yi not edin.

Talebiniz karşılanınca terminalde mesaj göreceksiniz: ``salloc: Granted job allocation [JOBID]``. ``squeue`` komutunu kullandığınız zaman ST (state) R (running) olarak gözükür.

Tahsis ettiğiniz kaynakta shell çalıştırın.

.. code-block:: bash

    srun --jobid=[JOBID] --pty /bin/bash

Jupyter'in çalıştığı makinenin ismini öğrenin: ``[HOSTNAME]``

.. code-block:: bash

    hostname

Çalışan imaja bağlamak için notebooks klasörü oluşturun:

.. code-block:: bash

    mkdir notebooks

Jupyter notebook başlatın.

.. code-block:: bash

    singularity run --nv -B notebooks:/tf/notebooks tensorflow_latest-gpu-jupyter.sif

.. note::
    URL'deki port numarasını ``[PORT]`` ve token'i not edin.

Jupyter Notebook'a erişmek için yeni bir terminal kullanarak ssh tüneli oluşturun:

.. code-block:: bash

    ssh -N -L 8888:[HOSTNAME]:[PORT] 172.16.7.1

Web tarayıcınızda http://localhost:8888 üzerinden Jupyter Notebook'a token kullanarak giriş yapabilirsiniz. **notebooks** klasöründe yaptığınız çalışmalar kalıcı olacaktır.
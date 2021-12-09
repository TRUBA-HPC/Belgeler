======================================
Container Kullanarak Çalışma
======================================

TRUBA altyapısında GPU bulunan kümelerde Singularity kullanarak container imajları çalıştırabilirsiniz.

.. note::
    `Singularity <https://sylabs.io/guides/3.7/user-guide/introduction.html#introduction-to-singularity>`_, karmaşık uygulamaların YBH kümelerinde taşınabilir ve tekrarlanabilir şekilde çalıştırılmasını sağlar. Singularity kullanarak `Sylabs Cloud Library <https://cloud.sylabs.io/library>`_'deki ve `Docker Hub <https://hub.docker.com/>`_'daki imajları çalıştırabilirsiniz.

---------------------------------------
sbatch Kullanarak Kuyruğa İş Gönderme
---------------------------------------

DockerHub'daki `Tensorflow imajlarından <https://hub.docker.com/r/tensorflow/tensorflow>`_ uygun etiketli (gpu) birini seçin ve `singularity pull <https://sylabs.io/guides/3.7/user-guide/cli/singularity_pull.html>`_ komutunu kullanarak indirin:

.. code-block:: bash

    singularity pull docker://tensorflow/tensorflow:latest-gpu

Örnek python kodu hazırlayın: **print_gpu.py**

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
    #SBATCH --time=0:01:00      # Sure siniri koyun.

    # NVIDIA GPU kullanmak icin --nv opsiyonunu kullanin.
    singularity run --nv tensorflow_latest-gpu.sif python print_gpu.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

.. warning::
    GPU kullanan işleri gönderirken toplam çekirdek sayısını işi gönderdiğiniz kümeye ve kullanacağınız GPU sayısına göre belirlemeniz gerekmektedir. İlgili bilgi :ref:`GPU Kılavuzu'nda <core-gpu-count>` bulunmaktadır.


İşi kuyruğa gönderin:

.. code-block:: bash

    sbatch submit-tensorflow-job.sh

Kuyruğa gönderdiğiniz işleri kontrol edin:

.. code-block:: bash

    squeue

İş bittikten sonra output dosyasını terminalde görüntüleyin: 

.. code-block:: bash

    cat print_gpu.out

---------------------------------------------
Jupyter Notebook ile Çalışma
---------------------------------------------

.. warning::

    TRUBA tipi Yüksek Başarımlı Hesaplama altyapılarında limitli miktarda kaynak pek çok kullanıcı tarafından paylaşımlı olarak kullanılmaktadır. Bu nedenle bu bölümde anlatılan bilgileri kullanarak uzun süreli kaynak tahsis edip bu kaynakları etkili bir şekilde kullanmamak (örneğin interaktif işi sonlandırmadan bilgisayar başından ayrılmak) doğru değildir.
    
Jupyter ve gpu etiketli tensorflow docker imajlarından birini indirin:

.. code-block:: bash

    singularity pull docker://tensorflow/tensorflow:latest-gpu-jupyter

`srun <https://slurm.schedmd.com/srun.html>`_ kullanarak üzerinde GPU bulunan kuyruklardan interaktif çalışmak için tahsis talep edin:

.. code-block:: bash

    srun -N 1 -n 1 -c 10 --gres=gpu:1 -p akya-cuda --time 1:00:00 --pty /bin/bash

.. note::
    ``--gres=gpu:1`` parametresindeki rakamı daha fazla GPU talep etmek için değiştirebilirsiniz. Bu durumda çekirdek sayısını :ref:`GPU Kılavuzu'na <core-gpu-count>` göre güncellemeyi unutmayın.

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
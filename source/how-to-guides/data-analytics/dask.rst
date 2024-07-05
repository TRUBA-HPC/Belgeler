=============
Dask Kılavuzu
=============

Bu belge TRUBA altyapısında Dask kullanımını kolaylaştırmak için oluşturulmuştur.

----------------------------
Container Kullanarak Çalışma
----------------------------

TRUBA altyapısında Singularity kullanarak container imajları çalıştırabilirsiniz.

.. note::

    `Singularity <https://sylabs.io/guides/3.7/user-guide/introduction.html#introduction-to-singularity>`_, karmaşık uygulamaların YBH kümelerinde taşınabilir ve tekrarlanabilir şekilde çalıştırılmasını sağlar. Kurulum yaparken ilgili conda paketlerini Singularity imajına yüklemek dosya sayısı kotanızın doluluğunu düşük tutmanızı sağlar ve TRUBA dosya sistemi için yük yaratmaz.
    
    Singularity kullanarak `Sylabs Cloud Library <https://cloud.sylabs.io/library>`_'deki ve `Docker Hub <https://hub.docker.com/>`_'daki imajları çalıştırabilirsiniz.

Singularity için container imajı yaratın
========================================

.. note::

    Dask yüklü bir Singularity imajınız varsa bu adımı atlayabilirsiniz.

Yerel bilgisayarınızda bir tanım dosyası kullanarak Singularity imajı oluşturabilirsiniz.

.. note::
    Yerel bilgisayarınızda Singularity kurulmuş olmalıdır. Kurulum için `ilgili belgeyi <https://docs.sylabs.io/guides/3.10/user-guide/quick_start.html#quick-installation-steps>`_ takip edebilirsiniz.

``dask.def`` dosyasını oluşturup düzenleyin.

.. code-block:: bash
    :caption: dask.def

    Bootstrap: docker
    From: continuumio/miniconda3:4.10.3
    %post
        conda install dask dask-mpi mpi4py openmpi=4.1.1 -c conda-forge -c
    anaconda
        chmod -R o+rX /opt/conda

Singularity imajını oluşturarak TRUBA dosya sistemine aktarın.

.. code-block:: bash

    sudo singularity build dask.sif dask.def
    scp dask.sif 172.16.11.1:/truba/home/USERNAME/dask.sif # USERNAME yer tutucusunu kullanıcı adınızla değiştirin.

Dask-MPI kullanarak Batch modunda çalışma
=========================================

.. note::

    Bu bölüm **Hamsi kümesinde** CPU kaynakları kullanarak çalışma için hazırlanmıştır. :doc:`Diğer kümeler <../../TRUBA/kullanici-el-kitabi/hesaplamakumeleri>` için aşağıda verilen örnek kodlar yönergelere uygun olarak değiştirilmelidir.

``my_client_script.py`` dosyasını oluşturup düzenleyin.

.. code-block:: python
    :caption: my_client_script.py

    from dask_mpi import initialize

    initialize(exit=False)

    from dask.distributed import Client

    with Client() as c:
        # https://examples.dask.org/array.html
        import dask.array as da
        x = da.random.random((10000, 10000), chunks=(1000, 1000))
        y = x + x.T
        z = y[::2, 5000:].mean(axis=1)
        print(z.compute())

İşi kuyruğa göndermek için ``submit_dask_mpi_batch.sh`` dosyasını oluşturup düzenleyin.

.. note::

    Betikteki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirin.

    2 worker için `4 görev çalıştırılmalıdır <https://mpi.dask.org/en/latest/batch.html>`_.

.. code-block:: bash
    :caption: submit_dask_mpi_batch.sh

    #!/bin/bash
    #SBATCH -p hamsi                        # Kuyruk adi
    #SBATCH -A  [USERNAME]                  # Proje adi
    #SBATCH -J dask_mpi_batch_test          # Gonderilen isin ismi
    #SBATCH -o dask_mpi_batch_test.out      # Ciktinin yazilacagi dosya adi
    #SBATCH --nodes 4                       # Gorev en az kac sunucuda calisacak?
    #SBATCH --ntasks-per-node 1             # Ayni gorevden her sunucuda kac adet calisacak?
    #SBATCH --cpus-per-task 28              # Her bir gorev kac cekirdek kullancak? Kumeleri kontrol edin.
    #SBATCH --time=00:10:00                 # Sure siniri koyun.
    
   
    echo "SLURM_JOB_ID $SLURM_JOB_ID"
    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "SLURM_NTASKS $SLURM_NTASKS"
    echo "SLURM_JOB_NUM_NODES $SLURM_JOB_NUM_NODES"

    module load centos7.9/lib/openmpi/4.1.1-gcc-7
    mpirun -np $SLURM_NTASKS singularity run dask.sif python
    my_client_script.py

İşi kuyruğa gönderin.

.. code-block:: bash

    sbatch submit_dask_mpi_batch.sh

İşin durumunu kontrol edin.

.. code-block:: bash

    squeue

İş çalışmaya başladıktan sonra çıktı dosyasını kontrol edin:

.. code-block:: bash

    cat dask_mpi_batch_test.out

..
    Scheduler IP adresinde başlayan Dashboard'a bağlanmak için yerel bilgisayarınızda yeni bir terminal kullanarak ssh tüneli oluşturun:

    .. code-block:: bash
    
        ssh -N -L 8787:SCHEDULER_IP_ADDR:8787 172.16.7.1

    Tüneli oluşturduktan sonra web tarayıcınızda http://localhost:8787 üzerinden Dashboard'a ulaşabilirisiniz.

İncelemenizi tamamladıktan sonra çalışan görevleri sonlandırın:

.. code-block:: bash

    scancel JOBID # JOBID parametresini squeue komutunun çıktısından öğrenebilirsiniz.
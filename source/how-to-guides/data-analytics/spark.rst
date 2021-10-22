=======================
Apache Spark Kılavuzu
=======================

TRUBA altyapısında bir Spark kümesini `bağımsız modda <https://spark.apache.org/docs/latest/spark-standalone.html>`_ çalıştırabilir ve çalıştırdığınız kümeye iş gönderebilirsiniz. 

------------------------------------------------
Apache Spark'ın indirilmesi ve yapılandırılması
------------------------------------------------

Güncel Spark versiyonunu web sitesinden indirin. Bu belgede aşağıdaki versiyonlar kullanılmıştır:

* Spark release 3.1.2
* Pre-built for Hadoop 2.7

.. code-block:: bash

    cd # Geçerli çalışma dizinini home dizininize değiştirin.
    wget https://ftp.itu.edu.tr/Mirror/Apache/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz
    tar -xvzf spark-3.1.2-bin-hadoop2.7.tgz
    rm spark-3.1.2-bin-hadoop2.7.tgz
    mv spark-3.1.2-bin-hadoop2.7 spark

Spark master ve worker düğümleri için log dizinlerini düzenlemek gereklidir.

.. code-block:: bash

    mkdir /truba_scratch/$USER/spark-log-dir
    cd /truba/home/$USER/spark/conf
    cp spark-env.sh.template spark-env.sh

``spark-env.sh`` dosyasını düzenleyerek dosyanın sonuna şu satırı ekleyin:

.. code-block:: bash
    :caption: spark-env.sh

    SPARK_LOG_DIR="/truba_scratch/$USER/spark-log-dir/$(hostname)"

.. warning::

    ``/truba_scratch`` dizininde bulunan dosyalar düzenli olarak silinmektedir. İlgili logları daha uzun süre saklamak istiyorsanız ``/truba/home/$USER/spark-log-dir`` dizinini oluşturup ``spark-env.sh`` dosyasına eklediğiniz satırı ``SPARK_LOG_DIR="/truba/home/$USER/spark-log-dir/$(hostname)"`` olarak değiştirebilirsiniz.

``/truba/home/$USER/spark/sbin/start-worker.sh`` dosyasının worker düğümlerinin arka planda çalışacak şekilde düzenlenmesi gerekmektedir. İstediğiniz düzenleyiciyi kullanarak dosyanın sonuna şu satırı ekleyin:

.. code-block:: bash
    :caption: start-worker.sh

    sleep infinity

---------------------------------------
Conda sanal ortamı kullanarak çalışma
---------------------------------------

TRUBA altyapısında Anaconda kullanarak yarattığınız sanal ortama PySpark yükleyebilirsiniz.

.. note::

    Sanal ortam kullanarak belirli bir Python sürümü için bir Python kurulumu ve bir dizi ek paket içeren bağımsız bir dizin ağacı yaratabilirsiniz. Bu sayede farklı uygulamalarınız için farklı sanal ortamlar yaratarak çakışan gereksinimlerin oluşmasını önlersiniz.

Kütüphanelerin Kurulumu
==========================

.. warning::

    Belgenin geri kalanda ev dizinine Miniconda kurulumu yapılmış kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :doc:`Python Kılavuzu'nu <../python/anaconda>` takip ederek yapabilirsiniz.

Mevcut shell oturumunuzda conda’nın temel ortamını etkinleştirin.

.. code-block:: bash

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

Conda kullanarak sanal ortam yaratın ve yarattığınız ortamı aktifleştirin.

.. code-block:: bash
    
    conda create --name spark-env
    conda activate spark-env
    conda list

Çalışmanız için gerekli paketleri kurun.

.. code-block:: bash

    conda install python=3.8 # PyArrow Python uyumluluğunu kontrol edin.
    conda install -c conda-forge pyspark
    conda list # PySpark versiyonunu kontrol edin.

Not: İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz.

.. note::
    
    İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz:

    .. code-block:: bash

        conda deactivate
        conda remove -n spark-env --all
        conda create --name spark-env
        conda activate spark-env

sbatch kullanarak Spark kümesine iş gönderme
==============================================

.. warning::

    Bu bölümde ``sbatch`` kullanarak **Hamsi kümesinde** Spark kümesi yaratılması ve çalışan kaynaklara iş gönderilmesi anlatılmaktadır. :doc:`Diğer kümeler <../../TRUBA/kullanici-el-kitabi/hesaplamakumeleri>` için aşağıda verilen örnek kodlar yönergelere uygun olarak değiştirilmelidir.

Spark kümesi başlatma ve master düğüm arayüzüne bağlanma
-----------------------------------------------------------

``/truba/home/$USER/spark/start-spark-cluster-hamsi.sh`` dosyasını oluşturup düzenleyin:


.. note::

    Betikteki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirin.

.. warning::

    ``--memory`` opsiyonunu kullanırken node üzerinde talep ettiğiniz hafızayı dikkate alınız.

.. code-block:: bash
    :caption: start-spark-cluster-hamsi.sh

    #! /bin/bash
    #SBATCH -p hamsi
    #SBATCH -A [USERNAME]
    #SBATCH -J spark-test-hamsi
    #SBATCH -o spark-test-hamsi.out
    #SBATCH -N 3
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=28
    #SBATCH --time=0:10:00

    # Activate conda environment
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate spark-env

    # Start Spark cluster
    rm -rf /truba_scratch/$USER/spark-log-dir/*
    MASTER_HOST="$(hostname)"
    echo $MASTER_HOST
    /truba/home/$USER/spark/sbin/start-master.sh
    srun /truba/home/$USER/spark/sbin/start-worker.sh spark://$MASTER_HOST:7077 --cores 28 --memory 96G &
    # memory = [NODE_BASINA_ISTENEN_CEKIRDEK_SAYISI]/[NODE_UZERINDEKI_TOPLAM_CEKIRDEK_SAYISI]

    sleep infinity

İşi kuyruğa gönderin ve gönderdiğiniz işin durumunu kontrol edin:

.. code-block:: bash
    
    sbatch start-spark-cluster-hamsi.sh
    squeue

Master düğüm nodelist'teki ilk node'da çalışacaktır (örn. hamsi88). Bu node'u iş çalışmaya başladıktan sonra ``spark-test-hamsi.out`` dosyasından öğrenebilirsiniz. Master düğüm arayüzüne erişmek isterseniz 8080 portu için levrek1 arayüz sunucusu üzerinden ssh tüneli oluşturabilirsiniz.

.. code-block:: bash
    :caption: Yerel bilgisayar terminali

    ssh -N -L 8080:[HOSTNAME]:[PORT] 172.16.7.1

.. note::

    İlgili node'da 8080 portu kullanımdaysa arayüze farklı bir port kullanarak erişmek gerekir. İlgili port numarasını bulmak için ``spark-test-hamsi.out`` dosyasından master düğüm loglarının nerede olduğunu öğrendikten sonra bu logları inceleyebilirsiniz.

Yerel bilgisayar web tarayıcınızda http://localhost:8080 üzerinden master düğüm arayüzüne bağlanabilirsiniz.

.. image:: /assets/spark-howto/web-interface.png  
   :width: 1000

sbatch kodunda Spark kümesine iş gönderme
-------------------------------------------

Spark kümesi başlatmak için kullanılan betik dosyası bir Spark uygulaması kümede çalıştırılmak üzere düzenlenebilir.

Örnek: Pi sayısı hesaplama
***************************

``/truba/home/$USER/spark/submit-pi-hamsi.sh`` dosyasını oluşturup düzenleyin:

.. note::

    Betikteki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirin.

.. warning::

    * ``--memory`` opsiyonunu kullanırken node üzerinde talep ettiğiniz hafızayı dikkate alınız.
    * Node sayısı, görev sayısı ve görev başına düşen çekirdek sayısını değiştirirseniz ``--total-executor-cores`` parametresini doğru hesaplayarak güncelleyiniz.

.. code-block:: bash
    :caption: submit-pi-hamsi.sh

    #! /bin/bash
    #SBATCH -p hamsi
    #SBATCH -A [USERNAME]
    #SBATCH -J spark-test-pi-hamsi
    #SBATCH -o spark-test-pi-hamsi.out
    #SBATCH -N 3
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=28
    #SBATCH --time=0:10:00

    # Activate conda environment
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate spark-env

    # Start Spark cluster
    rm -rf /truba_scratch/$USER/spark-log-dir/*
    MASTER_HOST="$(hostname)"
    echo $MASTER_HOST
    /truba/home/$USER/spark/sbin/start-master.sh
    srun /truba/home/$USER/spark/sbin/start-worker.sh spark://$MASTER_HOST:7077 --cores 28 --memory 96G &
    # memory = [NODE_BASINA_ISTENEN_CEKIRDEK_SAYISI]/[NODE_UZERINDEKI_TOPLAM_CEKIRDEK_SAYISI]

    # Submit Spark application
    spark-submit --master spark://$MASTER_HOST:7077 --total-executor-cores 84 examples/src/main/python/pi.py 100
    # total-executor-cores = [NODE_SAYISI]*[NODE_BASINA_DUSEN_GOREV_SAYISI]*[GOREV_BASINA_DUSEN_CEKIRDEK_SAYISI]

İşi kuyruğa gönderin ve gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    sbatch submit-pi-hamsi.sh
    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat spark-test-pi-hamsi.out

Örnek: Temel SQL özelliklerini kullanma
*****************************************

``/truba/home/$USER/spark/submit-sql-hamsi.sh`` dosyasını oluşturup düzenleyin:

.. note::

    Betikteki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirin.

.. warning::

    * ``--memory`` opsiyonunu kullanırken node üzerinde talep ettiğiniz hafızayı dikkate alınız.
    * Node sayısı, görev sayısı ve görev başına düşen çekirdek sayısını değiştirirseniz ``--total-executor-cores`` parametresini doğru hesaplayarak güncelleyiniz.

.. code-block:: bash
    :caption: submit-sql-hamsi.sh

    #! /bin/bash
    #SBATCH -p hamsi
    #SBATCH -A [USERNAME]
    #SBATCH -J spark-test-sql-hamsi
    #SBATCH -o spark-test-sql-hamsi.out
    #SBATCH -N 3
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=28
    #SBATCH --time=0:10:00

    # Activate conda environment
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate spark-env

    # Start Spark cluster
    rm -rf /truba_scratch/$USER/spark-log-dir/*
    MASTER_HOST="$(hostname)"
    echo $MASTER_HOST
    /truba/home/$USER/spark/sbin/start-master.sh
    srun /truba/home/$USER/spark/sbin/start-worker.sh spark://$MASTER_HOST:7077 --cores 28 --memory 96G &
    # memory = [NODE_BASINA_ISTENEN_CEKIRDEK_SAYISI]/[NODE_UZERINDEKI_TOPLAM_CEKIRDEK_SAYISI]

    # Submit Spark application
    spark-submit --master spark://$MASTER_HOST:7077 --total-executor-cores 84 examples/src/main/python/sql/basic.py
    # total-executor-cores = [NODE_SAYISI]*[NODE_BASINA_DUSEN_GOREV_SAYISI]*[GOREV_BASINA_DUSEN_CEKIRDEK_SAYISI]

İşi kuyruğa gönderin ve gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    sbatch submit-sql-hamsi.sh
    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat spark-test-sql-hamsi.out

``--executor-memory`` opsiyonu
--------------------------------

``spark-submit`` ile Spark kümesine uygulama çalıştırdığınızda her bir worker düğümünde çalışacak executor'lar için varsayılan hafıza değerini ``--executor-memory`` opsiyonunu kullanarak değiştirebilirsiniz.

.. code-block:: bash

    spark-submit --master spark://$MASTER_HOST:7077 --total-executor-cores 84 --executor-memory 16G my-spark-application.py
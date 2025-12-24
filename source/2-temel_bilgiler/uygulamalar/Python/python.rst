.. _python_kullanimi:


===================================
Python Kullanımı
===================================

Bu belge TRUBA altyapısında `Python <https://www.python.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.
Bu kılavuz aşağıdakileri kapsamaktadır:

.. grid:: 2

    .. grid-item-card::  :ref:`merkezi-python`
        :text-align: center
    .. grid-item-card:: :ref:`python-container`
        :text-align: center
    .. grid-item-card:: :ref:`python-ornek`
        :text-align: center


.. warning:: 
    
    * `/arf` depolama sistemine anaconda, miniconda, conda  veya herhangi bir Python kütüphanesi kesinlikle yüklenmemelidir, pip ve türevleri kullanılmamalıdır. Küçük boyutlu yüzbinlerce dosyadan oluştuğu için, her kullanıcının kendi ev dizinine kurduğu bu tip kütüphaneler dosya sistemlerinin performanslarını büyük ölçüde düşürmekte ve çalışan işlerin yavaşlamasına neden olmaktadır.
    * `/arf/sw/lib` dizininde çok geniş kapsamlı conda kütüphaneleri hali hazırda yüklüdür. Ayrıca YBH sistemleri için oluşturulmuş conda konteynerleri kullanıcılarımızın kullanımına sunulmuş durumdadır. Kullanıcılarımız Python ve conda ihtiyaçları için bu kurulumları kullanabilir ya da kendi Python konteynerlerini oluşturabilirler. Detaylar aşağıdaki bağlantıdan erişilebilir.


.. _merkezi-python:

----------------
Merkezi Modüller
----------------

Sistemde bulunan kurulumlari ``module av`` ile listeleyebilirsiniz. Temelde, conda ve standart ortam olmak üzere iki farklı python platformu ve yapay zeka paketlerin kapsayan CPU ve GPU tabanli moduller bulunmaktadır. Conda platformu içerisinde ise standart ve intel optimize edilmiş python olmak üzere iki farklı kullanım mevcuttur.

1. Standart Python:
    .. code-block:: 

        module load comp/python/3.12.2

2. Conda ortamında bulunan Python:
    - Standart python için

    .. code-block:: bash

        module load miniconda3

    - Intel optimize python için

    .. code-block:: bash

        module load miniconda-intelpython3

3. Yapay Zeka icin Python paketleri:
    Yapay zeka alanında sıklıkla kullanılan ``XGBoost, Catboost, TensorFlow, Keras, PyTorch, Lightning, scikit-learn, tranformers, deepspeed, datasets, langchain...`` paketleri CPU ve GPU bazli olmak uzere iki farkli kurulum hazırlanmıştır. Bu modülleri kullanmak için aşağıdaki komutları kullanabilirsiniz.

    .. tabs::

        .. tab:: CPU

            .. code-block:: bash

                module purge
                module load apps/truba-ai/cpu-2024.0
                

        .. tab:: GPU

            .. code-block:: bash
        
                module purge
                module load apps/truba-ai/gpu-2024.0

.. warning:: 

    **Hangi kuyruk için hangi platfomu seçmeliyiz?**

    İlgili komut çalıştırıldıktan sonra ``conda info`` ve ``conda list`` ile sanal ortam bilgisine ve içerisinde bulunan paketlerin versiyonlarına erişim sağlayabilirsiniz. Bu bilgiler ile birlikte :ref:`arf_kuyruk_bilgisi` altinda sunucu bilgilerinden ihtiyacınıza göre hangi platformu hangi kuyruk ile kullanmanız gerektiğine karar verebilirsiniz.

.. _bashrc_ekleme:

Bashrc Dosyası Düzenleme
------------------------

.. note::

    İlgili ortamları kulllanıcı arayüzlerinde ve hesaplama sunucularında aktif olması isteniliyorsa ``.bashrc`` ya da ``.bash_profile`` dosyanıza ihtiyaç duyduğunuz satırı eklemeniz gerekmektedir.
    
    Eğer ev dizininizde ``.bash_profile`` dosyası yoksa dosyayı yaratın. Ayrıca ``.profile`` ve ``.bashrc`` dosyalarını sembolik olarak ``.bash_profile`` dosyasına bağlamanız gerekebilir.

    .. code-block:: bash

        touch .bash_profile
        rm .profile .bashrc
        ln -s .bash_profile .profile
        ln -s .bash_profile .bashrc

Ayrıca, sadece ihtiyaç duyulan zamanlarda aktif edilmek istenilirse terminalde doğrudan ilgili komutu kullanabilirsiniz. SLURM betik dosyanızda da benzer şekilde ilgili anaconda versiyonu için olan yukarıdaki komutu yazmanız gerekmektedir.

.. _python-container:

-------------------
Python ve Konteyner
-------------------

Konteyner Oluşturma 
-------------------

Merkezi Python ortamlarını kullanmak istemeyen kullanıcılar, kendi ortamlarını oluşturmak için ``Docker`` ya da ``Apptainer (Singularity)`` konteynerlerini kullanabilirler. Bu konteynerlerin kullanımı detaylı olarak :ref:`Apptainer` sayfasında anlatılmıştır.

Aşağıda, ``/arf/sw/containers/miniconda3`` dizininde yer alan ``miniconda3-container.sif`` varsayılan konteyneri üzerinden, gerekli paketlerin kurulumu ve kullanıcıya özel konteynerin oluşturulması adımları belirtilmiştir.

Süreç; Kopyala - Aç - Yaz - Kapat - Kullan adımlarını içerir.

1. Kopyalama:
   
.. code-block:: bash

    mkdir -p $HOME/container-user && cd $HOME/container-user
    cp -r /arf/sw/containers/miniconda3/miniconda3-container.sif ./

2. Açma:
   
.. code-block:: bash

    apptainer build --sandbox miniconda3-user miniconda3-container.sif
    
.. code-block:: bash

    apptainer shell --no-home --writable --fakeroot miniconda3-user
    # veya
    * apptainer shell --no-home --writable miniconda3-user

3. Yazma:
   

.. code-block:: bash

    conda install -c conda-forge numpy pandas matplotlib seaborn scikit-learn

veya

.. code-block:: bash

    python -m pip install teaspoon


1. Çıkış:
 
.. code-block:: bash

    exit


2. Kapatma:
   
.. code-block:: bash

    apptainer build miniconda3-user.sif miniconda3-user


Konteyner Kullanımı
-------------------

Konteyner ortamında önceden yapılandırılmış Python kurulumunu kullanarak, aşağıdaki adımları izleyebilirsiniz:

1. Konteynerde kurulu Python’un versiyonunu kontrol etmek için:

.. code-block:: bash

    apptainer exec miniconda3-user.sif python --version

2. Hazırladığınız Python betiğini konteyner ortamında çalıştırmak için:

.. code-block:: bash

    apptainer exec miniconda3-user.sif python your_script.py

3. İnteraktif Python oturumu başlatmak için:

.. code-block:: bash

    apptainer exec -w miniconda3-user.sif python

Ek İpucu:
    Gerekli paketler ve ortam ayarları konteyner içerisinde önceden yapılandırılmıştır. İhtiyaç duyarsanız, ortam değişkenlerini de komut satırından ayarlayabilirsiniz.

.. _python-ornek:

Örnek Betik
-----------

İşlerinizi slurm dosyası hazırlayarak kullanıcı arayüzlerinde ``sbatch`` ile  sunucularda çalıştırılması üzere kuyruğa gönderilmelidir. Örnek betikler ``/arf/sw/scripts/python/`` dizininde bulunmaktadır.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek Betik -CPU (Tıklayınız)
    :color: info

    .. tab-set::

        .. tab-item:: İş Gönderme

            .. code-block:: bash

                sbatch job.slurm

        .. tab-item:: job.slurm

            .. code-block:: bash
        
                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --output=slurm-%j.out
                #SBATCH --error=slurm-%j.err
                #SBATCH --time=00:15:00
                #SBATCH --job-name=test

                #SBATCH --partition=orfoz
                #SBATCH --ntasks=112
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=1

                ###SBATCH --mal-user= your_email_address
                ###SBATCH --mail-type=BEGIN,END,FAIL
                ###SBATCH --mail-type=ALL

                ### Load modules

                module purge
                module load apps/truba-ai/cpu-2024.0

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                ### jobs
                python xgboost-test.py

                exit

        .. tab-item:: xgboost-test.py
            
            ..  code-block:: python

                from sklearn.datasets import make_classification
                from sklearn.model_selection import train_test_split
                from sklearn.metrics import accuracy_score
                from xgboost import XGBClassifier
                from matplotlib import pyplot

                import time
                start_time = time.time()  # Record the start time

                # define dataset
                X, y = make_classification(n_samples=100000, n_features=100, n_informative=100, n_redundant=0, random_state=1)

                # split data into train and test sets
                X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.50, random_state=1)

                # define the model
                model = XGBClassifier(n_estimators=2000, eta=0.05, subsample=0.5, colsample_bytree=0.5)

                # define the datasets to evaluate each iteration
                evalset = [(X_train, y_train), (X_test,y_test)]

                # fit the model
                model.fit(X_train, y_train, eval_metric='logloss', eval_set=evalset)

                # evaluate performance
                yhat = model.predict(X_test)
                score = accuracy_score(y_test, yhat)
                print('Accuracy: %.3f' % score)

                # retrieve performance metrics
                results = model.evals_result()
                print(results)

                evaluation_time = time.time() - start_time  # Calculate the elapsed time
                print("Evaluation Time:", round(evaluation_time, 2), "seconds")


.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek Betik - GPU (Tıklayınız)
    :color: info

    .. tab-set::

        .. tab-item:: İş Gönderme

            .. code-block:: bash

                sbatch job.slurm

        .. tab-item:: job.slurm

            .. code-block:: bash
        
                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --output=slurm-%j.out
                #SBATCH --error=slurm-%j.err
                #SBATCH --time=00:15:00
                #SBATCH --job-name=test

                #SBATCH --partition=xxxxx-cuda
                #SBATCH --ntasks=10
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=1
                #SBATCH --gres=gpu:1

                ###SBATCH --mal-user= your_email_address
                ###SBATCH --mail-type=BEGIN,END,FAIL
                ###SBATCH --mail-type=ALL

                ### Load modules

                module purge
                module load comp/python/ai-tools-kolyoz-1.0

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                ### jobs
                python tensor-torch-test.py

                exit

        .. tab-item:: tensor-torch-test.py
            
            ..  code-block:: python

                import torch
                import lightning
                import pytorch_lightning
                print("######## TORCH ########")

                print("Torch version: {}", torch.__version__)
                print("Lightning version: {}", lightning.__version__)

                print("TORCH-GPU available:{} " , torch.cuda.is_available())

                # Check if CUDA is available
                if torch.cuda.is_available():
                    # Get the number of available GPUs
                    num_gpus = torch.cuda.device_count()

                    # Loop through each GPU and print its properties
                    for i in range(num_gpus):
                        props = torch.cuda.get_device_properties(i)
                        print(f"GPU {i}: {props.name}")
                        print(f"  - Total Memory: {props.total_memory / 1e9} GB")
                        print(f"  - MultiProcessor Count: {props.multi_processor_count}")
                else:
                    print("CUDA is not available on this system.")

                print('#########################')

                import os
                import tensorflow as tf
                print('tf version: ')
                print(tf.__version__)

                os.environ['TF_XLA_FLAGS'] = '--tf_xla_enable_xla_devices'
                print("GPUs: ", len(tf.config.experimental.list_physical_devices('GPU')))

                from tensorflow.python.client import device_lib
                print("Local Devices:", device_lib.list_local_devices())

                print('GPU List: ')
                print(tf.config.list_physical_devices('GPU'))

                strategy = tf.distribute.MirroredStrategy()
                print("Number of devices: {}".format(strategy.num_replicas_in_sync))

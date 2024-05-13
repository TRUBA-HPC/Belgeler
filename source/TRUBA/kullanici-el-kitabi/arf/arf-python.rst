.. _arf-python:

===============================
ARF Kümesinde Python Kullanımı
===============================

Bu belge ARF kumelerinde `Python <https://www.python.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.

.. grid:: 3

    .. grid-item-card::  :ref:`arf-python-kullanimi`
        :text-align: center
    .. grid-item-card:: :ref:`arf-jupyter-araclari`
        :text-align: center
    .. grid-item-card:: :ref:`arf-python-ornek`
        :text-align: center

.. _arf-python-kullanimi:

----------------
Python Kullanımı
----------------

Sistemde kullanılabilecek conda ve standart ortam olmak üzere iki farklı python platformu bulunmaktadır. Conda platfomu içerisinde ise standart ve intel optimize edilmiş python olmak üzere iki farklı kullanım mevcuttur.

- Standart Python

    .. code-block:: 

        module load comp/python/3.12.2
    ile yüklemeler yapilabiblir. Bu python kullanılarak bir sanal ortam oluşturulması ve o ortam içerisine ihtiyaç duyulan paketlerin oluşturulan sanal ortama kurulması önerilmektedir. Bu süreç aşağıdaki adımlar ile tamamlanabilir:

    - Sanal ortam oluşturma : ``virtualenv /arf/home/$USER/python-3.12``
    - Sanal ortamı aktif etme : ``source /arf/home/$USER/python3.12/bin/activate``
    - Python ve pip kontrol etme: ``which python && which pip``
    - pip güncelleme: ``pip install --upgrade pip``
    - Paket yükleme ``python -m pip install paket-ismi`` 

- Conda ortamında bulunan Python

    - Standart python için

        .. code-block:: bash

            module load miniconda3

    - Intel optimize python için

        .. code-block:: bash

            module load miniconda-intelpython3

    ile yüklemeler yapılabiblir ve ``conda info`` ile conda platformunu ayarlamalarını  ve ``conda list`` ile içerisinde varsayılan olarak sunulan paketleri görüntüleyebilirsiniz. İhtiyaç halinde 

    - Ortam oluşturma: ``conda create -n custom-env``
    - Ortamı aktif etme: ``conda activate custom-env``
    - İstenilen python versiyonu kurma: ``conda install python=<version>``
    - Paket kurmak icin 
        
        .. code-block::       
            
            conda install -c <channel-name> <package-name>
            python -m pip install --user <package-name>

.. _arf-jupyter-araclari:

--------------------------
Jupyter Araçları 
--------------------------

ARF sisteminde interaktif islerinizi gerceklestirebileceginiz Open OnDemand servis edilmisitr. :ref:`arf-baglanti` sayfasindan interaktif arayuze ait baglanti bilgilerine erisebilirsiniz. Bu grafik kullanici arayuz uzerinde bulunan notebook kullanim ozet bilgileri su sekildedir:

**Jupyter Notebook - Intel AI tools**

Bu jupyter notebook, yapay zeka alanında kullanılan intel işlemciler için özelliştirilmiş paketlerin kurulumlarını içermektedir. Buradan açılmış bir jupyter notebook içerisinde

.. code-block:: 

    !conda list

ile yüklü paketleri listeleyebilirsiniz. Temel olarak, ``XGBoost, TensorFlow, Keras, PyTorch, Scikit-learn`` paketleri intel işlemciler ile optimize çalışacak şekilde mevcuttur. Daha fazla detayına `buradan <https://www.intel.com/content/www/us/en/developer/tools/oneapi/ai-analytics-toolkit.html#gs.9ay6kn>`_ erişebilirsiniz.

**Jupyter Notebook - Custom**

Bu araç ile jupyter notebook talebiniz kullanıcı ev dizininide belirtilen özelleşmiş jupyter ortamlarında başlatılmaktadır. Örnek olarak, merkezi miniconda kullanılarak ``test-env`` isminde bir conda ortamı oluşturduğunuzu ve bu ortam içerisinde kullanıcı ihtiyacı olan paketlerin kurulumları ve jupyter paketleri kurulduğunu varsayalım. 
Sonrasında kullanıcı ev dizininde bulunan ``.bashrc`` dosyası içerisinde

.. code-block:: 

    module load miniconda3
    conda activate test-env

eklendiği durumda jupyter notebook test-env ortamı içerisinde açılmaktadır.

.. _arf-python-ornek:

Örnek Betik
------------

Jupyter araçları kullanarak kısa süreli ve kısıtlı kaynak üzerinden çalışabilirsiniz. Asıl işinizi slurm dosyası hazırlayarak ``arf-ui1/arf-ui2`` kullanıcı arayüzlerinde ``sbatch`` ile orfoz sunucularında çalıştırılması üzere kuyruğa gönderilmelidir.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek Betik (Tıklayınız)
    :color: info

.. tabs::

    .. tab:: Is Gonderme

        .. code-block:: bash

            sbatch job.slurm

    .. tab:: job.slurm

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
            module load comp/python/ai-tools

            echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

            ### jobs
            python xgboost-test.py

            exit

    .. tab:: xgboost-test.py
        
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

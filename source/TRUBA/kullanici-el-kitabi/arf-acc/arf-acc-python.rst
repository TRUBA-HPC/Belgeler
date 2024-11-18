.. _arf-acc-python:

===============================
Python Kullanımı
===============================

Bu belge ARF ACC kumelerinde `Python <https://www.python.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.

.. grid:: 2

    .. grid-item-card::  :ref:`arf-acc-python-kullanimi`
        :text-align: center
    .. grid-item-card:: :ref:`arf-acc-python-ornek`
        :text-align: center

.. _arf-acc-python-kullanimi:

----------------
Python Kullanımı
----------------

Yapay zeka alanında sıklıkla kullanılan ``XGBoost, Catboost, TensorFlow, Keras, PyTorch, Lightning, scikit-learn, tranformers, deepspeed, datasets, langchain...`` paketleri NVIDIA H100 ve A100 GPUlar ile uyumlu özelliştirilmiş kurulumlarını içeren bir modül hazırlanmıştır. Bu modülü 

    .. code-block:: bash

        module load apps/truba-ai/gpu-2024.0

ile yükledikten sonra, ``conda list`` komutu ile yüklü paketleri listeleyebilirsiniz.

.. _arf-acc-python-ornek:

Örnek Betik
------------

İşinizi slurm dosyası hazırlayarak ``cuda-ui`` kullanıcı arayüzünde ``sbatch`` ile ``kolyoz`` sunucularında çalıştırılması üzere ``kolyoz-cuda`` kuyruğa gönderilmelidir. Örnek betikler ``/arf/sw/scripts/python/kolyoz-cuda/`` dizininde bulunmaktadır.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek Betik (Tıklayınız)
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

                    #SBATCH --partition=kolyoz-cuda
                    #SBATCH --ntasks=16
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

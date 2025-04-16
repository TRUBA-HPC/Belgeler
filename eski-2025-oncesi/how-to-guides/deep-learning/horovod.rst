=====================
Horovod Kılavuzu
=====================

Horovod kullanarak tek GPU için hazırladığınız model eğitimini çok sayıda GPU için ölçeklendirebilirsiniz. Bu belge TRUBA altyapısında Horovod uygulamasının kullanımını kolaylaştırmak için oluşturulmuştur.

---------------------------------------
Conda Sanal Ortamı Kullanarak Çalışma
---------------------------------------

TRUBA altyapısında Anaconda kullanarak yarattığınız sanal ortama Horovod ve ilgili kütüphaneleri yükleyebilirsiniz.

.. note::

    Sanal ortam kullanarak belirli bir Python sürümü için bir Python kurulumu ve bir dizi ek paket içeren bağımsız bir dizin ağacı yaratabilirsiniz. Bu sayede farklı uygulamalarınız için farklı sanal ortamlar yaratarak çakışan gereksinimlerin oluşmasını önlersiniz.


Kütüphanelerin Kurulumu
========================

.. warning::

    Belgenin geri kalanda ev dizinine Miniconda kurulumu yapılmış kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :doc:`Python Kılavuzu'nu <../python/anaconda>` takip ederek yapabilirsiniz.

Conda sanal ortamına Horovod kurulumu için gerekli kütüphaneler `ilgili GitHub deposundaki <https://github.com/kaust-vislab/horovod-gpu-data-science-project>`_ ``environment.yml`` dosyasında bulunmaktadır. Bu depoyu klonlayın.

.. code-block:: bash
        
    git clone https://github.com/kaust-vislab/horovod-gpu-data-science-project.git
    cd horovod-gpu-data-science-project 

.. note::

    ``environment.yml`` dosyasında ``-r file:requirements.txt`` söz dizimi mevcutsa ``file:`` ibaresini kaldırmanız gereklidir.

    .. code-block:: bash
        
        - pip:
          - -r requirements.txt # file: ibaresi mevcutsa kaldırın.

Conda sanal ortamına kurulum yapmak uzun sürdüğü için bir ``sbatch`` kodu hazırlayın:

.. code-block:: bash

    touch install-horovod.sh

.. note::

    Aşağıdaki kodda ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirin.

.. code-block:: bash
    :caption: install-horovod.sh

    #!/bin/bash
    #SBATCH -p hamsi
    #SBATCH -A [USERNAME]
    #SBATCH -J install-horovod
    #SBATCH -o output-install-horovod.out
    #SBATCH -n 1
    #SBATCH -N 1
    #SBATCH -c 28
    #SBATCH --time=1:00:00

    hostname
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

    module load centos7.9/lib/cuda/11.0

    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.0
    export HOROVOD_CUDA_HOME=$CUDA_HOME
    export HOROVOD_NCCL_HOME=/truba/home/$USER/miniconda3/envs/horovod-test
    export HOROVOD_NCCL_LINK=SHARED
    export HOROVOD_GPU_OPERATIONS=NCCL

    conda remove --name horovod-test --all -y
    conda create --name horovod-test -y
    conda activate horovod-test
    conda env update --file environment.yml

İşi kuyruğa gönderin:

.. code-block:: bash
    
    sbatch install-horovod.sh

Kurulumun Test Edilmesi
========================

Kurulumu interaktif olarak :doc:`cuda kümelerinde <../GPU/index>` test edebilirsiniz:

.. code-block:: bash
    
    srun -n 1 -N 1 -c 10 --gres=gpu:1 -p akya-cuda --time 00:10:00 --pty /bin/bash

.. code-block:: bash

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    module load centos7.9/lib/cuda/11.0
    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.0
    export HOROVOD_CUDA_HOME=$CUDA_HOME
    export HOROVOD_NCCL_HOME=/truba/home/$USER/miniconda3/envs/horovod-test
    export HOROVOD_NCCL_LINK=SHARED
    export HOROVOD_GPU_OPERATIONS=NCCL
    conda activate horovod-test
    horovodrun --check-build

Aşağıdaki gibi bir çıktı görmelisiniz:

.. code-block:: bash

    Horovod v0.21.3:

    Available Frameworks:
        [X] TensorFlow
        [X] PyTorch
        [ ] MXNet

    Available Controllers:
        [X] MPI
        [X] Gloo

    Available Tensor Operations:
        [X] NCCL
        [ ] DDL
        [ ] CCL
        [X] MPI
        [X] Gloo

sbatch Kullanarak Kuyruğa İş Gönderme
======================================

.. note::

    Bu başlıkta `Horovod GitHub deposunda <https://github.com/horovod/horovod/>`_ bulunan örnek kodları TRUBA altyapısında tek sunucu ve çok sayıda sunucuda çok sayıda GPU ile çalıştırmak için sbatch kodları sağlanmıştır. Bunun yanı sıra, tek GPU'da çalışan model eğitiminizi Horovod ile ölçeklendirmek için kodunuzda bazı değişikler yapmanız gerekmektedir. Değişiklikler için ilgili Horovod dokümantasyon sayfalarını takip edebilirsiniz:

    * `Tensorflow <https://horovod.readthedocs.io/en/stable/tensorflow.html>`_
    * `Keras <https://horovod.readthedocs.io/en/stable/keras.html>`_
    * `PyTorch <https://horovod.readthedocs.io/en/stable/pytorch.html>`_
    * `MXNet <https://horovod.readthedocs.io/en/stable/mxnet.html>`_

Horovod deposunu klonlayın:

.. code-block:: bash
        
    cd
    git clone https://github.com/horovod/horovod.git
    cd horovod-gpu-data-science-project

Tek sunucu, çok sayıda GPU
---------------------------

İşi ilgili kuyruğa göndermek için ``pytorch-synthetic-benchmark-1N.sh`` dosyasını oluşturup düzenleyin.

.. code-block:: bash
    :caption: pytorch-synthetic-benchmark-1N.sh

    #SBATCH -p palamut-cuda
    #SBATCH -A [USERNAME]
    #SBATCH -J horovod-1N
    #SBATCH -o output-pytorch-synthetic-benchmark-1N.out
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=8
    #SBATCH --cpus-per-task 16
    #SBATCH --gres=gpu:8
    #SBATCH --time=0:05:00

    export SERVER_NAME=palamut 
    export SERVER1_NUMBER=`echo "$SLURM_JOB_NODELIST" | grep -Eo [[:digit:]]+ | sed -n 1p`
    export SERVER1=$SERVER_NAME$SERVER1_NUMBER
    
    echo $SLURM_JOB_NODELIST
    echo $SERVER1

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.0
    export HOROVOD_CUDA_HOME=$CUDA_HOME
    export HOROVOD_NCCL_HOME=/truba/home/$USER/miniconda3/envs/horovod-gpu
    export HOROVOD_NCCL_LINK=SHARED
    export HOROVOD_GPU_OPERATIONS=NCCL
    
    conda activate horovod-test

    horovodrun -np $SLURM_NTASKS -H $SERVER1:8 \ 
	    python /truba/home/$USER/horovod/examples/pytorch/pytorch_synthetic_benchmark.py

.. note::

    Koddaki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla veya proje grubunuzla değiştirin.

.. warning::

    palamut-cuda yerine diğer cuda sunucularını kullanırsanız sunucu ismi ve sunucular üzerinde bulunan GPU sayısına göre kodu değiştirmeniz gerekir:

    * ``#SBATCH -p palamut-cuda``
    * ``#SBATCH --gres=gpu:8``
    * ``export SERVER_NAME=palamut``
    * ``horovodrun -np $SLURM_NTASKS -H $SERVER1:8 \``

İşi kuyruğa gönderin ve gönderdiğiniz işin durumunu kontrol edin:

.. code-block:: bash
    
    sbatch pytorch-synthetic-benchmark-1N.sh
    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat output-pytorch-synthetic-benchmark-1N.out

4 sunucu, çok sayıda GPU
-------------------------

İşi ilgili kuyruğa göndermek için ``pytorch-synthetic-benchmark-4N.sh`` dosyasını oluşturup düzenleyin.

.. code-block:: bash
    :caption: pytorch-synthetic-benchmark-4N.sh

    #SBATCH -p palamut-cuda
    #SBATCH -A [USERNAME]
    #SBATCH -J horovod-4N
    #SBATCH -o output-pytorch-synthetic-benchmark-4N.out
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=8
    #SBATCH --cpus-per-task 16
    #SBATCH --gres=gpu:8
    #SBATCH --time=0:05:00

    export SERVER_NAME=palamut
    export HOSTNAMES=`scontrol show hostnames $SLURM_JOB_NODELIST`
    export SERVER1_NUMBER=`echo "$HOSTNAMES" | grep -Eo [[:digit:]]+ | sed -n 1p`
    export SERVER2_NUMBER=`echo "$HOSTNAMES" | grep -Eo [[:digit:]]+ | sed -n 2p`
    export SERVER3_NUMBER=`echo "$HOSTNAMES" | grep -Eo [[:digit:]]+ | sed -n 3p`
    export SERVER4_NUMBER=`echo "$HOSTNAMES" | grep -Eo [[:digit:]]+ | sed -n 4p`
    export SERVER1=$SERVER_NAME$SERVER1_NUMBER
    export SERVER2=$SERVER_NAME$SERVER2_NUMBER
    export SERVER3=$SERVER_NAME$SERVER3_NUMBER
    export SERVER4=$SERVER_NAME$SERVER4_NUMBER

    echo $SLURM_JOB_NODELIST
    echo $SERVER1
    echo $SERVER2
    echo $SERVER3
    echo $SERVER4

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.0
    export HOROVOD_CUDA_HOME=$CUDA_HOME
    export HOROVOD_NCCL_HOME=/truba/home/$USER/miniconda3/envs/horovod-gpu
    export HOROVOD_NCCL_LINK=SHARED
    export HOROVOD_GPU_OPERATIONS=NCCL
    conda activate horovod-test

    horovodrun -np $SLURM_NTASKS -H $SERVER1:8,$SERVER2:8,$SERVER3:8,$SERVER4:8 \ 
	    python /truba/home/$USER/horovod/examples/pytorch/pytorch_synthetic_benchmark.py

.. note::

    Koddaki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla veya proje grubunuzla değiştirin.

.. warning::

    palamut-cuda yerine diğer cuda sunucularını kullanırsanız sunucu ismi ve sunucular üzerinde bulunan GPU sayısına göre kodu değiştirmeniz gerekir:

    * ``#SBATCH -p palamut-cuda``
    * ``#SBATCH --gres=gpu:8``
    * ``export SERVER_NAME=palamut``
    * ``horovodrun -np $SLURM_NTASKS -H $SERVER1:8,$SERVER2:8,$SERVER3:8,$SERVER4:8 \``

İşi kuyruğa gönderin ve gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash
    
    sbatch pytorch-synthetic-benchmark-4N.sh
    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat output-pytorch-synthetic-benchmark-4N.out
.. _gpu-kilavuzu:

===============
GPU Kılavuzu
===============

Bu belge TRUBA altyapısında GPU kaynaklarının kullanımını kolaylaştırmak için oluşturulmuştur.

----------------------
GPU Kaynağı Talep Etme
----------------------

TRUBA altyapısındaki GPU kaynakları SLURM kaynak yöneticisi ile kullanılabilir. GPU kaynağı bulunan kümelerde ``–-gres=gpu:n`` tanımı ile bu kaynaklar talep edilir.

.. note::
    ``–-gres=gpu:n`` tanımındaki ``n`` sayısı her bir sunucuda kullanılacak GPU sayısını belirtir. Kümelerdeki sunucular üzerinde farklı sayıda GPU bulunduğu için bu tanımlamanın işi göndereceğiniz kümeye göre yapılması gerekmektedir. GPU kaynağı bulunan kümeler için :doc:`hesaplama kümeleri belgesine <../../TRUBA/kullanici-el-kitabi/hesaplamakumeleri>` bakınız.

``sbatch`` ile gönderilmek üzere hazırlanan iş betiği örneği:

.. code-block::

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

    # Modüller
    # Çalıştırılacak komutlar

.. note::
    Betikteki ``[USERNAME]`` yer tutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

``srun`` ile iş çalıştırmak için örnek:

.. code-block:: bash
    
    srun -n 1 -N 1 -c 10 --gres=gpu:1 -p akya-cuda --time 1:00:00 # çalıştırılacak komutu buraya ekleyin.

``srun`` kullanarak 1 saat interaktif çalışmak için örnek:

.. code-block:: bash
    
    srun -n 1 -N 1 -c 10 --gres=gpu:1 -p akya-cuda --time 1:00:00 --pty /bin/bash

.. _core-gpu-count:

.. warning::
    Kümede talep ettiğiniz çekirdek sayısını kullanacağınız GPU sayısına göre belirleyiniz.

    * palamut-cuda kümesi için 16*[GPU_SAYISI]
    * akya-cuda ve akya-ai kümeleri için 10*[GPU_SAYISI]
    * barbun-cuda kümesi için 20*[GPU_SAYISI]

--------------------------------
GPU Kullanılan Uygulamalar
--------------------------------

.. toctree::
    :maxdepth: 1

    ../deep-learning/index.rst
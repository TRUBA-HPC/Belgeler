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
    ``--gres=gpu:n`` ifadesindeki ``n`` değeri, her bir sunucuda kullanılacak GPU sayısını belirtir. Kümelerde yer alan sunucularda farklı sayıda GPU bulunabileceği için bu değerin, işinizi göndereceğiniz kümeye uygun olarak belirlenmesi gerekir. GPU kaynağı bulunan kümeler hakkında daha fazla bilgi için bkz. :ref:`ARF Kuyruk Bilgisi <arf_kuyruk_bilgisi>` bölümü.


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

.. _core-gpu-count:

.. warning::
    Kümede talep ettiğiniz çekirdek sayısını kullanacağınız GPU sayısına göre belirleyiniz.

    * barbun-cuda kümesi için 20*[GPU_SAYISI] (Bir sunucuda 2 adet P100 bulunmaktadır.)
    * akya-cuda kümesi için 10*[GPU_SAYISI] (Bir sunucuda 4 adet V100 bulunmaktadır.)
    * palamut-cuda kümesi için 16*[GPU_SAYISI] (Bir sunucuda 8 adet A100 bulunmaktadır.)
    * kolyoz-cuda kümesi için 16*[GPU_SAYISI] (Bir sunucuda 4 adet H100 bulunmaktadır.)


.. note::

    palamut-cuda ve kolyoz-cuda kümelerinin kullanım izni ile ilgili bilgiler için lütfen :ref:`arf-acc` sayfasını inceleyiniz.
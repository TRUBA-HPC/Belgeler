.. _arf_acc_kuyruk_bilgisi:

===============
Kuyruk Bilgisi
===============


Her iki kümede iş kuyruğu adları ve özellikleri aynı şekilde yapılandırılmıştır. 

Zaman zaman bazı kuyruklardaki kaynak miktarı arttırılabilir ya da azaltılabilir, bazı kuyruklar kullanımdan kaldırılabilir. Herhangi bir kuyruğun bilgisine aşağıdaki komutla erişilebilir: 

.. code-block::

   scontrol show partition=kuyruk_adi 


Tüm kuyrukların varsayılan çalışma süresi 2 dakikadır. Betik dosyasında zaman bilgisi girilmeyen işler 2 dakika sonunda otomatik olarak sonlandırılmaktadır. Slurm betik dosyasında `#SBATCH -\-time <https://slurm.schedmd.com/sbatch.html>`_ komutu ile hesaplama için öngörülen zaman bilgisi girilen işler, belirtilen zaman sonunda otomatik olarak sonlandırılmaktadır. 

Her sunucu ailesinde, sunucu üzerindeki çekirdek sayısına ve bellek miktarına bağlı olarak bellek sınırlamaları mevcuttur. Eğer betik dosyalarında (ya da srun komutunda) herhangi bir bellek değeri girilmemişse, ilgili iş için, ``çekirdek sayısı x DefMemPerCore`` kadar bellek ayrılır. Betik dosyalarında (ya da srun komutunda) işler için ``--mem-per-core`` ya da ``--mem`` parametreleri ile daha fazla bellek talebinde bulunulabilir, ancak talep edilen bellek miktarı hiçbir koşulda *maxMemPerCore* degerini geçemez. *MaxMemPerCore* ve *DefMemPerCore* değerleri her sunucu ailesi için farklıdır. Tüm sunucular için bu verilere aşağıdaki tablodan erişilebilir. 

.. list-table:: Kuyruklar (partitions)
   :widths: 25 25 25 25 25 25 25 25
   :header-rows: 1
   
   * - Yıl
     - Adet
     - CPU/GPU
     - İşlemci Modeli
     - SPECfp_rate_base2006
     - Teorik Gflops
     - Bellek
     - Tanımı
   * - 🟢 palamut-cuda
     - palamut
     - 9  
     - 03-00:00:00
     - 16   
     - 7500MB  
     - 16GB
     - Aktif 
   * - 🟢 kolyoz-cuda
     - kolyoz
     - 24
     - 03-00:00:00  
     - 16  
     - 16GB 
     - 16GB
     - Aktif



..
  ``mid2`` ve ``long`` kuyruklarına gönderilen işler sardalya ya da barbun sunucularının herhangi birinde çalışmaya başlayabilirler. Bu kuyruklara gönderilecek işlerin belli bir sunucu ailesi üzerinde çalışması isteniyorsa, betik dosyalarına aşağıdaki tanımlar yazılmalıdır: 

  * barbunlar için 

  .. code-block::

   #SBATCH --constraint=barbun 

  * sardalyalar için 

  .. code-block::

   #SBATCH --constraint=sardalya 

  .. note::

   --contstraint parametresi yerine -C de kullanılabilir. 

  İşler önceden olduğu gibi üst kuyruklar yerine doğrudan sardalya, barbun veya diğer kuyruklarına gönderilebilir. 

.. warning::

  *barbun-cuda, akya-cuda*, *palamut-cuda* ve *kolyoz-cuda* kuyruklarına gönderilen işlerin GPU kullanabilecek ve GPU talep eden işler olması zorunludur.  GPU kümelerinin kullanımı ile ilgili dokümantasyon :ref:`gpu-kilavuzu` sayfamızı inceleyebilirsiniz.

..

.. code-block:: 

    sinfo

komutunu kullanarak kuyrukların mevcut doluluk durumunu görebilirsiniz. 

*Palamut-cuda*
^^^^^^^^^^^^^^

Her bir sunucuda 128 çekirdek ve 1TB bellek ayrıca 8'er adet Nvidia A100 80GB GPU (NVLink) kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 16 çekirdek ve 1 GPU talep etmelidir. Ayrıca sistemlerde scratch olarak kullanılmak üzere 12TB NVME disk /localscratch dizinine bağlanmıştır. Yüksek I/O gerektiren işlerin /localscratch dizininde çalıştırılması gerekmektedir.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi palamut-ui kullanıcı arayüzüne bağlandıktan sonra

.. code-block::

   scontrol show partition=palamut-cuda

komutu ile görülebilir.


*Kolyoz-cuda*
^^^^^^^^^^^^^^

Her bir sunucuda 64 çekirdek ve 1TB bellek ayrıca 4'er adet NVIDIA H100 80GB GPU (NVLink) kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 16 çekirdek ve 1 GPU talep etmelidir. Ayrıca sistemlerde tmp olarak kullanılmak üzere 7TB NVME disk / dizinine bağlanmıştır. Yüksek I/O gerektiren işlerin / dizininde çalıştırılması gerekmektedir.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi cuda-ui kullanıcı arayüzüne bağlandıktan sonra

.. code-block::

   scontrol show partition=kolyoz-cuda

komutu ile görülebilir.




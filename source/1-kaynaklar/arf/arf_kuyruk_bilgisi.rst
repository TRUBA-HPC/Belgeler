.. _arf_kuyruk_bilgisi:

==============
Kuyruk Bilgisi
==============

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
   * - 🟢 debug
     - orfoz, hamsi, barbun, barbun-cuda, akya-cuda
     - 238
     - 00-04:00:00
     - 1
     - 8000MB 
     - 9500MB
     - Aktif 
   * - 🔑 smp
     - orkinos
     - 1
     - 3-00:00:00
     - 4 
     - 17000MB  
     - 18400MB
     - Özel Kuyruk
   * - 🟢 barbun 
     - barbun   
     - 119  
     - 03-00:00:00  
     - 4
     - 8500MB  
     - 9500MB
     - Aktif
   * - 🟢 barbun-cuda 
     - barbun-cuda 
     - 24  
     - 03-00:00:00  
     - 20       
     - 8500MB    
     - 9500MB   
     - Aktif
   * - 🟢 akya-cuda
     - akya-cuda
     - 24  
     - 03-00:00:00 
     - 10 
     - 8500MB   
     - 9500MB
     - Aktif
   * - 🟢 hamsi  
     - hamsi 
     - 144  
     - 03-00:00:00      
     - 28    
     - 3400MB 
     - 3400MB
     - Aktif
   * - 🟢 orfoz 
     - orfoz 
     - 504
     - 03-00:00:00  
     - 56 / 55
     - 2000MB 
     - 2295MB
     - Aktif


.. warning::

  *barbun-cuda* ve *akya-cuda* kuyruklarına gönderilen işlerin GPU kullanabilecek ve GPU talep eden işler olması zorunludur.  GPU kümelerinin kullanımı ile ilgili dokümantasyon :ref:`gpu-kilavuzu` sayfamızı inceleyebilirsiniz.

..


*Debug*
^^^^^^^^^

Bu kuyruğa test amaçlı kısa süreli işler (öreneğin SLURM betik dosyanızın, kodunuzun doğru çalıştığından emin olmak için) gönderilir. Bu kuyruktaki herhangi bir işin çalışma süresi en fazla 15 dakikadır. 3 gün içinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=debug

komutu ile görülebilir. İlgili kuyrukta barbun, barbun-cuda, akya-cuda ve orkinos sunucuları tanımlıdır. Bu kuyruklara gönderilecek işlerin belli bir sunucu ailesi üzerinde çalışması isteniyorsa, betik dosyalarına aşağıdaki tanımlar yazılmalıdır: 

* Barbun için 

.. code-block::

  #SBATCH --constraint=barbun 

* Barbun-cuda için 

.. code-block::

  #SBATCH --constraint=barbun-cuda

* Akya-cuda için 

.. code-block::

  #SBATCH --constraint=akya-cuda

* Orkinos için 

.. code-block::

  #SBATCH --constraint=smp

.. note::

  `-\-contstraint` parametresi yerine `-C` de kullanılabilir. 



.. _barbun-node:

*Barbun*
^^^^^^^^

Her bir sunucuda 40 çekirdek ve 384GB bellek bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 15 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 20 çekirdek talep etmelidir. Kuyruğa gönderilebilecek işlerin minimum çekirdek sayısı 4'tür.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=barbun

komutu ile görülebilir.

.. _barbuncuda-node:

*Barbun-cuda*
^^^^^^^^^^^^^

Her bir sunucuda 40 çekirdek ve 384GB bellek ayrıca 2'şer adet Nvidia P100 16GB GPU kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 20 çekirdek ve 1 GPU talep etmelidir.

*Aynı sunucuda çalışmaya başlayan birden fazla iş aynı GPU kartını paylaşabilmektedir.*

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=barbun-cuda

komutu ile görülebilir.

*Akya-cuda*
^^^^^^^^^^^

Her bir sunucuda 40 çekirdek ve 384GB bellek ayrıca 4'er adet Nvidia V100 16GB GPU (NVLink) kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Ayrıca sistemlerde scratch olarak kullanılmak üzere 1.4TB NVME disk /tmp dizinine bağlanmıştır. Yüksek I/O gerektiren işlerin /tmp dizininde çalıştırılması gerekmektedir.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=akya-cuda

komutu ile görülebilir.

.. _hamsi-node:

*Hamsi*
^^^^^^^

Her bir sunucuda 56 çekirdek ve 192GB bellek bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 28 çekirdek talep etmelidir. Kuyruğa gönderilebilecek işlerin minimum çekirdek sayısı 28'dir.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=hamsi

komutu ile görülebilir.

.. _orfoz-node:

*orfoz*
^^^^^^^

Her bir sunucuda 112 çekirdek ve 256GB bellek bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 56 çekirdek talep edilmelidir. Kuyruğa gönderilebilecek işlerin minimum çekirdek sayısı 56'dır.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi ilgili kullanıcı arayüzüne bağlandıktan sonra

.. code-block::

   scontrol show partition=orfoz

komutu ile görülebilir.



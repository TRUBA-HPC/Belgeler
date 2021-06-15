
==================
Hesaplama Kümeleri
==================

Şu an için TRUBA iki farklı küme ile (Lüfer ve Levrek kümesi) hizmet vermektedir. TRUBA-lufer kümesindeki donanımlar lüfer sunucularından ve mercan sunucularının bir kısmından oluşmaktadır. TRUBA-levrek kümesinde ise levrek sunucuları ve mercan sunucularının bir kısmı bulunmaktadır.

TRUBA, her yıl yapılan düzenli alımlarla adım adım geliştirilmektedir. Yapılan her alım, zamanın ihtiyaçları ve mevcut sunucu teknolojileri gözüne alınarak yapıldığından, alınan hesaplama sunucularının modelleri, işlemcileri, çekirdek sayıları ve bellek miktarı farklılık göstermektedir.
	
----------------
TRUBA Kaynakları
----------------

2003 yılında faaliyete geçen TÜBİTAK ULAKBİM Yüksek Başarımlı ve Grid Hesaplama Merkezi'nde bulunan kaynaklar TRUBA'ya dahildir. Günümüzde TRUBA ~15.000 işlemci çekirdeği, 36 adet GPU ve toplamda 4PB Lustre dosya sistemi ile araştırmacılarımıza hizmet vermektedir.

+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|Yıl | Adet | CPU/GPU                                  | İşlemci Modeli                   | SPECfp_rate_base2006 | Teorik Gflops             | Bellek                | Tanımı                   |
+====+======+==========================================+==================================+======================+===========================+=======================+==========================+
|2003| 128  | 1 çekirdek x 1 CPU                       | Pentium IV 2.66 GHz              | -                    | -                         | 1 GB                  | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2006| 64   | 2 çekirdek x 2 CPU                       | Xeon 5110 1.60 GHz               | 17                   | -                         | 4 GB                  | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2006| 36   | 2 çekirdek x 2 CPU                       | Xeon 5110 1.60 GHz               | 17                   | -                         | 4 GB                  | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2007| 30   | 4 çekirdek x 2 CPU                       | Xeon X5355 2.66GHz               | 56.3                 | -                         | 16 GB                 | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2008| 16   | 4 çekirdek x 2 CPU                       | Opteron 2356 1.15GHz             | 81.3                 | 36.8                      | 16 GB                 | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2009| 154  | 4 çekirdek x 2 CPU                       | Xeon X5550 2.67GHz               | 184                  | 85.44                     | 24 GB                 | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2010| 52   | 12 çekirdek x 4 CPU                      | Opteron 6174 2.20GHz             | 574                  | 422.4                     | 128 GB                | Grid Sitesi&Federe Bulut |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2011| 192  | 12 çekirdek x 2 CPU                      | Opteron 6176 2.30GHz             | 294                  | 220.8                     | 128 GB                | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2013| 128  | 8 çekirdek x 2 CPU                       | Xeon E5-2690 2.90GHz             | 487                  | 371.2                     | 256 GB                | Özel Küme                |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2014| 48   | 12 çekirdek x 2 CPU                      | Xeon E5-2680 v3 2.50GHz          | 763                  | 960                       | 256 GB                | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2014| 16   | 12 çekirdek x 2 CPU & 2 x Nvidia M2090   | Xeon E5-2680 v3 2.50GHz          | 763                  | 960 Gflops & 2x1330 Gflops| 256 GB & 2x 6GB GDR5  | Kullanım Dışı            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2016| 1    | 14 çekirdek x 16 CPU                     | Xeon E7-4850 v3 2.20GHz          | -                    | 7.9 Tflops                | 4 TB                  | Orkinos Kümesi           |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2017| 128  | 14 çekirdek x 2 CPU                      | Xeon E5-2690 v3 2.60GHz          | 970                  | 1164 Gflops               | 256 GB                | Sardalya Kümesi          |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2018| 120  | 20 çekirdek x 2 CPU                      | Xeon Scalable 6148 2.40GHz       | 1400                 | 2048Gflops                | 384 GB                | Barbun Kümesi            |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2018| 24   | 20 çekirdek x 2CPU & 2xNvidia P100 GPU   | Xeon Scalable 6148 2.40GHz       | 1400                 | 2048Gflops & 9400Gflops   | 384 GB & 2x16 GB HBM2 | Barbun-Cuda Kümesi       |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+
|2021| 144  | 28 çekirdek x 2 CPU                      | Xeon(R) Gold 6258R CPU @ 2.70GHz | -                    | 3.234 Tflops              | 192 GB                | Hamsi Kümesi             |
+----+------+------------------------------------------+----------------------------------+----------------------+---------------------------+-----------------------+--------------------------+

----------------------
Güncel Sunucu Aileleri
----------------------
Güncel olarak kullanımda olan hesaplama kaynaları aşağıdaki gibidir. 

*Orkinos*
^^^^^^^^^
Sunucu üzerinde 4128 GB bellek, 224 adet Intel Xeon e7-4850 V4 çekirdeği bulunmaktadır. Yüksek belleki bir SMP sunucusudur. Üzerinde Redhat 7.2 işletim sistemi bulunmaktadır. Ortak dosya sistemine Infiniband ağ katmanı ile bağlıdır. Ortak dosya sistemi üzerindeki uygulamaların büyük bir çoğunluğu bu sistem üzerinde çalışabilir durumdadır. Ancak uygulamaların yüksek verimde çalışması için Intel derleyiciler ve MKL kütüphanesi ile ya da GCC derleyicileri ve kütüphaneleri ile derlenirken V3 işlemcilerin vektör komut setlerinin (AVX2) kullanılması için özellikle parametre girilmesi gerekmektedir.

*Sardalya*
^^^^^^^^^^

Sardalya sunucuları 153 adet Huawei Tecal RH1288 V3 model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon E5-2690 V4 işlemci ve toplam 28 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar. 

*Barbun ve Barbun-cuda*
^^^^^^^^^^^^^^^^^^^^^^^

Barbun sunucuları 120 adet Dell R640, Barbun-cuda sunucuları R740 model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon Scalable Gold 6148 işlemci ve toplam 40 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar.

*Akya-cuda*
^^^^^^^^^^^
Akya sunucuları 24 adet Supermicro 1029GQ-TRT model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon Scalable Gold 6148 işlemci ve toplam 40 adet işlemci çekirdeği ve 4 adet Nvidia Tesla V100 (32GB, NVLink ) GPU karti bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar.

*Hamsi (Yeni Nesil)*
^^^^^^^^^^^^^^^^^^^^
Hamsi sunucuları 144 adet INSPUR NF5180M5 sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adetIntel(R) Xeon(R) Gold 6258R CPU @ 2.70GHz işlemci ve toplam 56 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine HDR100 (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar. 

.. _partitions:

----------------------
Kuyruklar (partitions)
----------------------

Her iki kümede iş kuyruğu adları ve özellikleri aynı şekilde yapılandırılmıştır. 

Zaman zaman bazı kuyruklardaki kaynak miktarı arttırılabilir ya da azaltılabilir, bazı kuyruklar kullanımdan kaldırılabilir. Herhangi bir kuyruğun bilgisine aşağıdaki komutla erişilebilir: 

.. code-block::

   scontrol show partition=kuyruk_adi 

Kuyrukların kullanım durumuna, paylaşılan, dolu ya da boş olan node ve çekirdeklerin durumuna ``sinfo`` komutu ile erişilebilir. 

Tüm kuyrukların varsayılan çalışma süresi 2 dakikadır. Betik dosyasında zaman bilgisi girilmeyen işler 2 dakika sonunda otomatik olarak sonlandırılmaktadır. Slurm betik dosyasında `#SBATCH --time <https://slurm.schedmd.com/sbatch.html>`_ komutu ile hesaplama için öngörülen zaman bilgisi girilen işler, belirtilen zaman sonunda otomatik olarak sonlandırılmaktadır. 

Her sunucu ailesinde, sunucu üzerindeki çekirdek sayısına ve bellek miktarına bağlı olarak bellek sınırlamaları mevcuttur. Eğer betik dosyalarında (ya da srun komutunda) herhangi bir bellek değeri girilmemişse, ilgili iş için, ``çekirdek sayısı x DefMemPerCore`` kadar bellek ayrılır. Betik dosyalarında (ya da srun komutunda) işler için ``--mem-per-core`` ya da ``--mem`` parametreleri ile daha fazla bellek talebinde bulunulabilir, ancak talep edilen bellek miktarı hiç bir koşulda *maxMemPerCore* degerini geçemez. *MaxMemPerCore* ve *DefMemPerCore* değerleri her sunucu ailesi için farklıdır. Tüm sunucular için bu verilere aşağıdaki tablodan erişilebilir. 

+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|partitions   |   nodes      | #nodes  |  max run time | priority | min core | defMemPerCore  | maxMemPerCore |
+=============+==============+=========+===============+==========+==========+================+===============+
|  single     |  levrekv2    |     8   |  15-00:00:00  |  15000   |    1     |    9500MB      |    10500Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  short      |  sardalya    |    99   |  00-04:00:00  |  20000   |    4     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  short      |  barbun      |   119   |  00-04:00:00  |  20000   |    4     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  mid1       |  barbun      |   119   |  04-00:00:00  |  17500   |    4     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  mid1       |  sardalya    |    99   |  04-00:00:00  |  17500   |    4     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  mid2       |  barbun      |   119   |  08-00:00:00  |  15000   |    4     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  mid2       |  sardalya    |    99   |  08-00:00:00  |  15000   |    4     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  long       |  barbun      |   119   |  15-00:00:00  |  12500   |    4     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  long       |  sardalya    |    99   |  15-00:00:00  |  12500   |    4     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
| levrekv2    |  levrekv2    |    48   |  15-00:00:00  |  12500   |    4     |    9500MB      |    10500Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|levrekv2-cuda|  levrekv2    |    16   |  15-00:00:00  |  12500   |    4     |    9500MB      |    10500Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  smp        |  orkinos     |     1   |  15-00:00:00  |  12500   |    4     |    17000MB     |    18400Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  sardalya   |  sardalya    |   100   |  15-00:00:00  |  12500   |    4     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  barbun     |  barbun      |   119   |  15-00:00:00  |  12500   |    4     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
| interactive |  levrekv2    |     3   |  15-00:00:00  |  12500   |    1     |    9500MB      |    10500Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
| Barbun-cuda |  barbun-cuda |    24   |  15-00:00:00  |  12500   |   20     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  Akya-cuda  |  akya-cuda   |    20   |  15-00:00:00  |  12500   |   20     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  Hamsi      |   hamsi      |   144   |  03-00:00:00  |  12500   |    1     |    3400MB      |    34000Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  debug      |  barbun      |   119   |  00-00:15:00  |  12500   |    1     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  debug      |  barbun-cuda |    24   |  00-00:15:00  |  12500   |   20     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  debug      |  akya-cuda   |    24   |  00-00:15:00  |  12500   |   10     |    8500MB      |    9500Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  debug      |  orkinos     |     1   |  00-00:15:00  |  12500   |    1     |    17000MB     |    18400Mb    |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+
|  debug      |  sardalya    |    99   |  00-00:15:00  |  12500   |    1     |    8000MB      |    9000Mb     |
+-------------+--------------+---------+---------------+----------+----------+----------------+---------------+

Short, mid1, mid2 ve long kuyrukları, CPU tabanlı tüm sunucuları kapsayacak şekilde genişletilmiştir. Kuyrukların önceliklerinde çeşitli ayarlamalar yapılmış, süresi daha kısa olan kuyruklara gönderilen işlerin öncelikleri arttırılarak kısa süreli kuyruklara gönderilecek işlerin daha kısa sürede başlaması sağlanmıştır. 

  * Short kuyruğuna gönderilen işlerin önceliği 20000 
  * Mid1 kuyruğuna gönderilen işlerin önceliği 17500 
  * Mid2 kuyruğuna gönderilen işlerin önceliği 15000 
  * Single kuyruğuna gönderilen işlerin önceliği 15000 
  * Long ve geri kalan tüm kuyruklara gönderilen işlerin önceliği 12500 den başlamaktadır. 
  
Short, mid1, mid2 ve long kuyruklarını diğer kuyrukları kapsayacak üst kuyruklar olarak düşünülmelidir. Bu kuyruklara gönderilen işler levrek, levrekv2, sardalya ya da barbun sunucularının herhangi birinde çalışmaya başlayabilirler. Bu kuyruklara gönderilecek işlerin belli bir sunucu ailesi üzerinde çalışması isteniyorsa, betik dosyalarına aşağıdaki tanımlar yazılmalıdır: 

  * barbunlar için #SBATCH --constraint=barbun 
  * levrekler için #SBATCH --constraint=levrek 
  * sardalyalar için #SBATCH --constraint=sardalya 
  * levrekv2ler için #SBATCH --constraint=levrekv2 

.. note::

   --contstraint parametresi yerine -C de kullanılabilir. 

İşler önceden olduğu gibi üst kuyruklar yerine doğrudan mercan, levrekv2, sardalya ve barbun kuyruklarına gönderilebilir. 

*levrekv2-cuda, akya-cuda* ve *barbun-cuda* kuyruklarına gönderilen işlerin GPU kullanabilecek ve GPU talep eden işler olması zorunludur. Yeni düzenleme ile aynı GPU'u birden fazla iş tarafından kullanabilecektir. 

*Single*
^^^^^^^^^

Bu kuyruğa tek çekirdeklik (genelde seri) işler gönderilir. Toplam çekirdek sayısı 1 den fazla ise, iş başka bir kuyruğa gönderilmiş olsa bile, otomatik olarak bu kuyruğa yönlendirilir. 

Bu kuyruktaki herhangi bir işin çalışma süresi en fazla 15 gündür. 15 Gün içinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=single 

komutu ile görülebilir. 

*Short*
^^^^^^^

Kısa sürmesi beklenen işler bu kuyruğa gönderilmelidir. Kuyruktaki işler en fazla 4 saat çalışır. 4 saat içerisinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

Bu kuyruk ile ilgili ayrıntılı bilgi 

.. code-block::

   scontrol show partition=short 

komutu ile görülebilir. 

*Mid1*
^^^^^^

Bu kuyrukta çalışma süresi en fazla 4 gün olan işler çalıştırılır. Bu süre içerisinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır.

Bu kuyruk ile ilgili ayrıntılı bilgi 

.. code-block::

   scontrol show partition=mid1 

komutu ile görülebilir. 

*Mid2*
^^^^^^

Mid2 kuyruğundaki işlerin çalışma süresi en fazla 8 gündür. 8 gün içerisinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

Bu kuyruk ile ilgili ayrıntılı bilgi 

.. code-block::

   scontrol show partition=mid2 

komutu ile görülebilir. 

*Long*
^^^^^^

Long kuyruğundaki işlerin çalışma süresi en fazla 15 gündür. Bu süre zarfında tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

Bu kuyruk ile ilgili ayrıntılı bilgi 

.. code-block::

   scontrol show partition=long 

komutu ile görülebilir. 

*Interactive*
^^^^^^^^^^^^^

Interaktif işler çalıştırmak için kullanılır. İnteraktif işler ``Ondemand`` üzerinden ya da SSH terminalinden ``srun``, ``salloc`` ile kuyruğa gönderilebilir. Bu kuyrukta levrekv2 sunucuları kullanılmaktadır.

*Smp*
^^^^^

*Smp* kuyruğunda sadece *orkinos1* sunucusu bulunmaktadır. Kuyruk rezervasyon yönetimi ile çalıştırılmaktadır. Bu kuyruğu kullanmak isteyen kullanıcıların e-posta ile başvuruda bulunarak sistemi ne kadar süre ile kullanacaklarını, ne kadar kaynağa (işlemci/bellek) ihtiyaç duyduklarını bildirmeleri, ve ihtiyaçlarına göre bir rezervasyon yaptırmaları gerekmektedir.

Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=smp

komutu ile görülebilir.


*Sardalya*
^^^^^^^^^^

Her bir sunucuda 28 çekirdek ve 256GB bellek bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 15 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 14 çekirdek talep etmelidir. Kuyruğa gönderilebilecek işlerin minimum çekirdek sayısı 4'tür.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=sardalya

komutu ile görülebilir.

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
^^^^^^^^^^

Her bir sunucuda 40 çekirdek ve 384GB bellek ayrıca 2'şer adet Nvidia P100 16GB GPU kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 15 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 20 çekirdek ve 1 GPU talep etmelidir.

*Aynı sunucuda çalışmaya başlayan birden fazla iş aynı GPU kartını paylaşabilmektedir.*

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=barbun-cuda

komutu ile görülebilir.

*Akya-cuda*
^^^^^^^^^^

Her bir sunucuda 40 çekirdek ve 384GB bellek ayrıca 4'er adet Nvidia V100 16GB GPU (NVLink) kartı bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 15 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 40 çekirdek ve 4 GPU talep etmelidir. Ayrica sistemlerde scratch olarak kullanilmak uzere 1.4TB NVME disk /tmp dizinine baglanmistir. Yuksek I/O gerekiren islerin /tmp dizininde calıştırılması gerekmektedir.

*Aynı sunucuda çalışmaya başlayan birden fazla iş aynı GPU kartını paylaşabilmektedir.*

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=akya-cuda

komutu ile görülebilir.

.. _hamsi-node:

*Hamsi*
^^^^^^

Her bir sunucuda 56 çekirdek ve 192GB bellek bulunmaktadır. Kuyrukta işlerin en fazla çalışma süresi 3 gündür. Sistemin verimli kullanılabilmesi için gönderilecek işler en az 28 çekirdek talep etmelidir. Kuyruğa gönderilebilecek işlerin minimum çekirdek sayısı 28'dir.

İşlerde bellek sınırlaması kullanılmaktadır. Gönderilen işlerin sunucuların bellek sınırlamalarına uygun olarak gönderilmesi gerekmektedir. Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=hamsi

komutu ile görülebilir.

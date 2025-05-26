.. _hesaplama-kumeleri:

==================
Hesaplama Kümeleri
==================

TRUBA hesaplama kümeleri, her yıl geliştirilerek güncellenmektedir. Yapılan her güncelleme, zamanın ihtiyaçları ve mevcut sunucu teknolojileri gözüne alınarak yapıldığından, alınan hesaplama sunucularının modelleri, işlemcileri, çekirdek sayıları ve bellek miktarı farklılık göstermektedir.
	
Bu kılavuz aşağıdakileri kapsamaktadır:

.. grid:: 3

    .. grid-item-card::  :ref:`truba-kaynaklari`
        :text-align: center
    .. grid-item-card:: :ref:`guncel-sunucu-aileleri`
        :text-align: center
    .. grid-item-card:: :ref:`partitions`
        :text-align: center

.. _truba-kaynaklari:

----------------
TRUBA Kaynakları
----------------

2003 yılında faaliyete geçen TÜBİTAK ULAKBİM Yüksek Başarımlı ve Grid Hesaplama Merkezi'nde bulunan kaynaklar TRUBA'ya dahildir. Günümüzde TRUBA > 80.000 işlemci çekirdeği, 312 adet GPU ve toplamda 7.5PByte yapılandırılmış yüksek performanslı Lustre ve WEKA dosya sistemi ile araştırmacılarımıza hizmet vermektedir. 


.. list-table:: TRUBA Kaynakları
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
   * - 2016
     - 1
     - 14 çekirdek x 16 CPU
     - Xeon E7-4850 v3 2.20GHz
     - *-*
     - 7.9 Tflops
     - 4 TB 
     - orkinos
   * - 2017
     - 128 
     - 14 çekirdek x 2 CPU 
     - Xeon E5-2690 v3 2.60GHz
     - 970 
     - 1164 Gflops
     - 256 GB 
     - sardalya
   * - 2018
     - 120
     - 20 çekirdek x 2 CPU
     - Xeon 6148 2.40GHz
     - 1400
     - 2048Gflops
     - 384 GB
     - barbun
   * - 2018
     - 24
     - 20 çekirdek x 2CPU & 2xNvidia P100 GPU
     - Xeon 6148 2.40GHz
     - 1400
     - 2048Gflops & 9400Gflops 
     - 384 GB & 2x16 GB HBM2
     - barbun-cuda
   * - 2018
     - 24
     - 20 çekirdek x 2CPU & 4xNvidia V100 GPU
     - Xeon 6148 2.40GHz
     - 1400 
     - 2048Gflops & 4x7800Gflops
     - 384 GB & 4x16 GB HBM 
     - akya-cuda
   * - 2021
     - 144
     - 28 çekirdek x 2 CPU
     - Xeon 6258R 2.70GHz
     - *-*
     - 3.234 Tflops
     - 192 GB 
     - hamsi
   * - 2021
     - 9
     - 64 çekirdek x 2CPU & 8xNvidia A100 GPU
     - AMD 7742 2.24GHz
     - *-*
     - 4.600Gflops & 8x9.7Tflops
     - 1 TB & 8x80GB HBM
     - palamut-cuda
   * - 2023
     - 504
     - 56 çekirdek x 2CPU 
     - Intel(R) Xeon(R) Platinum 8480+ 2.0GHz
     - *-*
     - 7 Tflops
     - 256 GB
     - orfoz
   * - 2024
     - 24
     - 32 çekirdek x 2CPU & 4xNvidia H100 GPU
     - Intel(R) Xeon(R) GOLD 6548Y+ 2.5GHz
     - *-*
     - 5Tflops & 4x34Tflops
     - 1 TB & 4x80GB HBM
     - kolyoz-cuda 

.. _guncel-sunucu-aileleri:

----------------------
Güncel Sunucu Aileleri
----------------------
Güncel olarak kullanımda olan hesaplama kaynakları aşağıdaki gibidir. 

*Orkinos*
^^^^^^^^^
Sunucu üzerinde 4128 GB bellek, 224 adet Intel Xeon e7-4850 V4 çekirdeği bulunmaktadır. Yüksek belleki bir SMP sunucusudur. Üzerinde Redhat 7.2 işletim sistemi bulunmaktadır. Ortak dosya sistemine Infiniband ağ katmanı ile bağlıdır. Ortak dosya sistemi üzerindeki uygulamaların büyük bir çoğunluğu bu sistem üzerinde çalışabilir durumdadır. Ancak uygulamaların yüksek verimde çalışması için Intel derleyiciler ve MKL kütüphanesi ile ya da GCC derleyicileri ve kütüphaneleri ile derlenirken V3 işlemcilerin vektör komut setlerinin (AVX2) kullanılması için özellikle parametre girilmesi gerekmektedir.

..
  *Sardalya*
  ^^^^^^^^^^

  Sardalya sunucuları 153 adet Huawei Tecal RH1288 V3 model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon E5-2690 V4 işlemci ve toplam 28 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar. 

.. _barbun-cuda:

*Barbun ve Barbun-cuda*
^^^^^^^^^^^^^^^^^^^^^^^

Barbun sunucuları 120 adet Dell R640, Barbun-cuda sunucuları R740 model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon Scalable Gold 6148 işlemci ve toplam 40 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar. Barbun-cuda sunucularının her birinde ``2 adet NVIDIA P100`` GPU kartı bulunmaktadır.

..
  
  Mevcut durumda barbun bölümlendirmesinde 3 kuyruk tanımı bulunmaktadır: *mid2, long* ve *barbun*. Öncelik sıralaması da yüksekten düşüğe dogru *mid2, long* ve *barbun* şeklindedir. İşlerinizin tahmini çalışma süresine göre SLURM betik dosyanızda mid2 (maksimum 8 gün) veya long (maksimum 15 gün) kuyruklarını tanımlayabilirsiniz.

.. note::

  barbun-cuda sunucularında NVIDIA 565.57.01 sürücüsü bulunmaktadır:

  - NVIDIA-SMI 565.57.01              
  - Driver Version: 565.57.01      
  - CUDA Version: 12.7
  
  `NVIDIA 565.57.01 sürücüsü CUDA 12.x versiyonu ile uyumludur <https://docs.nvidia.com/deploy/cuda-compatibility/>`_ .

.. _akya-cuda:

*Akya-cuda*
^^^^^^^^^^^
Akya-cuda sunucuları 24 adet Supermicro 1029GQ-TRT model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel Xeon Scalable Gold 6148 işlemci ve toplam 40 adet işlemci çekirdeği ve ``4 adet NVIDIA Tesla V100`` (16GB, NVLink) GPU kartı bulunmaktadır. Sunucular birbirlerine EDR (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar.

.. note::

  akya-cuda sunucularında NVIDIA 550.90.07 sürücüsü bulunmaktadır:

  - NVIDIA-SMI 565.57.01              
  - Driver Version: 565.57.01      
  - CUDA Version: 12.7

  `NVIDIA 565.57.01 sürücüsü CUDA 12.x versiyonu ile uyumludur <https://docs.nvidia.com/deploy/cuda-compatibility/>`_ .

.. _hamsi:

*Hamsi*
^^^^^^^^^^^^^^^^^^^^
Hamsi sunucuları 144 adet INSPUR NF5180M5 sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel(R) Xeon(R) Gold 6258R CPU @ 2.70GHz işlemci ve toplam 56 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine HDR100 (100Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar. 

.. _orfoz:

*Orfoz*
^^^^^^^^^^^^^^^^^^^^
Orfoz sunucuları 504 adet Lenovo ThinkSystem SR630 V3 sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel(R) Xeon(R) Platinum 8480+ CPU @ 2.0GHz işlemci ve toplam 112 adet işlemci çekirdeği bulunmaktadır. Sunucular birbirlerine 200Gbps Infiniband ağ kartları ile bağlıdırlar. 

Orfoz sunucularının yer aldığı ARF hesaplama kümesi hakkındaki ayrıntılı bilgilere  :ref:`arf-genel-bilgileri` sayfasından erişim sağlayabilirsiniz.

.. _kolyoz-cuda:

*Kolyoz-cuda*
^^^^^^^^^^^^^^^^^^^^
Kolyoz sunucuları 24 adet `Lenovo ThinkSystem SD650-N V3 <https://www.lenovo.com/us/en/p/servers-storage/servers/supercomputing/thinksystem-sd650-n-v3-high-density-server/len21ts0028>`_ sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet Intel(R) Xeon(R) GOLD 6548Y+ CPU @ 2.5GHz işlemci ve toplam 64 adet işlemci çekirdeği ve 4 adet NVIDIA H100 (80GB, NVLink, HBM3, SXM5) GPU kartı bulunmaktadır. Sunucular birbirlerine 4 adet 200Gbps Infiniband ağ kartları ile bağlıdırlar. 

.. note::

 ``kolyoz-cuda`` kuyruğunda Rocky Linux (BLue Onyx) 9.4 işletim sistemi ve hesaplama sunucuları üzerinde NVIDIA 560.35.03 sürücüsü bulunmaktadır. `NVIDIA 560.35.03 sürücüsü CUDA 12.* versiyonu ile uyumludur <https://docs.nvidia.com/deploy/cuda-compatibility/>`_ .

  - NVIDIA-SMI 565.57.01
  - Driver Version: 565.57.01
  - CUDA Version: 12.7

Kolyoz sunucularının yer aldığı ARF ACC hesaplama kümesi hakkındaki ayrıntılı bilgilere  :ref:`arf-acc-genel-bilgiler` sayfasından erişim sağlayabilirsiniz.

.. _palamut-cuda:

*Palamut-cuda*
^^^^^^^^^^^^^^^^^^^^^^^^^^
Palamut sunucuları 9 adet HP Proliant XL675d Gen10 Plus model sunuculardan oluşmaktadır. Her bir sunucu üzerinde 2 adet AMD EPYC 7742 2.24GHz işlemci ve toplam 128 adet işlemci çekirdeği ve 8 adet Nvidia Tesla A100 (80GB, NVLink ) GPU kartı bulunmaktadır. Sunucular birbirlerine 4xHDR (200Gbps) Infiniband ağ kartları ile non-blocking yapıda bağlıdırlar.

.. note::

  Palamut-cuda kuyruğunda Rocky Linux (BLue Onyx) 9.4 işletim sistemi ve NVIDIA 565.57.01 sürücüsü bulunmaktadır. `NVIDIA 565.57.01 sürücüsü CUDA 12.X versiyonu ile uyumludur <https://docs.nvidia.com/deploy/cuda-compatibility/>`_ .

  - NVIDIA-SMI 565.57.01
  - Driver Version: 565.57.01
  - CUDA Version: 12.7

.. note::

  * kolyoz-cuda ve palamut-cuda hesaplama kümeleri özel küme olup sadece araştırma merkezleri tarafından yürütülen alt yapı projeleri (İlgili altyapı projeleri T.C. Cumhurbaşkanlığı Strateji ve Bütçe Başkanlığı, Strateji ve Bütçe Başkanlığı tarafından desteklenen projelerdir) ve de sözleşmeli proje araştırmacıları (TÜBİTAK ULAKBİM ile proje kapsamında sözleşmesi olan projeler) tarafından kullanılabilmektedir. Barbun-cuda ve akya-cuda hesaplama kümeleri tüm kullanıcılarımızın erişimine açıktır.

  * Mevcut durumda kolyoz-cuda ve palamut-cuda kuyrukları öncelikli olarak belirli araştırma gruplarına hizmet vermektedir. Bu araştırma gruplarında hesapları tanımlı olan kullanıcılar ``kolyoz-cuda`` ve/veya ``palamut-cuda`` hesaplama kümesine iş gönderebileceklerdir.

  * kolyoz-cuda ve palamut-cuda hesaplama kümeleri için ayrı bir kullanıcı arayüzü kurulmuştur (``cuda-ui``). İlgili cuda kuyruklarına sadece ``cuda-ui`` arayüzü üzerinden iş gönderilebilecektir. 

  * cuda-ui kullanıcı arayüzü üzerinde Rocky Linux 9.2 işletim sistemi bulunmaktadır.
  
  * kolyoz-cuda ve palamut-cuda hesaplama kümelerine erişim izni olan proje kullanıcıları aktif bir OpenVPN bağlantıları mevcut iken ``cuda-ui`` arayüz sunucusuna ``172.16.6.16`` IP adresine veya ``cuda-ui.yonetim`` adresine ssh ile bağlanabilirler.

  .. code-block:: bash

    ssh username@172.16.6.16
  
  veya

  .. code-block:: bash

    ssh username@cuda-ui.yonetim
  
  Veya aktif bir OpenVPN bağlantısı ile arf-ui kullanıcı arayüz sunucularından birisine bağlı iken ilgili kullanıcı arayüzü üzerinden cuda-ui arayüz sunucusuna ssh ile geçiş yapabilirler. SSH anahtalarını henüz oluşturmamış kullanıcılar, bu sunucuya arf-ui üzerinden geçiş yapabilmek için ssh anahtarlarını ``ssh-keygen`` ile aşağıdaki gibi oluşturabilirler:

  .. code-block::

    $>ssh-keygen (Sorulan tüm soruları “Enter” tuşuna basarak geçiniz)
   
    $>cp -p .ssh/id_rsa.pub .ssh/authorized_keys

.. warning::

   Her bir GPU icin kullanıcılar 16 çekirdek talep etmelidir. Örneğin: 2 sunucu üzerinde 4'er görev ve 4'er GPU kullanabilmek icin:
	
   .. code-block::

      srun -N 2  -n 8 -c 16 --gres=gpu:4   <komut>
      sbatch  -N 2  -n 8 -c 16 --gres=gpu:4 <betik_dosyasi>

   Kullanılacak toplam çekirdek sayısı = n x c

   N : kulllanılacak node sayısı

   n : çalıştırılacak görev sayısı

   c : her bir görev için kullanılacak çekirdek sayısı (varsayılan 1)

   gres=gpu:x : her bir node üzerinde kullanılacak GPU sayısı

.. _partitions:

----------------------
Kuyruklar (partitions)
----------------------

Her iki kümede iş kuyruğu adları ve özellikleri aynı şekilde yapılandırılmıştır. 

Zaman zaman bazı kuyruklardaki kaynak miktarı arttırılabilir ya da azaltılabilir, bazı kuyruklar kullanımdan kaldırılabilir. Herhangi bir kuyruğun bilgisine aşağıdaki komutla erişilebilir: 

.. code-block::

   scontrol show partition=kuyruk_adi 

Kuyrukların kullanım durumuna, paylaşılan, dolu ya da boş olan node ve çekirdeklerin durumuna ``sinfo`` komutu ile erişilebilir. 

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
   * - 🛑 single
     - levrekv2 
     - 8
     - 3-00:00:00
     - 1
     - 9500MB
     - 10500MB  
     - Kullanım Dışı
   * - 🛑 mid2
     - barbun
     - 189
     - 08-00:00:00 
     - 4    
     - 8000MB     
     - 9000MB
     - Kullanım Dışı
   * - 🛑 sardalya
     - sardalya
     - 100   
     - 3-00:00:00
     - 4
     - 8000MB
     - 9000MB
     - Kullanım Dışı 
   * - 🛑 long
     - barbun
     - 189
     - 3-00:00:00
     - 4  
     - 8000MB, 8500MB   
     - 9000MB, 9500MB 
     - Kullanım Dışı
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
   * - 🟢 palamut-cuda
     - palamut
     - 9  
     - 03-00:00:00
     - 16   
     - 7500MB  
     - 16384MB
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

  *Single*
  ^^^^^^^^^

  Bu kuyruğa tek çekirdeklik (genelde seri) işler gönderilir. Toplam çekirdek sayısı 1'den fazla ise, iş başka bir kuyruğa gönderilmiş olsa bile, otomatik olarak bu kuyruğa yönlendirilir. 

  Bu kuyruktaki herhangi bir işin çalışma süresi en fazla 3 gündür. 3 gün içinde tamamlanmamış işler sistem tarafından otomatik olarak sonlandırılmaktadır. 

  Bu kuyruk ile ilgili ayrıntılı bilgi

  .. code-block::

   scontrol show partition=single 

  komutu ile görülebilir. 

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

*Smp* kuyruğunda sadece *orkinos1* sunucusu bulunmaktadır. Kuyruk rezervasyon yönetimi ile çalıştırılmaktadır. Bu kuyruğu kullanmak isteyen kullanıcıların e-posta ile başvuruda bulunarak sistemi ne kadar süre ile kullanacaklarını, ne kadar kaynağa (işlemci/bellek) ihtiyaç duyduklarını bildirmeleri ve ihtiyaçlarına göre bir rezervasyon yaptırmaları gerekmektedir.

Bu kuyruk ile ilgili ayrıntılı bilgi

.. code-block::

   scontrol show partition=smp

komutu ile görülebilir.

..
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
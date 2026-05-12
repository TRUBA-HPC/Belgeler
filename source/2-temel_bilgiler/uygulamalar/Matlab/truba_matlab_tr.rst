===========================
TRUBA'da MATLAB Kullanımı
===========================

Giriş
=====

Bu doküman, MATLAB'ın TRUBA Yüksek Başarımlı Hesaplama (YBH) altyapısında nasıl
yapılandırılacağını ve kullanılacağını açıklamaktadır. Doküman; etkileşimli
çalıştırma, Slurm aracılığıyla betik iş gönderimi ve yerel MATLAB entegrasyonu
konularını kapsar. TRUBA, akademik kullanıcıların yüksek kapasiteli CPU ve
GPU'lar kullanarak yoğun hesaplama gerektiren simülasyonları hızlandırmasına,
standart bir dizüstü bilgisayarın kaldıramayacağı büyüklükteki veri setlerini
işlemesine ve çok sayıda MATLAB worker'ını aynı anda çalıştırarak hesaplama
süresini önemli ölçüde azaltmasına olanak tanır. Bu rehber, TRUBA'nın akademik
kullanıcıları için hazırlanmıştır.

Test Edilen Ortam
=================

.. admonition:: Not

   **Not:** Bu dokümantasyon aşağıdaki ortam özelinde oluşturulmuştur. MATLAB
   sürümlerindeki veya Slurm ayarlarındaki değişiklikler küçük düzeltmeler
   gerektirebilir.

================= ==================================================
Bileşen           Versiyon / Değer
================= ==================================================
Küme (Cluster)    TRUBA (arf ve cuda)
Test Edilen Part. debug, orfoz, barbun-cuda
MATLAB            R2025b
Lisans Modeli     Network Academic (MathWorks, bitiş 31 Ara 2027)
Slurm             23.02.5-1
İşletim Sistemi   Rocky Linux 9
Test Tarihi       2026-03-02
================= ==================================================

Ön Koşullar ve Lisanslama
=========================

Devam etmeden önce bu üç gereksinimin hazır olduğundan emin olun:

-  **Aktif TRUBA Hesabı:** Geçerli bir kullanıcı adı ve şifre.
-  **VPN Bağlantısı:** Kümeye erişmek için VPN aktif olmalıdır.
-  **Akademik Amaç:** TRUBA üzerindeki MATLAB kullanımı sadece akademik
   araştırmalar içindir. Ticari/kurumsal kullanıma izin verilmez.

Lisanslama ve Politika
----------------------

TRUBA, MATLAB'ı aşağıdaki şartlara sahip bir *Network Academic* lisansı ile
sunmaktadır:

.. list-table::
   :widths: 40 60
   :header-rows: 0

   * - Lisans Türü
     - Sponsored – Concurrent – Annual
   * - Geçerlilik Tarihi
     - **31 Aralık 2027**
   * - MATLAB + Tüm Toolboxlar
     - 200 eşzamanlı oturum (MATLAB Compiler dahil)
   * - MATLAB Parallel Server
     - 4000 worker

.. admonition:: Önemli

   **Önemli:** TRUBA hesaplama kaynaklarında yalnızca *akademik* MATLAB
   kullanımına izin verilir.

Uygulamada Bu Ne Anlama Geliyor?
------------------------------------

Lisansın nasıl yönetileceği, çalışma yönteminize bağlıdır:

-  **Open OnDemand veya Batch Modu Kullanımı:** MATLAB'ı doğrudan TRUBA kümesi
   üzerinde (web tarayıcısı veya batch script aracılığıyla) çalıştırırsanız,
   lisans, küme tarafında otomatik olarak sağlanır ve yönetilir. Kendi lisansınızı
   sağlamanıza gerek yoktur.

-  **Kişisel Bilgisayarınızda MATLAB Kullanımı:** Kodunuzu yerel MATLAB'ınızda
   yazıp küme eklentisini (plugin) kullanarak TRUBA'ya iş gönderirseniz, yerel
   kurulumunuz mutlaka bir *akademik* lisansa sahip olmalıdır. Bilgisayarınızda
   ticari veya deneme sürümü lisansı kullanıyorsanız, uzaktan yürütme işlemi
   engellenecektir.

.. admonition:: İpucu

   **MATLAB lisans türünüzü kontrol etmek için:**

   1. MATLAB'ı açın ve şunu yazın: ``ver``
   2. Lisans türü görünmüyorsa, https://www.mathworks.com/licensecenter adresinden
      MathWorks hesabınıza giriş yapın ve **My Licenses** altını kontrol edin.
   3. Hala emin değilseniz, üniversitenizin yazılım koordinatörü veya IT birimi
      ile iletişime geçin.

Uygulama Yönteminin Seçilmesi
=============================

TRUBA üzerinde MATLAB çalıştırmak için desteklenen üç yöntem vardır. Aşağıdaki
tabloyu kullanarak durumunuza en uygun olanı seçebilirsiniz.

+--------------------------------------------------+---------------------------------+------------------+
| Amacınız...                                      | Kullanılacak Yöntem             | Zorluk Seviyesi  |
+==================================================+=================================+==================+
| Küme üzerinde tam bir MATLAB Desktop oturumu     | Metot A: Open OnDemand          | Başlangıç        |
| başlatmak (Open OnDemand üzerinden GUI)          |                                 |                  |
+--------------------------------------------------+---------------------------------+------------------+
| Kodları yerelde geliştirip işleri kümeye         | Metot B: Yerel MATLAB + Plugin  | Orta             |
| göndermek                                        |                                 |                  |
+--------------------------------------------------+---------------------------------+------------------+
| İşleri tamamen Slurm üzerinden (GUI olmadan)     | Metot C: Slurm Batch Script     | Orta             |
| yürütmek                                         |                                 |                  |
+--------------------------------------------------+---------------------------------+------------------+
| Küme nodları üzerinde etkileşimli paralel        | İleri Düzey: Etkileşimli parpool| İleri            |
| worker'lar kullanmak                             |                                 |                  |
+--------------------------------------------------+---------------------------------+------------------+

.. admonition:: Not

   **Hangi yöntemi seçmelisiniz?** Metot A (Open OnDemand), herhangi bir yerel
   kurulum gerektirmediği için başlamanın en kolay yoludur. Ancak uzak bir GUI
   oturumu olarak çalıştığından performans daha yavaş olabilir. Düzenli veya
   yoğun kullanım için TRUBA'ya bağlı yerel bir MATLAB kurulumu (Metot B)
   önerilir.

.. _metot-a-open-ondemand:

Metot A — Open OnDemand (Etkileşimli GUI)
=========================================

Bu yöntem, web tarayıcınız üzerinden doğrudan grafiksel bir MATLAB arayüzü
kullanmanıza olanak tanır. Etkileşimli çalışmak istiyorsanız en iyi seçenektir
ve yerel bir MATLAB kurulumu gerektirmez.

.. admonition:: Önemli

   **Kural:** MATLAB'ı mutlaka Open OnDemand üzerinden başlatmalısınız.
   MATLAB'ın doğrudan login nodlarında çalıştırılması kesinlikle yasaktır ve
   tespit edilen oturumlar sonlandırılacaktır.

ARF Kümesine Bağlanma
---------------------

#. **TRUBA OpenVPN** bağlantınızı kurun.
#. Tarayıcınızı açın ve şu adrese gidin: https://172.16.6.20
#. TRUBA kullanıcı adınız ve şifrenizle giriş yapın.
#. Dashboard üzerinden **Interactive Apps** menüsüne tıklayın ve **Desktop**
   seçeneğini seçin.

Detaylı bağlantı talimatları için: https://docs.truba.gov.tr

.. figure:: /assets/matlab-howto/arf_ood_dashboard.png
   :alt: 

Desktop Oturumunda MATLAB'ı Başlatma
------------------------------------

Tarayıcıda sanal masaüstünüz göründüğünde:

#. **Terminal Açın:** Masaüstünde herhangi bir yere sağ tıklayın ve
   *Open Terminal Here* seçeneğini seçin.
#. **MATLAB Modülünü Yükleyin:** Ortamı hazırlamak için aşağıdaki komutları
   yazın:

.. code:: bash

   module purge
   module available | grep -i matlab  # yüklü sürümleri gösterir
   module load apps/matlab/r2025b

#. **MATLAB'ı Çalıştırın:**

.. code:: bash

   matlab

MATLAB'ı Küme ile Tanıştırma
----------------------------

TRUBA üzerinde MATLAB'ı ilk kez çalıştırdığınızda, hesaplama ortamını algılaması
gerekir; bu yapılandırmanın bir kez yapılması yeterlidir.

#. MATLAB **Home** sekmesinde, **Parallel** → **Discover Clusters…** yolunu
   izleyin.
#. MATLAB, size atanan hesaplama nodunu (örneğin ``orfoz34``) algılayacaktır.
#. İşlemi tamamlamak için yönlendirmeleri takip edin.

.. figure:: /assets/matlab-howto/matlab_discover_clusters.png
   :alt: 

.. admonition:: Not

   **Bu adım ne işe yarar?** Bu işlem sadece MATLAB'a bir TRUBA hesaplama nodu
   üzerinde çalıştığını bildirir. Uzun vadeli iş gönderimi (job submission)
   yapılandırmasını sağlamaz. Bu konu için :ref:`configuring-and-submitting-jobs`
   bölümüne bakınız.

Alternatif: MATLAB'ı GUI Olmadan Başlatma
-----------------------------------------

"MATLAB'ı Küme ile Tanıştırma" adımı tamamlandıktan sonra, her oturumda tam
grafiksel masaüstünün başlatılmasına gerek duyulmaz. Bunun yerıne kullanılabilecek iki alternatif mevcuttur:

-  **Etkileşimli komut satırı modu** (komut yazmaya devam edebilirsiniz):

.. code:: bash

   matlab -nodesktop

-  **Etkileşimli olmayan batch modu** (bir betiği çalıştırır ve otomatik çıkar):

.. code:: bash

   matlab -batch "betiginiz_veya_komutunuz"

.. admonition:: İpucu

   **Hangisi ne zaman kullanılır?** GUI yükü olmadan komutları etkileşimli yazmak
   istiyorsanız ``-nodesktop`` kullanın. Bir betiği herhangi bir etkileşim
   olmadan tam otomatik çalıştırmak istiyorsanız ``-batch`` kullanın.

Open OnDemand kullanırken *Cluster Profile Manager*'ı açtığınızda bir
**Validate** düğmesi görebilirsiniz. Bunu TRUBA üzerinde kullanmayın — bkz.
:ref:`the-validate-button`.

CUDA Kümesine Bağlanma
----------------------

TRUBA altyapısı temel olarak iki ana bölümden oluşur: Genel amaçlı hesaplamalar
için **ARF** (standart CPU ağırlıklı) ve yüksek başarımlı grafik işlemci 
ihtiyaçları için **CUDA** (güncel GPU odaklı) kümeleri

-  **ARF Erişimi:** https://172.16.6.20
-  **CUDA Erişimi:** https://172.16.6.16 *(Özel yetkilendirme gerektirir)*

CUDA erişim gereksinimleri için:
https://docs.truba.gov.tr/1-kaynaklar/arf_acc/arf_acc_baglanti.html#arf-acc-baglanti

Dosyalarınız, ayarlarınız ve MATLAB tercihleriniz her iki küme arasında
paylaşılır; bu nedenle geçiş yaparken ek bir MATLAB yapılandırması gerekmez.

-  **Home dizini:** ``/arf/home/$USER``
-  **MATLAB tercihleri:** ``~/.matlab/R2025b/`` (profil ayarları burada tutulur)

Sonraki Adımlar
---------------

MATLAB ortamınız artık yapılandırılmıştır. İş parametrelerini
ayarlamak ve kümeye ilk işinizi göndermek için
:ref:`configuring-and-submitting-jobs` bölümüne bakınız.

.. _metot-b-submit-from-your-local-matlab:

Metot B — Kendi MATLAB'ınızdan İş Gönderme
==========================================

Bu yöntem, kodunuzu kendi bilgisayarınızdaki MATLAB'da geliştirmenize ve MATLAB
ortamından ayrılmadan işleri doğrudan TRUBA'ya göndermenize olanak tanır.
Tek seferlik bir yapılandırma gerektirir.

.. admonition:: Önemli

   **Lisans hatırlatması:** Metot B, geçerli bir *akademik* lisans kapsamındaki
   yerel bir MATLAB kurulumu gerektirir. Ticari veya deneme
   lisansları TRUBA'ya iş gönderemez. Akademik lisansınız yoksa
   :ref:`metot-a-open-ondemand` yöntemini kullanın.

Tek Seferlik Yapılandırma
-------------------------

Bu kurulum her küme (ARF veya CUDA) için bir kez yapılmalı ve yerel MATLAB
sürümünüzü güncellediğinizde tekrarlanmalıdır.

Adım 1: User Path Doğrulaması
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MATLAB'ın TRUBA bağlantı betiklerini saklamak için belirli bir klasöre ihtiyacı
vardır.

#. Bilgisayarınızda MATLAB'ı açın.
#. Komut penceresine ``userpath`` yazın.
#. Bir klasör yolu dönüyorsa, eklenti (plugin) buraya kurulacaktır.
#. Boş dönüyorsa, sıfırlayın:

.. code:: matlab

   userpath('reset')
   userpath

.. figure:: /assets/matlab-howto/local_userpath_output.png
   :alt: 

Eğer klasör henüz mevcut değilse, manuel olarak oluşturun:

.. code:: matlab

   mkdir(fullfile(getenv('HOME'),'Documents','MATLAB'))
   userpath(fullfile(getenv('HOME'),'Documents','MATLAB'))
   savepath

Adım 2: TRUBA Cluster Plugin Kurulumu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **TRUBA MATLAB Plugin (ZIP)** dosyasını indirin:
   :download:`TRUBA MATLAB Plugin (ZIP) <../../../assets/matlab-howto/config-files/tubitak.Desktop.zip>` (12 May 2026 tarihinde güncellendi)
-  İçeriği doğrudan ``userpath`` tarafından döndürülen klasöre çıkartın.
-  MATLAB Komut Penceresinde şunu çalıştırın:

.. code:: matlab

   configCluster

-  Yönlendirmeleri takip edin: kümeyi (ARF veya CUDA) seçin ve **TRUBA kullanıcı
   adınızı** girin.

.. admonition:: Not

   **Henüz şifre gerekmemektedir.** Şifreniz sadece kümeye gerçekten bir iş
   gönderdiğinizde sorulacaktır.

.. figure:: /assets/matlab-howto/configcluster_execution.png
   :alt: 

Başarılı bir yapılandırmadan sonra, yerel MATLAB'ınızdan gönderilen işler TRUBA
kümesi üzerinde çalışacaktır. Profilin oluşturulduğunu *Home →
Parallel → Create and Manage Clusters* yolunu izleyerek doğrulayabilirsiniz.

.. figure:: /assets/matlab-howto/cluster_profile_manager.png
   :alt: 

.. _the-validate-button:

"Validate" (Doğrula) Düğmesi
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*Cluster Profile Manager* kısmını açtığınızda bir **Validate** düğmesi
görebilirsiniz.

.. admonition:: Önemli

   **Buradaki "Validate" düğmesini kullanmayın.** TRUBA üzerinde iş yürütme
   işlemleri MATLAB'ın dahili doğrulayıcısı tarafından değil, Slurm iş
   zamanlayıcısı tarafından yönetilir. Bu doğrulama testi muhtemelen
   başarısız olacaktır; ancak bu, MATLAB kurulumunuzun hatalı olduğu anlamına
   gelmez. Komutları çalıştırabildiğiniz sürece kurulumunuz
   doğrudur.

Adım 3: ARF ve CUDA Küme Profilleri
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ARF ve CUDA ayrı Slurm sistemleridir ve her biri kendi küme profiline ihtiyaç
duyar. Her iki sisteme de erişiminiz varsa, ``configCluster`` adımını
tekrarlayın ve istendiğinde CUDA kümesini seçin.

Bilgisayarınız ve Küme Arasında Geçiş Yapma
--------------------------------------------

MATLAB'a işinizi nerede çalıştıracağınızı tek bir komutla söyleyebilirsiniz.

-  **TRUBA üzerinde çalışmak için (varsayılan):**

.. code:: matlab

   c = parcluster; % TRUBA profilinizi yükler 

-  **Kendi bilgisayarınızda çalışmak için:**

.. code:: matlab

   c = parcluster('Processes'); % yerel işlemcileri kullanır 

.. admonition:: İpucu

   ``Processes`` profilini kişisel çalışma alanınız, TRUBA profilini ise ağır
   işlerin yapıldığı bir fabrika gibi düşünün. Fabrikaya işleri sadece
   çalışma alanınız için çok büyük olduğunda gönderin!

Listenizde bir ``Processes`` profili görmüyorsanız, manuel olarak ekleyin:

#. **Home** → **Parallel** → **Create and Manage Clusters** yolunu izleyin.
#. **Add Cluster Profile** → **Processes** seçeneğine tıklayın.

.. _next-steps-1-tr:

Sonraki Adımlar
---------------

Yerel MATLAB'ınız artık TRUBA'ya iş gönderecek şekilde yapılandırılmıştır.
İş parametrelerini ayarlamak için :ref:`configuring-and-submitting-jobs`
bölümüne bakınız.

.. _method-c-slurm-batch-script:

Metot C — Slurm Batch Script
=============================

Bu yöntem, MATLAB'ı tamamen bir Slurm betik aracılığıyla çalıştırır.
Standart bir Slurm iş betiği yazarsınız ve MATLAB, Slurm tarafından zaten 
tahsis edilmiş olan CPU'ları kullanarak bir paralel havuz (parallel pool) 
oluşturur. Herhangi bir küme profili veya eklenti (plugin) 
gerektirmez.

.. admonition:: Not

   **Bu yöntem ne zaman kullanılır?** Bu yöntem en doğrudan HPC yaklaşımıdır 
   ve yerel bir MATLAB kurulumu veya eklenti yapılandırması gerektirmez. 
   Özellikle Slurm iş betiklerine aşina olan kullanıcılar için uygundur.

   Slurm iş betikleri hakkında hızlı bir hatırlatmaya ihtiyaç duyuyorsanız:
   https://docs.truba.gov.tr/2-temel_bilgiler/slurm-betik-ozellik.html

Gereksinimler
-------------

-  TRUBA üzerinde ``/arf/scratch/$USER`` altında bir MATLAB betiği.
-  MATLAB'ı yükleyen ve kodunuzu çalıştıran bir Slurm iş betiği (``.sh``).
-  Slurm küme kuyruğu ve azami çalışma süresi (wall time) hakkında temel bilgi. Detaylar için :ref:`configuring-and-submitting-jobs`

Adım 1: MATLAB Betiğinizi Yazın
---------------------------------

MATLAB betiğinizi ``/arf/scratch/$USER`` altına kaydedin. Betiğiniz:

#. Slurm betiği tarafından atanan ``NUM_WORKERS`` ortam değişkenini okumalıdır.
#. Zaten tahsis edilmiş CPU'ları kullanarak bir paralel havuz oluşturmalıdır.
#. Hesaplamayı yürütmeli ve sonunda havuzu temizlemelidir.

.. code:: matlab

   % ornek_betik.m

   % Slurm tarafından aktarılan worker (işçi) sayısını oku
   n = str2double(getenv("NUM_WORKERS"));

   % Slurm tarafından halihazırda tahsis edilmiş çekirdekleri kullanarak
   % bir havuz oluştur. Bu işlem yeni bir Slurm talebi GÖNDERMEZ; sadece 
   % bu işe verilmiş kaynakları kullanır. (Bu, MATLAB'ın doğrudan Slurm 
   % ile konuştuğu Metot B'den farklıdır.)
   parpool('Processes', n); % Hesaplama nodu üzerindeki yerel süreçler

   % --- Hesaplama kısmı buraya gelir ---

   % Basit bir örnek hesaplama (sleep) — silinebilir.
   % Her worker 1 saniye bekler; toplam süre yaklaşık 1 saniye olmalıdır.
   tic;
   parfor i = 1:n
       pause(1);
   end
   elapsed = toc;
   fprintf('parfor demosu %.2f saniyede tamamlandı.\n', elapsed);

   % Temizlik
   delete(gcp('nocreate'));

.. admonition:: Not

   **Not:** ``NUM_WORKERS`` değişkeni aşağıdaki Slurm betiği tarafından 
   otomatik olarak ayarlanır. Slurm betiğindeki çekirdek sayısını 
   değiştirirseniz, worker sayısı otomatik olarak güncellenir — MATLAB 
   kodunuzu düzenlemenize gerek kalmaz. Slurm çıktısında MATLAB'ın 
   havuzu ``Processes`` profilini kullanarak başlattığını görebilirsiniz; 
   bu beklenen bir durumdur ve havuzun tahsis edilen hesaplama nodu 
   üzerinde yerel olarak çalıştığını gösterir.

Adım 2: Slurm Betiğinizi Yazın
-------------------------------

Aşağıdaki içeriği ``is_gonder.sh`` olarak kaydedin:

.. code:: bash

   #!/bin/bash
   #SBATCH -J matlab-is              # iş adı 
   #SBATCH -A $USER                  # hesap adı 
   #SBATCH -p orfoz                  # partition
   #SBATCH -N 1                      # node sayısı 
   #SBATCH --ntasks=56               # orfoz için 56xn çekirdek 
   #SBATCH --cpus-per-task=1 
   #SBATCH -t 0-00:30                # azami süresi 
   #SBATCH -o matlab-is_%j.out       # çıktı dosyası 
   #SBATCH -e matlab-job_%j.err      # hata dosyası
   
   module load apps/matlab/r2025b 

   # Bir çekirdek istemci, kalanı worker olur
   export NUM_WORKERS=$((SLURM_NTASKS - 1))  # = 55 worker

   matlab -batch "ornek_betik"

.. admonition:: İpucu

   **Çekirdek sayıları:** ``orfoz`` kuyruğu, çekirdeklerin node başına 
   56'nın katları şeklinde talep edilmesini gerektirir. 
   ``--ntasks=56`` ile bir çekirdek MATLAB istemcisi olurken 55 tanesi 
   paralel worker olur. Diğer kuyruklara (partition) özgü kurallar
   :ref:`configuring-and-submitting-jobs` bölümünde detaylandırılmıştır.

Adım 3: İşin Gönderilmesi ve İzlenmesi
--------------------------------------

İşi login nodundan gönderin:

.. code:: bash

   sbatch is_gonder.sh

İş durumunu kontrol edin:

.. code:: bash

   squeue -u $USER

İş tamamlandıktan sonra çıktı dosyasını inceleyin:

.. code:: bash

   cat matlab-is_<jobid>.out

.. _next-steps-2-tr:

Sonraki Adımlar
---------------

Her üç yöntem için de geçerli olan kuyruk (partition) kuralları, bellek 
yönetimi ve kaynak seçimi hakkında daha ayrıntılı bilgi edinmek için 
:ref:`configuring-and-submitting-jobs` bölümüne bakınız.

.. _configuring-and-submitting-jobs:

İşlerin Yapılandırılması ve Gönderilmesi
========================================

Bu bölüm **Metot A** (Open OnDemand) ve **Metot B** (Yerel MATLAB) için 
geçerlidir. **Metot C** (Slurm Batch Script) kaynak taleplerini 
doğrudan Slurm betiği içinde yönetir — bkz. :ref:`method-c-slurm-batch-script`.

İşleri göndermeden önce, Slurm kavramları hakkında temel düzeyde bilgi sahibi 
olmanız önerilir:

-  Slurm iş betiği temelleri:
   https://docs.truba.gov.tr/2-temel_bilgiler/slurm-betik-ozellik.html
-  TRUBA kuyruklarına (partition) genel bakış:
   https://docs.truba.gov.tr/2-temel_bilgiler/hesaplama_kumeleri.html

Ayarlanması Gereken Üç Temel Parametre
--------------------------------------

Her iş gönderimi için en az şu üç parametrenin ayarlanması gerekir:

.. code:: matlab

   c = parcluster;
   c.AdditionalProperties.Partition = 'debug';   % kullanılacak kuyruk 
   c.AdditionalProperties.NumNodes  = 1;         % node sayısı 
   c.AdditionalProperties.WallTime  = '0-00:10'; % maks. çalışma süresi (G-SA:DA) 

-  **Partition (Küme Kuyruğu):** İşinizin hangi sunucularda (node) çalışacağını
   belirler. Başlangıç testleri için her zaman ``debug`` kuyruğunu kullanın. 
   Üretim işleri için iş yükünüze (CPU, bellek veya GPU) uygun olan kuyruğu 
   seçin. Detaylar için aşağıdaki referans tablolarına bakın.

-  **NumNodes (Node Sayısı):** Bu değeri her zaman açıkça belirtin. Eğer boş 
   bırakılırsa, Slurm görevleri sunucular arasında çekirdek politikalarını 
   ihlal edecek şekilde verimsiz dağıtabilir.

-  **WallTime (Azami Çalışma Süresi):** Zorunludur. Testler için süreyi kısa 
   tutun (örneğin 10 dakika). Üst limitler kuyruğa bağlıdır; bunları TRUBA 
   login nodunda ``scontrol show partition`` komutuyla kontrol edebilirsiniz.

Kullanılabilir Kuyrukları Listeleme
--------------------------------------

MATLAB içerisinden kullanılabilir kuyrukların listesini almak için şu komutu kullanabilirsiniz:

.. code:: matlab

   c = parcluster;
   clusterPartitionNames(c)

Örnek çıktı:

::

   {'akya-cuda'  }
   {'barbun'     }
   {'barbun-cuda'}
   {'debug'      }
   {'hamsi'      }
   {'orfoz'      }
   {'smp'        }

.. admonition:: Not

   **Not:** Çevrimiçi dokümantasyon her zaman en güncel kuyruk yapılandırmasını
   yansıtmayabilir. MATLAB içinden hızlı bir liste için 
   ``clusterPartitionNames`` komutunu; bellek limitleri ve azami çalışma 
   süresi dahil tüm detaylar için ise login nodunda 
   ``scontrol show partition`` komutunu kullanın.

Ayarların  Değiştirilmesi ve Kaydedilmesi
-----------------------------------------

Varsayılan olarak, ``AdditionalProperties`` üzerinde yapılan değişiklikler 
MATLAB oturumları (sessions) arasında kaydedilmez.

Mevcut tüm ayarları görüntülemek için:

.. code:: matlab

   c.AdditionalProperties

İhtiyacınız olan parametreleri belirledikten sonra bir ayarı şu şekilde 
değiştirebilirsiniz:

.. code:: matlab

   c.AdditionalProperties.WallTime = '0-00:30';

Bir değeri temizlemek ve eklenti varsayılanlarına dönmek için:

.. code:: matlab

   c.AdditionalProperties.Partition = '';
   c.AdditionalProperties.NumNodes  = 0;
   c.AdditionalProperties.MemPerCPU = '';
   c.AdditionalProperties.RequireExclusiveNode = false;

Ayarlarınızın MATLAB oturumları arasında kalıcı  olmasını 
sağlamak için (değişiklik yaptıktan sonra kaydedin):

.. code:: matlab

   c.saveProfile

İş Gönderme
-----------

Kümeye iş göndermek için ``batch`` komutunu kullanın:

.. code:: matlab

   j = batch(c, @fonksiyonunuz, 1, {}, ...
       'Pool', 2, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

Argümanların açıklaması:

-  ``c``: TRUBA küme profili.
-  ``@fonksiyonunuz``: Kümede çalıştırılacak fonksiyon (hızlı bir test 
   için, TRUBA üzerindeki çalışma dizinini döndüren ``@pwd`` 
   kullanılabilir).
-  ``1``: Beklenen çıktı argümanı sayısı.
-  ``{}``: Giriş argümanları (bu örnekte boş).
-  ``'Pool', 2``: Paralel worker (işçi) sayısı.
-  ``'CurrentFolder', '.'``: Küme üzerindeki çalışma dizini.
-  ``'AutoAddClientPath', false``: MATLAB'ın yerel yolları küme 
   worker'larına eklemesini engeller (gereksiz uyarıları önler).

İş gönderildikten sonra Slurm kuyruğuna girer ve tamamen TRUBA üzerinde 
çalışır. MATLAB'ı veya masaüstü oturumunuzu kapatabilirsiniz; iş 
çalışmaya devam eder.

Pool+1 Kuralı
-------------

.. admonition:: Önemli

   **Toplam Slurm Görevi = Havuz (Pool) Boyutu + 1**

   Bir paralel havuz talep ettiğinizde, MATLAB işin yönetimi ve koordinasyonu 
   (orchestration) için ek bir görev (task) kullanır. Bu nedenle, 2'lik bir 
   havuz aslında 3 Slurm görevi talep eder. Bazı kuyruklar (partition) node 
   başına katı çekirdek sayıları uyguladığı için bu hesaplama çok önemlidir.

Örnek: ``orfoz`` üzerinde tam **56 çekirdek** kullanmak için ``Pool = 55`` 
olarak ayarlanmalıdır:

.. code:: matlab

   j = batch(c, @fonksiyonunuz, 1, {}, ...
       'Pool', 55, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

.. admonition:: Not

   **Sadece Metot C için:** Slurm iş betiklerinde (batch scripts) Pool+1 kuralı 
   manuel olarak uygulanmaz; worker (işçi) sayısı otomatik olarak 
   ``SLURM_NTASKS - 1`` formülüyle hesaplanır.

Kuyruk Referansı: CPU Kuyrukları
-----------------------------------

.. list-table::
   :header-rows: 1
   :widths: 15 15 25 45

   * - Kuyruk
     - Çekirdek/N
     - Bellek/CPU
     - Notlar
   * - ``debug``
     - esnek
     - —
     - Sadece test amaçlıdır
   * - ``orfoz``
     - 112
     - ~2000 MB
     - 56×n çekirdek istenmeli
   * - ``hamsi``
     - 56
     - ~3400 MB
     - 56×n çekirdek istenmeli
   * - ``barbun``
     - 40
     - ~8500 MB
     - 40×n çekirdek istenmeli
   * - ``smp``
     - 224
     - 3400 MB (maks 17000)
     - Tek node: ``orkinos1``

Çekirdek Sayısı Kuralları
~~~~~~~~~~~~~~~~~~~~~~~~~

Bazı kuyruklar katı "node başına çekirdek sayısı" politikaları uygular. Bu 
kurallar ihlal edilirse, Slurm işi bir hata mesajıyla reddeder.

-  ``orfoz``: Node başına **56 veya 112** çekirdek talep edilmelidir.
-  ``hamsi``: Node başına **56×n** çekirdek talep edilmelidir.
-  ``barbun``: Node başına **40×n** çekirdek talep edilmelidir.

.. admonition:: Önemli

   **Pool+1 kuralını unutmayın.** Örneğin ``orfoz`` üzerinde 56 çekirdek 
   ayırmak için MATLAB içinde ``Pool = 55`` ayarlamalısınız.

Reddedilen iş mesajı örneği:

::

   sbatch: error: Orfoz kuyruguna gonderilen islerde node basina 
   56/112 cekirdek talep ediniz.

Kuyruk Referansı: GPU Kuyrukları
-----------------------------------

=============== ========== ========= ======== ============
Kuyruk          Çekirdek/N GPU/Node  Bel./CPU GPU Baş. CPU
=============== ========== ========= ======== ============
``barbun-cuda`` 40         2         ~8500 MB 20
``akya-cuda``   40         4         ~8500 MB 10
=============== ========== ========= ======== ============

GPU Talep Kuralları
~~~~~~~~~~~~~~~~~~~

GPU kuyrukları hem zorunlu bir GPU talebi hem de katı bir CPU-GPU oranı uygular.

-  **barbun-cuda:**
   -  GPU talebi zorunludur.
   -  GPU başına **20×n** CPU çekirdeği talep edilmelidir.
   -  Tam bir node: 2 GPU + 40 CPU çekirdeğinden oluşur.

-  **akya-cuda:**
   -  GPU talebi zorunludur.
   -  GPU başına **10×n** CPU çekirdeği talep edilmelidir.
   -  Tam bir node: 4 GPU + 40 CPU çekirdeğinden oluşur.

MATLAB üzerinden GPU talep etmek için:

.. code:: matlab

   c.AdditionalProperties.GPUsPerNode = 2;

.. admonition:: Önemli

   **Eğer daha önce bir node kısıtlaması (Constraint)** ayarladıysanız 
   (örneğin test için ``orfoz``), GPU kuyruklarına iş göndermeden önce 
   bunu mutlaka temizleyin:

   .. code:: matlab

      c.AdditionalProperties.Constraint = '';

   Aksi takdirde Slurm uygun bir node bulamayabilir.

Hata mesajı örnekleri:

::

   barbun-cuda kuyruguna sadece GPU talebi olan isler gonderilebilir.

::

   sbatch: error: Too few CPUs requested for the number of GPUs.

Bellek Modeli
-------------

TRUBA'da bellek tahsisi, talep edilen CPU çekirdek sayısı ile orantılıdır; 
belleği doğrudan talep etmezsiniz. Daha fazla çekirdek talep etmek, size 
oranlı olarak daha fazla bellek sağlar. Bellek miktarları yukarıdaki 
kuyruk (partition) tablolarında belirtilmiştir.

.. admonition:: İpucu

   **Bellek yoğun işler:** Eğer işiniz CPU çekirdeğinden ziyade belleğe 
   ihtiyaç duyuyorsa, CPU başına bellek oranı daha yüksek olan bir kuyruk 
   seçin. ``barbun`` (~8500 MB/CPU), bellek yoğun iş yükleri için 
   genellikle en iyi seçenektir. Çok yüksek bellek gereksinimleri için 
   ``smp`` kuyruğunu değerlendirin.

.. admonition:: Not

   **Sorumlu kullanım:** Sadece daha fazla bellek elde etmek için, 
   işlemcilerin boşta kalmasına neden olacak şekilde gereksiz çekirdek 
   talebinde bulunmayın. Bunun yerine, işinize en uygun CPU/Bellek 
   oranını sunan kuyruğu tercih edin.

İş İzleme ve Sonuçların Alınması
================================

İş Çalışırken
-------------

İşin durumunu MATLAB içerisinden kontrol edebilirsiniz:

.. code:: matlab

   j.State

Olası durumlar:

-  ``queued``: Slurm kuyruğunda bekliyor.
-  ``running``: Şu anda yürütülüyor.
-  ``finished``: Başarıyla tamamlandı.
-  ``failed``: Bir hata oluştu.

Kısa test işleri için MATLAB'ı iş bitene kadar bekletmek (bloklamak) isterseniz:

.. code:: matlab

   wait(j)

Durumu TRUBA login nodu üzerinden kontrol etmek için:

.. code:: bash

   squeue -u $USER

İş bittikten sonra detaylı istatistikleri almak için:

.. code:: bash

   sacct -j <jobid> --format=JobID,State,Elapsed,AllocCPUS,NodeList

Tamamlanmış Bir İşe Geri Dönme
------------------------------

Uzun süreli işlerde, işi gönderdikten sonra MATLAB'ı kapatıp daha sonra 
sonuçları kontrol etmek için geri dönebilirsiniz. İşlerinize yeniden 
bağlanmak için:

.. code:: matlab

   c = parcluster;
   c.Jobs          % Bu profille ilişkili tüm işleri listeler

``c.Jobs``; iş kimliği (ID), durum ve gönderim zamanını içeren bir liste 
döndürür. Eğer birden fazla iş gönderdiyseniz, ilgili işi şu şekilde 
seçebilirsiniz:

.. code:: matlab

   % Konuma göre seçme (en son gönderilen iş)
   j = c.Jobs(end);

   % Veya gönderim sırasında not ettiğiniz ID ile seçme
   j = c.findJob('ID', 4);

Sonuçların Alınması
-------------------

#. **Fonksiyon Çıktısı (fetchOutputs):**
   Eğer işiniz değer döndüren bir fonksiyon olarak gönderildiyse, sonuçları 
   şöyle çekebilirsiniz:

   .. code:: matlab

      out = fetchOutputs(j);
      out{1}    % Çıktılar her zaman bir 'cell array' olarak döner

   Bu yöntem, küçük sonuçlar döndüren fonksiyonlar ve testler için en 
   pratik yoldur.

#. **Dosya Çıktısı:**
   Üretim işleri (production jobs) için MATLAB kodunuz genellikle sonuçları 
   ``save()`` vb. komutlarla doğrudan diske yazar. Bu dosyalar, ``batch`` 
   çağrısında belirttiğiniz ``CurrentFolder`` dizinine kaydedilir.

   .. admonition:: Önemli

      **Dosyalar nerede?**

      -  **Metot A (Open OnDemand):** Dosyalar küme üzerinde, belirttiğiniz 
         dizine (genellikle ``/arf/scratch/$USER``) yazılır. Bunlara 
         doğrudan TRUBA dosya sistemi üzerinden erişebilirsiniz.
      -  **Metot B (Yerel MATLAB):** Dosyalar yerel makinenize değil, 
         **küme üzerine** yazılır. Bunlara erişmek için TRUBA'ya SSH ile 
         bağlanmalı veya ``scp/sftp`` ile yerelinize kopyalamalısınız.

#. **Yazdırılan Çıktıları Görüntüleme:**
   Yürütme sırasında MATLAB'ın komut penceresine (command window) yazdırdığı 
   her şeyi görmek için:

   .. code:: matlab

      diary(j)

İş Başarısız Olursa
-------------------

.. code:: matlab

   j.State            % Durumun 'failed' olduğunu teyit edin
   j.Tasks(1).Error   % Hata mesajını görüntüleyin
   diary(j)           % Hatalar dahil tüm yazdırılan çıktıları inceleyin

Sorunu TRUBA desteğine bildirmeniz gerekirse, Slurm iş numarasını (job ID) 
şöyle alabilirsiniz:

.. code:: matlab

   j.getTaskSchedulerIDs()

Temizlik
--------

Tamamlanmış tek bir işi ve yerel üstverilerini (metadata) silmek için:

.. code:: matlab

   delete(j)

Profille ilişkili tüm iş kayıtlarını temizlemek için:

.. code:: matlab

   c = parcluster;
   delete(c.Jobs)

İleri Seviye: Masaüstünden Etkileşimli parpool
===============================================

Bu bölüm, kişisel bilgisayarınızdaki MATLAB üzerinden doğrudan TRUBA'da bir 
paralel havuz (parallel pool) başlatmayı açıklar. Havuz bağlandığında, 
``parfor`` döngüleriniz sanki yerelde çalışıyormuş gibi şeffaf bir şekilde 
küme worker'ları üzerinde yürütülür.

.. admonition:: Not

   **Gereksinimler:** VPN aktif olmalı ve bilgisayarınızda gelen trafik için 
   TCP 27370 portu açık olmalıdır.

Bağlantının Kurulması
---------------------

Havuzu başlatmadan önce, VPN IP adresinizi TRUBA worker nodlarına tanıtmak 
için aşağıdaki komutu çalıştırın:

.. code:: matlab

   sethostname

Beklenen çıktı:

::

   Found private IP address. Setting hostname: 10.x.x.x

Bu komutu MATLAB'ı her başlattığınızda çalıştırmalısınız. Eğer güvenlik duvarı 
iletişimi engelliyorsa şu hatayı alabilirsiniz:

::

   Check whether a firewall is blocking communication between the 
   worker machines and the MATLAB client machine.

TRUBA Üzerinde Paralel Havuz Başlatma
-------------------------------------

Küme profilini her zamanki gibi yapılandırın (kuyruk kuralları ve bellek 
rehberi için bkz. :ref:`configuring-and-submitting-jobs`), ardından 
havuzu başlatın:

.. code:: matlab

   c = parcluster;

   c.AdditionalProperties.Partition = 'orfoz';
   c.AdditionalProperties.NumNodes  = 1;
   c.AdditionalProperties.WallTime  = '0-00:30';

   pool = parpool(c, 56);

.. admonition:: Not

   ``parpool(c, 56)`` komutu arka planda 56 worker talep eden bir Slurm işi 
   gönderir. Tüm TRUBA kuyruk kısıtlamaları geçerlidir; örneğin ``orfoz`` 
   node başına 56×n çekirdek gerektirir. Havuz, siz açıkça silene kadar 
   aktif kalır ve küme kaynaklarını rezerve eder.

Bu başlangıç aşaması; MATLAB'ın Slurm işini göndermesi, worker süreçlerini 
başlatması ve bağlantıları kurması sırasında on saniyelerden birkaç dakikaya 
kadar sürebilir.

Kodun Etkileşimli Çalıştırılması
--------------------------------

Havuz bağlandığında, ``parfor`` döngüleriniz küme worker'ları üzerinde 
şeffafça çalışır. Havuzun çalıştığını doğrulamak için hızlı bir test:

.. code:: matlab

   tic; parfor i = 1:56, pause(1); end; toc

56 worker ile her iterasyon eşzamanlı çalışır, bu nedenle toplam geçen süre 
56 saniye yerine 1 saniyeye yakın olmalıdır. Bu, havuzun aktif olduğunu 
doğrular.

Havuzun İzlenmesi
-----------------

Aktif havuzları ve işleri görüntülemek için İş Monitörünü (Job Monitor) açın:

**Parallel** → **Monitor Jobs**

.. figure:: /assets/matlab-howto/open_job_monitor.png
   :alt: 

.. figure:: /assets/matlab-howto/job_monitor_window.png
   :alt: 

.. admonition:: Not

   Havuz aktif olduğunda İş Monitörü *Description: Interactive pool* ve 
   *State: running* durumlarını gösterir. Bu, worker'ların tahsis edildiği 
   anlamına gelir; mutlaka bir döngünün o an yürütüldüğü anlamına gelmez. 
   Havuz açık kaldığı sürece küme kaynakları rezerve edilir.

Havuzun Kapatılması
-------------------

İşiniz bittiğinde havuzu her zaman silin:

.. code:: matlab

   delete(gcp('nocreate'))

Boştaki havuzlar yaklaşık 30 dakika sonra otomatik olarak sonlandırılabilir, 
ancak kaynak israfını önlemek için buna güvenmeyin.

Sorun Giderme
-------------

Eğer havuz bağlanamazsa (örneğin VPN bağlantısını yeniledikten sonra), 
şunu deneyebilirsiniz:

.. code:: matlab

   fixConnection

.. _helper-functions-tr:

Yardımcı Fonksiyonlar
=====================

TRUBA, MATLAB içerisinden Slurm ve küme kaynaklarıyla etkileşimi 
kolaylaştıran çeşitli yardımcı fonksiyonlar sunar. Küme özelliklerini 
sorgulayan tüm fonksiyonlar aktif bir küme profili nesnesi gerektirir 
— bunları ``c = parcluster`` komutundan sonra çalıştırın.

.. list-table::
   :header-rows: 1
   :widths: 30 35 35

   * - Fonksiyon
     - Açıklama
     - Notlar
   * - ``clusterPartitionNames``
     - Kullanılabilir Slurm kuyruklarını listeler
     - Kuyruk ayarından önce teyit edin
   * - ``clusterFeatures``
     - Küme özelliklerini ve kısıtları listeler
     - Kuyruk kurallarını anlamak için yararlı
   * - ``clusterGpuCards``
     - Mevcut GPU modellerini listeler
     - GPU kaynağı talep etmeden önce kullanın
   * - ``fixConnection``
     - Küme bağlantısını yeniden kurar
     - Sadece etkileşimli parpool için geçerli
   * - ``seff``
     - İşin Slurm verimlilik verilerini gösterir
     - İş tamamlandıktan sonra kullanın
   * - ``willRun``
     - İşin neden kuyrukta olduğunu açıklar
     - İş beklerken kullanın

Kullanım
--------

.. code:: matlab

   % Küme sorgulama fonksiyonları — küme profili nesnesi gerektirir
   c = parcluster;
   clusterPartitionNames(c)
   clusterFeatures(c)
   clusterGpuCards(c)

   % İş fonksiyonları — MATLAB iş (job) nesnesi gerektirir
   % 'j' nesnesi batch() tarafından döndürülür veya c.Jobs ile alınır
   seff(j)      % İş tamamlandıktan sonra
   willRun(j)   % İş kuyrukta beklerken

seff Çıktısının Yorumlanması
----------------------------

``seff(j)``, işinizin kendisine ayrılan kaynakları ne kadar verimli 
kullandığına dair bir özet sunar. Örnek çıktı:

::

   ID: 5335910
   Cluster: arf
   User/Group: username/username
   State: COMPLETED (exit code 0)
   Nodes: 1
   Cores per node: 56
   CPU Utilized: 00:22:41
   CPU Efficiency: 22.50% of 01:40:48 core-walltime
   Job Wall-clock time: 00:01:48
   Memory Utilized: 50.29 GB
   Memory Efficiency: 45.98% of 109.38 GB

Gelecekteki iş gönderimlerini optimize etmek için en yararlı iki değer:

-  **CPU Verimliliği (CPU Efficiency):** %22.50 değeri, worker'ların işin 
   büyük bölümünde boşta kaldığı anlamına gelir. Ya iş yükü 56 worker'ı 
   meşgul tutmak için çok küçüktü ya da iterasyonlar arasında dengesiz 
   bir yük dağılımı vardı. Havuz (pool) boyutunu azaltmayı veya iterasyon 
   başına iş yükünü artırmayı düşünün.



-  **Bellek Verimliliği (Memory Efficiency):** %45.98 değeri, ayrılan 
   belleğin yaklaşık yarısının kullanılmadığı anlamına gelir. TRUBA'da 
   bellek miktarı talep edilen çekirdek sayısıyla ölçeklendiği için, bir 
   sonraki çalışmada daha az çekirdek talep ederek yeterli belleğe sahip 
   olmaya devam edebilirsiniz.

.. admonition:: İpucu

   Kaynak taleplerinizi optimize ederken her işten sonra ``seff`` komutunu 
   çalıştırın. CPU ve bellek verimliliği sürekli olarak yüksek olduğunda, 
   iş yükünüz için en doğru yapılandırmayı bulmuşsunuz demektir.

.. _troubleshooting-tr:

Sorun Giderme
=============

İş Başarısız Oldu: Hata Ayıklama Günlüklerinin Alınması
--------------------------------------------------------

Bir batch işi başarısız olursa, TRUBA üzerindeki MATLAB worker'larından gelen 
ayrıntılı hata mesajlarını almak için ``getDebugLog`` komutunu kullanın.

Havuz (pool) işleri için:

.. code:: matlab

   c.getDebugLog(job)

Bağımsız işler (birden fazla görev) için:

.. code:: matlab

   c.getDebugLog(job.Tasks)

Slurm İş Kimliğinin (Job ID) Alınması
-------------------------------------

Bir sorunu TRUBA desteğine bildirmeniz gerekirse, sizden Slurm iş kimliğini 
(Job ID) isteyebilirler. Bu kimliği şu komutla alabilirsiniz:

.. code:: matlab

   job.getTaskSchedulerIDs()

Örnek çıktı:

::

   ans =
       25539

Bu numara, TRUBA login nodunda ``squeue`` veya ``sacct`` komutlarıyla 
görülebilen Slurm iş numarasına karşılık gelir.



Lisanslama Sorunları
--------------------

TRUBA üzerindeki MATLAB işleri şunları gerektirir:

-  Yerel MATLAB kurulumunuzda geçerli bir **akademik lisans**.
-  ``parpool`` ve ``Pool`` parametreli ``batch`` kullanımı için 
   **Parallel Computing Toolbox**.

TRUBA'nın ağ lisansı zaten yapılandırılmıştır; küme tarafında herhangi bir 
ayar yapmanıza gerek yoktur.

Yerel Lisansınızı Kontrol Etme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yerel MATLAB kurulumunuzda Parallel Computing Toolbox olup olmadığını 
doğrulamak için:

.. code:: matlab

   license('test', 'Distrib_Computing_Toolbox')
   % Varsa 1, yoksa 0 döner

Oturumunuzda o an kullanılan tüm araç kutularını (toolboxes) görmek için:

.. code:: matlab

   license('inuse')

MATLAB'ınızda kurulu olan tüm araç kutularını görmek için:

.. code:: matlab

   ver

.. admonition:: Not

   Eklenti (Metot B) üzerinden kümeye iş göndermek için akademik lisans 
   zorunludur. Kurumsal lisansınızın Parallel Computing Toolbox'ı kapsayıp 
   kapsamadığından emin değilseniz, kurumunuzun MATLAB lisans yöneticisine 
   danışın.

Lisans Sorunu Belirtileri
~~~~~~~~~~~~~~~~~~~~~~~~~

-  İşin gönderildikten hemen sonra başarısız olması.
-  Worker'ların başlatılamaması.
-  ``parpool`` komutunun takılması veya lisans hatası (checkout failure) 
   vermesi.

TRUBA Tarafında Lisans Sorunu Olduğundan Şüpheleniyorsanız
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TRUBA desteğiyle iletişime geçin ve şu bilgileri ekleyin:

-  Slurm iş kimliği (``job.getTaskSchedulerIDs()``).
-  Hata ayıklama günlüğü (debug log) (``c.getDebugLog(job)``).
-  ``j.Tasks(1).Error`` komutundan gelen tam hata mesajı.

Daha Fazla Bilgi
================

MATLAB Parallel Computing Toolbox hakkında daha fazla bilgi edinmek için 
aşağıdaki resmi MathWorks kaynakları yardımcı olabilir:

-  `Paralel Hesaplamaya Genel Bakış <https://www.mathworks.com/products/parallel-computing/index.html>`_
-  `Paralel Hesaplama Dokümantasyonu <https://www.mathworks.com/help/parallel-computing/>`_
-  `Paralel Hesaplama Kod Örnekleri <https://www.mathworks.com/help/parallel-computing/examples.html>`_
-  `Paralel Hesaplama Eğitimleri <https://www.mathworks.com/products/parallel-computing/tutorials.html>`_
-  `Paralel Hesaplama Videoları <https://www.mathworks.com/products/parallel-computing/videos.html>`_
-  `Paralel Hesaplama Webinarları <https://www.mathworks.com/products/parallel-computing/webinars.html>`_

Bu kaynaklar, MATLAB içindeki genel paralel hesaplama kullanımını kapsar ve 
TRUBA küme yapılandırmasına özel değildir.

Hızlı Referans
==============

Temel Ayarlar
-------------

.. code:: matlab

   c = parcluster;

   c.AdditionalProperties.Partition = 'debug';   % kuyruk adı
   c.AdditionalProperties.NumNodes  = 1;         % node sayısı
   c.AdditionalProperties.WallTime  = '0-00:10'; % azami çalışma süresi (G-SA:DA)

Testler için her zaman ``debug`` ile başlayın. Üretim işleri için kuyruğu 
değiştirin.

.. _submitting-a-job-tr:

İş Gönderme
-----------

.. code:: matlab

   j = batch(c, @fonksiyonunuz, 1, {}, ...
       'Pool', N, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

.. _the-pool1-rule-tr:

Pool+1 Kuralı
-------------

::

   Toplam Slurm görevi = Pool + 1

MATLAB, yönetim (orchestration) için fazladan bir görev kullanır. Katı 
çekirdek politikası uygulayan kuyruklarda bu hesaplama kritiktir:

=============== ========== ===========
Kuyruk          Çekirdek/N Pool Değeri
=============== ========== ===========
``orfoz``       56         55
``orfoz``       112        111
``hamsi``       56         55
``barbun``      40         39
``barbun-cuda`` (GPU) 40   39
``akya-cuda``   (GPU) 40   39
=============== ========== ===========

.. _monitoring-and-retrieving-results-tr:

İş İzleme ve Sonuçların Alınması
--------------------------------

.. code:: matlab

   j.State              % queued / running / finished / failed
   wait(j)              % iş bitene kadar MATLAB'ı beklet
   diary(j)             % worker'ların çıktılarını görüntüle
   out = fetchOutputs(j); out{1}   % fonksiyon dönüş değerini al
   j.Tasks(1).Error     % iş başarısızsa hatayı görüntüle
   c.getDebugLog(j)     % detaylı worker hata günlüğü

Login nodu üzerinden:

.. code:: bash

   squeue -u $USER
   sacct -j <jobid> --format=JobID,State,Elapsed,AllocCPUS,NodeList

.. _coming-back-to-a-completed-job-tr:

Tamamlanmış Bir İşe Geri Dönme
------------------------------

.. code:: matlab

   c = parcluster;
   c.Jobs        % tüm işleri listele
   j = c.Jobs(end);          % en son gönderilen iş
   j = c.findJob('ID', 4);   % ID ile belirli bir işi seç

Ayarların Kaydedilmesi
----------------------

.. code:: matlab

   c.saveProfile             % ayarları oturumlar arasında kalıcı yap
   c.AdditionalProperties    % mevcut tüm ayarları görüntüle

Örnek: ``orfoz`` Üzerinde CPU İşi (56 çekirdekli yarım node)
-------------------------------------------------------------

.. code:: matlab

   c = parcluster;
   c.AdditionalProperties.Partition = 'orfoz';
   c.AdditionalProperties.NumNodes  = 1;
   c.AdditionalProperties.WallTime  = '0-00:10';

   j = batch(c, @pwd, 1, {}, ...
       'Pool', 55, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

   wait(j);
   out = fetchOutputs(j);
   out{1}    % TRUBA üzerindeki çalışma dizininizi döndürmelidir

Örnek: ``barbun-cuda`` Üzerinde GPU İşi (2 GPU, 40 CPU)
--------------------------------------------------------

.. code:: matlab

   c = parcluster;
   c.AdditionalProperties.Partition  = 'barbun-cuda';
   c.AdditionalProperties.NumNodes   = 1;
   c.AdditionalProperties.WallTime   = '0-00:10';
   c.AdditionalProperties.GPUsPerNode = 2;

   j = batch(c, @gpuDeviceCount, 1, {}, ...
       'Pool', 39, ...
       'CurrentFolder', '.', ...
       'AutoAddClientPath', false);

   wait(j);
   out = fetchOutputs(j);
   out{1}    % worker tarafından görülen GPU sayısını (2) döndürmelidir


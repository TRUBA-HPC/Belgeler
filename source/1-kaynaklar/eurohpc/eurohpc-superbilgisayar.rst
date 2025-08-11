.. _eurohpc_systems:

========================================
EuroHPC JU Süper Bilgisayar Sistemleri
========================================


EuroHPC JU, Avrupa'ya dünya lideri bir süper bilgi işlem altyapısı sağlamak için Avrupa genelinde konumlandırılmış on adet süper bilgisayar tedarik etmiştir (https://eurohpc-ju.europa.eu/supercomputers/our-supercomputers_en). Bu süper bilgisayarlar, mimari, hesaplama bölümleri, depolama ve kaynak yöneticisi açısından birbirinden farklılık gösterir.

Bu sistemlerden, EuroHPC JU'ya üye ülkelerde yerleşik olan akademi, kamu sektörü ve endüstriden gelen kullanıcılar, EuroHPC Erişim Çağrıları aracılığıyla faydalanabilirler. Türkiye'deki araştırmacılar, EuroHPC JU'ya üye ülke olarak bu sistemlere erişim sağlayabilirler.


   
   
.. grid:: 3

    .. grid-item-card:: :ref:`lumi`
        :text-align: center
    .. grid-item-card:: :ref:`leonardo`
        :text-align: center
    .. grid-item-card:: :ref:`marenostrum5`
        :text-align: center
    .. grid-item-card:: :ref:`meluxina`
        :text-align: center
    .. grid-item-card:: :ref:`karolina`
        :text-align: center
    .. grid-item-card:: :ref:`discoverer`
        :text-align: center
    .. grid-item-card:: :ref:`vega`
        :text-align: center
    .. grid-item-card:: :ref:`deucalion`
        :text-align: center
    .. grid-item-card:: :ref:`jupiter`
        :text-align: center
    .. grid-item-card:: :ref:`daedalus`
        :text-align: center


---------------------------------------------
Haziran 2025 TOP500 ve Green500 Listeleri
---------------------------------------------

10 Haziran 2025'te Hamburg, Almanya'daki ISC Yüksek Performanslı Konferansı'nda TOP500 ve Green500 listelerinin en son sürümleri yayınlandı. Tüm operasyonel EuroHPC JU süper bilgisayarları, dünyanın en güçlü sistemlerinin listelendiği TOP500'de yer almakta olup, ikisi küresel ilk 10'da yer almaktadır. EuroHPC JU, yeşil süper bilgisayarlar tedarik etme çabalarını sürdürmekte ve birçok sistemi Green500 listesinde üst sıralarda yer almaktadır


.. image:: /assets/eurohpc/June2025-Tableranking.png
    :width: 500
    :align: center

.. image:: /assets/eurohpc/fastest-systems-june2025.jpg
    :width: 450
    :align: center



---------------------------------------------
EuroHPC Süper Bilgisayar Sistemleri
---------------------------------------------


.. _lumi:


LUMI
------

LUMI, Finlandiya'da CSC tarafından işletilen pre-eksasayı bir EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Kajaani, Finlandiya (CSC – IT Center for Science)

*   **Sağlayıcı ve Mimari:** Hewlett Packard Enterprise (HPE), HPE Cray EX

*   **Performans:** 379.7 petaflop HPL performansına sahiptir. Sürekli performans 386.00 petaflop, Tepe performans 539.13 petaflop.

*   **Hesaplama Bölümleri:** GPU bölümü (LUMI-G), x86 CPU bölümü (LUMI-C), veri analizi bölümü (LUMI-D), konteyner bulut bölümü (LUMI-K).
    *   **LUMI-C (Tip 1):** 1376 sunucu, 2x AMD EPYC 7763 (64 Çekirdek, 2.45 GHz), 256 GB Bellek.

    *   **LUMI-C (Tip 2):** 128 sunucu, 2x AMD EPYC 7763 (64 Çekirdek, 2.45 GHz), 512 GB Bellek.

    *   **LUMI-C (Tip 3):** 32 sunucu, 2x AMD EPYC 7763 (64 Çekirdek, 2.45 GHz), 1024 GB Bellek.

    *   **LUMI-G:** 2560 sunucu, 1x AMD Trento (64 Çekirdek), 4x AMD Instinct MI250X (128 GB Bellek), 512 GB Bellek.

    *   **LUMI-D (Tip 1):** 4 sunucu, 2x AMD EPYC 7742 (64 Çekirdek, 2.25 GHz), 8 TB Bellek, 25 TB SSD lokal depolama.

    *   **LUMI-D (Tip 2):** 8 sunucu, 2x AMD EPYC 7742 (64 Çekirdek, 2.25 GHz), 8x NVIDIA A40 (48 GB Bellek), 2 TB Bellek, 14 TB SSD lokal depolama.

*   **İşlemci (CPU):** LUMI-C bölümü, 64 çekirdekli yeni nesil AMD EPYC™ CPU'lara sahiptir.

*   **Grafik İşlem Birimi (GPU):** LUMI-G, gelecek nesil AMD Instinct™ GPU'ya dayanmaktadır.

*   **Depolama Kapasitesi:** Üç bileşenden oluşur: 7 petabayt ultra hızlı flash depolama, 80 petabayt geleneksel kapasite depolama (Lustre paralel dosya sistemi tabanlı) ve 30 petabayt Ceph tabanlı veri yönetim hizmeti. Toplamda 117 petabayt depolama ve saniyede 2 terabayt maksimum G/Ç bant genişliği.

*   **Uygulama Alanları:** AI (özellikle derin öğrenme), geleneksel büyük ölçekli simülasyonlar ve büyük ölçekli veri analizleri.

*   **TOP500 Sıralaması (Haziran 2025):** 9. sırada yer alarak Mayıs 2022'den bu yana üçüncü yıl üst üste dünyanın en güçlü ilk 10 sistemi arasında kalmıştır. (Kasım 2024 sıralaması: 8. sırada).

*   **Green500 Sıralaması (Haziran 2025):** Watt başına 53 binden fazla milyon işlemle Green500 listesinde 36. sıraya ulaşmıştır. (Kasım 2024 sıralaması: 25. sırada).

*   **Diğer Detaylar:** Tamamen karbonsuz hidroelektrik yenilenebilir enerjiyle çalışır ve işlemcilerini soğutmak için sıvı soğutma kullanırken, atık ısıyı yerel bölge ısıtması için değerlendirir. 150m2'den fazla alan kaplar ve yaklaşık 150.000 kilogram ağırlığındadır.

.. _leonardo:


LEONARDO
----------

Leonardo, Bologna Teknoparkı, İtalya'da bulunan pre-eksasayı bir EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Bologna Teknoparkı, İtalya (CINECA)

*   **Sağlayıcı ve Mimari:** ATOS, BullSequana XH2000

*   **Performans:** 241.2 petaflop performansına sahiptir. Sürekli performans 249.04 petaflop, Tepe performans 315.74 petaflop.

*   **Hesaplama Bölümleri:** 240 petaflop sağlayan GPU bölümü (Booster) ve DDR5 Bellek ve yerel NVMe içeren 9 petaflop sağlayan x86 CPU bölümü (Veri Merkezli).

    *   **Booster (Intel Ice-Lake):** 3456 sunucu, 1 x CPU Intel Xeon 8358 (32 çekirdek, 2.6 GHz), 4 x NVidia özel Ampere GPU 64GB HBM2, 512 (8 x 64) GB RAM DDR4 3200 MHz.

    *   **Data-Centric (Intel Sapphire Rapids):** 1536 sunucu, 2x Intel Sapphire Rapids (56 çekirdek, TDP 350 W), 512 (16 x 32) GB RAM DDR5 4800 MHz, 8 TB NVM lokal depolama.

*   **İşlemci (CPU):** Intel Ice-Lake (Booster), Intel Sapphire Rapids (Veri Merkezli).

*   **Grafik İşlem Birimi (GPU):** NVIDIA Ampere mimarisine dayalı 13824 "Da Vinci" GPU, 10 exaflop FP16 Tensor Flow AI performansı sağlar.

*   **Depolama Kapasitesi:** 100 petabaytın üzerinde yeni nesil sabit disk sürücüleri ve 5 petabayt tam flash ve NVMe teknolojileriyle donatılmıştır.

*   **Uygulama Alanları:** Modüler ve ölçeklenebilir hesaplama uygulamaları, veri analizi, etkileşimli, acil ve bulut hesaplama uygulamaları.

*   **TOP500 Sıralaması (Haziran 2025):** Küresel sıralamada 10. sırada yer almaktadır ve bu konumu Kasım 2022'den bu yana korumaktadır. (Kasım 2024 sıralaması: 9. sırada).

*   **Green500 Sıralaması (Kasım 2024):** 48. sırada.

*   **Diğer Detaylar:** Leonardo, Tecnopolo di Bologna'nın tesislerinde yer almaktadır. EuroHPC Leonardo sistemi için ayrılan alan 1240 metrekare hesaplama odası ve 900 metrekare yardımcı alanı içerir.

.. _marenostrum5:

^^^^^^^^^^^^^^^
MARENOSTRUM 5
^^^^^^^^^^^^^^^

MareNostrum 5, Barselona, İspanya'da bulunan pre-eksasayı bir EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Barselona, İspanya (Barselona Süper Hesaplama Merkezi - BSC)

*   **Sağlayıcı ve Mimari:** Bull SAS (Bull Sequana XH3000 ve Lenovo ThinkSystem mimarilerini birleştirir).

*   **Performans:** Sürekli performans 215.40 petaflop, Tepe performans 314 petaflop.

*   **Hesaplama Bölümleri:** GPP (Genel amaçlı bölüm), ACC (Hızlandırılmış bölüm), NGT GPP (Yeni Nesil Teknoloji Genel Amaçlı bölüm) ve NGT ACC (Yeni Nesil Teknoloji Hızlandırılmış bölüm). Ayrıca ön ve son işleme için daha küçük bölümler.


*   **İşlemci (CPU):** GPP ve ACC bölümleri Intel Sapphire Rapids CPU'lara dayanmaktadır. NGT ACC, NVIDIA GB200'e ve NGT GPP, NVIDIA Grace'e dayanmaktadır.

*   **Grafik İşlem Birimi (GPU):** ACC bölümü NVIDIA Hopper'a dayanırken, NGT ACC bölümü NVIDIA GB200 üzerine inşa edilmiştir.

*   **Depolama Kapasitesi:** SSD/Flash ve sabit disklere dayalı 248 PB net kapasite sağlar, yazmada 1.2 TB/s ve okumada 1.6 TB/s toplam performans. Bant tabanlı uzun süreli arşiv depolama çözümü 402 PB ek kapasite sağlayacaktır.

*   **Uygulama Alanları:** Heterojen yapılandırması sayesinde tüm uygulamalara ideal olarak uyar, özellikle tıbbi uygulamalar, ilaç keşfi, dijital ikizler (dünya ve insan vücudu), enerji vb. alanlara odaklanmıştır.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 11. sırada.

*   **Green500 Sıralaması (Haziran 2025):** Watt başına 48 binden fazla milyon işlemle Green500 listesinde 44. sırada yer almıştır. (Kasım 2024 sıralaması: 30. sırada).

*   **Diğer Detaylar:** Doğrudan sıvı soğutma ve enerji verimli HPC teknolojilerini içerir ve tamamen yeşil enerjiyle desteklenmektedir. BSC'nin yeni tesislerinde yer almaktadır.

.. _meluxina:

^^^^^^^^^^^^^^^
MELUXINA
^^^^^^^^^^^^^^^
MeluXina, Lüksemburg'da bulunan bir petaölçek EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Bissen, Lüksemburg (LuxProvide)

*   **Sağlayıcı ve Mimari:** Atos, BullSequana XH2000

*   **Performans:** Sürekli performans 12.81 petaflop, Tepe performans 18.29 petaflop.

*   **Hesaplama Bölümleri:** Hızlandırıcı - GPU (500 AI PetaFlop), Küme (3 PetaFlop tepe), Hızlandırıcı - FPGA ve Büyük Bellek Modülleri.

    *   **CPU:** 573 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 512 GB Bellek.

    *   **GPU:** 200 sunucu, 2x AMD EPYC 7452 (32 Çekirdek, 2.35 GHz), 4x NVIDIA A100 (40GB Bellek), 512 GB Bellek, 1.92 TB SSD lokal depolama.

    *   **FPGA:** 20 sunucu, 2x AMD EPYC 7452 (32 Çekirdek, 2.35 GHz), 2x Intel Stratix 10MX (16 GB), 512 GB Bellek, 1.92 TB SSD lokal depolama.

    *   **Büyük Bellek:** 20 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 4 TB Bellek, 1.92 TB SSD lokal depolama.

    *   **Bulut:** 20 sunucu, 2x AMD Rome (64 Çekirdek, 2.6 GHz), 512 GB Bellek.

*   **İşlemci (CPU):** AMD EPYC.

*   **Grafik İşlem Birimi (GPU):** NVIDIA Ampere A100.

*   **Depolama Kapasitesi:** 600 GB/s'nin üzerinde tüm-flash scratch katmanına sahip 20 PetaBayt ana depolama, Bant arşivleme yetenekleri.

*   **Uygulama Alanları:** AI, Dijital İkizler, Geleneksel Hesaplama İş yükleri, Kuantum simülasyonu.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 112. sırada.

*   **Green500 Sıralaması (Kasım 2024):** Küresel olarak 55. sırada.

.. _karolina:

^^^^^^^^^^^^^^^
KAROLINA
^^^^^^^^^^^^^^^

Karolina, Ostrava, Çek Cumhuriyeti'nde bulunan bir petaölçek EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Ostrava, Çek Cumhuriyeti (IT4Innovations Ulusal Süper Hesaplama Merkezi)

*   **Sağlayıcı ve Mimari:** Hewlett Packard Enterprise (HPE), HPE Apollo 2000Gen10 Plus ve HPE Apollo 6500

*   **Performans:** Sürekli performans 9.59 petaflop, Tepe performans 12.91 petaflop.

*   **Hesaplama Bölümleri:**

    *   Standart sayısal simülasyonlar için evrensel bölüm (yaklaşık 720 sunucu, 3.8 PFlop/s tepe performans).

    *   70 sunuculu hızlandırılmış bölüm (her biri 8 GPU hızlandırıcı, standart YBH simülasyonları için 11 PFlop/s, yapay zeka hesaplamaları için 150 PFlop/s'ye kadar).

    *   Geniş veri kümesi işleme bölümü (24 TB'ye kadar paylaşımlı bellek, 74 TFlop/s performans).

    *   Bulut hizmetleri için 36 sunucu (131 TFlop/s performans).

    *   Yüksek hızlı ağ (200 Gb/s'ye kadar hız).

    *   Veri depolamaları (1 PB'den fazla kullanıcı verisi, 1 TB/s hızında yüksek hızlı depolama).

*   **İşlemci (CPU):** 100.000'den fazla CPU çekirdeği ve 250 TB RAM.

    *   **CPU:** 720 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 256 GB Bellek.

*   **Grafik İşlem Birimi (GPU):** 3.8 milyondan fazla CUDA çekirdeği / 240.000 Tensor çekirdeği NVIDIA A100 Tensor Core GPU hızlandırıcılar (toplam 22.4 TB HBM2 bellek).

    *   **GPU:** 72 sunucu, 2x AMD EPYC 7763 (64 Çekirdek, 2.45 GHz), 8x NVIDIA A100 (40GB Bellek), 1 TB Bellek.

*   **Depolama Kapasitesi:** 1 petabayttan fazla kullanıcı verisi, 1 TB/s hızında yüksek hızlı veri depolama.

*   **Uygulama Alanları:** Geleneksel Hesaplama, AI, Büyük Veri.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 165. sırada.

*   **Green500 Sıralaması (Kasım 2024):** Küresel olarak 52. sırada.

.. _discoverer:

^^^^^^^^^^^^^^^
DISCOVERER
^^^^^^^^^^^^^^^
Discoverer, Sofya, Bulgaristan'da bulunan bir petaölçek EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Sofya, Bulgaristan (Sofia Tech Park)

*   **Sağlayıcı ve Mimari:** Atos, BullSequana XH2000

*   **Performans:** Sürekli performans 4.52 petaflop, Tepe performans 5.94 petaflop.

*   **Hesaplama Bölümleri:** 1128 düğüm sağlayan bir bölüm, 4.44 petaflop.

    *   **CPU Standard:** 1110 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 256 GB Bellek.

    *   **CPU Large Memory:** 18 sunucu, 2x AMD EPYC 7763 (64 Çekirdek, 2.45 GHz), 1 TB Bellek.

*   **İşlemci (CPU):** AMD EPYC 7H12 64 çekirdek, 2.6GHz, 280W (Kod adı Rome).

*   **Grafik İşlem Birimi (GPU):** 4x NVIDIA DGX H200 sistemi, 32x NVIDIA H200 T GPU (her biri 141GB GPU belleği).

*   **Depolama Kapasitesi:** DDN ES7990X ExaScaler (2 PB) ve Cray ClusterStor E1000 (5 PB) (her ikisi de Lustre depolama), doğrudan GPU erişimli Weka AI optimize depolama (442 TB).

*   **Uygulama Alanları:** n-silico ilaç keşfi, yapı-özellik tahminleri, moleküler keşif, malzeme tasarımı ve ilaç geliştirmeyi geliştirme. İklim tahmini, çevresel modelleme, dijital ürün formülasyonu, karar verme desteği. SLM, makine öğrenimi ve sinir ağı eğitimi, otomasyonu iyileştirir ve veri odaklı çözümler oluşturur.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 223. sırada.

*   **Green500 Sıralaması (Kasım 2024):** Küresel olarak 223. sırada.

.. _vega:

^^^^^^^^^^^^^^^
VEGA
^^^^^^^^^^^^^^^

Vega, Maribor, Slovenya'da bulunan bir petaölçek EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Maribor, Slovenya (IZUM)

*   **Sağlayıcı ve Mimari:** Atos, BullSequana XH2000

*   **Performans:** Sürekli performans 6.92 petaflop, Tepe performans 10.05 petaflop.

*   **Hesaplama Bölümleri:** CPU bölümü: 960 düğüm (2 CPU ve 256GB bellek/düğüm, %20'si 1TB/düğüm), 1x HDR100 ve GPU bölümü: 60 düğüm (2 CPU ve 512GB bellek, 2x HDR100, 4x Nvidia A100/düğüm).

    *   **CPU Standard:** 768 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 256 GB Bellek, 1.92 TB M.2 SSD lokal depolama.

    *   **CPU Large Memory:** 192 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 1 TB Bellek, 1.92 TB M.2 SSD lokal depolama.

    *   **GPU:** 60 sunucu, 2x AMD EPYC 7H12 (64 Çekirdek, 2.6 GHz), 4x NVIDIA A100 (40GB Bellek), 512 GB Bellek, 1.92 TB M.2 SSD lokal depolama.

    *   **Cloud:** 30 sunucu, 2x AMD EPYC 7502 (32 Çekirdek, 2.5 GHz), 512 GB Bellek, 2x 7.6 TB U.2 SSD lokal depolama.

*   **İşlemci (CPU):** 2040x CPU AMD EPYC 7H12 (64c, 2.6-3.3GHz), CPU ve GPU bölümlerinde 130.560 çekirdek.

*   **Grafik İşlem Birimi (GPU):** 240x Nvidia A100 (40 GB HBM2), 6912 FP32 CUDA çekirdeği ve GPU başına 432 Tensor çekirdeği.

*   **Depolama Kapasitesi:** Yüksek performanslı NVMe Lustre (1PB), büyük kapasiteli Ceph (23PB).

*   **Uygulama Alanları:** Geleneksel Hesaplama, AI, Büyük Veri/HPDA, Büyük ölçekli veri işleme.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 266. sırada.

*   **Green500 Sıralaması (Kasım 2024):** Küresel olarak 268. sırada.

.. _deucalion:

^^^^^^^^^^^^^^^
DEUCALION
^^^^^^^^^^^^^^^

Deucalion, Guimarães, Portekiz'de bulunan bir petaölçek EuroHPC süper bilgisayarıdır.

*   **Konum ve İşletici:** Guimarães, Portekiz (FCT tarafından barındırılmakta ve CNCA tarafından yönetilmektedir)

*   **Sağlayıcı ve Mimari:** Fujitsu Technology Solutions (Fujitsu PRIMEHPC (ARM bölümü) ve Atos Bull Sequana (x86 bölümleri) birleştirir)

*   **Performans:** Sürekli performans 7.48 petaflop, Tepe performans 9.76 petaflop.

*   **Hesaplama Bölümleri:** ARM Bölümü: 1632 düğüm, 3.96 PFLops; x86 Bölümü: 500 düğüm, 1.86 PFLops; Hızlandırılmış: 33 düğüm, 1.55 PFLops.
    *   **ARM:** 1632 sunucu, Fujitsu A64FX (52 çekirdek, 2.0GHz), 16 GB HBM2 Bellek.
    *   **x86:** 500 sunucu, AMD EPYC Rome 7742 (64 çekirdek, 2.25 GHz), 256 GB Bellek.
    *   **GPU:** 33 sunucu, 2 x AMD EPYC Rome 7742 (64 çekirdek, 2.25 GHz), 4x NVIDIA A100 (80 GB), 512 GB Bellek.

*   **İşlemci (CPU):** A64FX (ARM bölümü), AMD EPYC (x86 bölümleri).

*   **Grafik İşlem Birimi (GPU):** 33 düğüm, her biri 4x Nvidia Ampere A100 40 GB veya 80 GB.

*   **Depolama Kapasitesi:** 430 TB Yüksek hızlı NVMe bölümü, 10.6 PB yüksek hızlı paralel dosya sistemi bölümü.

*   **Uygulama Alanları:** Geleneksel Hesaplama, AI, Büyük Veri.

*   **TOP500 Sıralaması (Kasım 2024):** Küresel olarak 259. sırada.

*   **Green500 Sıralaması (Kasım 2024):** Küresel olarak 94. sırada.

.. _jupiter:

^^^^^^^^^^^^^^^
JUPITER
^^^^^^^^^^^^^^^

JUPITER, EuroHPC'nin ilk eksasayı süper bilgisayarı olacak ve Almanya'daki Jülich Süper Hesaplama Merkezi'nde (JSC) işletilecektir. Eviden tarafından sağlanan BullSequana XH3000 doğrudan sıvı soğutmalı mimariye dayanmaktadır.

*   **Konum ve İşletici:** Jülich Süper Hesaplama Merkezi (JSC), Almanya

*   **Sağlayıcı ve Mimari:** Eviden, BullSequana XH3000

*   **Performans:** Yaklaşık 800 petaflop ara hesaplama gücüne sahip olup, saniyede 800 milyon milyar hesaplamaya eşdeğerdir ve Avrupa'nın en hızlı süper bilgisayarıdır. Yakında 1 ExaFLOP (saniyede 1 trilyon işlem) hesaplama gücü sunabilecektir.

*   **Hesaplama Bölümleri:** Hızlandırılmış GPU tabanlı Booster Modülü ve genel amaçlı, yüksek bellek bant genişliğine sahip Küme Modülü.

*   **İşlemci (CPU):** Küme Modülü, BullSequana XH3000 platformuna entegre SiPearl Rhea1 işlemcisini (ARM, HBM) kullanacaktır.

*   **Grafik İşlem Birimi (GPU):** Booster Modülü, BullSequana XH3000 platformuna entegre NVIDIA teknolojisini kullanacaktır.

*   **Depolama Kapasitesi:** 20 petabayt ultra hızlı flash depolama bölümü sağlayacaktır.

*   **Uygulama Alanları:** Bilim ve endüstrideki en zorlu simülasyonları ve yoğun AI uygulamalarını ele almak için tasarlanmıştır. Bu uygulamalar arasında AI'da büyük sinir ağlarının eğitilmesi, fonksiyonel malzemelerin geliştirilmesi için simülasyonlar, insan kalbinin veya beyninin dijital ikizlerinin oluşturulması, kuantum bilgisayarların doğrulanması ve tüm Dünya sistemini kapsayan yüksek çözünürlüklü iklim simülasyonları yer alacaktır.

*   **TOP500 Sıralaması (Haziran 2025):** 4. sırada.

*   **Green500 Sıralaması (Haziran 2025):** En hızlı ilk beş süper bilgisayar arasında en enerji verimli sistemdir. İlk kurulan modülü JEDI, Mayıs 2024'teki sıralamadaki çıkışından bu yana bir yıldır Green500 listesinde lider konumdadır. JUPITER Booster, watt başına 60 binden fazla milyon işlemle Green500 listesinde 21. sırada yer almıştır.

*   **Diğer Detaylar:** JUPITER, son aşama ince ayar ve teknik kabul sürecindedir. Yüksek verimli sıcak su soğutma sistemi ile çalışır ve operasyonda oluşan atık ısıyı binaları ısıtmak için kullanmayı amaçlamaktadır.
  
.. _daedalus:

^^^^^^^^^^^^^^^
DAEDALUS
^^^^^^^^^^^^^^^

DAEDALUS, orta ölçekli bir petaölçek EuroHPC süper bilgisayarı olacaktır.


*   **Konum ve İşletici:** Attica (Lavrio), Yunanistan (Ulusal Araştırma ve Teknoloji Altyapıları - GRNET)

*   **Sağlayıcı ve Mimari:** HPE, NVIDIA GH200 doğrudan sıvı soğutmalı mimari

*   **Performans:** Beklenen Sürekli performans 89 petaflop, Beklenen Tepe performans 115 petaflop.

*   **Hesaplama Bölümleri:** CPU bölümü, Hızlandırılmış bölüm.

*   **İşlemci (CPU):** Her GH200 süperçipinin 72 ARM çekirdeğinden 64'ünü kullanan sanal bölüm.

*   **Grafik İşlem Birimi (GPU):** Her süperçipinin 72 ARM çekirdeğinden 8'ini ve H100'ü kullanan sanal bölüm.

*   **Depolama Kapasitesi:** 1 PB Yüksek performanslı NVMe depolama ve 10 PB kullanılabilir kapasite depolama.

*   **Uygulama Alanları:** Geleneksel HPC, AI, Büyük Veri/HPDA.


-------------------------------------------------------------------
EuroHPC Yapay Zeka Fabrikaları ve Kuantum Bilgisayar Sistemleri
-------------------------------------------------------------------

EuroHPC Ortak Girişimi, şu anda Avrupa genelinde 13 Yapay Zeka Fabrikası'nın uygulanmasını denetlemektedir. Bu kapsamlı açık yapay zeka ekosistemleri, KOBİ'lere ve start-up'lara ücretsiz ve özelleştirilmiş destek sunmaktadır. Yapay Zeka Fabrikaları hakkında bilgi için :ref:`yz-fabrikalari` sayfasını ziyaret edebilirsiniz

EuroHPC JU ayrıca, süper bilgisayarlarla çeşitli Avrupa kuantum hesaplama teknolojilerini entegre eden bir Avrupa Kuantum Hesaplama altyapısı da geliştirmektedir. Bu çabanın bir parçası olarak, altı kuantum bilgisayar temin edilmiş olup, şu anda Polonya, Çek Cumhuriyeti, Fransa, Almanya, İtalya ve İspanya'da konuşlandırılmaktadır. Ayrıntılı bilgi için `EuroHPC JU Kuantum Bilgisayarları <https://eurohpc-ju.europa.eu/eurohpc-quantum-computers_en>`_ sayfasını ziyaret edebilirsiniz.


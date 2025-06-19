.. _eurohpc_erisim:

===============================================
EuroHPC JU Sistemlerine Erişim Çağrıları
===============================================

EuroHPC JU süper bilgisayarlarına erişim için farklı erişim çağrıları bulunmaktadır. Her çağrı, belirli bir kullanıcı grubuna yönelik farklı gereksinimler ve hedefler içermektedir.


.. grid:: 3

    .. grid-item-card::  :ref:`benchmark_cagrisi`
        :text-align: center
    .. grid-item-card:: :ref:`development_cagrisi`
        :text-align: center
    .. grid-item-card:: :ref:`yz-ab_cagrisi`
        :text-align: center
    .. grid-item-card:: :ref:`regular-access_cagrisi`
        :text-align: center
    .. grid-item-card::  :ref:`extreme-scale_cagrisi`
        :text-align: center
 


.. _benchmark_cagrisi:

----------------------------------------------
Benchmark (Kıyaslama) Erişim Çağrısı
----------------------------------------------

Bu çağrı, araştırmacılara ve Yüksek Performanslı Hesaplama (HPC) uygulama geliştiricilerine, Extreme Scale ve Regular Erişim çağrılarına başvurmadan önce uygulamalarını mevcut veya yeni EuroHPC JU süper bilgisayar sistemlerinde test etme veya kıyaslama (benchmark) yapma fırsatı sunmayı amaçlar. Özellikle kod ölçeklenebilirlik testleri veya yapay zeka uygulamalarının test edilmesi için tasarlanmıştır ve elde edilen sonuçların gelecekteki daha büyük başvurulara dahil edilmesi hedeflenir. Kullanıcılar süper bilgisayarlara alışmak için de bu çağrıyı kullanabilirler. Bu çağrı kapsamında kullanıcılara sınırlı miktarda kaynak tahsis edilir ve maksimum tahsis süresi üç aydır. Çağrılar sürekli açıktır ve aylık kesim tarihlerine sahiptir. Kaynaklara erişim, başvurunun yapılmasından sonraki 2-3 hafta içinde başlar. Değerlendirme süreci, bilimsel hakem değerlendirmesi olmaksızın idari kontrol ve teknik değerlendirme ile gerçekleşir.

**Çağrı için son başvuru tarihleri:**

1 Ocak 2025, 10:00 / 1 Şubat 2025, 10:00 / 1 Mart 2025, 10:00 / 1 Nisan 2025, 10:00 / 1 Mayıs 2025, 10:00 / 1 Haziran 2025, 10:00 / 1 Temmuz 2025, 10:00 / 1 Ağustos 2025, 10:00 / 1 Eylül 2025, 10:00 / 1 Ekim 2025, 10:00 / 1 Kasım 2025, 10:00 / 1 Aralık 2025, 10:00 (CET)

İlgili erişim çağrısı hakkında güncel ve ayrıntılı bilgi için tıklayınız: 
`Benchmark Erişim Çağrısı <https://eurohpc-ju.europa.eu/eurohpc-ju-call-proposals-benchmark-access_en>`_ 

.. list-table:: Benchmark Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Ülke
     - Bölümlendirme
     - İşlemci
     - Hızlandırıcı
     - Benchmark
   * - `DEUCALION <https://eurohpc-ju.europa.eu/supercomputers/our-supercomputers_en#deucalion>`_
     - Portekiz (FCT)
     - Deucalion ARM
     - Fujitsu A64FX
     - -
     - 2 000
   * -
     - 
     - Deucalion x86
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - Deucalion GPU
     - AMD Epyc
     - NVIDIA A100
     - 200
   * - `MARENOSTRUM5 <https://www.bsc.es/supportkc/docs/MareNostrum5/intro/>`_
     - İspanya (BSC)  
     - MN5 GPP
     - Intel Sapphire Rapids
     - -
     - 2 500
   * - 
     - 
     - MN5 ACC
     - Intel Sapphire Rapids
     - NVIDIA Hopper
     - 2 000
   * - 
     - 
     - MN5 HBM
     - Intel Sapphire Rapids
     - -
     - 2 000
   * - `LEONARDO <https://leonardo-supercomputer.cineca.eu/hpc-system/>`_
     - İtalya (CINECA)
     - Leonardo DCGP
     - Intel Sapphire Rapids
     - -
     - 2 000
   * - 
     - 
     - Leonardo Booster
     - Intel Xeon
     - NVIDIA A100
     - 3 500
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - Finlandiya (CSC)
     - LUMI-C
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - LUMI-G
     - AMD Epyc
     - AMD Instinct
     - 2 500
   * - `DISCOVERER <https://docs.discoverer.bg/resource_overview.html>`_
     - Bulgaristan (Sofia Tech Park)
     - Discoverer CPU
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - Discoverer GPU
     - AMD Epyc
     - NVIDIA Hopper
     - 200
   * - `MELUXINA <https://docs.lxp.lu/>`_
     - Lüksemburg (LuxProvide)
     - MeluXina CPU
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - MeluXina GPU
     - AMD Epyc
     - NVIDIA A100
     - 400
   * - 
     - 
     - MeluXina FPGA
     - AMD Epyc
     - Intel Stratix
     - 600
   * - `Karolina <https://docs.it4i.cz/karolina/hardware-overview/>`_
     - Çekya (IT4I VSB-TUO)
     - Karolina CPU
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - Karolina GPU
     - AMD Epyc
     - NVIDIA A100
     - 400
   * - `Vega <https://doc.vega.izum.si/>`_
     - Slovenya (IZUM Maribor)
     - Vega CPU
     - AMD Epyc
     - -
     - 2 000
   * - 
     - 
     - Vega GPU
     - AMD Epyc
     - NVIDIA A100
     - 400

.. note::

  * Yukarıdaki EuroHPC sistemleri, operasyonel olan en son mevcut sistemi gösterecek şekilde sıralanmıştır. 
  * Kaynaklar **düğüm saati (node hours)** cinsinden gösterilmektedir.

.. _development_cagrisi:

----------------------------------------------
Development (Geliştirme) Erişim Çağrısı
----------------------------------------------

Development çağrısı, araştırmacılara ve HPC uygulama geliştiricilerine, Extreme Scale ve Regular Erişim çağrılarına başvurmadan önce uygulamalarını EuroHPC süper bilgisayar sistemlerinde geliştirme, test etme ve optimize etme imkanı sağlamayı amaçlar. Temel olarak kod ve algoritma geliştirme ve optimizasyon projelerine, ayrıca yapay zeka uygulama yöntemlerinin geliştirilmesine odaklanmıştır. Bu çağrıya akademi, kamu ve özel sektör temsilcileri başvurabilir ve kullanıcılara sınırlı kaynak tahsisi yapılır. Tahsis süresi bir yıldır ve iki defaya kadar uzatma alınabilir. Çağrılar sürekli açıktır ve aylık kesim tarihlerine sahiptir. Kaynaklara erişim, başvurunun yapılmasından sonraki 2-3 hafta içinde başlar. Değerlendirme sürecinde bilimsel hakem değerlendirmesi yapılmaz, yalnızca idari kontrol ve teknik değerlendirme esastır.

**Çağrı için son başvuru tarihleri:**

1 Ocak 2025, 10:00 / 1 Şubat 2025, 10:00 / 1 Mart 2025, 10:00 / 1 Nisan 2025, 10:00 / 1 Mayıs 2025, 10:00 / 1 Haziran 2025, 10:00 / 1 Temmuz 2025, 10:00 / 1 Ağustos 2025, 10:00 / 1 Eylül 2025, 10:00 / 1 Ekim 2025, 10:00 / 1 Kasım 2025, 10:00 / 1 Aralık 2025, 10:00 (CET)

İlgili erişim çağrısı hakkında güncel ve ayrıntılı bilgi için tıklayınız: 
`Development Erişim Çağrısı <https://eurohpc-ju.europa.eu/eurohpc-ju-call-proposals-development-access_en>`_ 

.. list-table:: Development Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Ülke
     - Bölümlendirme
     - İşlemci
     - Hızlandırıcı
     - Development
   * - `DEUCALION <https://eurohpc-ju.europa.eu/supercomputers/our-supercomputers_en#deucalion>`_
     - Portekiz (FCT)
     - Deucalion ARM
     - Fujitsu A64FX
     - -
     - 4 000
   * -
     - 
     - Deucalion x86
     - AMD Epyc
     - -
     - 3 000
   * - 
     - 
     - Deucalion GPU
     - AMD Epyc
     - NVIDIA A100
     - 400
   * - `MARENOSTRUM5 <https://www.bsc.es/supportkc/docs/MareNostrum5/intro/>`_
     - İspanya (BSC)  
     - MN5 GPP
     - Intel Sapphire Rapids
     - -
     - 4 500
   * - 
     - 
     - MN5 ACC
     - Intel Sapphire Rapids
     - NVIDIA Hopper
     - 3 500
   * - 
     - 
     - MN5 HBM
     - Intel Sapphire Rapids
     - -
     - 4 000
   * - `LEONARDO <https://leonardo-supercomputer.cineca.eu/hpc-system/>`_
     - İtalya (CINECA)
     - Leonardo DCGP
     - Intel Sapphire Rapids
     - -
     - 4 000
   * - 
     - 
     - Leonardo Booster
     - Intel Xeon
     - NVIDIA A100
     - 4 500
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - Finlandiya (CSC)
     - LUMI-C
     - AMD Epyc
     - -
     - 4 000
   * - 
     - 
     - LUMI-G
     - AMD Epyc
     - AMD Instinct
     - 4 500
   * - `DISCOVERER <https://docs.discoverer.bg/resource_overview.html>`_
     - Bulgaristan (Sofia Tech Park)
     - Discoverer CPU
     - AMD Epyc
     - -
     - 4 500
   * - 
     - 
     - Discoverer GPU
     - AMD Epyc
     - NVIDIA Hopper
     - 450
   * - `MELUXINA <https://docs.lxp.lu/>`_
     - Lüksemburg (LuxProvide)
     - MeluXina CPU
     - AMD Epyc
     - -
     - 1 100
   * - 
     - 
     - MeluXina GPU
     - AMD Epyc
     - NVIDIA A100
     - 4 000
   * - 
     - 
     - MeluXina FPGA
     - AMD Epyc
     - Intel Stratix
     - 800
   * - `Karolina <https://docs.it4i.cz/karolina/hardware-overview/>`_
     - Çekya (IT4I VSB-TUO)
     - Karolina CPU
     - AMD Epyc
     - -
     - 4 000
   * - 
     - 
     - Karolina GPU
     - AMD Epyc
     - NVIDIA A100
     - 800
   * - `Vega <https://doc.vega.izum.si/>`_
     - Slovenya (IZUM Maribor)
     - Vega CPU
     - AMD Epyc
     - -
     - 4 000
   * - 
     - 
     - Vega GPU
     - AMD Epyc
     - NVIDIA A100
     - 800

.. note::

  * Yukarıdaki EuroHPC sistemleri, operasyonel olan en son mevcut sistemi gösterecek şekilde sıralanmıştır. 
  * Kaynaklar **düğüm saati (node hours)** cinsinden gösterilmektedir.
  
.. _yz-ab_cagrisi:

----------------------------------------------------------------
Bilim için Yapay Zeka ve İşbirlikçi AB Projeleri Erişim Çağrısı
----------------------------------------------------------------

Bu erişim modu çağrısı, etik Yapay Zeka (AI), Makine Öğrenmesi (ML) ve özellikle Temel Modeller (Foundation Models) ile Üretken Yapay Zeka (Generative AI), Büyük Dil Modelleri (Large Language Models) dahil olmak üzere AI uygulamalarını desteklemeyi amaçlar. Bilimsel araştırma faaliyetleri için tasarlanmış olup, araştırmaların bir parçası olarak yapay zeka modellerine dayanan tüm bilimsel kullanıcıları (finansmanlı olsun ya da olmasın), kamu sektörü kullanıcılarını ve Horizon Europe veya Dijital Avrupa Programı gibi AB programları tarafından finanse edilen Ar-Ge projelerine katılan endüstriyel kullanıcıları kapsar. Tahsisler altı aylık süreler için verilir. Çağrı sürekli açıktır ve önceden belirlenmiş kesim tarihlerine sahiptir. Kaynaklara erişim, kesim tarihinden sonra bir ay içinde başlar. Değerlendirme teknik inceleme ve uzman hakem değerlendirmesiyle yapılır ve ödül kararları "ilk gelen, ilk hizmet alır" ilkesi doğrultusunda mükemmeliyet, yenilikçilik ve etki ile uygulama kalitesi kriterlerine göre değerlendirilir.

**Çağrı için son başvuru tarihleri:**

20 Haziran 2025, 10:00 / 8 Ağustos 2025, 10:00 / 10 Ekim 2025, 10:00 / 12 Aralık 2025, 10:00 (CET) 


İlgili erişim çağrısı hakkında güncel ve ayrıntılı bilgi için tıklayınız: 
`Bilim için Yapay Zeka ve İşbirlikçi AB Projeleri Erişim Çağrısı <https://eurohpc-ju.europa.eu/eurohpc-ju-call-proposals-ai-science-and-collaborative-eu-projects_en>`_ 


.. list-table:: Bilim için YZ ve İşbirlikçi AB Projeleri Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Ülke
     - Bölümlendirme
     - İşlemci
     - Hızlandırıcı
     - Minimum Talep
     - Maximum Talep
   * - `MARENOSTRUM5 <https://www.bsc.es/supportkc/docs/MareNostrum5/intro/>`_
     - İspanya (BSC)  
     - MN5 ACC
     - Intel Sapphire Rapids
     - NVIDIA Hopper
     - 20 000
     - 90 000
   * - `LEONARDO <https://leonardo-supercomputer.cineca.eu/hpc-system/>`_
     - İtalya (CINECA)
     - Leonardo Booster
     - Intel Xeon
     - NVIDIA A100
     - 20 000
     - 90 000
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - Finlandiya (CSC)
     - LUMI-G
     - AMD Epyc
     - AMD Instinct
     - 20 000
     - 90 000
   * - `MELUXINA <https://docs.lxp.lu/>`_
     - Lüksemburg (LuxProvide)
     - MeluXina GPU
     - AMD Epyc
     - NVIDIA A100
     - 20 000
     - 90 000

.. note::

  * Yukarıdaki EuroHPC sistemleri, operasyonel olan en son mevcut sistemi gösterecek şekilde sıralanmıştır. 
  * Kaynaklar **düğüm saati (node hours)** cinsinden gösterilmektedir.

.. _regular-access_cagrisi:

----------------------------------------------
Düzenli Erişim Çağrısı
----------------------------------------------

Düzenli Erişim (Regular Access) Çağrısı, geniş ölçekli hesaplama zamanı, veri depolama ve destek kaynaklarına ihtiyaç duyan bilim, endüstri ve kamu sektörü alanlarındaki araştırmaları desteklemek üzere tasarlanmıştır. Bu çağrı, bilimsel yenilik sağlayacak, alanında önemli etki yaratacak ve büyük kaynak tahsisine olan ihtiyacı haklı çıkarabilecek başvurulara açıktır. Kaynaklar EuroHPC peta-ölçekli ve ön-exascale sistemlerinden dağıtılır. Tahsisler bir yıllık süre için verilir. Çağrı sürekli açıktır ve önceden belirlenmiş kesim tarihlerine sahiptir. Kaynaklara erişim, kesim tarihinden itibaren en fazla dört ay içinde başlar. Başvurular, bilimsel ve teknik mükemmeliyet temelinde teknik inceleme ve bilimsel hakem değerlendirmesine tabi tutulur.

**Çağrı için son başvuru tarihleri:**

28 Mart 2025, 10:00 / 5 Eylül 2025, 10:00 (CEST) 

İlgili erişim çağrısı hakkında güncel ve ayrıntılı bilgi için tıklayınız: 
`Düzenli Erişim Çağrısı <https://eurohpc-ju.europa.eu/eurohpc-ju-call-proposals-regular-access-mode_enn>`_ 


.. list-table:: Düzenli Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Ülke
     - Bölümlendirme
     - İşlemci
     - Hızlandırıcı
     - Toplam Kaynak
     - Minimum (Maximum) Talep
   * - `DEUCALION <https://eurohpc-ju.europa.eu/supercomputers/our-supercomputers_en#deucalion>`_
     - Portekiz (FCT)
     - Deucalion ARM
     - Fujitsu A64FX
     - -
     - 1 871 388
     - 60 000
   * -
     - 
     - Deucalion x86
     - AMD Epyc
     - -
     - 573 342
     - 60 000
   * - 
     - 
     - Deucalion GPU
     - AMD Epyc
     - NVIDIA A100
     - 37 840
     - 25 000
   * - `MARENOSTRUM5 <https://www.bsc.es/supportkc/docs/MareNostrum5/intro/>`_
     - İspanya (BSC)  
     - MN5 GPP
     - Intel Sapphire Rapids
     - -
     - 3 321 907
     - 60 000 (Max 230 000)
   * - 
     - 
     - MN5 ACC
     - Intel Sapphire Rapids
     - NVIDIA Hopper
     - 100 000
     - 20 000 (Max 100 000)
   * - `LEONARDO <https://leonardo-supercomputer.cineca.eu/hpc-system/>`_
     - İtalya (CINECA)
     - Leonardo DCGP
     - Intel Sapphire Rapids
     - -
     - 912 244
     - 60 000 (Max 120 000)
   * - 
     - 
     - Leonardo Booster
     - Intel Xeon
     - NVIDIA A100
     - 342 092
     - 25 000 (Max 220 000)
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - Finlandiya (CSC)
     - LUMI-C
     - AMD Epyc
     - -
     - 1 275 760
     - 60 000 (Max 120 000)
   * - 
     - 
     - LUMI-G
     - AMD Epyc
     - AMD Instinct
     - 309 181
     - 20 000 (Max 150 000)
   * - `DISCOVERER <https://docs.discoverer.bg/resource_overview.html>`_
     - Bulgaristan (Sofia Tech Park)
     - Discoverer CPU
     - AMD Epyc
     - -
     - 1 740 123
     - 60 000
   * - `MELUXINA <https://docs.lxp.lu/>`_
     - Lüksemburg (LuxProvide)
     - MeluXina CPU
     - AMD Epyc
     - -
     - 714 956
     - 60 000
   * - 
     - 
     - MeluXina GPU
     - AMD Epyc
     - NVIDIA A100
     - 149 729
     - 25 000
   * - `Karolina <https://docs.it4i.cz/karolina/hardware-overview/>`_
     - Çekya (IT4I VSB-TUO)
     - Karolina CPU
     - AMD Epyc
     - -
     - 984 725
     - 60 000
   * - 
     - 
     - Karolina GPU
     - AMD Epyc
     - NVIDIA A100
     - 93 500
     - 25 000
   * - `Vega <https://doc.vega.izum.si/>`_
     - Slovenya (IZUM Maribor)
     - Vega CPU
     - AMD Epyc
     - -
     - 1 188 382
     - 60 000
   * - 
     - 
     - Vega GPU
     - AMD Epyc
     - NVIDIA A100
     - 48 060
     - 25 000

.. note::

  * Yukarıdaki EuroHPC sistemleri, operasyonel olan en son mevcut sistemi gösterecek şekilde sıralanmıştır. 
  * Kaynaklar **düğüm saati (node hours)** cinsinden gösterilmektedir.

.. _extreme-scale_cagrisi:

----------------------------------------------
Aşırı Ölçekli Erişim Çağrısı
----------------------------------------------

Extreme Scale Erişim Modu Çağrısı Extreme Scale Erişim Modu çağrısı, hesaplama zamanı, veri depolama ve destek kaynakları açısından son derece büyük tahsislere ihtiyaç duyan ve bu ihtiyacı haklı çıkarabilen, yüksek etkili ve yenilikçi araştırmalar için özel olarak tasarlanmıştır. Bilim, endüstri ve kamu sektörünün tüm alanlarından başvurulara açıktır ve EuroHPC ön-exascale sistemlerinden kaynak dağıtır. Bu çağrı kapsamında tahsisler bir yıllık süreyle yapılır. Çağrı sürekli açıktır ve önceden belirlenmiş kesim tarihlerine sahiptir. Kaynaklara erişim, kesim tarihinden itibaren en fazla altı ay içinde başlar. Değerlendirme süreci teknik inceleme ve bilimsel hakem değerlendirmesine dayanır; ödül kararları mükemmeliyet, yenilikçilik ve etki ile uygulama kalitesi kriterlerine göre belirlenen önerilerin sıralamasına göre verilir.

İlgili erişim çağrısı hakkında güncel ve ayrıntılı bilgi için tıklayınız: 
`Aşırı Ölçekli Erişim Çağrısı <https://eurohpc-ju.europa.eu/eurohpc-ju-call-proposals-extreme-scale-access-mode_en>`_ 



.. list-table:: Aşırı Ölçekli Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Ülke
     - Bölümlendirme
     - İşlemci
     - Hızlandırıcı
     - Toplam Kaynak
     - Minimum (Maximum) Talep
   * - `JUPITER <https://eurohpc-ju.europa.eu/supercomputers/our-supercomputers_en#jupiter>`_
     - Almanya (Jülich)
     - JUPITER Booster
     - NVIDIA Grace
     - NVIDIA Hopper
     - 3 120 000
     - 245 000
   * - `MARENOSTRUM5 <https://www.bsc.es/supportkc/docs/MareNostrum5/intro/>`_
     - İspanya (BSC)  
     - MN5 GPP
     - Intel Sapphire Rapids
     - -
     - 5 536 512
     - 240 000
   * - 
     - 
     - MN5 ACC
     - Intel Sapphire Rapids
     - NVIDIA Hopper
     - 580 608
     - 160 000
   * - `LEONARDO <https://leonardo-supercomputer.cineca.eu/hpc-system/>`_
     - İtalya (CINECA)
     - Leonardo DCGP
     - Intel Sapphire Rapids
     - -
     - 1 520 407
     - 130 000
   * - 
     - 
     - Leonardo Booster
     - Intel Xeon
     - NVIDIA A100
     - 2 052 549
     - 245 000
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - Finlandiya (CSC)
     - LUMI-C
     - AMD Epyc
     - -
     - 2 126 267
     - 130 000
   * - 
     - 
     - LUMI-G
     - AMD Epyc
     - AMD Instinct
     - 1 855 084
     - 160 000
  

.. note::

  * Yukarıdaki EuroHPC sistemleri, operasyonel olan en son mevcut sistemi gösterecek şekilde sıralanmıştır. 
  * Kaynaklar **düğüm saati (node hours)** cinsinden gösterilmektedir.



.. note:: 

    Tüm çağrılara ilişkin dokumanlara ve başvuru koşullarına erişmek için `EuroHPC erişim çağrıları <https://eurohpc-ju.europa.eu/access-our-supercomputers/eurohpc-access-calls_en>`_ adresini ziyaret edebilirsiniz.
    
    EuroHPC JU tarafından sağlanan süper bilgisayar sistemlerine erişim, Avrupa Birliği ve katılımcı ülkelerin araştırmacıları ve endüstriyel kullanıcıları için ücretsizdir. Ancak, erişim çağrılarına başvuruların kabul edilmesi, belirli kriterlere ve değerlendirme süreçlerine bağlıdır. Bu nedenle, her çağrı için belirlenen kriterleri ilgili çağrının sayfasında veya `Süper Bilgisayar Erişim Politikası ve SSS <https://eurohpc-ju.europa.eu/supercomputers/supercomputers-access-policy-and-faq_en>`_ sayfasında yer alan "EuroHPC JU Access Policy" dokumanını dikkatlice incelemek önemlidir.

    Çağrılara başvurular `EuroHPC JU Portalı <https://access.eurohpc-ju.europa.eu/>`_ üzerinden yapılabilmektedir.



EuroHPC JU tarafından 2025 yılında açılan erişim çağrılarının son başvuru tarihleri aşağıdaki gibidir:

.. image:: /assets/eurohpc/TimelineAccessCalls_cut-offs_v3.png
    :width: 700
    :align: center

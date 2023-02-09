================================================
EuroHPC Sistemlerine Erişim Modları ve Çağrılar
================================================

---------------
Erişim Modları
---------------

Ortak girişim tarafından finanse edilen süper bilgisayarlara erişim süresi tahsisi, `EuroHPC Ortak Girişimi Konsey Yönetmeliği ve Ortak Girişimi’in Erişim Politikası <https://eurohpc-ju.europa.eu/documents_en?f%5B0%5D=document_title%3AEuroHPC%20JU%20Decision%20No%2006/2021%20-%20Access%20policy>`_’nda belirtilen ilkelere göre düzenlenecektir.

Bu ilkelere göre bilimsel, endüstriyel ve kamu sektörü kullanıcıları için altı farklı erişim modu bulunmaktadır:

* :ref:`Aşırı Ölçekli Erişim <extreme-access>`
* :ref:`Düzenli Erişim <regular-access>`
* :ref:`Kıyaslama (Benchmark) <benchmark-development>`
* :ref:`Geliştirme <benchmark-development>`
* Akademi için hızlı erişim
* Endüstri için hızlı erişim

Aslında endüstriyel kullanıcılar için iki tip kaynak kullanımı tanımlanabilir:

* **Araştırma ve İnovasyon (R&I) Erişimi:** Araştırma ve inovasyon için kaynaklar endüstriyel kullanıcılar için yukarıda belirtilen değerlendirmeye dayalı erişim modları kullanılacaktır. Araştırma sonuçlarının yayınlanması gerekmektedir. 
* **Ticari Erişim:** Endüstriyel kullanıcılar sivil uygulamalar için değerlendirmeye dayalı bir süreç olmadan ödeme yaparak kaynakları kullanabilmeleri planlanmaktadır.

İlgili erişim modlarına başvurular, `PRACE Değerlendirme Sayfası <https://pracecalls.eu/>`_ üzerinden yapılabilmektedir. 

Başvuru prosedürleri hakkında bilgi edinmek için `tıklayınız... <https://prace-ri.eu/hpc-access/eurohpc-access/eurohpc-ju-calls-how-to-apply/>`_

-------------------
EuroHPC Çağrıları
-------------------

.. _benchmark-development:

Kıyaslama (Benchmark) ve Geliştirme Çağrıları
==============================================

EuroHPC Ortak Girişimi Kıyaslama ve Geliştirme Erişim çağrılarının amacı, araştırmacılara ve HPC uygulama geliştiricilerine, aşırı ölçekli ve/veya normal bir projeye başvurmadan önce, gerçekleşmesi yakın/mevcut EuroHPC Pre-exascale ve/veya Petascale sisteminde uygulamalarını geliştirme, test etme ve optimize etme fırsatı vererek onları desteklemektir. 

İlgili teklif çağrıları başvuruya sürekli açık çağrılardır. Değerlendirme süreci, başvuru tarihinden itibaren maksimum iki hafta içerisinde tamamlanır ve onaylanması durumunda ilgili kaynak tahsisi sağlanır. Teklifler için 2023 yılı son başvuru tarihleri aşağıdaki gibidir:


.. list-table::
   :widths: 40 40
 
   * - 1 Ocak 2023 – 11:00 AM CET
     - 1 Temmuz 2023 – 11:00 AM CEST
   * - 1 Şubat 2023 – 11:00 AM CET
     - 1 Ağustos 2023 – 11:00 AM CEST
   * - 1 Mart 2023 – 11:00 AM CET
     - 1 Eylül 2023 – 11:00 AM CEST
   * - 1 Nisan 2023 – 11:00 AM CEST
     - 1 Ekim 2023 – 11:00 AM CEST
   * - 1 Mayıs 2023 – 11:00 AM CEST
     - 1 Kasım 2023 – 11:00 AM CET
   * - 1 Haziran 2023 – 11:00 AM CEST
     - 1 Aralık 2023 – 11:00 AM CET

Proje önerileri, `PRACE Değerlendirme Sayfası <https://pracecalls.eu/>`_ aracılığıyla, herhangi bir zamanda sunulabilir (sürekli açık). Projelerin değerlendirilmesi, her ay sabit bir tarihten sonra yapılır (kesme tarihi olarak anılır). Tahsis süreleri, kıyaslama çağrısı için iki veya üç ay, geliştirme çağrısı için ise 6 ay veya bir yıldır. Geliştirme çağrısı için tahsis iki kere yenilenebilir.


.. list-table:: Kıyaslama ve Geliştirme Erişim Çağrıları için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem/Hesaplama Bölümü
     - Mimari
     - Ülke
     - Kıyaslama
     - 
     - Geliştirme
     -
   * - 
     - 
     - 
     - Node Saati
     - Çekirdek/Saat
     - Node Saati
     - Çekirdek/Saat
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - HPC Cray EX
     - Finlandiya (CSC)
     - 7 000
     - 896 000
     - 15 000
     - 1 920 000
   * - `LUMI-G <https://docs.lumi-supercomputer.eu/>`_
     - HPC Cray EX
     - Finlandiya (CSC)
     - 20 000
     - 1 280 000
     - N/A
     - N/A
   * - `Vega CPU <https://doc.vega.izum.si/>`_
     - BullSequana XH2000
     - Slovenya (IZUM)
     - 5 000
     - 640 000
     - 10 000
     - 1 280 000
   * - `Vega GPU <https://doc.vega.izum.si/>`_
     - BullSequana XH2000
     - Slovenya (IZUM)
     - 400
     - 51 200
     - 1 000
     - 128 000
   * - `Karolina CPU <https://docs.it4i.cz/karolina/introduction/>`_
     - HPE Apollo 2000 Gen10 Plus, x86_64
     - Çekya (IT4I)
     - 7 000
     - 896 000
     - 15 000
     - 1 920 000
   * - `Karolina GPU <https://docs.it4i.cz/karolina/introduction/>`_
     - HPE Apollo 6500 Gen10 Plus, Nvidia GPGPU
     - Çekya (IT4I)
     - 1 000
     - 128 000
     - 3 000
     - 384 000
   * - `Discoverer <https://sofiatech.bg/en/petascale-supercomputer/>`_
     - Atos BullSequana XH2000
     - Bulgaristan
     - 7 000
     - 896 000
     - 15 000
     - 1 920 000
   * - `Meluxina CPU <https://docs.lxp.lu/>`_
     - Atos BullSequana XH2000
     - Lüksemburg
     - 7 100
     - 908 800
     - 15 300
     - 1 958 400
   * - `Meluxina GPU <https://docs.lxp.lu/>`_
     - Atos BullSequana XH2000
     - Lüksemburg
     - 1 000
     - 64 000
     - 3 000
     - 192 000
   * - `Meluxina FPGA <https://docs.lxp.lu/>`_
     - Atos BullSequana X430 A5
     - Lüksemburg
     - 1 500
     - *-*
     - 5 000
     - *-*

Kıyaslama ve Geliştirme Çağrıları için daha fazla bilgi almak üzere ilgili web sayfalarını ziyaret edebilirsiniz:

* `EuroHPC Ortak Girişimi Kıyaslama (Benchmark) ve Geliştirme Erişim Çağrıları <https://prace-ri.eu/hpc-access/eurohpc-access/eurohpc-ju-benchmark-and-development-access-calls/>`_ 


* `Kıyaslama (Benchmark) ve Geliştirme Erişim Çağrılarına Başvuru Sahipleri için Bilgi <https://prace-ri.eu/hpc-access/eurohpc-access/eurohpc-ju-benchmark-development-access-calls/benchmark-development-applicant-information/>`_

.. _regular-access:

Düzenli Erişim Çağrısı
=======================

EuroHPC Ortak Girişimi Düzenli Erişim Modu, büyük ölçekli kaynaklar gerektiren veya önemli bilgi işlem ve depolama kaynaklarına daha sık erişim gerektiren araştırma alanlarına, endüstriye (açık Ar-Ge) ve kamu sektörü uygulamalarına hizmet etmek için tasarlanmıştır. Bu erişim modu, çoğunlukla EuroHPC JU peta-ölçekli sistemlerine ait kaynakları tahsis etmektedir.

Düzenli erişim modu teklif çağrısı, son başvuru tarihinden en fazla dört ay sonra kaynaklara erişim sağlanacak şekilde sürekli olarak açıktır. Teklifler için bir sonraki gösterge niteliğindeki son tarihler şunlardır:

* `3 Mart 2023 - 10:00 (Lüksemburg Saati) <https://prace-ri.eu/call/eurohpc-ju-call-for-proposals-for-regular-access-mode-2023-03-03-cutoff/>`_
* 7 Temmuz 2023 - 10:00 (Lüksemburg Saati)
* 3 Kasım 2023 - 10:00 (Lüksemburg Saati)

Tahsisler, projelerin devamı için başvurma seçeneği ile bir (1) yıl süreyle verilir. Bu devam, usulüne uygun olarak gerekçelendirilecek, maksimum bir (1) ek yılla sınırlı olacak ve devam etmekte olan ihale edilen projelerinin değerlendirmesine bağlı olacaktır. 

Başvuru Sahipleri (Proje Yürütücüleri (PI)) herhangi bir zamanda yalnızca bir Düzenli Erişime hak kazanabilirler.

Proje başvuruları `PRACE Değerlendirme Sayfası <https://pracecalls.eu/>`_ aracılığıyla gerçekleştirilmektedir.

.. list-table:: Düzenli Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25
   :header-rows: 1

   * - Sistem/Hesaplama Bölümü
     - Mimari
     - Ülke
     - Toplam Çekirdek/Saat
     - Talep Edilebilecek Minimum Çekirdek/Saat
   * - `Vega CPU <https://doc.vega.izum.si/>`_
     - BullSequana XH2000
     - Slovenya (IZUM)
     - 75 milyon
     - 10 milyon
   * - `Vega GPU <https://doc.vega.izum.si/>`_
     - BullSequana XH2000
     - Slovenya (IZUM)
     - 1.5 milyon
     - 0.5 milyon
   * - `Meluxina CPU <https://docs.lxp.lu/>`_
     - Atos BullSequana XH2000
     - Lüksemburg (LuxProvide)
     - 65.5 milyon
     - 10 milyon
   * - `Meluxina GPU <https://docs.lxp.lu/>`_
     - Atos BullSequana XH2000
     - Lüksemburg (LuxProvide)
     - 11.1 milyon
     - 2 milyon
   * - `Karolina CPU <https://docs.it4i.cz/karolina/introduction/>`_
     - HPE Apollo 2000Gen10 Plus ve HPE Apollo 6500
     - Çekya (IT4I)
     - 60 milyon
     - 10 milyon
   * - `Karolina GPU <https://docs.it4i.cz/karolina/introduction/>`_
     - HPE Apollo 2000Gen10 Plus ve HPE Apollo 6500
     - Çekya (IT4I)
     - 6 milyon
     - 1 milyon
   * - `Discoverer <https://sofiatech.bg/en/petascale-supercomputer/>`_
     - Atos BullSequana XH2000
     - Bulgaristan (Sofiatech)
     - 104 milyon
     - 10 milyon

`Düzenli Erişim Çağrısı için daha fazla bilgi almak üzere ilgili web sayfasını ziyaret edebilirsiniz. <https://prace-ri.eu/hpc-access/eurohpc-access/eurohpc-ju-regular-access-mode/>`_



.. _extreme-access:

Aşırı Ölçekli Erişim Çağrısı
==============================================

Aşırı Ölçekli Erişim çağrısı, yüksek etkili ve yüksek kazançlı yenilikçi araştırmalarla HPC uygulamalarını hedefliyor.

Çağrı, hesaplama süresi, veri depolama ve destek kaynakları açısından son derece büyük tahsislere olan ihtiyacı ve kullanım kapasitesini gerekçelendiren bilim, endüstri ve kamu sektörünün tüm alanlarına açıktır.

* 15 Aralık 2022 - 10:00 (Lüksemburg Saati)
* 28 Nisan 2023 - 10:00 (Lüksemburg Saati)
* 28 Eylül 2023 - 10:00 (Lüksemburg Saati)

Tahsisler, projelerin devamı için başvurma seçeneği ile bir (1) yıl süreyle verilir. Bu devam, usulüne uygun olarak gerekçelendirilecek, maksimum bir (1) ek yılla sınırlı olacak ve devam etmekte olan ihale edilen projelerinin değerlendirmesine bağlı olacaktır. 

Başvuru Sahipleri (Proje Yürütücüleri (PI)) herhangi bir zamanda yalnızca bir Aşırı Ölçekli Erişime hak kazanabilirler.

Proje başvuruları `PRACE Değerlendirme Sayfası <https://pracecalls.eu/>`_ aracılığıyla gerçekleştirilmektedir.

.. list-table:: Aşırı Ölçekli Erişim Çağrısı için EuroHPC JU Sistemleri
   :widths: 25 25 25 25 25
   :header-rows: 1

   * - Sistem/Hesaplama Bölümü
     - Mimari
     - Ülke
     - Toplam Çekirdek/Saat (Node Saati)
     - Talep Edilebilecek Minimum Çekirdek/Saat
   * - `Leonardo BOOSTER <https://leonardo-supercomputer.cineca.eu>`_
     - BullSequana XH2000
     - İtalya (CINECA)
     - 189 milyon (5.9 milyon)
     - 20 milyon
   * - `LUMI-C <https://docs.lumi-supercomputer.eu/>`_
     - HPC Cray EX
     - Finlandiya (CSC)
     - 826.7 milyon (6.5 milyon)
     - 80 milyon
   * - `LUMI-G <https://docs.lumi-supercomputer.eu/>`_
     - HPC Cray EX
     - Finlandiya (CSC)
     - 689 milyon (10.8 milyon)
     - 55 milyon

* Leonardo BOOSTER hakkında özel teknik bilgiler için prace-tech@cineca.it adresinden CINECA ile iletişime geçebilirsiniz.

`Aşırı Ölçekli Erişim Çağrısı için daha fazla bilgi almak üzere ilgili web sayfasını ziyaret edebilirsiniz. <https://prace-ri.eu/hpc-access/eurohpc-access/eurohpc-extreme-scale-access/>`_

----------------------------------------------
Endüstriyel Kullanıcılar için Diğer Çağrılar
----------------------------------------------

FF4EuroHPC
===========

FF4EuroHPC KOBİ'lerin yüksek performanslı bilgi işlem teknolojilerine erişimi kolaylaştırmaya yardımcı olan ve KOBİ’lerin Avrupa'nın üst düzey HPC hizmetlerini kullanarak benzersiz ürünler geliştirmeleri ve daha rekabetçi hale gelebilmelerini hedefleyen bir Avrupa girişimidir.

`FF4EuroHPC hakkındaki ayrıntılı bilgiye web sayfalarından ulaşabilirsiniz. <https://www.ff4eurohpc.eu/en/about/about-the-project/>`_


Eylül 2020'nin başında başlayan FF4EuroHPC projesi üç yıl sürecek olup, proje Universitaet Stuttgart (USTUTT, Almanya) tarafından koordine edilmekte ve diğer 5 ortaktan oluşmaktadır: Scapos AG (Almanya), Teratec (Fransa), CINECA (Italya), CESGA (İspanya) ve Arctur (Slovenya). Ortaklar, KOBİ'lerin projelerini başarıya dönüştürmesine, iş zorluklarını çözmesine ve yenilikçi iş fırsatları geliştirmesine yardımcı olacaktır.

Proje konsorsiyumu, 2013 ve 2018 yılları arasında yürütülen Fortissimo ve Fortissimo 2 projelerinde deneyime sahip özel-kamu sektöründen 6 HPC uzman kuruluşundan oluşmaktadır. `Tamamlanan Fortissimo ve Fortissimo 2 projelerinin detayları için tıklayınız. <https://www.fortissimo-project.eu>`_

FF4EuroHPC Başvurusu ve Değerlendirme
---------------------------------------

..
  KOBİ'ler için toplamda iki açık çağrı sunulacaktır. İlk açık katılım çağrısı kapanmıştır. **FF4EuroHPC 2. Çağrısı Yüksek Başarımlı Hesaplama (YBH), Veri Analitiği ve Yapay Zeka servislerini kullanarak yenilikçi çözümler üretmek isteyen KOBİ başvurularına açılmıştır. Son başvuru tarihi 29 Eylül 2021 olarak ilan edilmiştir.**

.. 
  `FF4EuroHPC 2. Çağrı hakkında ayrıntılı bilgiye ulaşmak için lütfen web sayfasını ziyaret ediniz. <https://www.ff4eurohpc.eu/calls>`_

KOBİ'ler için toplamda iki açık çağrı sunulmuştur. İlgili çağrılar kapsamında çeşitli uygulama alanlarından Avrupa KOBİ'lerinden gelen problemleri ve zorlukları ele alan projelerin desteklenmesi planlanmıştır. Mühendislik, imalat veya Avrupa için hızlı ekonomik büyüme veya belirli ekonomik etki gösterebilecek sektörler tercih edilmektedir.

..
 Değerlendirme sürecinde hangi kriterlere uyulduğunu ve proje önerileri yazılırken nelere dikkat edilmesi gerektiğini öğrenmek için ilk açık çağrı için kullanılan kontrol listesini inceleyebilirsiniz. 

 https://www.ff4eurohpc.eu/en/open-calls/check-list/

Açık çağrıya başvuru yapıp kabul edilen projeler bulut tabanlı HPC sistemi üzerinde gerçekleştirilecektir. Projelerin başarı öyküleriyle sonuçlanarak endüstri topluluğuna ilham vermesi hedeflenmektedir. 

FF4EuroHPC tarafından sunulan ilk çağrıya 25 Avrupa ülkesinden (ek olarak Kanada'nın da yer aldığı) 68 proje başvurusu olmuştur. Bunlardan 16 tanesi Haziran 2021 itibari ile desteklenmeye başlanmıştır. İlk çağrıda desteklenen projeler hakkındaki bilgiye aşağıdaki linkten erişim sağlayabilirsiniz.


PRACE SHAPE
============

PRACE'in ücretsiz SHAPE programı (SME HPC Adoption Programme in Europe) Avrupa’da yer alan KOBİ’lere HPC alanında farkındalık kazandırmak, HPC kullanarak ürün kalitelerini iyileştirmek, teslimat sürelerini kısaltmak, rekabet gücünü arttırarak KOBİ’lerin yenilikçi hizmetler yaratmasını hedefler. 

2013 yılından bu yana SHAPE; hesaplamalı akışkanlar dinamiği, çelik döküm, tıp, genom, çevre ve yenilenebilir enerjiler, yapay zekâ gibi birçok alanda Avrupa’da yer alan 60’dan fazla KOBİ'nin HPC kullanımlarının somut faydalarını göstermeyi sağlamıştır.

Program, KOBİ'lerin hem PRACE altyapısına ücretsiz erişimini hem de PRACE altyapı uzmanından ücretsiz bir şekilde destek almasını sağlar.  PRACE uzmanı KOBİ’nin HPC tabanlı çözümünü değerlendirmede ve geliştirmede KOBİ ile birlikte çalışır.

PRACE SHAPE Başvurusu ve Değerlendirme
------------------------------------------

**PRACE SHAPE programı çağrıları yılda iki kez olmak üzere genellikle Nisan-Haziran ve Ekim-Aralık döneminde yapılır.** 

KOBİ'ler programa çevrimiçi veya indirilebilir form aracılığıyla başvuruda bulunabilir (bu aşamada PRACE'den rehberlik de alınabilir). Başvurular, PRACE tarafından atanan bir komite tarafından incelenir. KOBİ’nin iş gerekçesinin gücüne ve önerilen çalışmanın teknik fizibilitesine dayalı olarak gözden geçirilir ve değerlendirilir. 

SHAPE programına başvuran başarılı adaylar, altyapı ve uzman desteğini ücretsiz olarak alırlar ancak KOBİ’lerden aşağıdakileri gerçekleştirmeleri beklenir.

• PRACE uzmanı ile çalışarak projeye katkıda bulunularak gerekli eforun sağlanması
• Projenin tanıtımına yardımcı olunması (örnek: KOBİ'nin çevrimiçi kanalları, sektör yayınları vb.)
• Proje sonuçları hakkında proje sonu teknik bir yazı hazırlanması
• Projenin tamamlanmasını takip eden aylarda, işletme etkisinin değerlendirilmesine yardımcı olması için takip raporu hazırlanması

`SHAPE çağrıları hakkında daha fazla bilgi için lütfen ilgili siteyi ziyaret ediniz. <https://prace-ri.eu/prace-for-industry/shape-access-for-smes/>`_

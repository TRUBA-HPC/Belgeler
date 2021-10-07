=====================
Snakemake Kılavuzu
=====================

--------
İÇERİK
--------

-  :ref:`target to giris`
-  :ref:`target to exp1`
-  :ref:`target to exp2`
-  :ref:`target to exp3`
-  :ref:`target to exp4`
-  :ref:`target to exp5`
-  :ref:`target to exp6`
-  :ref:`target to sonuc`

.. _target to giris:

------
GİRİŞ
------

Bu uygulama dökümanı, karmaşık süreçli veri analizi ihtiyacı bulunan 
araştırmacılara yardımcı olması amacıyla hazırlanmıştır. Sabancı Üniversitesi, Adebali Lab bünyesinde 
yürütülen çalışma kapsamında kullanılan iş akışı yöneticisi (snakemake), iş paketi yöneticisi (conda) 
örnek uygulamalarda kullanılmış ve TÜBİTAK-ULAKBİM'de TRUBA tarafından işletilen Yüksek Başarımlı 
Hesaplama (YBH) kümesi üzerinde çalışacak şekilde planlanmıştır.

Toplam 6 adet uygulama eğitimi hazırlanmıştır. Bunlar, öncelikle bir YBH
veri kümesine bir iş dosyası nasıl hazırlanır, iş nasıl gönderilir,
durumu takip edilir, sonucu alınır göstermek için hazırlanmıştır
(uygulama 1). Bir işte ardi ardına gelen (bağımlılığı olan) pek çok
hesaplama bulunabilir. Bu iş dosyası nasıl hazırlanır, karşılaşılan
problemler nelerdır göstermek için uygulama 2 hazırlanmıştır. Farklı
proteinler (iş dosyaları) üzerinde bu hesaplamanın ölçeklenebilmesinde
ki zorluklar uygulama 3'te gösterilmeye çalışılmıştır. Uygulama 4'te, iş
akışı yöneticisine (snakemake) çok basit bir örnek verilerek giriş
yapılmış, ortam tanıtılmıştır. Uygulama 5'te ise önceki sorunları
gösterilen uygulamaların snakemake ile nasıl yapıldığı ve sorunlara
nasıl çözüm getirildiği gösterilmiştir. Uygulama 6 ise büyük ölçekli
veri analizinde snakemake getirdiği çözümler, fayda sağlayabilecek iyi
pratik uygulamasından bahsedilmiştir.

Her bir uygulama, örnek iş dosyası, konuyla ilgili bilgi, çalıştırılan
komutlar ve çıktıları kapsamaktadır. Tüm bu bilgiler uygulama içerisinde
yer alan github sayfasında yer almaktadır. 

https://github.com/emrahkyn/snakemake_hpc_tutorial

Ayrıca, 16 Eylül, 2021 tarihinde detayları aşağıda linkte belirtilen sunumda bu uygulamalar gösterilmiştir.

https://indico.truba.gov.tr/event/48/ 

.. _target to exp1:

-------------------------------------------------------------------------
Uygulama 1: Yüksek Başarımlı Hesaplama (YBH) kümesinde örnek iş koşturma 
-------------------------------------------------------------------------

Amaç: 
======

Bu uygulamada, TRUBA YBH kümesine basit bir iş dosyası hazırlanıp
koşturulması sağlanacak, bir iş dosyasının olması gereken temel
özelliklerinden bahsedilecektir. 

Kaynak:
========

`Uygulama-1 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp1>`__

Bilgi:
======

YBH Temel Bileşenleri 
^^^^^^^^^^^^^^^^^^^^^^
YBH, temel olarak kullanıcı arayüzü, iş planlayıcı (denetleyici) ve hesaplama uçları bileşenlerinden
oluşmaktadır. Kullanıcının yapmak istediği hesaplama ise iş olarak
adlandırılmaktadır.

Kullanıcının YBH ile etkileşimi kullanıcı arayüzü (TRUBA için levrek1)
sunucusu üzerinden olmaktadır. Yeni bir iş yollama, küme üzerinde
hesaplama yapılan (koşturulan) işin durumu, devam eden işin
sonlandırılması, ihtiyaç duyulan ortam (yazılım, kütüphane, araç)
kurulması vb işler bu sunucu üzerinde yapılmaktadır.

Kullanıcı bir iş yolladığında bu iş kullanıcı arayüzünde değil hesaplama
uçlarında koşturulmaktadır. Hesaplama uçları kendi içerisinde
gruplandırılır (örneğin aynı marka/model fiziksel sunucuların aynı
grupta yer alması gibi) ve kullanıcı işini bu gruptan (iş dosyasında
partition olarak ifade edilir, örn: mid2, barbun, long) birine yollar.
İş dosyası hazırlarken kaç hesaplama ucu, kaç çekirdek, ne kadar bellek
ve işin tahminen ortalama ne kadar süreceği gibi bilgilere bağlı olarak
hesaplama uçları belirlenir ve hesaplamalar bu uçlar üzerindeki
çekirdekler üzerinde yapılır. TRUBA’da sardalya, mercan, barbun vb
ismindeki sunucular hesaplama uçlarıdır.

İş planlayıcı (denetleyici) ise temelde kuyruk yönetim sistemlerinde
olduğu gibi kullanıcının bilgileri, gönderdiği işin özellikleri ve
kümenin durumu (hesaplama uçlarının kullanım yoğunluğu) gibi bilgilere
göre kaynakları belirler ve hesabın bu kaynaklar üzerinde yapılmasını
sağlar. TRUBA’da bunun için SLURM kullanılmaktadır.

İşin (Run) Özellikleri
^^^^^^^^^^^^^^^^^^^^^^

“Merhaba dünya”, yazdırmak yeni bir ortam/programalama dili
öğrenildiğinde sıklıkla kullanılan bir örnektir. Bu uygulama için bir iş
dosyası hazırlanacak ve küme üzerinde koşturularak hesaplama ucu
üzerinde çalıştırılması sağlanacaktır. Bunun için temel olarak:

 1. İşin hangi hesaplama grubunda, kaç hesaplama ucu ve çekirdeği üzerinde, ne kadar tahmini süre çalışacağı tanımlanmalıdır. 
 2. Kodun çalışması için ortamın hazırlanması (PATH, LIBRARY vb.) sağlanmalıdır. 
 3. İşin çıktı (output) dosyasının yazılacağı dizin, koşturulan işin çıktı ve hata dosyalarının tutulması (log) gerekmektedir.

Dosyalar ve Komutlar:
=====================
::

    • test.slurm, örnek iş dosyası. Hesap adını (#SBATCH -A emrah) kendi kullanıcı adınız olacak
    • hello_world.py, örnek kod parçacığı
    • test.out, iş tamamlandıktan sonra üretilen çıktı dosyası
    • readMe: Çalıştırılan komutlar ve çıktılar

::

    git clone https://github.com/emrahkyn/snakemake_hpc_tutorial.git
    cd exp1
    sbatch test.slurm
    squeue

Uyarılar:
=========

-  Kullanıcı arayüzü sunucusu (levrek1), işlerin yönetimi ve
   yazılımların kurulması için ayrılmıştır. Burada işleri koşturmak,
   sunucu üzerinde ki kaynakları (cpu, ram) tüketeceğinden dolayı diğer
   kullanıcıların kümeyi kullanamaz haline getirme riski bulunmaktadir.
   Bu nedenle kullanıcı arayüzü üzerinde iş koşturmadan kaçınılmalıdır.
-  Olabildiğince 1 hesaplama ucu üzerinde işleri koşturmaya çalışınız.
   İşiniz 8 çekirdek gerektiriyorsa bunu 1 hesaplama ucu, 8 çekirdek
   şeklinde talep ediniz. MPI tarzı kütüphanelerin kullanımında birden
   fazla hesaplama ucu kullanmak anlamlı olabilir.

.. _target to exp2:

-------------------------------------------------------------
Uygulama 2: Ardışık hesaplamanın yapıldığı örnek iş koşturma 
-------------------------------------------------------------

Amaç:
======

Bu uygulamada birbirini takip eden (bir sonraki hesaplamanın önceki
hesabın bitmesini beklediği durum) örnek bir hesaplama iş betik dosyası
kullanılarak hazırlanmıştır. İş akışı yönetim (workflow) araçları
kullanmaksızın bu hesaplamanın nasıl yapılacağı gösterilmiş eksikleri
belirtilip ne gibi sorunlarla karşılaşılabileceği tartışılmıştır. 

Kaynak:
=======

`Uygulama-2 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp2>`__

Bilgi: 
======

Lokal bir bilgisayarda tipik bir hesaplama temel olarak şunları içerir: 

 - girdi (dosya)
 - çıktı (dosya) 
 - çalıştırılabilir kod (betik) 
 - log 
 - araç, yazılım (python)

Bu hesabın Yüksek Başarımlı Hesaplama (YBH) üzerinde çalışabilmesi
içinse slurm iş dosyası hazırlanmalıdır. Bu dosya içerisinde şunlar
tanımlıdır: 

 - kaynak gereksinimi (cpu, ram, zaman limiti, vb) 
 - hangi hesap ve hangı grup bilgisayarda koşacağı (partition) 
 - ortam değişkenlerinin tanımlanması (path gibi) 
 - hangi hesaplamaların sırayla yapılacağı

Ardışık hesaplamalarda bu iş dosyasında hesaplar sırayla yazılır. İlk
görevin (hesaplamanın) çıktı dosyası, bir sonraki görevin girdi dosyası
olarak devam edecek şekilde bir iş akışı elle (manual) oluşturulur.

Her bir görev için gerekli ortamın (yazılım, araç, kütüphane) kurulumu
kullanıcının ev dizininde yapması gereken bir süreçtir. Kullanıcı
arayüzünde kullanıcının hesapları kısıtlıdır, diğer bir deyişle süper
kullanıcı hakkı (root) verilmemiştir. Bu nedenle kurulum yapmak genel
olarak sistemde mevcut derleyiciler (gnu, intel, vb) kullanılarak kaynak
kod üzerinden yapılır, ancak bu paket yöneticisi (conda gibi) araçlar
kullanılmadan yapılması zor ve zahmetli bir süreçtir. İşlemci mimarisine
göre derleme yapmak, uygun kütüphaneleri ve versiyonlarını eklemek
(dependency problem), yapılandırmada uygun parametreleri seçmek
(configuration) dikkat isteyen bir durumdur.

Bu uygulamada blast veri tabanından seçilen bir protein için 3 ardışık
görev slurm iş dosyasında tanımlanarak küme üzerinde koşturulmuştur.
Görevler, girdi ve çıktı dosyalarına göre ardışık hale getirilmiştir.
İlk ve son görevde python kütüphanesi, ikinci görevde ise blast
kütüphanesi kullanılmıştır. Blast YBH ortamında hazır olmayan bir
yazılımdır, bu nedenle kurulumun kullanıcı tarafında yapılması
gerekmektedir. Gerekli ortam değişkenleri de iş dosyasında örnekte
gösterildiği gibi yapıldıktan sonra ardışık işler tek betik dosyası
içerisinde koşturulabilir ve sonuçları alınabilir.

Dosyalar ve Komutlar:
======================

Mevcut dosya ve klasörler 

 - input: iş akışı için gerekli girdi dosyaları (blastb gibi) 
 - output: iş akışı sonrasında üretilen dosyalar 
 - logs: ardışık hesaplarda oluşacak hataların tutulması için 
 - scripts: çalışabilir dosyalar (python kodları) 
 - sw: iş akışı için gerekli yazılımlar (psiblast) 
 - test.slurm: iş dosyası 
 - slurm-.out, slurm-.err: koşan işin çıktı ve hata dosyaları 
 - readMe: çalıştırılan komutlar, çıktılar ve notlar

Komutlar 

 - Kurulum: 
     - wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.31/ncbi-blast-2.2.31+-src.tar.gz
     - tar xzvf ncbi-blast-2.2.31+-src.tar.gz 
     - cd ncbi-blast-2.2.31+-src/c++ 
     - ./configure 
     - cd ReleaseMT/build 
     - make all\_r

::

     - sbatch test.slurm
     - squeue
     - tail -f slurm-7562851.* logs/*
     - cat slurm-7562851.out
     - cat slurm-7562851.err
     - ls output

Uyarilar:
==========

 - Özellikle root yetkisi olmadan kurulum yapmak zor bir iştir, linux işletim sistemleri ile gelen apt-get, yum gibi paket yöneticileri pratikte kullanılamaz. Kurulum yapılacak her bir kodun kaynak kodunu bulup o yazılama özgü direktifleri takip etmek gerekir. Derleme zaman alıcı bir süreçtir, bu örnekte yaklaşık 1 saat sürmüştür. Yüzlerce kütüphane ve yazılıma bağlıdır, derleyici seçimi, işlemci mimarisi, kütüphane özgün tanımlamalar gibi ileri düzey yapılandırma ister. Kaynak koddan derlemek o kümeye özgüdür, başka bir küme de işlemi tekrarlamak gerekir, bu nedenle taşınabilir (portable) ve tekrar üretilebilir (reproducable) değildir. Performans iyileştirme gibi özel bir durum yok ise paket yöneticisi kullanmak süreci hızlandıracaktır. 
 -  Ardışık iişlerin tek betik dosyasında yer alması konfigürasyonu zor bir örnektir, iş akışını takip etmek zordur.
 -  Son iş hata almış olsa bile tekrar baştan bütün görevler çalıştırılır bu nedenle tekrar hesaplama yapılmaktadır.
 -  Bazı hesaplar cpu yoğun, bazıları bellek yoğun özelliktedir, kimi kısa süre kimi ise çok uzun süre hesaplama gerektirir. Ardışık tüm hesaplara hesaba özgü sayıda çekirdek, bellek atamak gerekir.
 -  Tek bir protein için bu örnek verilmiştir. On binlerce protein için bu işin ölçeklenebilir olması gerekmektedir (her bir protein için yeni bir iş dosyası hazırlamak gerek). Aynı klasör içerisinde on binler proteine özgü çıktı dosyaları, log dosyalarının oluşması takip edilebilirliği imkansız hale getirip sürecin yönetilebilir olmaktan çıkarmaktadır.
 -  İş akışında herhangi bir değişiklik yapılması gerektiğinde, örneğin yazılım versiyonu ya da bir parametre, bütün iş dosyalarında bu değişimi tek tek yapmak gerekecektir.
 -  Ardışık hesapların arasına yeni bir hesap eklemek ya da çıkarmak sadece input ve output dosyalarını takip ederek oldukça zahmetli bir iştir. 

.. _target to exp3:

-----------------------------------------------------
Uygulama 3: Ardışık hesaplamalarda ölçeklenebilirlik
-----------------------------------------------------
   
Amaç: 
=====
Bu uygulamada 3 protein için 3 tane ardışık hesaplama işi oluşturulacak ve on binlerce iş dosyası olduğunda oluşabilecek sorunlardan bahsedilecektir. 


Kaynak:
=======

`Uygulama-3 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp3>`__

Bilgi: 
=======
Geniş ölçekli (large-scale) bir veri analizinde ölçeklenebilirlik oldukça önemlidir. Hesaplamanın büyüklüğünü ardışık hesapların sayısı yanında kaç tane bu şekilde ardışık işin olduğu da tanımlar. On binlerce hesap bu şekilde yapılacaksa her biri için iş dosyası oluşturmak, isimlerini tek tek değiştirmek, sonuçlarını takip ve kontrol etmek pratik değildir. Nitekim 3 ardışık hesaplama olan 3 iş dosyası için:

 - 9 adet log dosyası
 - 9 adet çıktı dosyası
 - 6 adet slurm çıktı ve hata dosyası aynı dizinde oluşturulur.

Dosyalar ve Komutlar:
======================

Mevcut dosya ve klasörler 

 - input: iş akışı için gerekli girdi dosyaları (blastb gibi) 
 - output: iş akışı sonrasında üretilen dosyalar 
 - logs: ardışık hesaplarda oluşacak hataların tutulması için 
 - scripts: çalışabilir dosyalar (python kodları) 
 - \*.slurm: her bir protein için hazırlanan iş dosyası 
 - slurm-\*.out, slurm-\*.err: koşan işin çıktı ve hata dosyaları 
 - readMe: çalıştırılan komutlar, çıktılar ve notlar

Komutlar

.. code-block:: bash

    sbatch P01008.slurm, sbatch P22033.slurm, sbatch P68871.slurm
    squeue
    cat slurm-756299*.out
    ls logs, ls output

Uyarilar:
==========

-  20.000 protein, 10 ardışıl hesaplama için 200.000 log ve çıktı
   dosyası oluşacak demektir, 20.000 iş dosyasını hazırlamak, tek tek
   yollamak, sonuçları takip etmek, hata ile bitenleri tekrar yollayıp
   yönetmek oldukça zordur.

.. _target to exp4:

----------------------------------------------------------
Uygulama 4: Tek hesaplı basit iş akışı örneği (Snakemake) 
----------------------------------------------------------

Amaç:
======

İş akışı yöneticisi (snakemake) için çok basit bir hesap oluşturup
YBH üzerinde çalıştırılacak ve temel özelliklerinden bahsedilecektir.
Snakemake temel komutları ile temel giriş yapılacaktır. 

Kaynak:
========

`Uygulama-4 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp4>`__

Bilgi: 
=======

İş akışı yöneticisi, Snakemake, python dili temel alınarak
tekrar üretibilen (platform bağımsız çalıştığında aynı sonucu veren)
ve ölçeklenebilir (çok sayıda iş ve ardışık hesaplama) bir akış
diagramı üretmek için kullanılan bir araçtır. İş akışında herhangi
bir değişiklik yapılmaksızın yalnızca yüksek başarımlı hesaplama da
değil, aynı zamanda bulut bilişimi, grid hesaplama, lokal sunucuda
çalıştırmayı da destekleyen esnek bir araçtır. Bu örnekte tek hesaplı
bir iş akışı diagramı snakemake için oluşturulup lokalde ve YBH
üzerinde nasıl çalıştığı gösterilmiştir. Örnek bir girdi dosyası
basit bir python kodu ile işlenerek kaç adet satır olduğu hesaplanmış
ve sonuç yine bir çıktı dosyasına yazılmıştır.

İş akışı, Snakefile adı verilen dosya içerisinde oluşturulur. Her bir
hesaplama rule ön eki ile tanımlanır ve bu hesaplamaya ait girdi, çıktı
ve çalıştırılacak komut yaml örneğinde olduğu gibi hazırlanır. YBH
üzerinde iş koşturulduğunda slurm iş dosyasının logları, üretilecek
çıktılar, hesaplamaya ait log dosyaları aynı dizin üzerinde oluşturulur.

Dosyalar ve Komutlar:
======================

Mevcut dosya ve klasörler 
 - textInputFile: iş akışı için gerekli girdi dosyası 
 - textOutputFile: iş akışı sonrasında üretilen dosya 
 - task1.err: tek hesapta oluşan hataların tutulması için log dosyası 
 - countLines.py: çalışabilir dosyala 
 - slurm-.out, slurm-.err: koşan işin çıktı ve hata dosyaları 
 - Snakefile: iş akışını tanımlayan dosya 
 - readMe: çalıştırılan komutlar, çıktılar ve notlar

Komutlar 
 - YBH ve Snakemake bağımsız hesabı lokalde çalıştırmak için 
     - python countLines.py textInputFile textOutputFile 
 - Snakemake çalışma ortamını aktif etmek için 
     - source ~/miniconda3/etc/profile.d/conda.sh 
     - conda activate snakemake 
 - Snakemake ile lokalde çalıştırmak için 
     - snakemake -j 1 
 - Snakemake ile YBH üzerinde koşturmak için 
     - snakemake -j 1 --cluster "sbatch -A emrah -p sardalya -n 1 -J test.job" - squeue

Uyarilar:
==========

 -  YBH üzerine iş gönderildiğine squeue ile işin durumunu, oluşturulan slurm dosyası (slurm-.out) ile işin nasıl ilerlediğini takip edebilirsiniz. Bu dosya oluşmadıysa Snakemake, slurm üzerinden işinizi kümeye gönderememiş demektir, bu durumda özellikle –cluster ile gönderdiğiniz bilgileri kontrol ediniz.
 -  .snakemake/log dizini altında snakemake komutu ile çalıştırdığınız her bir hesaplamanın çıktısı burada yer alan dosyaya yazılmaktadır (örn: .snakemake/log/2021-09-05T131457.207403.snakemake.log)
   
.. _target to exp5:

------------------------------------------------------------------
Uygulama 5: Çok hesaplı iş akışı örneği (Snakemake ve Conda)
------------------------------------------------------------------

Amaç: 
======

Snakemake iş akışı yöneticisi ve Conda paket yöneticisinin
birlikte kullanıldığı, örnek bir hesap üzerinden 3 protein için küme
üzerinde iş koşturulacak, tipik bir iş akışı için gerekli bilgiler
tanıtılacaktır. 

Kaynak:
========

`Uygulama-5 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp5>`__

Bilgi: 
=======

Aşağıda Şekil 1’de Snakemake tarafından hazırlanan
hesaplama için oluşturulan iş akışı diagramı verilmiştir. Bu
uygulamada 3 protein için (P010008, P22033 ve P68871) her birinde 3
ayrı hesabın yapıldığı (query\_fasta, psiblast ve get\_blasthits) bir
örnek verilmiştir. Şekilden anlaşılacağı üzere iş akışı query\_fasta
ile başlamakta ve get\_blasthits ile sonlanmaktadır. Hesaplardan
get\_blasthits başlaması için önceki her 2 hesabın bitmesi
gerekmektedir. En sonda yer alan all hesabı özel bir tanımlama olup
farklı proteinler için iş akışını bağlamakta kullanılmaktadır, özetle
tüm proteinler için son hesap olan get\_blasthits tamamlanınca işin
biteceğini söyler.

Burada her bir hesap parçacığı için Snakemake bir slurm iş dosyası
(önceki uygulamalarda elle hazırlanmıştı) hazırlar ve Slurm iş
yöneticisi ile konuşarak işin koşturulması, durumunun takip edilmesi ve
tamamlandığında diğer hesap için benzer işlerin yönetilmesini bizim
yerimize yapar. Aşağıda örnekte yer alan toplam 10 hesap için 10 ayrı iş
dosyası hazırlar, her bir iş dosyası birbirinden bağımsız olduğundan
talep ettiği kaynak, kodun çalıştırılacağı ortam, girdi ve çıktı
dosyaları birbirinden bağımsız tanımlanabilir yapıdadır. Yapısal bir iş
tanımı dosyası ile bu iş akışı hesabının tanımlanacak bir liste ile tüm
proteinler için koşturulması kolaylıkla yapılabilmektedir. Bu, büyük
ölçekte veri analizinda büyük esneklik sağlamaktadır.

.. figure:: /assets/snakemake-howto/pipeline1.png 

   **Şekil 1.** Örnek iş akışı diagramı

İş paketi yöneticisi (conda), kullanıcı arayüzünde kullanıcı tarafından
bir yükleme yapılmaksızın gerekli ortamın kurulması, çevre
değişkenlerinin tanımlanmasından sorumludur. Bir yaml dosyası üzerinden
istenilen versiyonda yazılım belirtilen repo’dan indirilerek kurulum
yapılır. Uygulamada geçen örnek yaml dosyası aşağıda verilmiştir.
Özetle, bioconda reposundan blast’ın 2.9.0 versiyonunu kur demektir.
Snakemake, conda paket yöneticisi ile entegredir, Snakefile içerisinde
her bir rule altında conda değişkeni ile yaml dosyası verilerek iş
akışında ki her bir görev için ayrı ortamları tanımlamaya olanak sağlar.
Benzer şekilde rule altında resources değişkeni ile her bir hesap için
ayrı ayrı kaynak talebinde bulunabilir. Örneğin, “cpus=8, time\_min=300”
ile o hesap için 8 çekirdek talep edileceği, hesaplamanın da 300 sn
süreceği belirtilmiş olur.

.. code-block:: bash

    name: blast
    channels:
      - bioconda
    dependencies:
    - blast = 2.9.0

Snakemake, python tabanlı bir tanımla dilidir. Bu nedenle Snakefile
içerisine python kod parçaları yazılabileceği gibi, tüm hesaplar için
gerekli parametrelerin ayrı bir config dosyasında tutulup kullanılması
sağlanabilir. Aşağıda örnek bir config dosyası verilmiştir. Bu config
dosyasında tanımlı tüm değişkenler Snakefile içerisinden
alınabilmektedir, bu hem okunabilirliği oldukça kolaylaştırır hem de bir
değişkende yapılan değişimin tüm iş dosyalarında otomatik yapılmasını
sağlar.

.. code-block:: bash

    #general config
    query_ids: ["P01008", "P22033", "P68871"]
    workdir: /truba/home/emrah/WORKFOLDER/TEST/TUTORIAL_0921/exp5

    ##blast
    blastdb: "/truba/home/emrah/shared/blastdb/all_eu.fasta"
    outfmt: "0"
    max_target_seqs: "5000"
    num_iterations: "2"

    ##parse blast
    blast_hit_number: "1000"

Son olarak çıktı dosyalarının kendi içerisinde organize bir şekilde
(kendi klasöründe tutulacak şekilde) tutulması Snakemake tarafından
yapılmaktadır. O dizin yok ise otomatik şekilde oluşturulması sağlanır.

Dosyalar ve Komutlar:
======================

Mevcut dosya ve klasörler 
 - output: iş akışı esnasında üretilen çıktı dosyaları 
 - envs: Hesapların yapılması için kurulacak ortamların/yazılımların yer aldığı yaml dosyası 
 - logs: iş akışı şemasında yer alan tüm hesapların log dosyalarının tutulduğu klasör 
 - scripts: çalışabilir dosyaların yer aldığı klasör 
 - slurm-.out, slurm-.err: koşan işin çıktı ve hata dosyaları 
 - Snakefile: iş akışını tanımlayan dosya 
 - readMe: çalıştırılan komutlar, çıktılar ve notlar 
 - config.yml: Hesaplar için tanımlı parametreler 
 - workflow.svg: iş akışını gösterir Snakemake tarafından oluşturulan resim 

Komutlar 

 - İşlerin gönderilmeden önce kontrolü amacı ile çalıştırılması 
     - snakemake -j 3 --use-conda --cluster "sbatch -A emrah -p sardalya -n 4 -J test.job -t 30:00" --keep-going  --dry-run 
 - Aynı anda 3 iş çalıştırabilecek şekilde conda paket yöneticisi ile birlikte hesapların çalıştırılmaya başlanması 
     - snakemake -j 3 --use-conda --cluster "sbatch -A emrah -p sardalya -n 4 -J tes t.job -t 30:00" –keep-going 
 - Kuyruktaki işlerin durumunun sorgulanması 
     - squeue 
 - Her bir protein için işler kendi klasöründe yer alacak şekilde oluşturulur. 
     - ls output

Uyarilar:
==========

.. code-block:: bash

    • İş akışı yöneticisi kullanmanın en büyük avantajlarından biri tekrar hesaplamanın önüne geçmektir. Örneğin iş akışında ki P01008 proteinin için son hesap olan get_blasthits manuel bir şekilde sonlandırılıp işler tekrar çalıştırılırsa, bu durumda önceki hesapların (query_fasta, psiblast) tekrar yapılmasına gerek olmayacaktır. Dry-run ile çalıştırıldığında sadece bu hesap için çalıştırılacağı görünecektir.
    • Snakemake bir hesabın bitip bitmediğini çıktı dosyasının olup olmadığına bakarak anlar. Eğer bir iş öldüyse ve hata log yerine output dosyasının içine yazıyorsa sorunun nereden kaynaklandığı bulunamaz. Çünkü snakemake bitmeyen o hesaba ait tüm çıktı dosyalarını silerek süreci tamamlar.

.. _target to exp6:

------------------------------------------------------
Uygulama 6: Snakemake ile gerçek uygulama – Phylogeny 
------------------------------------------------------

Amaç:
======

Sabancı Üniversitesi Adebali Lab olarak büyük ölçekli veri analizinde
kullandığımız iş akışı örneği gösterilip ileri düzey yapılandırma
örnekleri ile snakemake ve conda’nın bu kapsamda sağladığı avantajlardan
bahsedilecektir. 

Kaynak:
========

`Uygulama-6 <https://github.com/emrahkyn/snakemake_hpc_tutorial/tree/main/exp6>`__

Bilgi: 
=======
Büyük ölçekli veri analizinda Snakemake ve Conda’nın
sağladığı önceki uygulamalarda bahsedilen avantajlara ek olarak
araştırmacıların kullanabileceği diğer özellikler aşağıda
listelenmiştir.

**1. Taşınabilirlik** Lokal sunucuda, YBH kümesinde, bulut veya grid
hesaplama üzerinde iş akışında (workflow) herhangi bir değişiklik
yapmadan çalışabilir. Bu araştırmada basit değişiklikle ilgili hesaplama
hem Sabancı üniversitesi hem de TRUBA üzerinde YBH kümesinde
çalışabilmektedir. Örn: config klasörü içerisinde slurm\_sabancı ve
slurm\_truba

**2. Ölçeklenebilirlik** Bir protein için hazırlanan iş akışı, bir
değişiklik yapılmadan tüm proteinler için de kolayca uygulanabilir.
Benzer şekilde herhangi bir hesaplama için farklı parametreler verilerek
de bu işin yapılmasına olanak sağlar. Örn: config.yml dosyası içerisinde
ki query\_ids ve weights dizi değişkenleri

**3. Tekrar üretebilirlik ve Dağıtabilirlik** Bir hesaplamanın tekrar
çalıştırıldığında aynı sonucu üretmesi önemlidir. Aynı sonucu üretmek
ise, girdi dosyası ve parametrelerin aynı olması yanında kullanılan
yazılımın versiyonuna da bağlıdır. Paket yöneticisi (conda) kullanılarak
ortamın hazırlanması, iş akışının standard bir şekilde verilmesi tekrar
üretebilirliği sağlamaktadır. Örn: envs klasörü içerisinde blastp.yml,
rules içerisinde psiblast.smk dosyaları

Snakemake, pek çok dosyayı içerisinde barındıran bir yapıdır, hangi
dosyaların hangi klasör altında yer almasına yönelik bir rehber de
bulunmaktadır. Buna uygun iş akışı hazırlandığında dağıtabilirlik ya da
bir başkası tarafından anlaşılabilirlik kolaylaşmaktadır. Bu uygulamada
paylaşılan iş akışı bu rehbere uygun tutulmaya çalışılmıştır.

Rehber:
https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html

**4. Mükerrer hesaplamanın önüne geçme** On binlerce yapılan hesaplama
da tek seferde tüm işlerin tamamlanması pek olanaklı değildir. Aynı
hesaplar birden fazla çalıştırılması gerekebilir. Snakemake, eğer
hesaplama üzerinde bir değişiklik yapılmadıysa (girdi dosyası,
parametreler, aynı yazılım ve versiyon) bu durumda o hesabı tekrar
yapmayacaktır. Mevcut dizinde o dosyanın olması önceden bu hesabın
yapıldığını gösterir.

**5. Önbellekleme** Aynı iş akışında üretilen dosyaların kontrolünü
Snakemake garanti etmektedir, hesaplama önceden yapılıyorsa tekrar
yapmayacaktır. Ancak, yeni bir iş akışı hazırlandığında (ayrı bir
kümede) bu hesap önceden yapılıyor mu buna bakacaktır. Bunun için girdi
dosyası, parametreler ve kullanılan yazılımın hash kodu olusturulur ve
önceden belirtilen dizinde md5sum benzeri kodları tutulur. İş akışının
olduğu yerde fiziksel dosya oluşturmak yerine sembolik link atılır.
Tekrar hesaplama yapıldığında snakemake önce kontrol eder, önbellekte
varsa hesap yapmadan basitçe sembolik link atarak hesabı bitirmiş olur.

.. figure:: /assets/snakemake-howto/pipeline2.png

    **Şekil 2.** Phylogeny – İş akışı diagramı

**6. Loglama & Performans** İş akışında yer alan her bir iş için hem log
hem de işin ne kadar sürdüğü ile ilgili benchmark sonuçları her bir
kuralda (hesaplamada) tanımlanarak dosya içerisine alınabilir. İleride
işlerin ne kadar sürdüğü ile ilgili analiz yapmak açısından faydalıdır.
Örn: psiblast.smk dosyası

**7. Singularity** İş akışında yer alan her bir hesaplama için gerekli
ortam talep edilen kaynakta (cpu, ram) konteynır (container) üzerinde
hazırlanarak işlerin çalıştırılması sağlanır. Not: Henüz bu özelliğini
TRUBA üzerinde çalıştırarak denemedik.

**8. İzleme ve Raporlama** Çok basit şekilde kurulumu gerçekleştirilen
(Panoptes) bir sunucu üzerinden iş akışında devam eden, tamamlanan
hesaplamalar web arayüzü üzerinden takip edilebilir. Örn: --wms-monitor
Ayrıca, hesaplar tamamlandıktan sonra otomatik raporların oluşturulması
konusunda da oldukça yeteneklidir.

**9. Entegrasyon** Verilerin tutulması lokalde ya da YBH üzerinde arşiv
klasöründe tutulabileceği gibi S3 API destekli farklı bulut
merkezlerinde obje depolama olarakta tutulabilir. Örn: snakemake –help

**10. Python kodu çalıştırabilme** İş akışının tanımlandığı Snakefile,
python tabanlı olduğundan içerisinde python kodu da yazılabilir. Bu
büyük bir esneklik kazandırmaktadir. Bu uygulama da olduğu gibi arşiv
klasöründen önce o proteinin hesaplamasının yapılıp yapılmadığı kontrol
edilebilir, yapıldıysa herhangi bir hesaplama bu protein için yapılmadan
hızlı şekilde sürecin tamamlanması sağlanır. Örn: Snakefile dosyası
içerisinde ki python fonksiyonu

İş akışı yöneticisi büyük ölçekli verilerin analizini standard bir
şekilde oldukça otomatikleşteren bir çözüm sunmaktadır. Bunun yanında
çok sayıda iş dosyasının (hesapların) hangi durumda kaldığını görmek
aylarca sürecek hesaplamalarda ne kadarını tamamlandığını göstermesi
açısından faydalıdır. Bunun için bir örnek diagram hazırlanmıştır (Şekil
3), yardımcı olur düşüncesiyle de bash betik kodları github üzerinden
paylaşılmıştır.

.. figure:: /assets/snakemake-howto/framework1.png

    **Şekil 3.** Verinin arşivlenmesi ve yedeklenmesi

Genel olarak mevcut durumu özetleyen, hesabı biten işleri arşivleyen,
yedekleyen örnek kodlar aşağıdan ulaşılabilir durumdadır.
https://github.com/CompGenomeLab/phylogeny-snakemake/tree/main/resources/query\_ids

Dosyalar ve Komutlar:
========================

Mevcut dosya ve klasörler 

.. image:: /assets/snakemake-howto/directory1.png 

Komutlar

.. code-block:: bash

    git clone
    vi config.yml
    snakemake --use-conda --cache --profile ../config/slurm_truba –dry-run
    snakemake --use-conda --cache --profile ../config/slurm_truba --dry-run --wms-monitor http://ephesus.sabanciuniv.edu:5000

.. _target to sonuc:

------
SONUÇ 
------

-  Büyük ölçekli veri analizlerinde, bir araç kullanmadan (snakemake, conda) hesaplama yapmak mümkün, ancak hiç pratik değil.
-  Snakemake & Conda, sadece iş akışı gerektiren hesaplamalar da değil, fazla sayıda iş/kaynak gerektiren tüm hesaplamalarda kullanılabilir.
-  Hazırlık, öğrenme zaman alıcı bir süreç, uzun vadede sağladığı pek çok avantajla işleri çok kolaylaştırıyor.
-  Araştırma döngüsünde (iş akışında değişiklik, parametre havuzu, yazılım güncelleme, yeni girdi dosyaları) büyük avantaj sağlar.

.. |framework 1| image:: /assets/snakemake-howto/framework1.png
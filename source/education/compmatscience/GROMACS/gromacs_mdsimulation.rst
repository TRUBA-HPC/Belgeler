=================================
MD Simülasyonun Hazırlanması
=================================

-------------------------------------
Sistemin Dengeye Getirilmesi
-------------------------------------

Enerji minimizasyonu (EM), geometri ve solvent uyumu açısından iyi bir başlangıç yapısına sahip olmamızı sağlamıştır. Gerçek moleküler dinamik simülasyonlara başlamak için, proteinin etrafındaki çözücü ve iyon dengesi sağlanmalıdır. Bu noktada kontrolsüz dinamikler denenirse sistem başarısız olabilir. Bunun nedeni çözücünün genellikle kendi içinde optimize edilmiş olmasına karşın çözelti ile optimize edilmemiş olmasıdır. Simülasyonun istenilen sıcaklığa getirilmesi ve çözünen madde (protein) ile ilgili doğru yönelimin oluşturulması gerekir. Kinetik enerjilere göre doğru sıcaklığa ulaştıktan sonra uygun yoğunluğa ulaşılana kadar sisteme basınç uygulanır.

Pdb2gmx’in önceki basamaklarda oluşturduğu ``posre.itp`` dosyası bu aşamada kullanılacaktır. ``posre.itp`` nin amacı, proteinin ağır atomlarına (hidrojen dışındaki atomlar) konum sınırlayıcı bir kuvvet uygulamaktır. Önemli bir enerji probleminin üstesinden gelindikten sonra harekete izin verilir. Konum sınırlamalarının faydası proteindeki yapısal değişikliklerin ilave değişkeni olmaksızın solventi, protein etrafında dengelemeye olanak sağlamalarıdır. Konum sınırlamalarının temeli (sınırlama potansiyelinin sıfır olduğu koordinatlar), ``grompp`` un ``-r`` seçeneğine iletken bir koordinat dosyası aracılığıyla sağlanır. 

Dengeleme genellikle iki aşamada gerçekleşir. İlk aşama NVT topluluğu (sabit parçacık sayısı, hacim ve sıcaklık) altında yürütülür. Bu topluluğa ``izotermal-izokorik`` ya da ``kanonik`` de denir. Böyle bir prosedürün zaman çerçevesi sistemin içeriğine bağlıdır ancak NVT’de sistemin sıcaklığı, istenen değerde bir platoya ulaşmalıdır. Sıcaklık henüz sabitlenmediyse ek süre gerekecektir. Genelde 100-200 ps yeterlidir, bu örnek için 100 ps NVT dengelemesi yapılacaktır. Bu işlem kullandığınız cihaza bağlı olarak zaman alabilir (16 çekirdekte paralel olarak çalıştırılırsa 1 saatten az sürebilir) [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)].

``mdp`` dosyasını oluşturmak için öncelikle şu linkteki metni kopyalayın:

http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp

.. image:: /assets/compmatscience-gromacs-education/gmx_nvt_mdp.png
   :align: center
   :width: 300px

Terminalde ``nano nvt.mdp`` yazarak bir mdp dosyası oluşturun, ``CTRL+v`` ile yapıştırın ve ``y`` ile kaydedin. nvt.mdp dosyası oluşturuldu. 

EM adımında yaptığımız gibi grommp ve mdrun kullanacağız. 

.. code-block::

    gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr

    gmx mdrun -deffnm nvt

Kullanılan parametrelerin tam açıklamaları GROMACS el kitabında bulunabilir. mdp dosyasındaki birkaç parametre şu şekildedir:

* gen_vel = yes: Hızlanmayı başlatır. Farklı rastgele tohumların (gen_seed) kullanılması farklı başlangıç hızları verir ve bu nedenle aynı başlangıç yapısından farklı simülasyonlar yürütülebilir. 

* tcoupl = V-rescale: Hızı yeniden ölçeklendirmeyi sağlar. 

* pcoupl = no: Basınç eşleşmesi uygulanmadı.

Enerji kullanılarak sıcaklık işleyişini inceleyecek olursak:

.. code-block::

    gmx energy -f nvt.edr -o temperature.xvg

Sistem sıcaklığını seçmek ve çıkmak için ``16 0`` yazınız. 

.. image:: /assets/compmatscience-gromacs-education/gmx_temp.png
   :align: center
   :width: 300px

Grafiği oluşturmak için:

.. code-block::

    xmgrace temperature.xvg

Oluşturulan grafik aşağıdaki gibi görünmelidir:

.. image:: /assets/compmatscience-gromacs-education/gmx_time_temp.png
   :align: center
   :width: 300px

Grafikten sistem sıcaklığının hızlı bir şekilde hedef sıcaklık olan 300 K’e ulaştığı ve denge süresince sabit kaldığı görülmektedir.

Yapılan NVT dengelemesi, sistem sıcaklığının dengelenmesini sağlamıştır. Veri toplamadan önce, sistemin basıncı ve dolayısıyla yoğunluğu stabilize edilmelidir. Basınç dengelemesi sabit bir NPT (parçacık sayısı, basınç, sıcaklık) topluluğu etkisi altında gerçekleştirilir. Topluluğa ``izotermal-izobarik`` topluluk da denir ve deneysel koşullara çok benzer. 

100 ps’lik NPT dengelemesi için kullanılan .mdp dosyası aşağıdaki linkten bulunabilir:
http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp

.. image:: /assets/compmatscience-gromacs-education/gmx_lysozyme-npt.png
   :align: center
   :width: 300px

Linkteki metni kopyalayınız ve terminalde ``nano npt.mdp`` yazarak bir mdp dosyası oluşturunuz, ve ``CTRL+v`` ile yapıştırınız ve ``y`` ile kaydediniz.

Bu dosya NVT dengelemesinde kullanılan dosyaya benzerdir. Bazı farklılıklar ise;

* continuation = yes: NVT dengeleme aşamasından simülasyona devam ediliyor.

* gen_vel = no: Hızlar yörüngeden okunmaktadır (aşağıdaki gibi). 

NVT dengelemesinde yaptığımız gibi ``grompp`` ve ``mdrun`` kullanılacaktır. NVT dengelemesinden kontrol noktası dosyasını dahil etmek için ‘-t’nin eklendiği unutulmamalıdır. Bu dosya simülasyona devam etmek için gereken tüm durum değişkenlerini içermektedir. NVT sırasında üretilen hızları korumak için bu dosya eklenmelidir. Koordinat dosyası (-c), NVT simülasyonunun son çıktısıdır. 

.. code-block::

    gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr

    gmx mdrun -deffnm npt

Enerji kullanılarak basınç ilerlemesi analiz edilirse;

.. code-block::

    gmx energy -f npt.edr -o pressure.xvg

.. image:: /assets/compmatscience-gromacs-education/gmx_pressure.png
   :align: center
   :width: 300px

Sistemin basıncını seçmek ve çıkmak için ``18 0`` yazın. Grafiği görmek içinse ``xmgrace pressure.xvg`` yazın.

.. image:: /assets/compmatscience-gromacs-education/gmx-pressure-xmgrace.png
   :align: center
   :width: 300px

Basınç değerinin 100 ps dengeleme süresince geniş ölçüde dalgalandığı grafikten görülmektedir ancak bu beklenmedik bir durum değildir. Bu verilerin hareketli ortalaması kırmızı çizgiyle görülmektedir. Dengeleme süresince basıncın ortalama değeri ``7.5 ± 160.5 bar`` dır. Referans basıncı 1 bar olduğundan bu sonuç kabul edilebilir mi? Basınç, büyük ortalama kare kök dalgalanmasından (160.5 bar) da anlaşılacağı gibi, bir MD simülasyonu boyunca geniş ölçüde dalgalanan bir miktardır. Yani istatistiksel olarak konuşursak, elde edilen ortalama (7.5 ± 160.5 bar) ile hedef/referans değeri (1 bar) birbirine oldukça yakındır.

Yoğunluk değişimini incelemek için;

.. code-block::

   gmx energy -f npt.edr -o density.xvg

Oluşturulan son md dosyasında tüm adımlar basınç incelerkenki gibi ilerler ancak son adımda ``18 0`` yerine ``24 0`` yazılarak yoğunluk seçilir. Diğer tüm adımlar grafik çizerken de aynıdır. Elde edilen grafik aşağıdaki gibidir.

.. image:: /assets/compmatscience-gromacs-education/gmx_density.png
   :align: center
   :width: 300px

Basınçta olduğu gibi, yoğunluğun hareketli ortalaması da kırmızı ile çizilmiştir. 100 ps boyunca ortalama değer 1019 ± 3 kg m :sup:`-3` olup, 1000 kg m :sup:`-3` deneysel değerine ve 1008 kg m :sup:`-3` SPC/E modelinin beklenen yoğunluğuna yakındır. ``SPC/E`` su modelinin parametreleri, su için deneysel değerlere oldukça yakındır. Yoğunluk değerleri zamanla oldukça kararlı hale gelmiştir, bu da sistemin basınç ve yoğunluk dengelemelerinin iyi yapıldığını gösterir.

.. note::

   Basınçla ilgili terimlerin yakınsaması yavaştır ve bu nedenle NPT dengelemesini burada belirtilenden biraz daha uzun süre çalıştırmanız gerekebilir [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)].

-------------------------------------
MD Aşamaları
-------------------------------------

İki NVT ve NPT dengeleme aşamasının tamamlanmasının ardından, sistem artık istenen sıcaklık ve basınçta iyi dengelenmiştir. Artık konum sınırlamalarını kaldırmaya ve veri toplama için üretim MD' sini çalıştırmaya hazırdır. İşlem, daha önce gördüğümüz gibidir, çünkü grompp için kontrol noktası dosyası kullanılacaktır. Bu örnek için 1 ns’lık bir MD dosyası çalıştırılacaktır. MD dosyasının metnine aşağıdaki linkten ulaşabilirsiniz:

http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp

.. image:: /assets/compmatscience-gromacs-education/gmx_nanomd.png
   :align: center
   :width: 300px

MD dosyasını oluşturmak için metni kopyalayın, terminale ``nano md.mdp`` yazın ve metni yapıştırın ve ``y`` ile kaydedin. Daha sonra terminale aşağıdaki kodu girin.

.. code-block::

   gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
   
Bu adımdan sonra ``mdp.tpr`` dosyası oluşturulmuştur. 

Grompp, PME hesaplaması için kaç işlemcinin ve PP hesaplamaları için kaç işlemcinin ayrılması gerektiğini belirleyen PME yükü için bir tahmin yazdıracaktır. Ayrıntılar için GROMACS el kitabına bakabilirsiniz.

mdrun’ı yürütmek içinse;

.. code-block::

   gmx mdrun -deffnm md_0_1

GROMACS 2018'de PME hesaplamaları, simülasyonu önemli ölçüde hızlandıran grafik işlem birimlerine (GPU) aktarılabilir [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)].
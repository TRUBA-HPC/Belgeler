======================
GROMACS Avantajları
======================

GROMACS, modern bir moleküler dinamik simülasyon uygulamasından beklenen tüm algoritmaları desteklemekle birlikte bazı ekstra avantajlar da sunmaktadır:

#. GROMACS, diğer tüm programlara kıyasla son derece yüksek performans sağlar. Kod içeresinde birçok optimizasyon, minimizasyon ve simülasyon algoritması tanıtılmıştır (örneğin, ikili etkileşimler üzerinden en içteki döngülerden virial hesaplaması çıkarılmış ve ters karekökü hesaplamak için GROMACS’ın yazılım rutinleri kullanılmaktadır. GROMACS 4.6 ve sonraki sürümlerinde neredeyse tüm yaygın platformlar için versiyonlarında en içteki döngüler, mevcut komut düzeyinde paralelliği kullanmak için derleyicinin SIMD makine talimatlarına dönüştürdüğü içsel işlevler kullanılarak C programlama dili ile yazılır. Bu çekirdekler, tek ve çift hassasiyette mevcuttur. X86 ailesi ve diğer işlemcilerde bulunan tüm farklı SIMD desteği türlerini desteklemektedir. Ayrıca GROMACS 4.6 ve sonraki sürümlerde NVIDIA hesaplama yeteneği>= 2.0 olan GPU'larda mükemmel CUDA tabanlı GPU hızlandırması bulunmaktadır.

#. GROMACS açık metin formatında yazılmış topolojiler ve parametreler içermesi nedeniyle kullanıcı dostudur. Birçok hata kontrol mekanizması vardır ve hata mesajları sorunu net bir biçimde tanımlamaktadır. Bir C ön işlemcisi kullanıldığından, topolojilerinizde koşullu parçalara sahip olabilir ve diğer dosyaları dahil edilebilir. GROMACS, çoğu dosyayı sıkıştırdığınızda okuma sonucu otomatik olarak gzip olarak aktarır. 

#. Tüm programlar girdi ve çıktı dosyaları için komut satırı seçenekleriyle basit bir arabirim kullanırken GROMACS’ın belli bir yazı dili yoktur. Elektronik ortamda ücretsiz olarak sağlanan kılavuzları kullanabilir ya da program içerisinde aşağıdaki komutlar ile yardım alabilirsiniz:

    .. code-block::

        gmx help (yardm istenen komut) veya gmx (yardım istenen komut) -h

#. Simülasyon çalışırken ne kadar ilerlediğini ve tahmini olarak ne zamana çalışmayı tamamlayacağını GROMACS sürekli olarak gösterebilmektedir.

#. Çalıştırma girdi dosyaları, çıktı dosyaları, yörünge (trajectory) koordinatları donanım ve versiyon özelliklerinden bağımsızdır. Böylece farklı bir kayan nokta hassasiyetine sahip de olsa herhangi bir GROMACS sürümü tarafından farklı bir sistemde okunabilmektedir.

#. GROMACS, simülasyon sırasında verilerini depolamak için çok kompakt bir yol sağlayan kayıplı sıkıştırma yöntemini kullanarak koordinatları yazabilir. Doğruluk oranı, kullanıcı tarafından ayarlanabilir.

#. GROMACS, yörünge ve koordinat çıktıları analizinde kullanılabilecek çok çeşitli araçlar içerir. Böylelikle rutin analizleri yapmak için herhangi bir kod yazmanıza gerek kalmaz. Xmgr/Grace grafikleri eksen isimleri, lejantlar gibi grafik özellikleri yerleştirilmiş şekildedir.

#. Yalnızca standart X kitaplıkları gerektiren temel bir yörünge görüntüleyici dahildir ve birçok harici görselleştirme aracı GROMACS dosya biçimini okuyabilir.

#. GROMACS, standart MPI iletişim protokolü kullanılarak ya da tek düğümlü iş istasyonları için kendi ‘Thread MPI’ kitaplığı aracılığıyla paralel olarak çalıştırılabilir.

#. GROMACS, simülasyonların zaman adımlarını önemli ölçüde uzatmayı mümkün kılan ve böylece doğruluk veya ayrıntıdan ödün vermeden performansı daha da arttıran son teknoloji algoritmalar içerir.

#. Paket, proteinler ve hatta multimerik yapılar için tam otomatik bir topoloji dosyası oluşturma programı içerir. 20 standart aminoasit kalıntısının yanı sıra bazı modifiye edilmiş kalıntılar, 4 nükleotit ve 4 deoksinükleotit kalıntısı, birkaç şeker, lipid ve biyolojik küçük moleküller gibi bazı özel gruplar için yapı taşları mevcuttur.

#. GROMACS’ı hem kuantum kimyası hem de biyoinformatik /veritabanlarına arayüzlerle genişletmek için devam eden gelişmeler sürmektedir.

#. GROMACS, 2.1 sürümüyle GNU Kısıtlı Genel Kamu Lisansına (LGPL) sahip ücretsiz bir yazılımdır. Özgür Yazılım Vakfı tarafından yayınlanan LGPL şartları dahilinde 2.1 veya daha sonraki sürümleri yeniden dağıtabilir ve/veya değiştirebilirsiniz [http://www.gromacs.org/About_Gromacs (Erişim tarihi: 25.06.2021)].  

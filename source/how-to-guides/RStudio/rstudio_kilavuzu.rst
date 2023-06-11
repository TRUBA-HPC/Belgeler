TRUBA RStudio Kılavuzu
======================

Bu kılavuz TRUBA altyapısında kişiselleştirilmiş RStudio kullanımı için
gerekli kurulumları yapmaya yardımcı olmak amacıyla oluşturulmuştur.
Kılavuzda aşağıdaki basamaklar anlatılmıştır:

TRUBA’da `OnDemand
arayüzü <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/openondemand/index.html#>`__
ile RStudio’ya erişim sağlanabilmektedir. Bu kılavuzun yazım tarihi
itibariyle OnDemand’daki RStudio, ``gcc-7`` ile derlenmiş ``R-4.2.2``
sürümü ile çalışmaktadır. Dolayısıyla ``gcc-12`` gibi başka derleyiciler
gerektiren R paketlerinin yüklenmesinde sorunlar yaşanabilmektedir. Bu
gibi sıkıntıları aşmak ve analiz ihtiyaçlarına daha iyi hizmet edebilmek
için kullanıcılar ``miniconda`` aracılığıyla bir sanal ortam oluşturup
kendi R/RStudio kurulumlarını yapabilirler. Bunun için aşağıdaki adımlar
takip edilir:

TRUBA sunucularına bağlanma
~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. ULAKBİM ağının dışından bağlanılıyorsa `ilgili
   kılavuz <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/index.html>`__
   takip edilerek OpenVPN bağlantısı kurulur.

2. Bundan sonra PuTTY SSH aracılığıyla TRUBA terminaline bağlanılır.
   Bağlantı için detaylara
   `buradan <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/index.html>`__
   erişebilirsiniz. Bağlantı kurulduğunda ``home`` dizininizi görüyor
   olacaksınız:

``/truba/home/kullanici-adi``

TRUBA terminalde miniconda3 kurulumu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. ``home`` dizinindeyken miniconda’yı indirin. Bu prosedürle ilgili
   kılavuza
   `buradan <https://docs.truba.gov.tr/how-to-guides/python/anaconda.html>`__
   erişebilirsiniz.

``wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh``

2. ``bash`` komutu ile kurulumu yapın. Kurulum sırasında sorulduğunda
   ``conda init`` komutunu çalıştırmayın.

``bash Miniconda3-latest-Linux-x86_64.sh``

3. Kurulumdan sonra script’i silebilirsiniz:

``rm Miniconda3-latest-Linux-x86_64.sh``

4. Conda’yı güncelleyin (buradaki kod ``conda`` komutunu shell’e tanıtıp
   ``update`` fonksiyonun çalışmasını sağayacaktır):

::

   eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
   conda update conda

RStudio için sanal ortam oluşturma
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Aşağıdaki kodları kullanarak miniconda içinde RStudio ortamını
   oluşturup RStudio kurulumunu yapın:

::

   conda create -n rstudio-env # RStudio için bir ortam oluşturulur.
   conda activate rstudio-env  # Oluşturulan ortam aktif edilir.
   conda install -c conda-forge rstudio-desktop # RStudio ve bağımlı paketler kurulur.

2. RStudio sanal ortamı kurulup aktive edildikten sonra aşağıdaki kod
   örneği ile ilgili R paketleri kurulabilir. Conda ortamı paketleri
   birbiriyle uyumlu olarak çalışacak şekilde yükler. Ancak daha sonra
   RStudio içinde ``install.packages("xxx")`` şeklinde CRAN’dan veya
   GitHub gibi başka kaynaklardan da paketler kurulabilir. Bu durumda
   uyum sorunu oluşabilmektedir ve grid-teknik’ten destek talep
   edilebilir.

::

   conda install -c conda-forge r-ragg
   conda install -c conda-forge r-tidyverse
   conda install -c conda-forge r-seurat

3. Miniconda altında bu şekilde kurulan R uygulaması TRUBA’daki `R
   modüllerinden <https://docs.truba.gov.tr/how-to-guides/R/index.html>`__
   bağımsız olarak çalışmaktadır. Shell’de bu aşağıdaki şekilde
   doğrulanabilir:

::

   which R
   # ~/miniconda3/envs/rstudio-env/bin/R

4. Bu ve bir sonraki adımda RStudio sanal ortamının TRUBA’ya
   bağlanıldığında otomatik olarak yüklenmesi için ``.bashrc`` dosyasını
   düzenleyeceğiz. Bu sayede OnDemand üzerinden RStudio bağlanıldığında
   burada yaptığız kurulum kullanıma hazır olacaktır. ``home``
   dizinindeyken aşağıdaki kod ile ``.bashrc`` dosyası otomatik olarak
   güncellenecektir. Güncellenmiş dosya içindeki komutlar, kullanıcı
   yeni oturum açtığında shell’e ``conda`` komutunu tanıtacaktır.

``conda init bash``

5. Bu dosyayı ``nano .bashrc`` komutuyla açıp son satıra aşağıdaki
   komutu ekleyin. Değiştirmeyi yaptıktan sonra kaydederek çıkmak için
   sırasıyla ``Ctrl+X`` ve ``Y`` kısayollarını kullanın

``conda activate rstudio-env``

6. Bu basamakta ``.bash_profile`` dosyasını düzenleyerek, ``.bashrc``
   dosyasının yeni oturum oluşturulurken otomatik olarak
   çalıştırılmasını sağlayacağız. Her bağlanıldığında bu ortam
   içerisinde bulunmak istemiyorsanız, bu basamağı atlayabilirsiniz.
   ``nano .bash_profile`` komutuyla dosyayı açın, aşağıdaki satırı
   ekleyin, ve yukarıdaki gibi kaydedin:

``source ~/.bashrc``

OnDemand ile Conda-RStudio’ya erişim
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. `İlgili
   kılavuzda <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/openondemand/index.html>`__
   belirtildiği, gibi OpenVPN bağlantısıyla https://172.16.0.200
   adresinden OnDemand arayüzüne bağlanıp RStudio oturumu açın. Burada
   maksimum 24 core üzerinde 24 saate kadar interaktif analiz
   yapılabilmektedir.

2. OnDemand-RStudio oturumu otomatik olarak bizim kurduğumuz sanal
   ortamdaki RStudio ile açılacaktır. Bunu RStudio terminalinde
   aşağıdaki komutu yazarak doğrulayabilirsiniz:

::

   which R
   # ~/miniconda3/envs/rstudio-env/bin/R

3. Benzer şekilde, R paketleri kullanıcının temel ``home`` dizininde
   yerine, miniconda altında yer almaktadır. Bunu RStudio konsolunda
   aşağıdaki komutu yazarak doğrulayabilirsiniz:

::

   .libPaths()
   [1] "/truba/home/kullanici-adi/miniconda3/envs/rstudio-env/lib/R/library"

Diğer faydalı bilgiler
~~~~~~~~~~~~~~~~~~~~~~

**TRUBA bilgisayarlarına veri aktarımı**

1. Analizler için TRUBA bilgisayarlarına internetten dosya indirilmesi
   gerekirse, kullanıcılar OnDemand-TRUBA desktop aracılığıyla bunu
   görsel bir şekilde yapabilirler.

2. TRUBA bilgisayarlarına lokal bilgisayarlardan dosya aktarılması
   gerekirse, FileZilla gibi SFTP protokolünü destekleyen programlar
   kullanılabilir. Bunun için ilgili programa bağlanılacak olan TRUBA
   bilgisayarının adresi ve kullanıcı adı/şifresi gibi bilgiler girilir.
   Bunun için `dosya transferi
   kılavuzunu <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/winscp.html>`__
   takip edebilirsiniz. Kolaylık olması açısından ``levrek1`` sunucusuna
   bağlanmak için gerekli adres aşağıda verilmiştir:

   -  (ULAKNET ağı dışından bağlanılıyorsa OpenVPN ile) ``172.16.7.1``
      (veya ``levrek1.yonetim``)
   -  (Kampüsten erişimde OpenVPN’e gerek yoktur)
      ``levrek1.ulakbim.gov.tr``

**Yüksek performanslı işlerin yapılması**

1. RStudio arayüzü interaktif analizler için iyi bir çözümken, daha
   yüksek performans gerektiren hesaplama işleri için SLURM kaynak
   yöneticisinin kullanılması daha uygundur. `İlgili
   kılavuzda <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kaynakyoneticisi-isdongusu/basic_slurm_commands.html>`__
   daha fazla bilgi sahibi olabilirsiniz. Burada iki adet kullanım
   örneğini paylaşacağım.

2. Bu tip kullanımlar için yazılan R kodunu script olarak kaydetmek
   gerekecektir. Bu kod içerisinde oluşturulacak veri objeleri ``.rds``
   veya ``.rda`` olarak kaydedilebilir. Bu objeler daha sonra interaktif
   RStudio ortamında görselleştirme vb. amaçlarla kullanılabilir.
   Bahsedildiği gibi oluşturulan scriptleri iş kümesine göndermeden önce
   test etmek gerekebilir. Bu amaçla aşağıdaki kod ile ``debug``
   kuyruğundan 15 dakika boyunca 10 iş kullanacak bir çekirdek
   istenebilir. Böylece ana bilgisayarı meşgul etmeden hesaplama
   kümesinde size ayrılan bir shell’de işlem yürütebilirsiniz. ``srun``
   argümanları hakkında ayrıntılı bilgiyi
   `burada <%5Bhttps://slurm.schedmd.com/srun.html>`__ bulabilirsiniz.

``srun -p debug -N1 -n10 -A kullanici_adi -time=00:15:00 --pty bash -i``

3. R script’inin çalıştığından emin olduktan sonra bunu hesaplama
   kümesine aktarmak için aşağıdaki gibi ``.sh`` scripti oluşturup,
   ``sbatch`` komutu kullanılabilir. Detaylı bilgi için `ilgili
   kılavuzu <https://docs.truba.gov.tr/how-to-guides/R/index.html>`__
   takip edebilirsiniz.

``slurm_is_verme_R.sh`` dosyası aşağıdaki gibi hazırlanabilir:

::

   #!/bin/bash

   #SBATCH -p hamsi                                # kuyruk adi, isinizin calisma suresine gore guncelleyiniz.
   #SBATCH -A kullanici_adi                        # kendi kullanici adiniz ile degistiriniz.
   #SBATCH -J R_analizi                            # isin adi.
   #SBATCH -n 28                                   # is icin toplamda kullanilacak cekirdek adeti.
   #SBATCH -N 1                                    # is icin kullanilacak sunucu sayisi.
   #SBATCH --time=01:00:00                         # isinizin suresi (1 saat)
   #SBATCH --workdir=/truba_scratch/kullanici_adi/test    # isinizi calistiracaginiz dizin, kendi kullanici kodunuz ile guncellemeniz gerekmektedir.
   #SBATCH --mail-type=ALL                         # isin asamalarinda bilgilendirmek icin e-posta tanimi.
   #SBATCH --mail-user=kullanici@xyz.edu.tr        # kendi eposta adresiniz ile guncelleyiniz.


   # Oturumunuz otomatik olarak rstudio-env ile açılacaktır. Ancak başka modülleri yüklemeniz gerekirse veya TRUBA tarafından derlenmiş R'ı kullanmak isterseniz ilgili modülleri aşağıdaki gibi yükleyebilirsiniz. Detaylı bilgi için modüller kılavuzunu inceleyiniz (https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/moduller.html)

   # module purge
   # gcc ile derlenmiş R kullanmak için derleyici ile birlikte yüklüyoruz.
   # module load centos7.9/comp/gcc/7
   # module load centos7.9/app/R/4.2.2-gcc-7

   echo "SLURM_NODELIST $SLURM_NODELIST"

   echo Job Started:

   date

   # R calisma komutunuzu inputlariniz ile birlikte veriniz.
   R CMD BATCH my_R_Script.R

   echo Job Finished:

   date

Bu dosya daha sonra iş kümelerine aşağıdaki gibi gönderilebilir:

``sbatch Slurm_is_verme_R_gcc.sh``

R paketlerinin kurulumu sırasında derleyici sorunlarını çözmek için diğer yaklaşımlar
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  R paketleri kurulurken derleyicilerin düzgün bir şekilde çağrılması
   için ~/.R/Makevars dosyasına ilgili flag’ler eklenebilir. Bununla
   ilgili detaylar internette farklı kaynaklardan elde edilebilir
   (`StackOverflow’dan bir
   örnek <https://stackoverflow.com/questions/1616983/building-r-packages-using-alternate-gcc>`__)

-  R paketlerinin kurulumu sırasında TRUBA oturumunda hali hazırda yüklü
   olmayan modüller gerekirse terminal üzerinden ilgili modüller
   yüklenebilir. Bunun için `modüller
   kılavuzunu <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/moduller.html>`__
   inceleyebilirsiniz.

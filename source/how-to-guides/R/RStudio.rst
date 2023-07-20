.. _RStudio-kilavuzu:

======================
RStudio Kılavuzu
======================

Bu kılavuz TRUBA altyapısında kişiselleştirilmiş RStudio kullanımı için
gerekli kurulumları yapmaya yardımcı olmak amacıyla oluşturulmuştur.
Kılavuzda aşağıdaki basamaklar anlatılmıştır:


.. grid:: 3

    .. grid-item-card::  :ref:`open-ondemand-ile-rstudio`
        :text-align: center
    .. grid-item-card:: :ref:`farkli-rstudio-versiyonu-kullanma`
        :text-align: center
    .. grid-item-card:: :ref:`yuksek_performansli_islerin_yapilmasi`
        :text-align: center

.. _open-ondemand-ile-rstudio:

Open OnDemand ile RStudio
-----------------------------
Kullanıcı arayüzü kullanarak RStudio kullanım yol haritasını :ref:`open_ondemand`
de bulabilirsiniz.
Resimde görüldüğü üzere kısa yoldan RStudio arayüzünü kullanabilmek için 2 aşamadan oluşmaktadır.

- İstenilen interaktif sunucusu için çekirdek ve saat yazılması
- İnteraktif işlerde kuyruğa girmesi
- RStudio kullanıma hazır.

.. image:: /assets/RStudio-howto/images/OpenOnDemandRstudio.png


Bu kılavuzun yazım tarihi itibariyle Open OnDemand’daki RStudio, ``gcc-7`` ile derlenmiş ``R-4.2.2``
sürümü ile çalışmaktadır. Dolayısıyla ``gcc-12`` gibi başka derleyiciler
gerektiren R paketlerinin yüklenmesinde sorunlar yaşanabilmektedir. Bu
gibi sıkıntıları aşmak ve analiz ihtiyaçlarına daha iyi hizmet edebilmek
için kullanıcılar ``miniconda`` aracılığıyla bir sanal ortam oluşturup
kendi R/RStudio kurulumlarını yapabildikleri gibi :ref:`R_Source_code` kılavuzu takip edilerek istenilen derleyici ile kurulum gerçekleştirilebilir.


.. _farkli-rstudio-versiyonu-kullanma:

Farklı RStudio versiyonu kullanma
-----------------------------------

Conda Platformu
~~~~~~~~~~~~~~~

İstenilen RStudio versiyonu kullanmak için anaconda platformunda uygun conda ortamı oluşturularak kullanılabilir. Bu durumda öncelikle :ref:`merkezi-anaconda` ya da :ref:`miniconda-kurulum` sayfalarını ziyaret ederek gerekli kurulumlar gerçekleştirilir. Sonrasında

1. Aşağıdaki kodları kullanarak miniconda içinde RStudio ortamını
   oluşturup RStudio kurulumunu yapın:

   .. code-block:: bash

      conda create -n rstudio-env # RStudio için bir ortam oluşturulur.
      conda activate rstudio-env  # Oluşturulan ortam aktif edilir.
      conda install -c conda-forge rstudio-desktop # RStudio ve bağımlı paketler kurulur.

   .. warning:: 

      RStudio sanal ortamı kurulup aktive edildikten sonra aşağıdaki kod
      örneği ile ilgili R paketleri kurulabilir. Conda ortamı paketleri
      birbiriyle uyumlu olarak çalışacak şekilde yükler. Ancak daha sonra
      RStudio içinde ``install.packages("xxx")`` şeklinde CRAN’dan veya
      GitHub gibi başka kaynaklardan da paketler kurulabilir. Bu durumda
      uyum sorunu oluşabilmektedir ve grid-teknik’ten destek talep
      edilebilir.


2. Miniconda altında bu şekilde kurulan R uygulaması TRUBA’daki kurulu olan :ref:`R modülleri <R-modules>`
   bağımsız olarak çalışmaktadır. Terminal'de aşağıdaki şekilde
   doğrulanabilir:

   .. code-block:: r

      which R
      # ~/miniconda3/envs/rstudio-env/bin/R

3. Bu ve bir sonraki adımda RStudio sanal ortamının TRUBA’ya
   bağlanıldığında otomatik olarak yüklenmesi için ``.bashrc`` dosyasını
   düzenleyeceğiz. Bu sayede Open OnDemand üzerinden RStudio bağlanıldığında
   burada yaptığız kurulum kullanıma hazır olacaktır. ``home``
   dizinindeyken aşağıdaki kod ile ``.bashrc`` dosyası otomatik olarak
   güncellenecektir. Güncellenmiş dosya içindeki komutlar, kullanıcı
   yeni oturum açtığında shell’e ``conda`` komutunu tanıtacaktır.

   ``conda init bash``

   Conda tanımlama için problem ile karşılaşılırsa ``.bashrc`` içerisine aşağıdaki betik içierisinde kullanıcı adınızı değiştirerek ekleyebilirsiniz.

   .. dropdown:: :octicon:`codespaces;1.5em;secondary` Conda başlangıç ayarı (Tıklayınız)
      :color: info
      

      .. code-block:: bash

            eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

            # >>> conda initialize >>>
            # !! Contents within this block are managed by 'conda init' !!
            __conda_setup="$('/truba/home/kullanici_adiniz/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
            if [ $? -eq 0 ]; then
               eval "$__conda_setup"
            else
               if [ -f "/truba/home/kullanici_adiniz/miniconda3/etc/profile.d/conda.sh" ]; then
                  . "/truba/home/kullanici_adiniz/miniconda3/etc/profile.d/conda.sh"
               else
                  export PATH="/truba/home/kullanici_adiniz/miniconda3/bin:$PATH"
               fi
            fi
            unset __conda_setup
            # <<< conda initialize <<<
            conda activate rstudio-env

4. Her bağlanıldığında bu oluşturtulan sanal ortam
   içerisinde bulunmak istemiyorsanız, bu basamağı atlayabilirsiniz. Eğer ev dizininizde ``.bash_profile`` dosyası yoksa dosyayı yaratın. Ayrıca ``.profile`` ve ``.bashrc`` dosyalarını sembolik olarak ``.bash_profile`` dosyasına aşağıdaki komutlar aracılığı ile bağlayabilirsiniz.

   .. code-block:: bash

      touch .bash_profile
      ln -s .bash_profile .profile
      ln -s .bash_profile .bashrc

Bu kurulum aşaması tamamlandıktan sonra, RStudio istemini :ref:`open_ondemand` tarafından gerçekleştrildiğinde OnDemand-RStudio oturumu otomatik olarak kurulan sanal
ortamdaki RStudio ile açılacaktır. R paketleri kullanıcının ``home`` dizininde miniconda altında yer almaktadır. Bunu RStudio konsolunda aşağıdaki komutu yazarak doğrulayabilirsiniz:

.. dropdown:: :octicon:`codespaces;1.5em;secondary` R kodları (Tıklayınız)
   :color: info   

   .. code-block:: r

      .libPaths()

      [1] "/truba/home/kullanici-adi/miniconda3/envs/rstudio-env/lib/R/library"

   .. code-block:: r

      sessionInfo()   
      
      R version 4.2.1 (2022-06-23)
      Platform: x86_64-conda-linux-gnu (64-bit)
      Running under: CentOS Linux 7 (Core)

      Matrix products: default
      BLAS/LAPACK: /truba/home/kulanici_adiniz/miniconda3/envs/r-kernel/lib/libopenblasp-r0.3.21.so

      locale:
      [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=tr_TR.UTF-8       
      [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=tr_TR.UTF-8    LC_MESSAGES=en_US.UTF-8   
      [7] LC_PAPER=tr_TR.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
      [10] LC_TELEPHONE=C             LC_MEASUREMENT=tr_TR.UTF-8 LC_IDENTIFICATION=C       

      attached base packages:
      [1] stats     graphics  grDevices utils     datasets  methods   base     

      loaded via a namespace (and not attached):
      [1] compiler_4.2.1 tools_4.2.1   


TRUBA-DESKTOP
~~~~~~~~~~~~~

TRUBA'da modül olarak bulunan diğer versiyonlarla
RStudio kullanmak isteyenler TRUBA-DESKTOP'a bağlanıp
uzak masaüstü içerisinde terminale aşağıdakiler yazılarak 
yapılabilir. 

.. code-block:: bash 

    module purge
    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64
    module load centos7.9/app/R/4.2.2-mkl-oneapi-2021.2
    rstudio

İstenilirse, burada sizlere gelen masaüstü ekranı üzerinden terminal açılarak RStudio için hazırlanmış ortam ``conda activate rstudio-env`` ile aktif edilir ve ``rstudio`` komudu ile arayüze ulaşabilirsiniz.

.. note::

    İstenilirse Jupyter araçları ile belirtilen R modülleri kullanabilir. Detayları :ref:`jupyter-anaconda` tarafında bulabilirsiniz.

.. _yuksek_performansli_islerin_yapilmasi:

Yüksek performanslı işlerin yapılması
-------------------------------------

1. RStudio arayüzü interaktif analizler için iyi bir çözümken, daha
   yüksek performans gerektiren hesaplama işleri için SLURM kaynak
   yöneticisinin kullanılması daha uygundur. :ref:`basic_slurm_commands` ve :ref:`slurm-betik`
   kılavuzları ile daha fazla bilgiye erişebilirsiniz. 

2. Bu tip kullanımlar için yazılan R betiğinin çıktılarını ya da çalışma ortamını (R workspace) kaydetmek
   gerekecektir. Kod içerisinde oluşturulacak veri objesini ``.rds``
   veya birden fazla veri objelerini ``.rda`` ya da ``.RData`` olarak kayıt edilebilir. Bu objeler daha sonra interaktif
   RStudio ortamında görselleştirme vb. amaçlarla kullanılabilir. Örnek kullanımlar

   - ``.rda``:
      * *save(obj1, obj2, file="/path/to/filename.rda")* ve yüklemek için *load("/path/to/filename.rda")* ile seçilmiş objeleri
      * *save.image("/path/to/workspace.rda")* ile bütün değişkenleri, verileri ve fonksiyonları saklanabilir ve yüklenebilir.

   - ``.rds``: *saveRDS(obj, file="/path/to/filename.rds") ve readRDS("/path/to/filename.rds")*
  

   Bahsedildiği gibi oluşturulan betikleri iş kümesine göndermeden önce
   işinize bağlı olarak küçük parametreler test etmek gerekebilir. Bu amaçla aşağıdaki kod ile ``debug``
   kuyruğundan 15 dakika boyunca her işte bir çekirdek kullanacak şekilde toplamda 10 iş 
   çalıştırılacak bir sunucu istenebilir. Böylece ana bilgisayarı meşgul etmeden hesaplama
   kümesinde size ayrılan bir terminalde işlem yürütebilirsiniz. ``srun``
   argümanları hakkında ayrıntılı bilgiyi
   `burada <%5Bhttps://slurm.schedmd.com/srun.html>`__ bulabilirsiniz.

   .. code-block:: bash
      
      srun -p debug -N1 -n10 -A kullanici_adi -time=00:15:00 --pty bash -i

3. R betiğinin beklenildiği gibi çalıştığından emin olduktan sonra bunu hesaplama
   kümesi için kuyruğa göndermek için aşağıdaki gibi ``.sh`` betiği oluşturup,
   ``sbatch`` komutu kullanılabilir. Detaylı bilgi için `ilgili
   kılavuzu <R-modules>`__
   takip edebilirsiniz.

   .. dropdown:: :octicon:`codespaces;1.5em;secondary` Slurm kodları (Tıklayınız)
      :color: info

      .. code-block:: slurm
         :caption: slurm_is_verme_R.sh

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


         # Eğer .bashrc dosyası ayarlandıysa, oturumun otomatik olarak rstudio-env ile açılacaktır.
         # Ancak emin olmak adına aşağıdakiler de eklenebilir

         # module purge
         # eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
         # conda activate rstudio-env

         # R calisma komutunuzu inputlariniz ile birlikte veriniz.
         R CMD BATCH R_script.R
         
         # İşiniz hakkında detaylı bilgiyi job_id.info dosyayına yazdırabiliriz.
         scontrol show job $SLURM_JOB_ID > ${SLURM_JOB_ID}.info

         exit

   
   Bu dosya daha sonra iş kümelerine aşağıdaki gibi gönderilebilir: 
   
   .. code-block::
      
      sbatch slurm_is_verme_R.sh


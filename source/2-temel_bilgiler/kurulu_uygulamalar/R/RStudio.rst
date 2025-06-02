.. _RStudio-kilavuzu:

======================
RStudio Kılavuzu
======================

Bu kılavuz RStudio kullanımı için
gerekli kurulumları yapmaya yardımcı olmak amacıyla oluşturulmuştur.
Kılavuzda aşağıdaki basamaklar anlatılmıştır:


.. grid:: 3

    .. grid-item-card::  :ref:`open-ondemand-ile-desktop-alma`
        :text-align: center
    .. grid-item-card:: :ref:`rstudio-baslatma`
        :text-align: center
    .. grid-item-card:: :ref:`yuksek_performansli_islerin_yapilmasi`
        :text-align: center

.. _open-ondemand-ile-desktop-alma:

Open OnDemand ile Masaüstü Alma
-------------------------------

Grafiksel arayüz kullanmak için, web tabanlı kullanıcı arayüzü olan :ref:`open_ondemand` tercih edilebilir. İnteraktif arayüz ile ilgili bağlantı bilgilerine :ref:`arf_baglanti` sayfasından erişebilirsiniz. 

Masaüstüne erişim için 5 aşamalı bir süreç uygulanmaktadır:

1. Web arayüzünden masaüstü menüsüne erişim:

   .. image:: /assets/RStudio-howto/images/desktop-alma.png
      
2. Gerekli kaynak talebi:

   .. image:: /assets/RStudio-howto/images/kaynak-talep-etme.png

3. Kuyrukta uygun kaynağın beklenmesi:

   .. image:: /assets/RStudio-howto/images/kuyruk-bekleme.png

4. Masaüstü başlatma:

   .. image:: /assets/RStudio-howto/images/desktop-baslatma.png

5. Terminal açma:

   .. image:: /assets/RStudio-howto/images/terminal-acma.png

Bundan sonra, `module av` komutu ile merkezi sistemdeki modüller listelenir ve `module load` komutu ile istenilen modül yüklenebilir. Eğer istenilen modül mevcut değilse, kullanıcının ev dizinine gerekli program kurulabilir.

.. _rstudio-baslatma:

RStudio Başlatma
----------------

:ref:`open-ondemand-ile-desktop-alma`  adımlarını takip ederek masaüstüne erişim sağlandıktan sonra, RStudio'nun başlatılması için aşağıdaki adımlar izlenmelidir:

1. Terminal penceresi açılması ve modüllerin yüklenmesi:

   .. image:: /assets/RStudio-howto/images/rstudio-module-yukleme.png

2. RStudio'nun başlatılması:
 
   .. image:: /assets/RStudio-howto/images/rstudio-calistirma.png


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
`burada <%5Bhttps://slurm.schedmd.com/srun.html>`__ bulabilirsiniz. :ref:`interaktif-is-calistirma` kılavuzu ile interaktif sunucuya bağlanma hakkında daha fazla bilgiye erişebilirsiniz.

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
         #SBATCH -n 54                                   # is icin toplamda kullanilacak cekirdek adeti.
         #SBATCH -N 1                                    # is icin kullanilacak sunucu sayisi.
         #SBATCH --time=01:00:00                         # isinizin suresi (1 saat)
         #SBATCH --workdir=/arf/scratch/kullanici_adi/test    # isinizi calistiracaginiz dizin, kendi kullanici kodunuz ile guncellemeniz gerekmektedir.
        


         # Eğer .bashrc dosyası ayarlandıysa, oturumun otomatik olarak rstudio-env ile açılacaktır.
         # Ancak emin olmak adına aşağıdakiler de eklenebilir

         # module purge
         # module load comp/python/miniconda3      
         # conda activate rstudio-env

         # R calisma komutunuzu inputlariniz ile birlikte veriniz.
         R CMD BATCH R_script.R
         
         # İşiniz hakkında detaylı bilgiyi job_id.info dosyayına yazdırabiliriz.
         scontrol show job $SLURM_JOB_ID > ${SLURM_JOB_ID}.info

         exit

   
   Bu dosya daha sonra iş kümelerine aşağıdaki gibi gönderilebilir: 
   
   .. code-block::
      
      sbatch slurm_is_verme_R.sh


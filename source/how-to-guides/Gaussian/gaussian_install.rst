======================================
TRUBA'da Gaussian Programının Kurulumu
======================================

Altyapıda Gaussian'ın farklı versiyonları sıkıntısız bir şekilde çalışmaktadır. En yüksek performansı almak için işin gönderileceği işlemciye uygun (Intel AVX, AVX2 ve AVX512) Gaussian versiyonunu kullanmak önemlidir. Aksi taktirde eski nesil işlemciler ile yeni nesil işlemciler üzerinde çalışan uygulamada sadece frekans hızından kaynaklı bir farklılık hissedilebilir. 

Gaussian'da (tüm versiyonları için) performansı (aynı zamanda diğer kullanıcıların işlerinin performansını) etkileyen bir diğer durum ise, işin çalışması sırasında oluşturulan geçici dosyaların hangi dizinde oluşturulacağıdır. **Gaussian yoğun biçimde I/O işlemleri yapan bir uygulamadır.** Bu nedenle geçici dosyalar kullanıcının ev dizininde değil, işin çalıştığı **hesaplama sunucusunun yerel /tmp dizininde** oluşturulmalıdır. Bu şekilde Gaussian'ın I/O işlemlerinden hem diğer kullanıcıların işleri etkilenmeyecek, hem de yerel disklerin erişim hızları yüksek olduğu için Gaussian'ın genel performansı yükselecektir. 

Aşağıda Gaussian programının **g16** versiyonunun TRUBA altyapısında derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip  ederek kurulumunu kendi ev dizininizde yapabilirsiniz. **g09** versiyonu aynı adımlar izlenerek kurulabilir.

--------------------
Uygulanacak adımlar:
--------------------

**1.** Gaussian'ın binary olarak dağıtılan bir paket program olduğu için, sadece arşiv paketini açmak kurulum için yeterlidir, herhangi bir derlemeye gerek bulunmamaktadır. Öncelikle kaynak kodunu kendi ev dizininize alınız. Kaynak kodu sıkıştırılmış dosya formatında (\*.tar veya \*.tar.gz vb.) olduğu için açmak için aşağıdaki komutlardan dosya formatınıza uygun olanı kullanınız.

.. code-block:: bash

 tar -xvf gaussian16.tar 
 tar -xvf gaussian16.tgz

**2.** Bu adımda programınızı çalıştıran g16 (executable) kodunun olduğu dizini (g16a3) kendi ev dizininize kopyalayarak adını g16 
olarak değiştirin.  


.. code-block:: bash

  /truba/home/kullaniciadi/ctafs/apps/gaussian/legacy_g16/g16a3
  cp -r g16a3 /truba/home/kullaniciadi/
  mv g16a3 g16

**3.** Programı kullanmak için bazı çevre değişkenleri tanımlanmalıdır. Bu tanımlar .profile (yada .bashrc ) dosyasının içinde yapılabileceği gibi slurm dosyasının içerisinde de yapılabilir.

---------------------------------
 .bashrc Dosyasının Oluşturulması 
---------------------------------

Bu bölümde .bashrc dosyasının oluşturularak programı çalıştırma işlemi gösterilecektir. İlk olarak terminalinizden ~/.bashrc dosyanınızı herhangi bir editör yardımıyla açınız.

.. code-block:: bash

  emacs -nw ~/.bashrc   # Bu kod satırı **emacs** editör kullanılarak .bashrc dosyanızı açar. Siz de vi ya da nano gibi editörlerle aynı işlemi uygulayabilirsiniz. 
 
Dosyanın içerisine aşağıdaki komutları yazınız.

.. code-block:: bash

  export g16root=/truba/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp
  . $g16root/g16/bsd/g16.profile

.. warning:: 

  **.bashrc** dosyanızın hemen aktif olması için ``source ~/.bashrc`` komutunu uygulayınız.

Programı çalıştırmak için ``$g16root/g16/g16 <jobname.gjf>> out &`` komutunu giriniz.

--------------------------------------
SLURM Betik Dosyasının Oluşturulması 
--------------------------------------

Slurm dosyası oluşturmak için aşağıdaki komut satırlarını kendi işinize göre uyarlayarak kopyalayınız. 

Barbun kümesi için örnek SLURM betik dosyası
----------------------------------------------

Gaussian09-barbun.slurm
^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p mid2
  #SBATCH -A kullaniciadi
  #SBATCH --constraint=barbun
  #SBATCH -J jobname
  #SBATCH --nodes=1
  #SBATCH --ntasks-per-node=20
  #SBATCH --time=2-12:00:00
  #SBATCH --workdir=/truba/scratch/kullaniciadi/hesaplama_yapilan_dizin
  #SBATCH --output=jobname.out
  #SBATCH --error=slurm-%j.err

  export g09root=/truba/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp/$SLURM_JOB_USER/g16.$SLURM_JOB_ID
  . $g09root/g09/bsd/g09.profile

  if [ -d "$GAUSS_SCRDIR" ]
  then
  rm -rf $GAUSS_SCRDIR
  else
  mkdir $GAUSS_SCRDIR
  fi

  $g09root/g09/g09 < /truba/scratch/kullaniciadi/hesaplama_yapilan_dizin/jobname.gjf
  
  rm -rf $GAUSS_SCRDIR

  exit

Hamsi kümesi için örnek SLURM betik dosyası
----------------------------------------------

Gaussian09-hamsi.slurm

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p hamsi
  #SBATCH -A kullaniciadi
  #SBATCH -J jobname
  #SBATCH --nodes=1
  #SBATCH --ntasks-per-node=28
  #SBATCH --time=12:00:00
  #SBATCH --workdir=/truba/scratch/kullaniciadi/hesaplama_yapilan_dizin
  #SBATCH --output=jobname.out
  #SBATCH --error=slurm-%j.err

  export g09root=/truba/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp/$SLURM_JOB_USER/g16.$SLURM_JOB_ID
  . $g09root/g09/bsd/g09.profile

  if [ -d "$GAUSS_SCRDIR" ]
  then
  rm -rf $GAUSS_SCRDIR
  else
  mkdir $GAUSS_SCRDIR
  fi

  $g09root/g09/g09 < /truba/scratch/kullaniciadi/hesaplama_yapilan_dizin/jobname.gjf

  rm -rf $GAUSS_SCRDIR

  exit


.. note::

  Farklı kümelerde hesap yaparken (örneğin sardalya kümesi için) ``#SBATCH --constraint=barbun`` satırındaki barbun kısmını değiştirebilirsiniz (``#SBATCH --constraint=sardalya``) Diğer kümelerdeki minimum çekirdek sayıları için https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/hesaplamakumeleri.html ziyaret ediniz. 

  ``#SBATCH --time=12:00:00`` satırını daha uzun süreli hesaplarınız için saat yerine gün olarak ``#SBATCH --time=2-00:00:00`` (2 gün) şeklinde değiştirebilirsiniz. 

  Süreyi ve hesaplama kümesini kurallar dahilinde değiştirebilirsiniz: 
  https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/hesaplamakumeleri.html#kuyruklar-partitions

  ``#SBATCH --workdir=/truba/scratch/kullaniciadi`` hesaplama_yapilan_dizin satırını hesap yaptığınız dizine göre değiştirmelisiniz. Hesap yaptığınız dizini öğrenmek için terminalde ``pwd`` komutunu kullanabilirsiniz.

  export g09root=/truba/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp/$SLURM_JOB_USER/g16.$SLURM_JOB_ID
  . $g09root/g09/bsd/g09.profile

  export g09root=/truba/home/kullaniciadi satırındaki /truba/home/kullaniciadi kısmını g09 yazılımının bulunduğu dizine göre düzenlemeniz gerekmektedir. 

  . $g09root/g09/bsd/g09.profile g09.profile bulunduğu dizinin yerini veriniz.  

  /truba/scratch/kullaniciadi/hesaplama_yapilan_dizin/jobname.gjf satırındaki .gjf uzantılı dosya yerine com uzantılı dosya kullanılıyorsa  .com şeklinde değiştirilmelidir.


Yukarıdaki SLURM betik dosyasını oluşturduktan sonra ``sbatch job.slurm`` komutu ile işlerinizi çalıştırabilirsiniz.

.. warning:: 

  **g09** versiyonu benzer adımlar izlenerek kurulabilir. g16 kurulumundan farklı olarak: Arşivden çıkan dosya direkt g09 dizinini çıkartır. Bu nedenle yukarıda gösterilen 2. adımı uygulamanıza gerek yoktur.Yukarıdaki adımlardan farklı olarak yapmanız gereken ilgili komut satırlarının **g16** yerine **g09** ile değiştirilmesidir.
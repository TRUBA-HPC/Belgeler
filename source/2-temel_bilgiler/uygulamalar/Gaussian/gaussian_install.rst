
.. grid:: 3

    .. grid-item-card::  :ref:`gaussian-kurulum`
        :text-align: center
    .. grid-item-card:: :ref:`development_cagrisi`
        :text-align: center
    .. grid-item-card:: :ref:`arf-g16-kilavuzu`
 
.. _gaussian-kurulum:

======================================
Gaussian Programının Kurulumu
======================================

Altyapıda Gaussian'ın farklı versiyonları sıkıntısız bir şekilde çalışmaktadır. En yüksek performansı almak için işin gönderileceği işlemciye uygun (Intel AVX, AVX2 ve AVX512) Gaussian versiyonunu kullanmak önemlidir. Aksi taktirde eski nesil işlemciler ile yeni nesil işlemciler üzerinde çalışan uygulamada sadece frekans hızından kaynaklı bir farklılık hissedilebilir. 

Gaussian'da (tüm versiyonları için) performansı (aynı zamanda diğer kullanıcıların işlerinin performansını) etkileyen bir diğer durum ise, işin çalışması sırasında oluşturulan geçici dosyaların hangi dizinde oluşturulacağıdır. **Gaussian yoğun biçimde I/O işlemleri yapan bir uygulamadır.** Bu nedenle geçici dosyalar kullanıcının ev dizininde değil, işin çalıştığı **hesaplama sunucusunun yerel /tmp dizininde** oluşturulmalıdır. Bu şekilde Gaussian'ın I/O işlemlerinden hem diğer kullanıcıların işleri etkilenmeyecek, hem de yerel disklerin erişim hızları yüksek olduğu için Gaussian'ın genel performansı yükselecektir. 

Aşağıda Gaussian programının **g16** versiyonunun TRUBA altyapısında derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip  ederek kurulumunu kendi ev dizininizde yapabilirsiniz. **g09** versiyonu aynı adımlar izlenerek kurulabilir.

--------------------
Uygulanacak Adımlar
--------------------

Kurulum, preprocess gibi işlemlerinizi arf-ui kullanıcı arayüzünde gerçekleştirmemeniz gerekmektedir. Aşağıdaki komut ile inteaktif shell alarak gerçekleştirmelisiniz.

.. code-block:: bash

  srun -n 1 -N 1 -p debug --time=30:00 --pty /bin/bash -i


**1.** Gaussian'ın binary olarak dağıtılan bir paket program olduğu için, sadece arşiv paketini açmak kurulum için yeterlidir, herhangi bir derlemeye gerek bulunmamaktadır. Öncelikle kaynak kodunu kendi ev dizininize alınız. Kaynak kodu sıkıştırılmış dosya formatında (\*.tar veya \*.tar.gz vb.) olduğu için açmak için aşağıdaki komutlardan dosya formatınıza uygun olanı kullanınız.

.. code-block:: bash

 tar -xvf gaussian16.tar 
 tar -xvf gaussian16.tgz

**2.** Bu adımda programınızı çalıştıran g16 (executable) kodunun olduğu dizini (g16a3) kendi ev dizininize kopyalayarak adını g16 
olarak değiştirin.  


.. code-block:: bash

  /arf/home/kullaniciadi/ctafs/apps/gaussian/legacy_g16/g16a3
  cp -r g16a3 /arf/home/kullaniciadi/
  mv g16a3 g16

**3.** Programı kullanmak için bazı çevre değişkenleri tanımlanmalıdır. Bu tanımlar .profile (ya da .bashrc ) dosyasının içinde yapılabileceği gibi slurm dosyasının içerisinde de yapılabilir.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .bashrc Dosyasının Oluşturulması 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu bölümde .bashrc dosyasının oluşturularak programı çalıştırma işlemi gösterilecektir. İlk olarak terminalinizden ~/.bashrc dosyanınızı herhangi bir editör yardımıyla açınız.

.. code-block:: bash

  emacs -nw ~/.bashrc   # Bu kod satırı **emacs** editör kullanılarak .bashrc dosyanızı açar. Siz de vi ya da nano gibi editörlerle aynı işlemi uygulayabilirsiniz. 
 
Dosyanın içerisine aşağıdaki komutları yazınız.

.. code-block:: bash

  export g16root=/arf/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp
  . $g16root/g16/bsd/g16.profile

.. warning:: 

  **.bashrc** dosyanızın hemen aktif olması için ``source ~/.bashrc`` komutunu uygulayınız.

Programı çalıştırmak için ``$g16root/g16/g16 <jobname.gjf>> out &`` komutunu giriniz.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
SLURM Betik Dosyasının Oluşturulması 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Slurm dosyası oluşturmak için aşağıdaki komut satırlarını kendi işinize göre uyarlayarak kopyalayınız. 

.. _arf-g16-kilavuzu:

============================================================
ARF Hesaplama Kümesinde Gaussian 16 Programının Kullanılması
============================================================

`Gaussian'ın sayfasında <http://gaussian.com/>`_ verilen kullanıcı el kitabına aşağıdaki linkten ulaşarak ilgili program ve de kullanımı hakkında detaylı bilgilere ulaşabilirsiniz.

* `Gaussian 16 El Kitabı <http://gaussian.com/man/>`_

Mevcut durumda TRUBA'daki ARF hesaplama kümesinde ilgili lisanslı Gaussian programları kullanılabilmektedir.

* ARF kümesine bağlantı için :ref:`arf_baglanti` sayfasını inceleyebilirsiniz.

Terminalden ARF kümesine arf-ui1 veya arf-ui2 kullanıcı arayüzü üzerinden bağlantı sağladıktan sonra  

.. code-block:: bash

    module available

komutunu yazdığınızda ARF kümesinde kurulu olan temel programlar listelenecektir. 


Özel olarak sadece Gaussian programına ait modülleri görüntülemek isterseniz terminalde

.. code-block:: bash

    module avail |& grep gaussian

veya

.. code-block:: bash

    module avail 2>&1 | grep gaussian

komutlarından birisini yazabilirsiniz.


Gaussian 16 programına erişimi tanımlı olan araştırmacılar kendi kullanıcı dizinlerinde bir çalışma klasörü yaratarak aşağıdaki örnek SLURM betik dosyasını ilgili klasörde oluşturarak sistemde çalışmak üzere submit edebilirler.

.. code-block:: bash

    mkdir g16-test
    cd g16-test
    touch gaussian16-orfoz.slurm    #*.slurm uzantılı bos bir text dosyası olusturmak icin


--------------------------------------
SLURM Betik Dosyasının Oluşturulması 
--------------------------------------

Aşağıda örnek olarak verilen SLURM betik dosyasında 

.. code-block:: bash

    apps/gaussian/g16-avx

modülü kullanımıştır. Özellikle büyük ve karmaşık moleküler sistemlerin modellenmesi üzerine çalışan araştırmacılarımızın zaman etkin sonuçlar alabilmesi amacıyla 

.. code-block:: bash

    apps/gaussian/g16-avx2
    
modülünü kullanmaları önerilir. 

`AVX, AVX2 ve diğer binary versiyonlar arasındaki temel farklar hakkındaki bilgiye erişmek için lütfen tıklayınız <https://gaussian.com/g16/g16_plat.pdf>`_ 

.. tabs::

    .. tab:: orfoz

        .. code-block:: bash

            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 55   # orfoz sunucularinda node basina 55 veya 110 cekirdek talep edilebilir. 
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            module purge
            module load apps/gaussian/g16-avx

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
            source $g16root/g16/bsd/g16.profile
            
            if [ -d "$GAUSS_SCRDIR" ]
            then
            rm -rf $GAUSS_SCRDIR
            else
            mkdir -p $GAUSS_SCRDIR
            fi

            $g16root/g16/g16 < g16input_file.gjf

            rm -rf $GAUSS_SCRDIR

            exit

    .. tab:: hamsi

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p hamsi
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 54   # hamsi sunucularinda node basina 54 cekirdek talep edilebilir. 
            #SBATCH -C weka
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            module purge
            module load apps/gaussian/g16-avx

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
            source $g16root/g16/bsd/g16.profile
            
            if [ -d "$GAUSS_SCRDIR" ]
            then
            rm -rf $GAUSS_SCRDIR
            else
            mkdir -p $GAUSS_SCRDIR
            fi

            $g16root/g16/g16 < g16input_file.gjf

            rm -rf $GAUSS_SCRDIR

            exit

    .. tab:: barbun

        .. code-block:: bash
      
            #!/bin/bash
            #SBATCH -p barbun
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 20   # barbun sunucularinda 20 ve katlari olacak sekilde cekirdek talep edilebilir. 
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            module purge
            module load apps/gaussian/g16-avx

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
            source $g16root/g16/bsd/g16.profile
            
            if [ -d "$GAUSS_SCRDIR" ]
            then
            rm -rf $GAUSS_SCRDIR
            else
            mkdir -p $GAUSS_SCRDIR
            fi

            $g16root/g16/g16 < g16input_file.gjf

            rm -rf $GAUSS_SCRDIR

            exit



İlgili SLURM betik dosyasını kendi kullanıcı dizininizde yer alan çalışma klasörünüzde düzenledikten sonra

.. code-block:: bash

    sbatch gaussian16.slurm

komutu ile sisteme submit edebilirsiniz.

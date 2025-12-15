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

.. note:: 

    Kurulum, preprocess gibi işlemlerinizi arf-ui kullanıcı arayüzünde gerçekleştirmemeniz gerekmektedir. Aşağıdaki komut ile interaktif shell alarak gerçekleştirmelisiniz.

    .. code-block:: bash

        srun -n 1 -N 1 -p debug --time=30:00 --pty /bin/bash -i


**1.** Gaussian, binary olarak dağıtılan bir paket program olduğu için, sadece arşiv paketini açmak kurulum için yeterlidir, herhangi bir derlemeye gerek bulunmamaktadır. Öncelikle kaynak kodunu kendi ev dizininize (``/arf/home/kullaniciadi``) kopyalayınız. Kaynak kodu sıkıştırılmış dosya formatında (\*.tar veya \*.tar.gz vb.) olduğundan dolayı açmak için aşağıdaki komutlardan dosya formatınıza uygun olanı kullanınız.

.. code-block:: bash

 tar -xvf gaussian16.tar 

veya

.. code-block:: bash

 tar -xvf gaussian16.tgz

**2.** Bu adımda programınızı çalıştıran g16 (executable) kodunun olduğu dizini (örneğin; ``g16a3``)  kendi ev dizininize kopyalayarak adını ``g16`` olarak değiştiriniz.

Örneğin; ``/arf/home/kullaniciadi/apps/gaussian/legacy_g16/g16a3`` dizininde ``g16a3`` adlı dizin altında g16 kodu bulunmaktadır. Aşağıdaki komutları kullanarak kendi ev dizininize kopyalayınız ve adını ``g16`` olarak değiştiriniz.

.. code-block:: bash

    cd /arf/home/kullaniciadi/apps/gaussian/legacy_g16
    cp -r g16a3 /arf/home/kullaniciadi/
    mv g16a3 g16

**3.** Programı kullanmak için bazı çevre değişkenleri tanımlanmalıdır. Bu tanımlar ``.profile`` (ya da ``.bashrc`` ) dosyasının içinde yapılabileceği gibi SLURM dosyasının içerisinde de yapılabilir.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.bashrc Dosyasının Oluşturulması 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bu bölümde .bashrc dosyasının oluşturularak programı çalıştırma işlemi gösterilecektir. İlk olarak terminalinizden ~/.bashrc dosyanınızı herhangi bir editör (vim, nano, emacs vb.) yardımıyla açınız.

.. code-block:: bash

  emacs -nw ~/.bashrc   

Yukarıdaki kod satırı **emacs** editör kullanılarak .bashrc dosyanızı açar. Siz de vi ya da nano gibi editörlerle aynı işlemi uygulayabilirsiniz. 
 
Dosyanın içerisine aşağıdaki komutları yazınız.

.. code-block:: bash

  export g16root=/arf/home/kullaniciadi
  export GAUSS_SCRDIR=/tmp
  . $g16root/g16/bsd/g16.profile

.. warning:: 

  **.bashrc** dosyanızın hemen aktif olması için ``source ~/.bashrc`` komutunu uygulamanız gerekmektedir.

.. warning:: 

  **g09** versiyonu benzer adımlar izlenerek kurulabilir. g16 kurulumundan farklı olarak: Arşivden çıkan dosya direkt g09 dizinini çıkartır. Bu nedenle yukarıda gösterilen 2. adımı uygulamanıza gerek yoktur.Yukarıdaki adımlardan farklı olarak yapmanız gereken ilgili komut satırlarının **g16** yerine **g09** ile değiştirilmesidir.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
SLURM Betik Dosyasının Oluşturulması 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SLURM dosyası oluşturmak için aşağıdaki komut satırlarını lütfen kendi işinize ve g16 binary dosyasının yer aldığı dizine göre uyarlayarak güncelleyiniz. 

.. tabs::

    .. tab:: orfoz

        .. code-block:: bash

            #!/bin/bash
            #SBATCH -p orfoz
            #SBATCH -A kullanici_adi
            #SBATCH -J jobname
            #SBATCH -N 1
            #SBATCH -n 1
            #SBATCH -c 56
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            export g16root=/arf/home/kullaniciadi
            . $g16root/g16/bsd/g16.profile

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
          
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
            #SBATCH -c 56
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            export g16root=/arf/home/kullaniciadi
            . $g16root/g16/bsd/g16.profile

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
            
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
            #SBATCH -c 40   # barbun sunucularinda node basina 40 cekirdek talep edilebilir 
            #SBATCH --time=3-00:00:00
            #SBATCH --output=jobname.out
            #SBATCH --error=slurm-%j.err

            echo "SLURM_NODELIST $SLURM_NODELIST"
            echo "NUMBER OF TASKS $SLURM_NTASKS"
            echo "NUMBER OF CORES=$SLURM_CPUS_PER_TASK"

            export g16root=/arf/home/kullaniciadi
            . $g16root/g16/bsd/g16.profile

            export GAUSS_SCRDIR=/tmp/$SLURM_JOB_ID
            
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

komutu ile Gaussian işinizi sisteme submit edebilirsiniz.

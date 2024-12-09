.. _arf-g16-kilavuzu:

===========================================================
ARF Hesaplama Kümesinde Gaussian 16 Programının Kullanılması
===========================================================

`Gaussian'ın sayfasında <http://gaussian.com/>`_ verilen kullanıcı el kitabına aşağıdaki linkten ulaşarak ilgili program ve de kullanımı hakkında detaylı bilgilere ulaşabilirsiniz.

* `Gaussian 16 El Kitabı <http://gaussian.com/man/>`_

Mevcut durumda TRUBA'daki ARF hesaplama kümesinde ilgili lisanslı Gaussian programları kullanılabilmektedir.

* ARF kümesine bağlantı için :ref:`arf-baglanti` sayfasını inceleyebilirsiniz.

Terminalden ARF kümesine arf-ui1 veya arf-ui2 kullanıcı arayüzü üzerinden bağlantı sağladıktan sonra  

.. code-block:: bash

    module available

komutunu yazdığınızda ARF kümesinde kurulu olan temel programlar listelenecektir. 

.. image:: /assets/gaussian/terminal-module.png
   :align: center
   :width: 900px

İlgili programlar arasında Gaussian için aşağıdaki modüllerin de listede yer aldığını göreceksiniz:


.. code-block:: bash

    apps/gaussian/g16-avx
    apps/gaussian/g16-avx2
    apps/gaussian/g16-legacy
    apps/gaussian/g16-sse4.2
    apps/gaussian/gview

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

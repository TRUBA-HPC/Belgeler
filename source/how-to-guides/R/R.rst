.. _R-modules:

===
R
===

Bu belge TRUBA altyapısında `R <https://www.r-project.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.
Bu kılavuz aşağıdakileri kapsamaktadır:

.. grid:: 4

    .. grid-item-card::  :ref:`TRUBA-r-modulleri`
        :text-align: center
    .. grid-item-card:: :ref:`r-paket-kurulum`
        :text-align: center
    .. grid-item-card:: :ref:`terminalde-r-ile-calismak`
        :text-align: center
    .. grid-item-card:: :ref:`slurm-r-paralellestirme`
        :text-align: center
    .. grid-item-card::  :ref:`is-dizileri-job-array`
        :text-align: center
    .. grid-item-card:: :ref:`benchmark-sonuclari`
        :text-align: center
    .. grid-item-card:: :ref:`islerin-takibi`
        :text-align: center
    .. grid-item-card:: :ref:`sorunlar-cozumler`
        :text-align: center
.. _TRUBA-r-modulleri:

TRUBA'da R Modülleri
--------------------
R işlerini çalıştırabilmek için öncelikle modülleri yüklememiz gerekir.
Centos 7.9 sistemimizde gcc ve intel ile derlenmiş iki farklı R versiyonu bulunmaktadır.

TRUBA'da bulunan modülleri görmek için 

.. code-block:: bash

    module avail -t 2>&1 | grep -i centos7.9/app/R

Sisteminize gcc ve intel versiyonlarını modül olarak kullanmak için aşağıdaki kod parçacıkları yazılır.

.. tabs::

    .. tab:: GCC

        .. code-block:: bash

            module purge
            module load centos7.9/comp/gcc/7
            module load centos7.9/app/R/4.2.2-gcc-7

    .. tab:: Intel

        .. code-block:: bash
    
            module purge
            source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64
            module load centos7.9/app/R/4.2.2-mkl-oneapi-2021.2


İş vermeden önce kullanılmak istenilen R paketlerini kullanılacak dizine kurmanızı öneririz.
Yoğunluğa sebep vermemek ve hesabınızın askıya alınmaması için paket kurulumlarınızı *barbun1* arayüzünde gerçekleştirmeniz tavsiye edilir. O halde işleri SLURM'a vermeden önce şu adımları takip edebiliriz:
*levrek1* kullanıcı arayüzünde iken 

.. code-block:: bash

    ssh barbun1 

ile *barbun1* sunucusuna geçiş yapılır. *barbun1* sunucusu içinde iken yukarıda belirtildiği gibi modüller yüklendikten sonra terminale şunu yazdığımızda 

.. code-block:: r

    R --vanilla

R çalışmaya başlar ve paket kurulum aşamasına geçebiliriz.

.. _r-paket-kurulum:

R paketi kurulum
------------------
Paketleri kurmadan önce hangi repoyu kullanacağını belirtebiliriz. 
Sonrasında, diyelim ki kaynak kodlu paketleri kurmak için kullanılan ``remotes``
R paketini kurmak istiyoruz. Kullanıcı ev dizininizde ilk R paketi kurduğunuzda karşınıza 
"is not writable" uyarısı ve kişisiel kütüphane oluşturmak için öneri alacaksınız.
Bu durumda iki defa ``yes`` yazdıktan sonra paketiniz kurulum aşamasına geçecektir. 

.. code-block:: r
    
    chooseCRANmirror(ind=69)
    install.packages("remotes")
    Warning in install.packages("remotes") :
    'lib = "/truba/sw/centos7.9/app/R/4.2.2/lib64/R/library"' is not writable
    Would you like to use a personal library instead? (yes/No/cancel) yes
    Would you like to create a personal library
    ‘~/R/x86_64-pc-linux-gnu-library/4.2’
    to install packages into? (yes/No/cancel) yes

Varsayalım ki ``~libs/R_libs`` dizini altına R paketlerini kurmak istiyoruz. Bu durumda öncelikle ``mkdir -p ~libs/R_libs`` ile klasör oluşturulur. 
R içinde iken ``.libPaths()`` çalıştırıldığında aktif olan kütüphane dizinlerini listeleyebilir ve ``.libPaths("path/to/libs")`` ile de istenilen klasör aktif olarak eklenir. İstediğimiz paketi istediğimiz yerden çağırmak için 

.. code-block:: r
    
    library(packagename, lib.loc="~/libs/R_libs")

yazabiliriz. Paket kurmak istediğimizde ise 

.. code-block:: r 
    
    install.packages("packagename", lib="~/libs/R_libs")

ile paket istenilen yere kurulmuş olur. Ayrıca var olan paketin bulunduğu dizinleri bulmak için ``find.package("packagename")`` kullanılabilir.

İstenilirse R için kullanılacak kütüphanenin dizini ``.bashrc`` dosyasında belirtilebilinir. 

.. code-block:: bash

    export R_LIBS_USER=/path/to/R_libs

HPC Paketler
~~~~~~~~~~~~

HPC'de sıklıkla kullanılan R paketlerini 
`buradan <https://cran.r-project.org/web/views/HighPerformanceComputing.html>`_ bulabilirsiniz.
Mesela, R'da MPI işleri için yazılan Rmpi paketi kurmak isteyelim.
Rmpi'yi kümeye yüklemek için, gcc ile derlenmiş R başlatılmadan önce uygun MPI modülünün yüklenmesi gerekir.

.. code-block:: bash

    module purge
    module load centos7.9/comp/gcc/7
    module load centos7.9/lib/openmpi/4.1.5-gcc-7
    module load centos7.9/app/R/4.2.2-gcc-7
    R --vanilla -q 

Bu adımdan sonra R çağrılmış olacak ve paket kurma adımları ile devam edebiliriz.

.. code-block:: r
    
     chooseCRANmirror(ind=66)
     install.packages("Rmpi",
      configure.args="
      --with-Rmpi-include=/truba/sw/centos7.9/lib/openmpi/4.1.5-gcc-7/include
      --with-Rmpi-libpath=/truba/sw/centos7.9/lib/openmpi/4.1.5-gcc-7/lib 
      --with-Rmpi-type=OPENMPI
      ")   

.. warning:: 

    Rmpi paketi yüklenirken kullanılan OpenMPI ile iş verirken modül olarak yüklediğiniz versiyon aynı olması gerekmektedir. Rmpi paketi *barbun* ve *hamsi* hesaplama kümelerinde uyumlu çalışmaktadır.

Kaynak kod kullanılarak Rmpi paketini ``~/libs/R_libs`` dizi altına kurmak isterseniz, öncelikle ``cran`` 'dan paketin tar.gz dosyası indirilir ve ``R CMD INSTALL`` kullanılarak kurulabilir.

.. code-block:: bash
     
    wget https://cran.r-project.org/src/contrib/Rmpi_0.7-1.tar.gz

    R CMD INSTALL --library=~/libs/R_libs --configure-args="--with-Rmpi-include=/truba/sw/centos7.9/lib/openmpi/4.1.5-gcc-7/include --with-Rmpi-libpath=/truba/sw/centos7.9/lib/openmpi/4.1.5-gcc-7/lib --with-Rmpi-type=OPENMPI" Rmpi_0.7-1.tar.gz


.. _ornek_MPI_rmpi:
   
**Örnek MPI çalışması**

Bir den fazla MPI işleri için tek sunucu içerisinde birden fazla iş çalıştırılabileceği gibi birden fazla sunucu içerisinde de dağıtılabilir. :ref:`slurm-r-paralellestirme` içerisinde örnek çalışmalar mevcuttur. Genel anlamda MPI teriminde master, bazı görevleri tamamlamak için ``slave`` adı verilen bağımlı çekirdeklere mesajlar gönderen ana çekirdektir. Rmpi paketi içinde ``mpi.spawn.Rslaves()`` kullanarak `slave`'leri oluşturduğunuzda, ilk etapta varsayılan ayar olarak talep edilen mevcut çekirdek sayısını alır. MPI için kullanmak istediğiniz belirli çekirdek sayısını tanımlamak için ``nslaves=x`` seçeneğini kullanabilirsiniz. Master için bir çekirdek (genelde rank 0) tahsis edilip geriye kalan çekirdekler hesaplama için kullanılmaktadır. Bu süreci daha düzgün yönetebilmek adına ``mpi.universe.size()`` ile elde edilen mevcut çekirdek sayısından bir eksiği kadar olan çekirdek sayısını kullanarak istenilen çekirdekler kullanılabilir. Daha fazla detay için `ilgili sayfaya <https://cran.r-project.org/web/packages/Rmpi/index.html>`_ bakabilirsiniz. 

Aşağıda, 5 tane MPI işi için talep edilen aynı sunucu içerisindeki 5 tane çekirdeğin her biri için *rank* ve *size* bilgileri içeren R ve kuyruğa göndermek için SLURM dosyasını örnek alabilirsiniz. Ayrıca, master iş üzerinden diğer 4 çekirdeğe ``rnorm(10)`` işi ``mpi.remote.exec()`` fonksiyonu ile gönderilmiş ve çıktıları bir *data frame* olarak master çekirdeğe kayıt edilmiştir.  

.. dropdown:: :octicon:`codespaces;1.5em;secondary` R ve SLURM dosyası (Tıklayınız)
    :color: info

    .. tab-set:: 
        .. tab-item:: test_mpi.R

            .. code-block:: r

                library("Rmpi")
                sprintf("MPI şleri için toplam çekirdek sayısı: %i", mpi.universe.size())
                ntotalslaves <- mpi.universe.size() - 1
                sprintf("Master sunucu hariç toplam  %i slaves açılabilir", ntotalslaves)
                mpi.spawn.Rslaves(nslaves=ntotalslaves)
                ###############################
                mpi.remote.exec( paste("I am",mpi.comm.rank(),"of", mpi.comm.size()))

                # Her çekirdeğe bağımsız olarak aynı anda  rnorm(10) fonksiyonu göndermek ve
                # çıktısını data frame olarak kayıt etmek için

                x<-mpi.remote.exec(cmd=rnorm,10)

                x
                ##############################
                mpi.close.Rslaves()
                mpi.quit()

        .. tab-item:: test_mpi.slurm

            .. code-block::

                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --partition=debug
                #SBATCH --constraint=barbun
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH	--time=00:15:00
                #SBATCH	--job-name=test
                #SBATCH --ntasks=5
                #SBATCH --nodes=1
                #SBATCH	--cpus-per-task=1

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                module load centos7.9/lib/openmpi/4.1.5-gcc-7
                module load centos7.9/app/R/4.2.2-gcc-7

                # btl_openib_allow_ib ile sunucular arası infiniband bağlantısı olduğu belirtilir.
                # fork() uyarısı almamak adına mpi_warn_on_fork false yapılabilir.
                mpirun -n 1 --mca btl_openib_allow_ib true --mca mpi_warn_on_fork 0 R CMD BATCH --vanilla test_mpi.R

                exit

        .. tab-item:: test_mpi.Rout

            .. code-block:: 

                R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
                Copyright (C) 2022 The R Foundation for Statistical Computing
                Platform: x86_64-pc-linux-gnu (64-bit)

                R is free software and comes with ABSOLUTELY NO WARRANTY.
                You are welcome to redistribute it under certain conditions.
                Type 'license()' or 'licence()' for distribution details.

                Natural language support but running in an English locale

                R is a collaborative project with many contributors.
                Type 'contributors()' for more information and
                'citation()' on how to cite R or R packages in publications.

                Type 'demo()' for some demos, 'help()' for on-line help, or
                'help.start()' for an HTML browser interface to help.
                Type 'q()' to quit R.

                > library(Rmpi)
                > sprintf("MPI şleri için toplam çekirdek sayısı: %i", mpi.universe.size())
                [1] "MPI şleri için toplam çekirdek sayısı: 5"
                > ntotalslaves <- mpi.universe.size() - 1
                > sprintf("Master sunucu hariç toplam  %i slaves açılabilir", ntotalslaves)
                [1] "Master sunucu hariç toplam  4 slaves açılabilir"
                > mpi.spawn.Rslaves(nslaves=ntotalslaves)
                    4 slaves are spawned successfully. 0 failed.
                master (rank 0, comm 1) of size 5 is running on: barbun21
                slave1 (rank 1, comm 1) of size 5 is running on: barbun21
                slave2 (rank 2, comm 1) of size 5 is running on: barbun21
                slave3 (rank 3, comm 1) of size 5 is running on: barbun21
                slave4 (rank 4, comm 1) of size 5 is running on: barbun21
                > ###############################
                > mpi.remote.exec( paste("I am",mpi.comm.rank(),"of", mpi.comm.size()))
                $slave1
                [1] "I am 1 of 5"

                $slave2
                [1] "I am 2 of 5"

                $slave3
                [1] "I am 3 of 5"

                $slave4
                [1] "I am 4 of 5"

                >
                > # Her çekirdeğe bağımsız olarak aynı anda  rnorm(10) fonksiyonu göndermek ve
                > # çıktısını data frame olarak kayıt etmek için
                >
                > x<-mpi.remote.exec(cmd=rnorm,10)
                >
                > x
                            X1         X2          X3          X4
                1  -2.132664460 -0.8432298 -0.33385398  1.37359227
                2   1.239282805 -1.6678905  2.53662146 -0.01688626
                3  -0.422106771  2.1799427 -0.05482666 -0.09163513
                4   0.943984186 -2.2284997 -1.14711907 -1.90560222
                5  -1.398988653  0.6544200  0.50693274  1.03411686
                6  -0.573611598 -0.3727489 -0.33978203  0.35506209
                7  -0.953274336 -1.0387477  0.79627835  2.28846078
                8   0.644383745  0.5777544  0.07857582 -2.12907425
                9   0.049157198  1.0551450 -0.64556348 -0.92635345
                10  0.000487631  0.4441380 -0.64147467 -0.55125029
                > ##############################
                > mpi.close.Rslaves()
                [1] 1
                > mpi.quit()







.. _terminalde-r-ile-calismak:

Terminalde R ile çalışmak
----------------------------
Komut satırında R ile temelde iki farklı şekilde çalışabilinir. R betiklerini çalıştırırken kullanılan 
daha fazla parametre detayları için
`ilgili sayfayı <https://cran.r-project.org/doc/manuals/R-intro.html#Invoking-R-from-the-command-line>`_ ziyaret edebilirsiniz.

.. code-block:: bash

    # Çıktı olarak my_R_Script.Rout'sını çalışma dizinine kayıt eder.
    R CMD BATCH R_script.R
    # Terminal içinde çıktıları yazar.
    Rscript R_script.R
    # Terminal içinde çıktıları yazar.
    Rscript R_script.R > R_script.Rout

.. _slurm-r-paralellestirme:

R, SLURM ve Paralelleştirme
---------------------------

Yüksek performans elde edebilmek için kaynaklara ihtiyaç bulunmaktadır. Bu kaynakları etkili şekilde kutlanmak yüksek başarımlı hesaplama alanları içinde önem arz etmektedir. R ortamının kendisi paralelleştirilmemiş olduğunu dikkate aldığımızda vektörel işlemler ya da paralelleştirme için özel paketler kullanılmadığı sürece R tek çekirdek üzerinde çalışmaktadır. Bu amaç doğrultusunda aşağıda kapalı (implicit) ve açık paralelleştirme (explicit) örneklerle kısaca bahsedilmeden önce örnek seri kod, çok iş parçacıklı kodlar, çok düğümlü (parallel MPI) veya hibrit isleri (çok iş parçacıklı ve çok düğümlü kodlar) için SLURM parametreleri paylaşılmıştır. Daha fazla detay için `buraya <https://www.john-ros.com/Rcourse/parallel.html>`_ bakabilirsiniz. 

.. tabs::

    .. tab:: Seri

        .. code-block::  slurm

            #SBATCH --nodes=1
            #SBATCH --ntasks=1
            #SBATCH --cpus-per-task=1

    .. tab:: OpenMP

        .. code-block::  slurm

            #SBATCH --nodes=1
            #SBATCH --ntasks=1
            #SBATCH --cpus-per-task=<c>

    .. tab:: MPI-Tek

        .. code-block::  slurm

            #SBATCH --nodes=1
            #SBATCH --ntasks=<n>
            #SBATCH --cpus-per-task=1

    .. tab:: MPI-Çoklu

        .. code-block::  slurm

            #SBATCH --nodes=<N>
            #SBATCH --ntasks=<n>
            #SBATCH --cpus-per-task=1
    
    .. tab:: Hibrit

        .. code-block::  slurm

            #SBATCH --nodes=<N>
            #SBATCH --ntasks=<n>
            #SBATCH --cpus-per-task=<c>

OpenMP-Üstü Kapalı paralellik
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

R kurulumu varsayılan şeklide kurulduğunda kendi `Basic Linear Algebra Subprograms (BLAS) <https://www.netlib.org/blas/>`_ kütüphanesi ile birlikte gelir. Ancak BLAS kütüphanesi sadece tek çekirdek üzerinde çalışır. Linear algebra işlemleri için pek çok paralel çalışabilen kütüphane bulunmaktadır. Kütüphanelerin karşılaştırması için `buraya <https://en.wikipedia.org/wiki/Comparison_of_linear_algebra_libraries>`_ bakılabilir. TRUBA'da varsayılan R ile intel MKL kütüphanesi kullanan iki farklı versiyon bulanmaktadır. Bu kütüphanler kullanılarak işlemlerimizi hızlandırabiliriz. İşlerimizi ölçeklendirme kısmında R yüklenirken, OpenMP ortam değişkeni *OMP_NUM_THREADS* ayarlanmamış olarak bırakılır. Bu, R kodunu doğrudan bir master üzerinde çalıştırırken, bu sunucudaki bulunan tüm çekirdeklerin R'de derlenen dahili çoklu iş parçacığı kütüphaneleri tarafından kullanılacağı anlamına gelir. Sunucu aşırı yükleneceğinden ve işiniz başarısız olabileceğinden bu önerilmez. Bu nedenle, R kodunu çalıştırmadan önce SLURM betiği içerisinde *OMP_NUM_THREADS* değerini uygun bir değere ayarlanmalı. Örneğin, R içinde dahili çoklu iş parçacığında kullanılmak üzere 4 çekirdek atamak için aşağıdakiler SLURM içine yazılabilir.

.. tabs::

    .. tab:: GCC
        
        .. code-block:: slurm

            export OMP_NUM_THREADS=4
    
    .. tab:: Intel
        
        .. code-block:: slurm

            export MKL_NUM_THREADS=4

Diğer taraftan bir de kod parçacıkları içerisinde paketler kullanarak çoklu çekirdek ve/veya çoklu sunucular içerisinde paralelleştirme yapılabilir.

.. list-table:: OpenMP karşılaştırılması
   :widths: 20 20 15 15 15 15
   :header-rows: 1
   :align: center

   * - Version
     - N-n-c / OMP
     - user
     - system
     - elapsed
     - CPU Efficiency
   * - R-4.2.2-GCC
     - 1-1-1 / 1
     - 558.712
     - 2.312
     - 561.292
     - 100.00%
   * - 
     -  1-1-10 / 10
     - 398.644
     - 0.634
     - 400.237
     - 9.88%
   * - R-4.2.2-Intel
     - 1-1-1 / 1
     - 59.676
     - 0.517
     - 60.190
     - 96.88%
   * - 
     - 1-1-10 / 10
     - 215.618
     - 2.443
     - 22.037
     - 81.85%


Tabloda varsayılan parametreler kullanılarak GCC ile derlenmiş R ve Intel ile derlenmiş R versiyonlarını farklı OpenMP seçenekleri ile örnekler ``system.time()`` içerisinde çalıştırılmış ve iş bitiminde ``seff <job_id>`` kullanılarak elde edilen *CPU Efficiency* bilgileri yer almaktadır. Kullanılan ``svd()`` fonksiyonu kullanılan Linear Algebra paketlerine göre fark göstermiştir. Diğer taraftan, GCC ile olan R versiyonunda 10 tane OpenMP işleri için çekirdek istenmiş olmasına rağmen R'ın kendi BLAS paketi paralel çalışmadığı için zaman olarak pek kazanç elde edilememiştir. Ayrıca CPU etkin kullanımına bakıldığında 10 çekirdeğin sadece 9.88% kullanılmıştır. Yazdığımız R betiklerini SLURM'a verebilmek için örnek dosyalar aşağıdaki gibi olabilir:

.. dropdown:: :octicon:`codespaces;1.5em;secondary` R ve SLURM dosyası (Tıklayınız)
    :color: info

    .. tab-set:: 

        .. tab-item:: single_R_script.R

            .. code-block:: r
                
                svd_func <- function(x){
                set.seed(x)
                A = matrix(runif(1e6), nrow = 1e3)
                svd(A)
                }

                system.time(
                lapply(1:100, svd_func)
                )
        
        .. tab-item:: anode_atask_mcore.sh

            .. code-block:: bash

                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --partition=debug
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH	--time=00:15:00
                #SBATCH --workdir=/path/to/work
                #SBATCH	--job-name=test
                #SBATCH --ntasks=1
                #SBATCH --nodes=1
                #SBATCH	--cpus-per-task=10

                ### GCC versiyonu için
                module purge
                module load centos7.9/comp/gcc/7
                module load centos7.9/app/R/4.2.2-gcc-7
                
                ## Intel versiyonu için
                ## source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64
                ## module load centos7.9/app/R/4.2.2-mkl-oneapi-2021.2

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                export OMP_NUM_THREADS=$SLURM_NTASKS
                ## intel ile derlenmiş R kullanılıyor ise
                ## export MKL_NUM_THREADS=$SLURM_NTASKS
                ## export MKL_NUM_THREADS=1

                #### R scripts #####
                Rscript --vanilla single_R_script.R > single_R_script.Rout

                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit


SLURM ayarlamaları için :ref:`Temel SLURM Komutları<basic_slurm_commands>`, :ref:`SLURM Betik Özellikleri <slurm-betik>` ve :ref:`Örnek SLURM Betik Dosyaları <example_slurm>` ziyaret edebilirsiniz.

    
    
Sonrasında işlerimizi SLURM aracılığı ile kuyruğa gönderebiliriz.

.. code-block:: bash

    sbatch anode_atask_mcore.sh

İşimizin durumunu kontrol etmek için :ref:`islerin-takibi` tarafına bakabilirsiniz. Ayrıca işleriniz bittikten sonra SLURM iş raporlarına ``seff``, ``sacct`` ve ``sstat`` komutları ile de erişebilirsiniz.


Paketler ile açık paralellik
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SLURM sizin için işlerinizi çoklu çekirdek ya da sunucu kullanmanız için tahsis eder ve ancak işlerinizi paralell çalışacak şekilde ayarlama yapmaz. Betikler hazırlanırken gerekli paketlerin kullanılması ve uygun formatta hazırlanmasına dikkat edilmelidir.
Bu amaç için aşağıda örnek senaryolar bulunmaktadır. Açık paralel şekilde betik yazımında kontrol altına alabilmek için OMP_NUM_THREADS ya da MKL_NUM_THREADS değerleri 1 olarak verilmelidir.


**1. Tek-Sunucu ve Çok-Çekirdek**

İşlerimizi verirken çok çekirdek kullanması için `parallel_R_script.R`  ve `anode_mtask_acore.sh`
dosyalarını örnek alabilirsiniz. 
R da açık bir şekilde paralel iş yapmanın kolay yollarından bir tanesi `doParallel <https://cran.r-project.org/web/packages/doParallel/index.html>`_ paketini kullanmaktır. ``doParallel`` içerisinde ``foreach``, ``iterators`` ve ``parallel`` gibi paketleri de içerisinde barındırır. ``foreach`` paketi for döngüsünü ``%do%`` ile seri ve ``%dopar%`` ile paralel olarak kullanmamızı kolaylaştıran pratik fonksiyonları sağlayan bir pakettir. Yalnız, paralel çalışması için %dopar% öncesinde mevcut olan çekirdek sayısı kayıt edilmeli. Bu süreç için ``doParallel::registerDoParallel()``, ``%dopar%`` öncesinde belirtilebilir. Eğer ``registerDoParallel()`` çağrılırsa mevcut olan çekirdek sayısının yaklaşık yarısı kadar kayıt eder. İstenilirse ``registerDoParallel(cores=number_cores)`` ile çekirdek sayısını belirtebiliriz. 

Ayrıca R betiği içerisinde SLURM aracılığı ile tahsis edilen iş/çekirdek sayısına erişmek ve o sayı kadar işlerimizi ölçeklendirmek isteyebiliririz. Bu durumda, ``parallel::detectCores()`` yerine  ``parallelly::availableCores(omit=1)`` veya ``Sys.getenv(c("SLURM_NTASKS"))`` kullanmanız tavsiye edilir. Örnek senaryolar ve çıktıları aşağıda görebilirsiniz. ``barbun`` suncularında 80 çekirdek bulunduğu için ``detectCores()`` fonksiyonu istenilenden fazlasını yani hepsini buluyor. 

.. tabs::

    .. group-tab:: Senaryo 1
        
        .. code-block:: slurm

            #SBATCH --nodes=1
            #SBATCH --ntasks=1
            #SBATCH --cpus-per-task=20
    
    .. group-tab:: Senaryo 2
        
        .. code-block:: slurm

            
            #SBATCH --nodes=1
            #SBATCH --ntasks=20
            #SBATCH --cpus-per-task=1

.. tabs::

    .. group-tab:: Senaryo 1
        
        .. code-block:: r

            library(doParallel)
            # parallel, foreach, iterators
            library(parallelly)

            nc <- parallel::detectCores()-1
            paste("The number of the cores", nc)

            [1] "The number of the cores 79"

            nw <- as.numeric(Sys.getenv(c("SLURM_NTASKS")))-1
            paste("The number of the tasks",nw)

            nw1 <- foreach::getDoParWorkers()-1
            paste("The number of the tasks",nw1)

            [1] "The number of the tasks 0"

            ncp <- parallelly::availableCores(omit=1)
            paste("The number of the available cores", ncp)

            [1] "The number of the available cores 19"

    
    .. group-tab:: Senaryo 2
        
        .. code-block:: r

            library(doParallel)
            # parallel, foreach, iterators
            library(parallelly)

            nc <- parallel::detectCores()-1
            paste("The number of the cores", nc)

            [1] "The number of the cores 79"

            nw <- as.numeric(Sys.getenv(c("SLURM_NTASKS")))-1
            paste("The number of the tasks",nw)

            nw1 <- foreach::getDoParWorkers()-1
            paste("The number of the tasks",nw1)

            [1] "The number of the tasks 19"

            ncp <- parallelly::availableCores(omit=1)
            paste("The number of the available cores", ncp)

            [1] "The number of the available cores 1"

    .. tab:: Slurm

        .. code-block:: slurm

            #!/bin/bash

            #SBATCH --account=kullanici_adiniz
            #SBATCH --partition=debug
            #SBATCH --constraint=barbun
            #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
            #SBATCH --error=%A.err
            #SBATCH --time=00:15:00
            #SBATCH --workdir=/truba/home/kullanici_adiniz/sw-u/R/script
            #SBATCH --job-name=1120.1-G
            #SBATCH --ntasks=1
            #SBATCH --nodes=1
            #SBATCH --cpus-per-task=20


            ### Load modules
            module purge
            module load centos7.9/comp/gcc/7
            module load centos7.9/app/R/4.2.2-gcc-7

            echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

            export OMP_NUM_THREADS=1
            #export OMP_NUM_THREADS=$SLURM_NTASKS
            #intel ile derlenmiş R kullanılıyor ise
            #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

            #### R scripts #####
            Rscript --vanilla parallel_R_script.R > parallel_R_script1110.Rout


            printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
            echo  >> ${SLURM_JOB_ID}.info
            scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

            exit
    .. tab:: parallel_R_script.R
        .. code-block:: r

            library(doParallel)
            # parallel, foreach, iterators
            library(parallelly)

            svd_func <- function(x){
            set.seed(x)
            A = matrix(runif(1e6), nrow = 1e3)
            svd(A)
            }

            ncp <- parallelly::availableCores(omit=1)
            paste("The number of the available cores", ncp)

            doParallel::registerDoParallel(ncp)
            # parallel backend, register and stopregister: otomatik kendisi yapıyor

            system.time(
            foreach(i=1:100) %dopar% { svd_func(i) }
            )

R içerisinde yukarıda belirtilen otomatik paralel kayıt işlemi en etkili olan yöntem olmakla birlikte, istenilirse PSOCK ve FORK tipinde de paralel kümeleme ayarı yapılabilir. Bilindiği üzere FORK tipinde paralel işlerde aynı R ortamları (veriler, fonksiyonlar, paketler) kopyalanmadan master iş tarafından paylaşılırken, PSOCK tipinde aynı R ortamı istenilen paralel iş sayısı kadar kopya oluşturulup işler koşturulur. Aşağıdaki bu iki tip için kullanılabilicek taslak bir R betiğini incelenebilir.

.. tabs:: 

    .. tab:: PSOCK / FORK

        .. code-block:: r

            library(doParallel)
            library(parallelly)
            
            ncp <- parallelly::availableCores(omit=1)
            cl <- parallel::makeCluster(ncp, type = "xxxxx")
            doParallel::registerDoParallel(cl)

            # To check registration
            foreach::getDoParRegistered()
            foreach::getDoParWorkers()

            # Here your parallel codes

            # Stop to clusters
            parallel::stopCluster(cl )

.. note:: 
    
    Yukarıda ki örneklerde MPI kullanmadan R paketleri kullanılarak tek sunucu içerisinde paralelleştirme yapılmıştır. Aslında, ``--ntasks`` parametresi ile MPI iş sayısını belirtmektedir. Dolayısıyla, tek sunucu içerisinde MPI işi gerekmedikçe ``--ntasks=1`` ve ``--cpus-per-task=<c>`` seçmek ve ``doParallel`` paketi kullanmak tavsiye edilir.  MPI işleri için  `Rmpi <https://cran.r-project.org/web/packages/Rmpi/index.html>`_ ya da `pbdMPI <https://cran.r-project.org/web/packages/pbdMPI/index.html>`_ paketi kullanılarak :ref:`ilgili kılavuz <ornek_mpi_rmpi>` takip edilebilir.

**2. Çok-Sunucu ve Çok-Çekirdek**

Çok sunucu kullanmak bazen avantaj olmakla beraber işlerin çalışması başlayıncaya kadar geçen süreler sebebiyle dezavantaj durumuna dönüşebilmektedir. Bu bilgiler ışığında işler ayarlanmalıdır. Sadece MPI çalışacak şekilde işler ayarlanabildiği gibi hibrit şekilde işler de olabilir. Aşağıda basit ``for`` döngüsünü paralel şekilde koşturan iki senaryo için taslak örnekler bulunmaktadır. 

**OpenMPI veya Hibrit (OpenMP + OpenMPI) iş verme**

Tek sunucu içerisinde kullanılabilecek maksimum çekirdek sayıısı yetersiz kaldığı durumlarda birden fazla sunucu içerisinde işlerimizi dağıtık olarak çok çekirdek kullanmak bir çözüm olabilmektedir.  

.. dropdown:: :octicon:`codespaces;1.5em;secondary` R ve SLURM dosyası (Tıklayınız)
    :color: info

    .. tab-set:: 

        .. tab-item:: mpi_R_script.R

            .. code-block:: r

                library(doParallel)
                library(Rmpi)
                library(doMPI)

                cl <- startMPIcluster(verbose=TRUE)
                registerDoMPI(cl)

                svd_func <- function(x){
                set.seed(x)
                A = matrix(runif(1e6), nrow = 1e3)
                svd(A)
                }

                system.time(
                foreach(i = 1:100) %dopar% {svd_func(i)}
                )

                closeCluster(cl)

        .. tab-item:: mnode_mtask_acore.sh

            .. code-block:: slurm

                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --partition=debug
                #SBATCH --constraint=barbun
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/kullanici_adiniz/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=10
                #SBATCH --nodes=2
                #SBATCH --ntasks-per-node=5
                #SBATCH --cpus-per-task=1

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                ## MPI icin
                module load centos7.9/lib/openmpi/4.1.5-gcc-7

                module load centos7.9/app/R/4.2.2-gcc-7

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                export OMP_NUM_THREADS=1
                #export OMP_NUM_THREADS=$SLURM_NTASKS_PER_NODE
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                mpirun -np $SLURM_NTASKS --mca btl_openib_allow_ib true R CMD BATCH --vanilla  mpi_R_script.R

                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit
        .. tab-item:: mnode_mtask_mcore.sh

            .. code-block:: slurm

                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --partition=debug
                #SBATCH --constraint=barbun
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/kullanici_adiniz/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=10
                #SBATCH --nodes=2
                #SBATCH --ntasks-per-node=5
                #SBATCH --cpus-per-task=2

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                ## MPI icin
                module load centos7.9/lib/openmpi/4.1.5-gcc-7

                module load centos7.9/app/R/4.2.2-gcc-7

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                export OMP_NUM_THREADS=2
                #export OMP_NUM_THREADS=$SLURM_NTASKS_PER_NODE
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                mpirun -np $SLURM_NTASKS --mca btl_openib_allow_ib true R CMD BATCH --vanilla  mpi_R_script.R

                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit

SLURM'a **- -ntasks=10 - -nodes=2 - -ntasks-per-node=5** diyerek her sunucuda 5'er iş olmak üzere 2 tane sunucuda toplamda 10 işi  birer çekirdek üzerinde çalışacağını söyleyebiliriz. Hibrit işlerde ise aynı kurgu içerisinde 10 iş çalışırken her işi tek çekirdek değil 2 çekirdek kullanarak kapalı paralelleştirme ile hızlandıralabilir.

.. _is-dizileri-job-array:

İş dizileri (job array)
------------------------------------------------
İş dizileri (job array), SLURM'ün tek bir koddan birden fazla iş oluşturma yeteneğinden yararlanmanıza imkan sağlar. Bunun yararlı olduğu durumları şu şekilde olabilir:

- Koşturulacak işlerin bir listesinin oluşturulması ve listedeki her komuttan bir iş oluşturulması.
- Bir veri seti üzerinde birden fazla parametre ile aynı anda çalıştırılması.
- Aynı programın farklı veri setleriyle aynı anda çalıştırılması.
  
SLURM'de kullanılan ``--array`` parametresinin atadığı değerlere ``$(SLURM_ARRAY_TASK_ID)`` ile iş numaralarına ulaşabilriz. Örnek kullanım ``program $((SLURM_ARRAY_TASK_ID))`` şeklinde olabilirken parametre durumları aşağıdaki gibi verilebilir:

- ``--array=2,5,8``: *program 2*, *program 5* ve *program 8* olmak üzere 3 iş başlatılır.
- ``--array=1-10`` : 1'den 10'a kadar değer vererek 10 tane işi aynı anda çalıştırır.
- ``--array=0-9``: 0, 3, 6, 9 değerleri ile birlikte 4 tane iş başlatılır.
- ``--array=1-10%2``: Aynı anda 2'şer iş çalıştırmak üzere modifiye eder.

Girdi dosyalarınızı *input_1, input_2, ... , input_10* olduğunda ``program input_$((SLURM_ARRAY_TASK_ID))`` ile her iş için ayrı bir girdi dosyasını alarak koşturulabilir.

Aşağıda 2 tane girdi kabul eden ve girdiler arasında bir liste oluşturup listenin her değeri için rastgele üretilen matrisin tekil değer ayrışımı (Singular Value Decomposition) hesaplayan R betiğini iş dizisi (job-array) kullanılarak bir örnek gösterilmeye çalışılmıştır. SLURM ``--array=1-9:2`` ile 1,3,5,7 ve 9 değerlerini SLURM_ARRAY_TASK_ID olarak saklayacak ve 5 tane iş çalıştıracaktır. Her işin çıktısı da *job_array_1.Rout, job_array_3.Rout, ..., job_array_9.Rout* şeklinde çalışma dizinine kayıt edilecektir. 

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek iş dizileri SLURM ve R dosyası (Tıklayınız)
    :color: info

    .. tab-set:: 

        .. tab-item:: job_array.R

            .. code-block:: r

                # Girdileri karakter vektörü olarak saklar
                args = commandArgs(trailingOnly=TRUE)

                start_i =as.integer( args[1] )
                end_i = as.integer( args[2] )


                print(start_i)
                print(end_i)

                svd_func <- function(x){
                set.seed(x)
                A = matrix(runif(1e6), nrow = 1e3)
                svd(A)
                }

                system.time(
                lapply(start_i:end_i, svd_func)
                )

        .. tab-item:: job_array.sh

            .. code-block:: slurm

                #!/bin/bash

                #SBATCH --account=kullanici_adiniz
                #SBATCH --partition=debug
                #SBATCH --output=%A_%a.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A_%a.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/kullanici_adiniz/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=1
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=2
                #SBATCH --ntasks-per-node=1
                #SBATCH --array=1-9:2

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                module load centos7.9/app/R/4.2.2-gcc-7

                export OMP_NUM_THREADS=1
                #export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                SEED=${SLURM_ARRAY_TASK_ID}

                #R CMD BATCH --vanilla '--args 40 50'  job_array_R_script.R
                Rscript --vanilla job_array_R_script.R $SEED $((SEED+2)) > job_array_${SEED}.Rout

                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit

        .. tab-item:: bash

            .. code-block:: bash

                sbatch job_array.sh


Birbirleri ile bağımlı işler çalıştırmak için ``--dependency`` parametresi için `SLURM'ün sayfası <https://slurm.schedmd.com/sbatch.html>`_ ziyaret edilebilir.

.. _benchmark-sonuclari:

Benchmark Sonuçları
--------------------
Sistemlerimizde iki farklı derleyici ile elde edilmiş R versiyonları bulunmaktadır. 
Ne zaman hangisini kullanacağımız konusunda ön bilgi sahibi olmak 
adına aşağıda yapılmış olan benchmark sonuçlarını inceleyebilirsiniz.

Kullanılan optimize paketlerini görmek için ``sessionInfo()`` fonksiyonu kullanabilirsiniz.
Intel derleyicisi ile olan modüller yüklendikten sonra R içerisinde ``sessionInfo()`` çalıştırılırsa BLAS/LAPACK paketlerini `Intel® oneAPI Math Kernel Library (oneMKL) <https://www.intel.com/content/www/us/en/developer/articles/technical/using-onemkl-with-r.html>`_ kullanıldığından emin olabiliriz. TRUBA'dan ``hamsi`` kümelerinde yapılan `R-benchmark-2.5 <https://mac.r-project.org/benchmarks/>`_ sonuçlarını aşağıda bulabilirsiniz:

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Benchmark Sonuçları (Tıklayınız)
    :color: info

    .. tab-set::
    
        .. tab-item:: R-Intel oneAPI MKL
     
            .. code-block:: r

                > sessionInfo()
                R version 4.2.2 (2022-10-31)
                Platform: x86_64-pc-linux-gnu (64-bit)
                Running under: CentOS Linux 7 (Core)

                Matrix products: default
                BLAS/LAPACK: /truba/sw/centos7.9/comp/intel/oneapi-2021.2/mkl/2021.2.0/lib/intel64/libmkl_intel_lp64.so.1

                locale:
                [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
                [3] LC_TIME=tr_TR.UTF-8        LC_COLLATE=en_US.UTF-8    
                [5] LC_MONETARY=tr_TR.UTF-8    LC_MESSAGES=en_US.UTF-8   
                [7] LC_PAPER=tr_TR.UTF-8       LC_NAME=C                 
                [9] LC_ADDRESS=C               LC_TELEPHONE=C            
                [11] LC_MEASUREMENT=tr_TR.UTF-8 LC_IDENTIFICATION=C       

                attached base packages:
                [1] stats     graphics  grDevices utils     datasets  methods   base     

                loaded via a namespace (and not attached):
                [1] compiler_4.2.2

        .. tab-item:: Benchmark Sonuçları

            .. code-block:: text

                R Benchmark 2.5
                ===============
                Number of times each test is run__________________________:  3

                I. Matrix calculation
                ---------------------                                          GCC                   Intel
                Creation, transp., deformation of a 2500x2500 matrix (sec):  0.804              0.829666666666667
                2400x2400 normal distributed random matrix ^1000____ (sec):  0.685333333333334  0.381 
                Sorting of 7,000,000 random values__________________ (sec):  0.962333333333333  0.893666666666666 
                2800x2800 cross-product matrix (b = a' * a)_________ (sec):  16.583             0.0690000000000002 
                Linear regr. over a 3000x3000 matrix (c = a \ b')___ (sec):  7.83566666666667   0.0336666666666664
                                    --------------------------------------------
                                Trimmed geom. mean (2 extremes eliminated):  1.82341634513467   0.279399678965381 

                II. Matrix functions
                --------------------
                FFT over 2,400,000 random values____________________ (sec):  0.169666666666662  0.207666666666667
                Eigenvalues of a 640x640 random matrix______________ (sec):  0.957666666666673  0.269666666666666
                Determinant of a 2500x2500 random matrix____________ (sec):  3.486              0.054666666666666
                Cholesky decomposition of a 3000x3000 matrix________ (sec):  6.54566666666667   0.03
                Inverse of a 1600x1600 random matrix________________ (sec):  2.97866666666667   0.0686666666666665
                                    --------------------------------------------
                                Trimmed geom. mean (2 extremes eliminated):  2.15040974669976   0.0920333259275001 

                III. Programmation
                ------------------
                3,500,000 Fibonacci numbers calculation (vector calc)(sec):  0.658333333333322  0.302333333333333
                Creation of a 3000x3000 Hilbert matrix (matrix calc) (sec):  0.202999999999993  0.358000000000001 
                Grand common divisors of 400,000 pairs (recursion)__ (sec):  0.284666666666662  0.337333333333335 
                Creation of a 500x500 Toeplitz matrix (loops)_______ (sec):  0.047333333333332  0.0626666666666651
                Escoufier's method on a 45x45 matrix (mixed)________ (sec):  0.371000000000009  0.308000000000007 
                                    --------------------------------------------
                                Trimmed geom. mean (2 extremes eliminated):  0.277802097935828  0.315523711731498


                Total time for all 15 tests_________________________ (sec):  42.5723333333333   4.20600000000001
                Overall mean (sum of I, II and III trimmed means/3)_ (sec):  1.02891822888886   0.200940590409758
                                    --- End of test ---

.. _islerin-takibi:

İşlerin Takibi
--------------
Çalışmakta olan işlerinizin işlemci  yükünü ve bellek kullanımını 
http://grafana.yonetim:3000  veya http://172.16.0.114:3000 adreslerinden 15 güne kadar takip edebilirsiniz.
Bu bağlantıya sadece :ref:`openvpn baglantısı ile <open-vpn>` üzerinden erişilebilmektedir.

.. note:: 
    
    Örnek betik dosyalarına ``/truba/sw/scripts/R`` dizininden erişim sağlayabilirsiniz.

.. _sorunlar-cozumler:

Sorunlar ve Çözümler
------------------------------
R paketlerinin kurulumu sırasında derleyici sorunlarını çözmek için diğer yaklaşımlar:

- :ref:`R_Source_code` örnek alınarak istenilen derleyici kullanılarak kurulum yapılabilir.

-  R paketleri kurulurken derleyicilerin düzgün bir şekilde çağrılması
   için ~/.R/Makevars dosyasına ilgili flag’ler eklenebilir. Bununla
   ilgili detaylar internette farklı kaynaklardan elde edilebilir.(`StackOverflow’dan bir
   örnek <https://stackoverflow.com/questions/1616983/building-r-packages-using-alternate-gcc>`__) Bu süreç için ``home`` dizinde iken

.. code-block:: bash
    
    mkdir -p ~/.R
    vim ~/.R/Makevars

ile açılan dosya içerisine aşağıdaki örnek parametrelerden gerekli olanlar kopyala yapıştır yapılabilir.

.. dropdown:: Örnek bayraklar (flags) (Tıklayınız)
    :color: warning
    :icon: zap

    .. code-block:: bash
        
        ## C++ flags
        CXX=g++
        CXX11=g++
        CXX14=g++
        CXX17=g++

        CXXFLAGS=-O3 -march=native -Wno-ignored-attributes
        CXX11FLAGS=-O3 -march=native -Wno-ignored-attributes
        CXX14FLAGS=-O3 -march=native -Wno-ignored-attributes
        CXX17FLAGS=-O3 -march=native -Wno-ignored-attributes

        CXXPICFLAGS=-fPIC
        CXX11PICFLAGS=-fPIC
        CXX14PICFLAGS=-fPIC
        CXX17PICFLAGS=-fPIC

        CXX11STD=-std=c++11
        CXX14STD=-std=c++14
        CXX17STD=-std=c++17

        ## C flags
        CC=gcc
        CFLAGS=-O3 -march=native

        ## Fortran flags
        FC=gfortran
        F77=gfortran
        FFLAGS=-O3 -march=native
        FCFLAGS=-O3 -march=native
    
            

-  R paketlerinin kurulumu sırasında TRUBA oturumunda hali hazırda yüklü
   olmayan modüller gerekirse terminal üzerinden ilgili modüller
   yüklenebilir. Bunun için `modüller
   kılavuzunu <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/moduller.html>`__
   inceleyebilirsiniz.

Dokümanla ilgili eksik ya da hata bulmanız durumunda bizlere grid-teknik@ulakbim.gov.tr adresinden erişebilirsiniz. Eklenmesini istediğiniz bilgiler için de bizlere aynı adresten ulaşabilirsiniz. 


.. _R-kilavuzu:

===============
R Kılavuzu
===============

Bu belge TRUBA altyapısında `R <https://www.r-project.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.

R işlerini çalıştırabilmek için öncelikle modülleri yüklememiz gerekir.
Centos 7.9 sistemimizde gcc ve intel ile derlenmiş iki farklı R versiyonu bulunmaktadır.

TRUBA'da bulunan modülleri görmek için 

.. code-block:: bash

    module avail -t 2>&1 | grep -i centos7.9/app/R

Siteminize gcc versiyonu yüklemek için 

.. code-block:: bash

    module purge
    module load centos7.9/comp/gcc/7
    module load centos7.9/app/R/4.2.2-gcc-7
	
veya intel versiyonu yüklemek için 

.. code-block:: bash
    
    module purge
    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64
    module load centos7.9/app/R/4.2.2-mkl-oneapi-2021.2

kod parçaları yazılır.
İş vermeden önce kullanılmak istenilen R paketlerini kullanılacak dizine kurmanızı öneririz.
Yoğunluğa sebep vermemek ve hesabınızın askıya alınmaması için paket kurulumlarınızı *barbun1* arayüzünde gerçekleştirmeniz tavsiye edilir. O halde işleri SLURM'a vermeden önce şu adımları takip edebiliriz:
*levrek1* kullanıcı arayüzünde iken 

.. code-block:: bash

    ssh barbun1 

ile *barbun1* sunucusuna geçiş yapılır. *barbun1* sunucusu içinde iken yukarıda belirtildiği gibi modüller yüklendikten sonra terminale şunu yazdığımızda 

.. code-block:: r

    R

R çalışmaya başlar ve paket kurulum aşamasına geçebiliriz.

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
----------------
HPC'de sıklıkla kullanılan R paketlerini 
`buradan <https://cran.r-project.org/web/views/HighPerformanceComputing.html>`_ bulabilirsiniz.
Mesela, R'da MPI işleri için yazılan Rmpi paketi kurmak isteyelim.
Rmpi'yi kümeye yüklemek için, gcc ile derlenmiş R'yi başlatmadan önce uygun MPI modülünü yüklememiz gerekir.

.. code-block:: bash

    module purge
    module load centos7.9/comp/gcc/7
    module load centos7.9/lib/openmpi/4.1.1-gcc-7
    module load centos7.9/app/R-4.2.2-gcc-7
    R

Bu adımdan sonra R çağrılmış olacak ve paket kurma adımları ile devam edebiliriz.

.. code-block:: r
    
     chooseCRANmirror(ind=69)
     install.packages("Rmpi",
      configure.args="
      --with-Rmpi-include=/truba/sw/centos7.9/lib/openmpi/4.1.1-gcc-7/include
      --with-Rmpi-libpath=/truba/sw/centos7.9/lib/openmpi/4.1.1-gcc-7/lib 
      --with-Rmpi-type=OPENMPI
      ")   

Terminalde R ile çalışmak
----------------------------
Temelde R ile ``shell script``'de iki farklı şekilde çalışabilirsiniz. R betiklerini çalıştırırken kullanılan 
daha fazla parametre detayları için
`burayı <https://cran.r-project.org/doc/manuals/R-intro.html#Invoking-R-from-the-command-line>`_ ziyaret edebilirsiniz.

.. code-block:: bash

    # Çıktı olarak my_R_Script.Rout'sını çalışma dizinine kayıt eder.
    R CMD BATCH R_script.R
    # Terminal içinde çıktıları yazar.
    Rscript R_script.R
    # Terminal içinde çıktıları yazar.
    Rscript R_script.R > R_script.Rout

SLURM, R ve Paralelleştirme
--------------------------

İşlerimizi ölçeklendirme kısmında R yüklenirken, OpenMP ortam değişkeni *OMP_NUM_THREADS* ayarlanmamış olarak bırakılır. Bu, R kodunu doğrudan bir dev-node üzerinde çalıştırırken, bu sunucudaki tüm CPU'ların R'de derlenen dahili çoklu iş parçacığı kütüphanesi tarafından kullanılacağı anlamına gelir. Sunucu aşırı yükleneceğinden ve işiniz başarısız olabileceğinden bu önerilmez. Bu nedenle, lütfen R kodunu çalıştırmadan önce slurm betiği içerisinde *OMP_NUM_THREADS* değerini uygun bir değere ayarlayın. Örneğin, R içinde dahili çoklu iş parçacığında kullanılmak üzere 4 çekirdek atamak için

.. code-block:: slurm

    export OMP_NUM_THREADS=4

yazılabilir. Diğer taraftan bir de kod parçacıkları içerisinde paketler kullanarak çoklu çekirdek ve/veya çoklu sunucular içerisinde paralelleştirme yapılabilir.

Yazdığımız R betiklerini SLURM'a verebilmek için örnek dosyalar aşağıdaki
gibi olabilir:

.. dropdown:: R ve SLURM dosyası (Tıklayınız)

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
        
        .. tab-item:: anode_atask_acore.sh

            .. code-block:: bash

                #!/bin/bash

                #SBATCH --account=iguzel
                #SBATCH --partition=single
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/iguzel/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=1
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=1


                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                module load centos7.9/app/R/4.2.2-gcc-7

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                export OMP_NUM_THREADS=1
                #export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                #### R scripts #####
                R CMD BATCH --vanilla single_R_script.R


                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit

SLURM ayarlamaları için :ref:`SLURM Betik Özellikleri <slurm-betik>` ve :ref:`Örnek SLURM Betik Dosyaları <example_slurm>` ziyaret edebilirsiniz.

    
    
Sonrasında işlerimizi SLURM'a gönderebiliriz.

.. code-block:: bash

    sbatch anode_atask_acore.sh

İşimizin durumunu kontrol etmek ve daha fazlasını yapabilmek için :ref:`Temel SLURM Komutları<basic_slurm_commands>` tarafına bakabilirsiniz.

İş devam ederken veya bittikten sonra single_R_script.Rout çıktı dosyasını inceleyebilirsiniz.

.. dropdown:: R çıktı dosyası (Tıklayınız)

    .. code-block:: bash
        :caption: single_R_script.Rout

        > svd_func <- function(x){
        + set.seed(x)
        + A = matrix(runif(1e6), nrow = 1e3)
        + svd(A)
        + }
        >
        > system.time(
        + lapply(1:100, svd_func)
        + )
        user  system elapsed
        385.126   0.530 386.098
        >
        >
        > proc.time()
        user  system elapsed
        385.401   0.653 387.677

Çok-Çekirdek ve Çok-Sunucu kullanımı
-------------------------------------
SLURM sizin için işlerinizi çoklu çekirdek ya da sunucu kullanmanız için tahsis eder ve ayarlama yapmaz.
Sizler betiklerinizi hazırlarken gerekli paketleri ve formatta hazırlamaya dikkat etmelisiniz.
Bu amaç için aşağıda iki örnek senaryo bulunmaktadır. Daha önce de belirtildiği gibi
program içinde kullanılan paketlerin kurulmuş olması gerekir.


**Çok-Çekirdek ve Tek-Sunucu**

İşlerimizi verirken çok çekirdek kullanması için `parallel_R_script.R`  ve `anode_mtask_acore.sh`
dosyalarını örnek alabilirsiniz. 

*foreach* paketi for döngüsünü ``%do%`` ile seri ve ``%dopar%`` ile paralel olarak kullanmamızı kolaylaştıran fonksiyonları sağlayan bir pakettir. Yalnız, paralel çalışması için %dopar% öncesinde mevcut olan çekirdek sayısı kayıt edilmeli. Bu süreç için ``registerDoParallel()``, ``%dopar%`` öncesinde belirtilmeli. Eğer ``registerDoParallel()`` çağrılırsa mevcut olan çekirdek sayısının yarısı kadar kayıt eder. İstenilirse ``registerDoParallel(cores=number_cores)`` ile çekirdek sayısını belirtebiliriz. 

.. dropdown:: R ve SLURM dosyası (Tıklayınız)
    
    .. tab-set:: 
        
        .. tab-item:: parallel_R_script.R

            .. code-block:: r
               
                library(foreach)
                library(parallel)
                library(doParallel)

                svd_func <- function(x){
                set.seed(x)
                A = matrix(runif(1e6), nrow = 1e3)
                svd(A)
                }

                no_cores <- detectCores()
                system.time(
                mclapply(1:100, svd_func, mc.cores = no_cores)
                )

                registerDoParallel(cores=no_cores)
                system.time(
                foreach(i=1:100) %dopar% { svd_func(i) }
                )

        .. tab-item:: anode_mtask_acore

            .. code-block:: slurm

                #!/bin/bash

                #SBATCH --account=iguzel
                #SBATCH --partition=debug
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/iguzel/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=10
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=1


                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                module load centos7.9/app/R/4.2.2-gcc-7

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info
                echo "we are running from this directory: $SLURM_SUBMIT_DIR" >> ${SLURM_JOB_ID}.info
                echo "The name of the job is: $SLURM_JOB_NAME" >> ${SLURM_JOB_ID}.info
                echo "The job ID is $SLURM_JOB_ID" >> ${SLURM_JOB_ID}.info
                echo "The job was run on these nodes: $SLURM_JOB_NODELIST" >> ${SLURM_JOB_ID}.info
                echo "Number of nodes: $SLURM_JOB_NUM_NODES" >> ${SLURM_JOB_ID}.info
                echo "We are using $SLURM_CPUS_ON_NODE cores per node" >> ${SLURM_JOB_ID}.info
                echo "Total of $SLURM_NTASKS tasks" >> ${SLURM_JOB_ID}.info

                export OMP_NUM_THREADS=1
                #export OMP_NUM_THREADS=$SLURM_NTASKS
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                #### R scripts #####
                R CMD BATCH --vanilla parallel_R_script.R


                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                printf '\n' >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit

**Çok-Çekirdek ve Çok-Sunucu**

Çok sunucu kullanırken sunucular arası iletişimi sağlayan MPI paketlerini kullanırken aynı zamanda tek sunucu içerisinde paralelleştirme pakerlerini de kullanabiliriz. Aşağıdaki iki farklı versiyon için örnek bulunmaktadır.

**OpenMPI**

Birden fazla sunucu içerisinde işlerimizi dağıtık olarak çok çekirdek kullanmak istediğinizde 
`mpi_R_script.R` ve `mnode_mtask_acore.sh` dosyalarını kullanabilirsiniz.

.. dropdown:: R ve SLURM dosyası (Tıklayınız)

    .. tab-set:: 

        .. tab-item:: mpi_R_script.R

            .. code-block:: r

                library(foreach)
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
                mpi.quit()

        .. tab-item:: mnode_mtask_acore.sh

            .. code-block:: slurm

                #!/bin/bash

                #SBATCH --account=iguzel
                #SBATCH --partition=debug
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/iguzel/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=10
                #SBATCH --nodes=2
                #SBATCH --ntasks-per-node=5
                #SBATCH --cpus-per-task=1

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                ## MPI icin
                module load centos7.9/lib/openmpi/4.1.1-gcc-7

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

SLURM'a **- -ntasks=10 - -nodes=2 - -ntasks-per-node=5** diyerek her sunucuda 5'er iş olmak üzere 2 tane sunucuda toplamda 10 iş çalışacağını söyleyebiliriz.

**Hibrit (OpenMP + OpenMPI) iş verme**

Çoklu sunucuları kullanmanın avantajlarından yararlanabilmek için kodumuzu ona göre ayarlamalıyız. Mesela aşağıdaki kod parçacıklarına dikkat edilirse ``foreach`` fonksiyonu ile 10 tane iş bölünür ve her iş ``mclapply`` ile 2 tane çekirdek üzerinden koşturulur.

.. dropdown::  R ve SLURM dosyası (Tıklayınız)

    .. tab-set:: 

        .. tab-item:: mpi_paralel_R_script.R

            .. code-block:: r

                library(foreach)
                library(parallel)
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
                foreach(i=1:10) %dopar% {mclapply(seq(i,100,10), svd_func, mc.cores=2)}
                )

                closeCluster(cl)
                mpi.quit()


        .. tab-item:: mnode_mtask_mcore.sh

            .. code-block:: slurm

                #!/bin/bash
        
                #SBATCH --account=iguzel
                #SBATCH --partition=debug
                #SBATCH --output=%A.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/iguzel/sw-u/R-TRUBA/script
                #SBATCH --job-name=test
                #SBATCH --ntasks=5
                #SBATCH --nodes=2
                ###SBATCH --ntasks-per-node=5
                #SBATCH --cpus-per-task=2

                ### Load modules
                module purge
                module load centos7.9/comp/gcc/7
                ## MPI icin
                module load centos7.9/lib/openmpi/4.1.1-gcc-7
                module load centos7.9/app/R/4.2.2-gcc-7

                export OMP_NUM_THREADS=2
                #export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
                #intel ile derlenmiş R kullanılıyor ise
                #export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

                echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info
                
                mpirun -np $SLURM_NTASKS --mca btl_openib_allow_ib true R CMD BATCH --vanilla  mpi_parallel_R_script.R

                printf -- '-%.0s' {1..50}  >>  ${SLURM_JOB_ID}.info
                echo >> ${SLURM_JOB_ID}.info
                scontrol show job $SLURM_JOB_ID >> ${SLURM_JOB_ID}.info

                exit

Bağımsız iş çalıştırma, iş dizileri ( job array)
------------------------------------
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

.. dropdown:: Örnek iş dizileri SLURM ve R dosyası (Tıklayınız)

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

                #SBATCH --account=iguzel
                #SBATCH --partition=debug
                #SBATCH --output=%A_%a.out #%A=JOB_ID %a=ArrayIndex
                #SBATCH --error=%A_%a.err
                #SBATCH --time=00:15:00
                #SBATCH --workdir=/truba/home/iguzel/sw-u/R-TRUBA/script
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

Open OnDemand ile RStudio
-----------------------------
Kullanıcı arayüzü kullanarak RStudio kullanım yol haritasını :ref:`open_ondemand`
de bulabilirsiniz.
Resimde görüldüğü üzere kısa yoldan RStudio arayüzünü kullanabilmek için 2 aşamadan oluşmaktadır.

- İstenilen interaktif sunucusu için çekirdek ve saat yazılması
- İnteraktif işlerde kuyruğa girmesi
- RStudio kullanıma hazır.

.. image:: /assets/RStudio-howto/images/OpenOnDemandRstudio.png


Bu kısayoldan kullanılan RStudio R-4.2.2-gcc-7 versiyonu kullanır. 
Farklı versiyonlarda kullanmak için TRUBA-Desktop'a bağlanıp
uzak masaüstü içinde terminale aşağıdakiler yazılarak 
yapılabiliir. 

.. code-block:: bash 

    module purge
    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64
    module load centos7.9/app/R/4.2.2-mkl-oneapi-2021.2
    rstudio

.. note::

    İstenilirse Jupyter araçları ile belirtilen R modülleri kullanabilir. Detayları :ref:`jupyter-anaconda` tarafında bulabilirsiniz.

**Farklı RStudio versiyonu kullanma**

İstenilen RStudio versiyonu kullanmak için anaconda platformunda uygun conda ortamı oluşturularak kullanılabilir. Bu durumda öncelikle :ref:`merkezi-anaconda` ya da :ref:`miniconda-kurulum` sayfalarını ziyaret ederek gerekli kurulumlar gerçekleştirilir. Sonrasında

.. code-block:: bash

    conda create -n rstudio-env # RStudio için bir ortam oluşturulur.
    conda activate rstudio-env  # Oluşturulan ortam aktif edilir.
    conda install -c conda-forge rstudio-desktop # RStudio ve bağımlı paketler kurulur.

Bu kurulum aşaması tamamlandıktan sonra, :ref:`open_ondemand` tarafından TRUBA-DESKTOP isteminde bulunulur. Burada sizlere bir masaüstü ekranı gelecektir. Bu ekrandan terminal açılarak RStudio için ortam ``conda activate rstudio-env`` ile aktif edilir ve ``rstudio`` komudu ile arayüze ulaşabilirsiniz.

Benchmark Sonuçları
--------------------
Sistemlerimizde iki farklı derleyici ile elde edilmiş R versiyonları bulunmaktadır. 
Ne zaman hangisini kullanacağımız konusunda ön bilgi sahibi olmak 
adına aşağıda yapılmış olan benchmark sonuçlarını inceleyebilirsiniz.

Kullanılan optimize paketlerini görmek için ``sessioninfo()`` fonksiyonu kullanabilirsiniz.
İntel derleyicisi ile olan modüller yüklendikten sonra çalıştırılırsa aşağıdaki çıktıyı elde ederiz.

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


Fark edildiği üzeri BLAS/LAPACK paketlerini `Intel® oneAPI Math Kernel Library (oneMKL) <https://www.intel.com/content/www/us/en/developer/articles/technical/using-onemkl-with-r.html>`_ 
kütüphanesinden kullanıyor.

`hamsi` kümelerinden bir sunucu içerisinde yapılan `R-benchmark-2.5 <https://mac.r-project.org/benchmarks/>`_ sonuçları:

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

İşlerin Takibi
-----------------
Çalışmakta olan işlerinizin işlemci  yükünü ve bellek kullanımını 
http://grafana.yonetim:3000  veya http://172.16.0.114:3000 adreslerinden 15 güne kadar takip edebilirsiniz.
Bu bağlantıya sadece openvpn baglantısı (:ref:`openvpn ile erişim<open-vpn>`) üzerinden erişilebilmektedir.

Ek Notlar
-----------
- Farklı R versiyonları için :ref:`R_Source_code` tarafını ziyaret edebilirsiniz.

- Örnek betik dosyasına ``/truba/sw/scripts/R`` dizininden erişim sağlayabilirsiniz.


Dokümanla ilgili eksik ya da hata bulmanız durumunda bizlere grid-teknik@ulakbim.gov.tr adresinden erişebilirsiniz. Eklenmesini istediğiniz bilgiler için de bizlere aynı adresten ulaşabilirsiniz. 


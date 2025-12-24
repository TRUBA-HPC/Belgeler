
Slurm ile MPI kullanımı
=======================

MPI, HPC için çok önemli olan bir şeye izin verir - birden çok düğümün (sunucunun) aynı prosedür üzerinde çalışmasını sağlar. Sunucular arasındaki bu işbirliği oldukça sorunsuzdur ve TRUBA gibi bir sistemde çalışmak kolaydır. MPI içeren görevleri yürütmek için, iş adımlarını ``mpirun`` komutunu kullanarak başlatmamız gerekir (şimdiye kadar kullanılan ``srun`` komutu yerine). ``mpirun`` komutu kullanılarak oluşturulan iş adımları yine birden fazla görev oluşturacaktır, ancak bu görevler aynı MPI prosedürü üzerinde çalışacaktır. Öte yandan, ``srun`` komutu kullanılarak oluşturulan görevler birbirinden bağımsızdır.

OMP ile deney yapmak için aşağıdaki MPI programını kullanacağız (şimdilik bu programı anlamaya çalışmanıza gerek yok :) İlerki bölümleri takip ettikten sonra geri dönüp anlamaya çalışmanızı tavsiye ederiz :)):

.. code-block:: c

   #include <stdio.h>
   #include <omp.h>
   #include <limits.h>
   #include <unistd.h>
   static long long num_steps=1000000000;
   double step;
   char hostname[HOST_NAME_MAX];

   int main(int argc, char** argv){
           gethostname(hostname, HOST_NAME_MAX);
           int i, myid, num_procs;
           double x, pi, remote_sum, sum=0, start=0, end=0;;
           MPI_Init(&argc, &argv);
           MPI_Barrier(MPI_COMM_WORLD);
           MPI_Comm_rank(MPI_COMM_WORLD, &myid);
           MPI_Comm_size(MPI_COMM_WORLD, &num_procs);
           start = MPI_Wtime();
           step = 1.0/(double) num_steps;
           for (i = myid; i< num_steps; i=i+num_procs){
                   x =(i+0.5)*step;
                   sum +=4.0/(1.0+x*x);
           }
           printf("Process %d running on %s\n", myid, hostname);
           if (myid==0){
                   for (i = 1; i< num_procs;i++){
                           MPI_Status status;
                           MPI_Recv(&remote_sum, 1, MPI_DOUBLE, i, 0, MPI_COMM_WORLD, &status);
                           sum +=remote_sum;
                   }
                   pi=sum*step;
           } else {
                   MPI_Send(&sum, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
           }
           MPI_Finalize();

           if (myid ==0){
                   end = MPI_Wtime();
                   printf("Processes %d, took %f \n", num_procs, end-start);
           }
           return 0;
   }

Aynı prosedür üzerinde çalışmak için birden çok düğüm (ve düğüm başına birden çok görev) kullanarak MPI programlarını yürütme
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Aşağıda gösterilen mpi.slurm betiği, MPI görevlerini yürütmek için birden çok düğümü nasıl kullanabileceğimizi gösterir:

.. code-block:: bash

   #!/bin/bash

   #SBATCH --account=<my_account>
   #SBATCH --job-name=<job_name>
   #SBATCH --partition=<part>
   #SBATCH --time=d-hh:mm:ss
   #SBATCH --nodes=<N> # Number of nodes that will take part in the MPI procedure
   #SBATCH --ntasks-per-node=<npn> # maximum limit of processes that can run in parallel
                   # on a single node
   #SBATCH --workdir=<dir>
   #SBATCH --output=<out>
   #SBATCH --error=<err>

   # This MPI procedure will use <n1> tasks only
   mpirun -np=<n1> ./my_mpi_program

   # Thsi MPI procedure will use <npn> * <N> tasks
   mpirun ./my_mpi_program

Ardından, bu komut dosyasını yürütmek üzere TRUBA'ya aşağıdaki komutu kullanarak göndeririz:

.. code-block:: bash

   $ sbatch example_mt1.slurm

``<my_account>``\ : TRUBA'daki hesap adı

``<job_name>``\ : iş kuyruğunda görünen gönderilen işin adı.

``<part>``\ : çalışmayı sıraya alacağınız bölümün adı.

`<time>`: Çalışmanızın çalışacağı maksimum süre. Bu girdinin biçimi `d-hh: mm: ss\ ``şeklindedir, burada``\ d\ ``günü,``\ hh\ ``saati,``\ mm\ ``dakikayı ve``\ ss` saniyeyi temsil eder. Not: Yürütülebilir dosya belirtilen bu zaman aralığında sona ermezse, otomatik olarak sonlandırılacaktır.

``<N>``\ : bu komut dosyasındaki görevleri çalıştırmak için kullanılacak düğüm (sunucu) sayısı.

``<n>``\ : komut dosyası içinde paralel olarak çalışacak maksimum görev sayısı.

``<n1>``\ : ilgili MPI iş adımına katkıda bulunacak görev sayısı

``<c>``\ : her görevin yürütülmesi için ayrılmış CPU sayısı

``<dir>``\ : TRUBA'da komut dosyasının yürütüleceği yol. Burası genellikle girdi ve çıktı dosyalarının bulunduğu yerdir. Komut dosyasında tanımlanan tüm göreli yollar ``<out>`` ile göreli olacaktır.

``<out>``\ : bu işin ``stdout`` unun yazdırılacağı dosya. Bu, koddaki yürütmelerin ürettiği tüm çıktıları içerir.

``<err>``\ : bu işin ``stderr`` inin yazdırılacağı dosya.

``Sbatch`` komutunu çağırdığımızda, işi TRUBA kuyruğuna kaydedeceğiz. Kaynaklar mevcut olduğunda ve işimiz sıranın en üstünde olduğunda, aşağıdakiler gerçekleşecektir:


#. Talep edilen kaynaklar, talep edilen zaman aralığı için tahsis edilecektir ve bu durumda talep ettiklerimiz:

   #. ``<N>`` düğüm
   #. ``<npn> * <N>`` görev yürütme yetkisi
   #. her görev için ``<c>`` işemci, yani totalde ``<c> * (<npn> * <N>)`` işlemci

#. the lines starting with ``mpirun`` will start job-steps that will  run the program my_mpi_omp_program using ``<N>`` nodes. The first job-step will use ``<n1>`` tasks to run its procedure. The second will use ``<n>`` tasks.  Both of these job-steps' tasks will use ``<c>`` threads. 
#. ``mpirun`` ile başlayan satırlar, my_mpi_omp_program programını ``<N>`` düğüm kullanarak çalıştıracak iş adımlarını başlatacaktır. İlk iş adımı, prosedürünü çalıştırmak için ``<n1>`` görev kullanacaktır. İkincisi, ``<n>`` görev kullanacaktır. Bu iş adımlarının her iki görevi de ``<c>`` iş parçacığı kullanacaktır.

Örnek\ **:**
^^^^^^^^^^^^^^

Aşağıda gösterilen ``mpi_example.slurm`` betiği, MPI programlarının TRUBA'da nasıl çalıştırılabileceğini gösterir ve yürütme için ayrılmış görev sayısının ``-np`` seçeneği kullanılarak nasıl değiştirilebileceğini gösterir. Komut dosyasını, kullanmak istediğimiz düğüm sayısını ve her bir düğümde kullanmak istediğimiz görev sayısını tanımlayarak başlatıyoruz. Ardından, gerekli modülleri yükleyerek ve MPI kodumuzu derleyerek yürütme ortamını kuruyoruz. Son olarak iki MPI iş adımı çalıştırıyoruz. Her iş adımı farklı sayıda görev kullanır, ancak, ``srun``\ 'dan farklı olarak, bir iş adımı ``mpirun`` kullanılarak başlatıldığında, oluşturduğu görevlerin tümü bağımsız olmak yerine aynı prosedür üzerinde çalışacaktır.

Bu iş ``short`` bölümüne eklenecek ve 20 dakika içinde bitecektir. ``mpi.c`` dosyası ``/arf/home/my_account/`` konumunda bulunur. İşlerin çıktıları ``/arf/home/my_account/output.txt`` dosyasına ve hatalar ``/arf/home/my_account/error.txt`` dosyasına yazdırılacaktır.

.. code-block:: bash

   #!/bin/bash

   #SBATCH --account=<my_account>
   #SBATCH --job-name=my_job
   #SBATCH --partition=short
   #SBATCH --time=0-00:02:00
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=4
           # Job-steps created in this job will be able to create up to 8 tasks
   #SBATCH --workdir=/arf/home/my_account/
   #SBATCH --output=output.txt
   #SBATCH --error=error.txt

   # Setup the environment
   # 1. load the modules required for compilation
   module purge # remove any modules that were loaded on the client server to start fresh
   module load centos7.3/comp/gcc/7
   module load centos7.3/lib/openmpi/3.0.0-gcc-7.0.1
   # 2. compile code
   mpicc mpi.c -o mpi

   echo "Using four tasks"
   mpirun -np 4 ./mpi
   echo ""
   echo ""
   echo "Using six tasks"
   mpirun -np 6 ./mpi
   echo ""
   echo ""
   echo "Using eight tasks"
   mpirun ./mpi
   echo ""
   echo ""

Ardından, bu komut dosyasını yürütmek üzere TRUBA'ya aşağıdaki komutu kullanarak göndeririz:

.. code-block:: bash

   $ sbatch mpi_example.slurm

Bu SLURM komut dosyasını gönderirken gözlemlediğimiz bir çıktı:

.. code-block::

   Using four tasks
   Process 1 running on akya14.yonetim
   Process 3 running on akya14.yonetim
   Process 0 running on akya14.yonetim
   Process 2 running on akya14.yonetim
   Processes 4, took 3.254500 

   Using six tasks
   Process 4 running on akya15.yonetim
   Process 0 running on akya14.yonetim
   Process 2 running on akya14.yonetim
   Process 5 running on akya15.yonetim
   Process 3 running on akya14.yonetim
   Process 1 running on akya14.yonetim
   Processes 6, took 2.209622 

   Using eight tasks
   Process 1 running on akya14.yonetim
   Process 6 running on akya15.yonetim
   Process 0 running on akya14.yonetim
   Process 3 running on akya14.yonetim
   Process 4 running on akya15.yonetim
   Process 5 running on akya15.yonetim
   Process 2 running on akya14.yonetim
   Process 7 running on akya15.yonetim
   Processes 8, took 1.722208

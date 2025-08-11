.. _paralel_ve_seri_is_calistirma:


Seri ve Paralel İş Çalıştırma
==============================

Bir algoritma bir problemi çözmek için takip edilen adımlardan oluşur. Somut bir örnek vermek gerekirse bir araba nakil bandını düşünebiliriz. Nakil bandındaki her adım arabayı oluşturmak için bir işlem teşkil eder. Bu işlemler parça ekleme veya düzeltme olarak düşünülebilir. Bu işlemleri doğru sonuç alınacak şekilde sıraya koymak ve mümkünse bu işlemleri hızlandırmak büyük önem teşkil eder. 

Araba üretimi hızlandırmak isteyen bir şirket yeni bir nakil bandı satın ve iki kat daha fazla işçi işe alarak, iki araba üretme hızını yarıya indirebilir. Bu şekilde hızlandırılabilen problemler *utanç verici derecede paralel problemler* olarak adlandırılmaktadır. Ne yazık ki çoğu problem bu sınıfa dahil değildir.

Mesela butik bir araba üreticisiyseniz, sadece bir avuç araba yapmak için yeni bir montaj hattı inşa etmek, tasarruf edeceğinden daha fazla zaman ve paraya mal olmaktaysa, nasıl daha hızlı araba üretebilirsiniz? Tek yol, birden fazla kişinin aynı anda tek bir araba üzerinde çalışmasını sağlamaktır. Bunun için birbirini engellemeyen ve aynı anda uygulanabilecek adımların belirlenmesi gerekir, mesela arabanın moturu ve şasisi eş zamanlı inşa edilebilir. Algoritmalar da aynı özellikleri taşımaktadır. Bu dokümanda araba nakil bandı örneği ile tanıttığımız paralel algoritmaların özellikleri anlatılacaktır.

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

Bu iş ``short`` bölümüne eklenecek ve 20 dakika içinde bitecektir. ``mpi.c`` dosyası ``/truba/home/my_account/`` konumunda bulunur. İşlerin çıktıları ``/truba/home/my_account/output.txt`` dosyasına ve hatalar ``/truba/home/my_account/error.txt`` dosyasına yazdırılacaktır.

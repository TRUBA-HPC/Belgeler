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

        #include <mpi.h>
        #include <stdio.h>

        int main(int argc, char** argv) {
        // Initialize the MPI environment
        MPI_Init(NULL, NULL);

        // Get the number of processes
        int world_size;
        MPI_Comm_size(MPI_COMM_WORLD, &world_size);

        // Get the rank of the process
        int world_rank;
        MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

        // Get the name of the processor
        char processor_name[MPI_MAX_PROCESSOR_NAME];
        int name_len;
        MPI_Get_processor_name(processor_name, &name_len);

        // Print off a hello world message
        printf("Hello world from processor %s, rank %d out of %d processors\n",
                processor_name, world_rank, world_size);

        // Finalize the MPI environment.
        MPI_Finalize();
        }



Aşağıda gösterilen mpi.slurm betiği, MPI görevlerini yürütmek için birden çok düğümü nasıl kullanabileceğimizi gösterir:

.. code-block:: bash

        #!/bin/bash
        #SBATCH -p orfoz
        #SBATCH -J mpi_test
        #SBATCH -N 1
        #SBATCH -n 1
        #SBATCH -c 110
        #SBATCH -C weka
        #SBATCH --time=3-00:00:00


        export OMP_NUM_THREADS=1


        echo "SLURM_NODELIST $SLURM_NODELIST"
        echo "NUMBER OF TASKS $SLURM_NTASKS"

        module purge

        #module load lib/openmpi/4.0.5
        #mpicc mpi-hello.c -o mpi-hello


        module load lib/openmpi/5.0.0
        mpicc mpi-hello.c -o mpi-hello

        #module load oneapi
        #mpiicx mpi-hello.c -o mpi-hello

        mpirun -np $SLURM_NTASKS ./mpi-hello 

        exit

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

`module av` komutu ile mevcut OpenMPI kütüphanelerini görüntüleyebilirsiniz. 

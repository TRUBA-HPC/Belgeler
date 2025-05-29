.. _paralel_ve_seri_is_calistirma:


Seri ve Paralel İş Çalıştırma
==============================

Bir algoritma bir problemi çözmek için takip edilen adımlardan oluşur. Somut bir örnek vermek gerekirse bir araba nakil bandını düşünebiliriz. Nakil bandındaki her adım arabayı oluşturmak için bir işlem teşkil eder. Bu işlemler parça ekleme veya düzeltme olarak düşünülebilir. Bu işlemleri doğru sonuç alınacak şekilde sıraya koymak ve mümkünse bu işlemleri hızlandırmak büyük önem teşkil eder. 

Araba üretimi hızlandırmak isteyen bir şirket yeni bir nakil bandı satın ve iki kat daha fazla işçi işe alarak, iki araba üretme hızını yarıya indirebilir. Bu şekilde hızlandırılabilen problemler *utanç verici derecede paralel problemler* olarak adlandırılmaktadır. Ne yazık ki çoğu problem bu sınıfa dahil değildir.

Mesela butik bir araba üreticisiyseniz, sadece bir avuç araba yapmak için yeni bir montaj hattı inşa etmek, tasarruf edeceğinden daha fazla zaman ve paraya mal olmaktaysa, nasıl daha hızlı araba üretebilirsiniz? Tek yol, birden fazla kişinin aynı anda tek bir araba üzerinde çalışmasını sağlamaktır. Bunun için birbirini engellemeyen ve aynı anda uygulanabilecek adımların belirlenmesi gerekir, mesela arabanın moturu ve şasisi eş zamanlı inşa edilebilir. Algoritmalar da aynı özellikleri taşımaktadır. Bu dokümanda araba nakil bandı örneği ile tanıttığımız paralel algoritmaların özellikleri anlatılacaktır.

Veri Bağımlılığı
----------------

Birçok farklı alanda ve uygulamada birbirine veri olarak bağlı işlemler sonucunda bir hesaplama yaparız. Bir başka deyişle yinelemeli işlemler, bir değerin hesaplanıp bu değerin bir sonraki hesaplamada kullanıldığı, seri işlemler teşkil etmektedir ve bu tarz işlemler büyük ölçüde paralelleştirilemez. Aşağıda bir seri kod örneği verilmiştir:

.. code-block:: c

   old_value = starting_point
   for iteration in 1 ... 10000
      new_value = function(old_value)
      old_value = new_value

Örnekte ``new_value`` ``old_value`` kullanılarak elde edilmekte ve bu değer tekrar ``old_value``\ 'ya eşitlenmektedir. Yani döngünün bir önceki tekrarında hesaplanan değer bir sonraki tekrarda kullanılmaktadır. Bu durum veri bağımlılığı olarak adlandırılmaktadır. Döngü tekrarı ``k+1``\ 'deki ``new_value`` döngü tekrarı ``k``\ 'daki ``old_value``\ 'ya bağımlıdır. Veri bağımlılığı bir programdaki paralel ve seri bölgeleri belirler.

Yukarda bahsettiğimiz araba nakil bandında da bu şekilde kısıtlamalar ve bağımlılıklar düşünebiliriz. Mesela, bir arabanın tekerleklerini aynı anda, *paralel* bir şekilde, monte edebiliriz. Fakat bunu yapabilmek için arabanın aksının monte edilmiş olması gerekir. Araba aksının monte edilmesi ve tekerleklerin mont edilmesi aynı anda yapılamayacak işlemleri teşkil etmektedir. Bu analojide tekerlekleri monte etme işleminin aksı monte etme işlemine bağımlı olduğunu söyleyebiliriz.

Paralel bir şekilde çalıştırılamayan kısımları **Seri Bölgeler**\ , ve paralel olarak çalıştırılabilen kısımları **Paralel Bölgeler** olarak adlandırmaktayız. Bir program hiçbir zaman seri bölgelerin toplam süresinden daha hızlı çalıştırılamaz. Aşağıda seri ve paralel bölge örnekleri verilmiştir:

.. code-block:: c

   serial   | vector_0[0] = 1;
            | vector_1[1] = 1;
            | for i in 2 ... 1000
            |   vector_1[i] = vector_1[i-1] + vector_1[i-2];

   parallel | for i in 0 ... 1000
            |   vector_2[i] = i;

   parallel | for i in 0 ... 1000
            |   vector_3[i] = vector_2[i] + vector_1[i];
            |   print("The sum of the vectors is.", vector_3[i]);

Ölçeklenebilirlik
-----------------

Bir parallel programın hızlanması, bu programın tek bir işlemci ile çalışma süresinin, N işlemci ile çalışma süresine olan oranı olarak tanımlanmıştır. İdeal olarak hızlanmanın kullanılan işlemci sayısına eşit olmasını, ``hızlanma = N``\ , isteriz. Böylece bütün işlemciler işlemci gücünün tamamını kullanmış olurlar. Fakat birazdan bahsedeceğimiz sebepler yüzünden bu durum çoğu zaman gerçekleştirilemez.

Amdahl Yasası ve Güçlü Ölçekleme
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Amdahl yasası paralel programlama ile elde edilebilecek teorik hızlanma limitini tanımlamaktadır: Sabit bir problem için hızlanmanın üst sınırı kodun seri kısmı tarafından belirlenir. Buna güçlü ölçekleme denir ve sonuçları aşağıdaki şekilden anlaşılabilir.


.. image:: /assets/openmpi-education/images/amdahl.png
   :target: /assets/openmpi-education/images/amdahl.png
   :alt: /assets/openmpi-education/images/amdahl.png


Bir programın 20 saatte çalışmasını tamamladığını ve bu programın seri bölgesinin programın yüzde 5 ini kapsadığını kabul edersek, Amdahl yasasına göre programın hızlanması yukardaki şekilde gibi mavi çizgi ile gösterilebilir. Programın yüzde 5'i yani 1 saati seri olduğundan program hiçbir zaman 1 saatten daha fazla çalıştırılamaz ve, ne kadar işlemci kullanılırsa kullanılsın, elde edilebilecek hızlanma en fazla 20 olabilir.

Güçlü Ölçekleme
^^^^^^^^^^^^^^^


* Sabit bir toplam sorun boyutu için çözüm süresinin işlemci sayısıyla nasıl değiştiği olarak tanımlanır.
* İletişim ek yükü tipik olarak kullanılan işlem sayısıyla arttığından, daha büyük işlem sayılarında iyi bir güçlü ölçekleme elde etmek daha zordur.

Pratikte problemin boyutu, işlem için ayrılan kaynak miktarı ile artmaktadır. Bu nedenle problem büyüklüğüne göreceli hızlanmanın ölçülmesi de yüksek performanslı uygulamalar için önemlidir.

Gustafson Yasası ve Zayıf Ölçekleme
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Gustafson yasası, programdaki paralel bölgenin kaynak miktarı ile doğrusal olarak ölçeklendiği ve seri bölgenin problemin boyutuna göre artmadığı yaklaşımlarına dayanmaktadır. 


.. image:: /assets/openmpi-education/images/gustafson.png
   :target: /assets/openmpi-education/images/gustafson.png
   :alt: /assets/openmpi-education/images/gustafson.png


Yasaya göre işlemci saysı arttıkça ölçekli hızlanma linear olarak artar. Yukarıdaki figürde gösterildiği gibi ölçekli hızlanma eğimi 1'den küçük olmakla birlikte lineer bir ilişki göstermektedir.

Zayıf ölçekleme işlemci başına sabit bir sorun boyutu için çözüm süresinin işlemci sayısına göre nasıl değiştiği olarak tanımlanır. Güçlü ölçeklemede problem bütün işlemcilerin toplamı için sabitken, zayıf ölçeklemede işlemci sayısı arttıkça problemin boyutu da artmaktadır.

İletişimin Önemi
----------------

Paralel bir programdaki en önemli konseptlerden birisi işlemcinin hafıza ya da işlemciler arası gerçekleştirdiği iletişimin hızıdır. İletişim hızı, bir kişinin göndermesi/alması gereken veri miktarı ve iletişim için temel alınan donanımın bant genişliği ve sistemin gecikme sabiti ile belirlenir. Gecikme, yazılım gecikmesinden (işletim sisteminin bir iletişime hazırlanmak için ihtiyaç duyduğu süre) ve donanım gecikmesinden (donanımın küçük bir veriyi göndermesi/alması için gereken süre) oluşur. Genel olarak paralel programı çözen işlemci saysını arttırdıkça iletişim miktarı da artmaktadır. İletişim bir noktadan sonra darboğaz haline gelip hızlanmayı durdurup yavaşlamaya sebep olabilir.

Yüzey Hacim Oranı
-----------------

Paralel bir algoritmada bir işlemci tarafından kullanılan veri iki türlü değerlendirilmektedir:


* İşlemcinin ihtiyacı olan fakat başka işlemciler tarafından kontrol edilen veriler.
* İşlemcinin kendi kontrol ettiği ve hesaplayabildiği veriler.

Bahsedilen ilk veri tipi yüzey ikincisi ise hacim olarak adlandırılmaktadır. Yüzey tipi veriler işlemciler arasında iletişim teşkil eder ve yüzey veri tipi ne kadar artarsa işlem süresi o kadar yavaşlar.

Amdahl yasası nedeniyle, her bir iletişimin hazırlanması sonlu bir zaman aldığından (gecikme süresi) aynı yüzey için iletişim sayısını en aza indirilmelidir. Bu, mümkünse yüzey verilerinin, birçok seferde iletilmesindense tek bir iletişimde değiş tokuş edilmesini önerir.



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

.. code-block:: bash

   #!/bin/bash

   #SBATCH --account=<my_account>
   #SBATCH --job-name=my_job
   #SBATCH --partition=short
   #SBATCH --time=0-00:02:00
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=4
           # Job-steps created in this job will be able to create up to 8 tasks
   #SBATCH --workdir=/truba/home/my_account/
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
.. _paralel-prog:

===================
Paralel Programlama
===================

Kullanıcılar kendi geliştirdikleri uygulamaları derlemek için sistemde yüklü MPI (Multi Node) ya da OpenMP (multithread) kütüphanelerini ve derleyicilerini kullanabilirler. Herhangi bir uygulamanın paralel olarak derlenmesi ve paralel olarak çalışabilmesi için uygulamanın buna uygun olarak yazılmış olması gereklidir.

OpenMP derlemesi yapmak için uygulamayı **-fopenmp, -lomp5** ya da **-lpthread** kütüphaneleri ile bağlamak (link) genelde yeterli olurken, MPI derlemesi yapabilmek için, uygulamayı **mpicc, mpif90, mpicxx (mpiicc, mpiifort)** ile derlemek gerekmektedir. 

------------------------------------------------
MPI (Message Passing Interface) : impi, openmpi 
------------------------------------------------

Sistemde farklı versiyondaki *Intel derleyiciler* için Intel MPI (impi) ve OpenMPI'ın *GCC ve Intel derleyiciler* ile derlenmiş farklı versiyonları (3.0.0, 4.0.1, 4.1.1) bulunmaktadır. 

* **impi** ile derleme yapabilmek ya da **impi** ile derlenmiş bir uygulamayı çalıştırmak için Intel çevre değişkenleri aşağıdaki örneklerde olduğu gibi yüklenmelidir. 
 
  Farklı versiyonlar için yer alan derleyiciler hakkında bilgiye Levrek arayüz sunucusuna bağlıyken terminalde ``module available`` komutu ile ulaşılabilir. Ayrıntılı bilgiler için lütfen :ref:`moduller-truba` sayfasına bakınız.

 .. code-block::

    module load centos7.3/comp/intel/PS2019-update1

    Hamsi kümesinde Intel OneAPI için:

    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

* **OpenMPI** ile derleme yapmak için, OpenMPI için oluşturulmuş ilgili modül dosyasının yüklenmesi gerekmektedir. 

  GCC ile derlenmiş OpenMPI için: 

 .. code-block::

    module load centos7.3/lib/openmpi/4.0.1-gcc-7.0.1

    Hamsi kümesi için:

    module load centos7.9/lib/openmpi/4.1.1-gcc-7


 Intel ile derlenmiş OpenMPI için: 

 .. code-block::

    module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

    Hamsi kümesi için:

    module load centos7.9/lib/openmpi/4.1.1-intel-oneapi-2021.2

----------------------
OpenMP (Multi-thread) 
----------------------

Derleme GCC derleyicileri ile yapılacak ise ayrıca herhangi bir module yüklemeye gerek bulunmamaktadır. Ancak Intel matematik kütüphanesinin avantajları kullanılmak isteniyorsa, Intel çevre değişkenlerinin kullanılması gerekmektedir.  

 .. code-block::

    module load centos7.3/comp/intel/PS2019-update1
    veya
    module load centos7.3/comp/intel/PS2018-update2

    Hamsi kümesi için:

    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

-----------------------------------------------------
 Multithread/multitask uygulamaların çalıştırılması
-----------------------------------------------------

OpenMP ya da pthread tarzı sadece node içi paralelleştirme kullanan uygulamaları ``sbatch`` ya da ``srun`` ile çalıştırırken dikkat edilmesi gereken bazı husular bulunmaktadır.

**Sbatch ile çalışırken:**

**-N 1 :** en fazla 1 node kullanılmalı

**-n 5 (ya da -c 5) :** iş tanımı için en az - en fazla 5 çekirdek ayrılır. Sbatch herhangi bir görev çalıştırmadığı için -n parametresi de sorun oluşturmayacaktır. Ancak doğru olan -c 'yi kullanmaktır.

**export OMP_NUM_THREADS=5 :** uygulama kendisi için 5 çekirdeğe kadar izin verildiğinden haberdar edilir. Bazı uygulamalar izin verilen çekirdek sayısını otomatik olarak farkedebilir. Ancak genel olarak bunu yazmaya ihtiyaç vardır.

**srun ile çalışırken:**

**-N 1 :** en fazla 1 node kullanılmalıdır.

**-n 1 :** 1 task/görev başlatılacaktır.

**-c 5:** görev başına 5 çekirdeğe izin verilecektir.

Uygulama kaç çekirdek kullanabilecegini otomatik algılayabilmeli ya da, ``export OMP_NUM_THREADS=5`` komutu, ``srun`` komutundan önce çalıştırılmalıdır.

.. note::

   -n değeri 1 den fazla olursa, örneğin 2, komutun iki kopyası birbirinden bağımsız olarak çalıştırılacaktır. 

--------------------------------------------------
 Hibrid (MPI+OpenMP) uygulamaların çalıştırılması
--------------------------------------------------

Genel olarak tersi olsa da, iyi tasarlanmış hibrid uygulamaların (örnegin Intel MKL ile birlikte gelen xhpl) performansı MPI uygulamalardan daha iyi olabilmektedir. Bunun başlıca sebebi, nodelar arası gerçekleşen iletişim ihtiyaçlarının önemli ölçüde azalması, node içerisindeki tasklar arası haberleşmenin, network ya da Infiniband katmanına göre çok daha hızlı olan ortak bellek üzerinde gerçekleşmesidir.

xhpl'in *hibrid, mpi ve multitask* versiyonları için hazırlanmış olan slurm betiklerini ``/truba/sw/script`` dizini altında bulabilirsiniz.

Hibrid bir iş çalıştırırken; *node sayısı, çalıştırılacak görev sayısı, ve görev başına kullanılacak çekirdek sayısı* parametreleri slurm dosyasında belirtilmelidir. Ayrıntılı bilgiye ``man sbatch`` komutu ile ulaşılabilir.


**Sbatch ile çalışırken:**

**-N 4 :** -n tane taskın başlatılacağı node sayısı

**-n 16 :** başlatılacak görev sayısı, node başına eşit sayıda görev düşmesi performansa olumlu etki yapacaktır. O nedenle -N'in katları şeklinde olması önemlidir.

**-c 4 :** görev başına kullanılacak çekirdek sayısı. Burada, node başına düşen görev sayısı x gorev başına düşen çekirdek sayısının, ilgili node'un çekirdek sayısını aşmaması gerekir.

Bu yapılandırma ile her biri 4 çekirdeğe kadar kaynak kullanabilen toplamda 16 görev (16x4 =64 çekirdek) 4 node üzerinde çalıştırılacaktır.

.. note::

   Eğer işlemcinin hybertreading özelliği kullanılmak isteniyorsa, ayrıca ``--threads=2`` ve ``export OMP_NUM_THREADS=4`` yapılandırması kullanılabilir. Hyperthreading'in performansa katkısı uygulamaya göre değişebilir. Kullanıcının test edip değerlendirmesi gereken bir durumdur. 
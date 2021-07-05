
İletişimciler ve Gruplar
========================

Yazılım kütüphanelerinin kullanımı, programcıların her ihtiyaç duyulduğunda tekerleği yeniden icat etmek zorunda kalmadan yeni yazılım geliştirmelerine olanak tanır. Yazılım bileşenleri, düzgün bir şekilde paketlenir ve belgelenirse, programcıların amaçlarına uyacak şekilde kolayca yeniden kullanılabilir ve birleştirilebilir. MPI standardı farklı mimarilerde sorunsuz bir şekilde çalışabilmek için işlemler arasındaki iletişimi ve işlemler hakkındaki bilgileri ``communicators`` ve ``groups`` soyutlaştırmaları ile sağlar.

İletişimciler iki farklı şekilde tanımlanır:


* ``Intracommunicators``\ : Noktadan noktaya ve toplu mesaj aktarma rutinleri aracılığıyla etkileşime girebilen işlemler topluluğu.
* ``Intercommunicators``\ : Mesaj iletimi yoluyla etkileşime girebilen ayrık ``intracommunicator`` süreçlerin toplamıdır.

Bu dersin kapsamında ``intracommunicator``\ 'lar ile ilgileneceğiz ve bunlara kısacası iletişimci diye hitap edeceğiz.

Bir iletişimci temel iki objeden oluşur:


* Grup (group): sıralı bir işlem koleksiyonu. Gruptaki her işleme, negatif olmayan bir tam sayı olan bir sıra atanır. Sıralama, gruptaki her süreci benzersiz bir şekilde tanımlar.
* Bağlam (context): her bir iletişimciyi benzersiz şekilde tanımlayan sistem tanımlı bir objedir. Bağlam iletişimci için benzersiz olduğu için aynı grup birden fazla iletişimciye ait olabilir.

``MPI_COMM_WORLD`` mpi kütüphanesi tarafından önceden tanımlanmış iletişimcidir.

.. code-block:: c

   MPI_Comm comm = MPI_COMM_WORLD;

Herhangi bir iletişimcideki işlemci sayısını ve büyüklüğünü aşağıdaki fonksiyonları kullanarak elde edebiliriz.

.. code-block:: c

   int rank;
   int size;
   MPI_Comm_size(comm, &size);
   MPI_Comm_rank(comm, &rank);

MPI ile İletişimci Yaratmak
---------------------------

Yaratılmış iletişimcilerin bağlamı direk olarak değiştirilemez fakat ait olduğu grup aşağıdaki gibi çağırabilir.

.. code-block:: c

   int MPI_Comm_group(MPI_Comm comm,
                      MPI_Group *group)

Peki grupları nasıl manipüle edebiliriz?


* Hali hazırda varolan gruplardan işlemcileri ekleyerek ve çıkararak.
* Hali hazırda var olan gruplar üzerinde küme işlemleri, kesişim vb., kullanarak.

İşlemlerin çıkarılması ve dahil edilmesi, sıralar ile yapılır, sıranın bir grup içindeki bir işlemin benzersiz tanımlayıcısı olduğunu hatırlayın.

.. code-block:: c

   int MPI_Group_excl(MPI_Group group,
                      int n,
                      const int ranks[],
                      MPI_Group *newgroup)

``MPI_comm_create`` fonksiyonunu yeni yarattığımız grup ile çağırdığımızda bize bu grubun arasındaki mesajlaşmayı destekleyecek bir iletişimci yaratır.

.. code-block:: c

   int MPI_Comm_create(MPI_Comm comm,
                       MPI_Group group,
                       MPI_Comm *newcomm)

İletişimci Örneği
^^^^^^^^^^^^^^^^^

.. code-block:: c

   /* Adapated from:
    * https://github.com/UoB-HPC/hpc-course-examples/blob/master/mpi/advanced/example10/group_to_comm.c
    */

   #include <stdio.h>
   #include <stdlib.h>

   #include <mpi.h>

   #define NPROCS 4

   int main(int argc, char *argv[]) {
     int rank;
     int size;
     int new_rank;
     int sendbuf;
     int recvbuf;
     int count;
     // list of process ranks in first and second groups
     int ranks1[2] = {0, 1};
     int ranks2[2] = {2, 3};

     MPI_Group world_group;
     MPI_Group new_group;
     MPI_Comm new_comm;

     MPI_Init(&argc, &argv);
     MPI_Comm_rank(MPI_COMM_WORLD, &rank);
     MPI_Comm_size(MPI_COMM_WORLD, &size);

     // MPI_COMM_WORLD büyüklüğü oluşturacağımız gruplar için uygun mu kontrol ediyoruz
     if (size != NPROCS) {
       fprintf(stderr, "Error: Must have %d processes in MPI_COMM_WORLD\n",
               NPROCS);
       MPI_Abort(MPI_COMM_WORLD, 1);
     }

     // işlem kendi sırasını diğer işlemlere yollayacak
     sendbuf = rank;
     count = 1;

     // MPI_COMM_WORLD grubunu alyoruz
     MPI_Comm_group(MPI_COMM_WORLD, &world_group);

     // split the processes in half, one half goes to ranks1 the other to ranks2
     if (rank < NPROCS / 2) {
       MPI_Group_excl(world_group, NPROCS / 2, ranks1, &new_group);
     } else {
       MPI_Group_excl(world_group, NPROCS / 2, ranks2, &new_group);
     }

     MPI_Comm_create(MPI_COMM_WORLD, new_group, &new_comm);

     // compute total of ranks in MPI_COMM_WORLD in the newer, smaller communicator
     MPI_Allreduce(&sendbuf, &recvbuf, count, MPI_INT, MPI_SUM, new_comm);

     // yeni gruptaki işlem sırası
     MPI_Group_rank(new_group, &new_rank);

     printf("rank= %d newrank= %d recvbuf= %d\n", rank, new_rank, recvbuf);

     MPI_Group_free(&world_group);
     MPI_Group_free(&new_group);
     MPI_Comm_free(&new_comm);

     MPI_Finalize();

     return EXIT_SUCCESS;
   }

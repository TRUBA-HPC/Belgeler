
Engellemeyen İletişim
=====================

Önceki derste, sıralar arasında iletişim kurmak için ``MPI_Send`` ve ``MPI_Recv`` işlevlerini kullandık. Bu işlemlerin program akışını bloke ettiğini gördük. ``MPI_Send`` yalnızca program gönderme arabelleğini güvenli bir şekilde değiştirebildiğinde dönecek ve ``MPI_Recv`` yalnızca veriler alındıktan ve alma arabelleğine yazıldıktan sonra dönecektir. Bu şekilde iletişim kurmak güvenli ve basittir, ancak iletişim gerçekleşirken programın beklemesine neden olur. Genellikle veri beklerken gerçekleştirebileceğimiz hesaplamalar vardır bunun için asenkron bir iletişim şekline ihtiyaç vardır.

MPI standardı, gönderme ve alma işlevlerinin, ``MPI_Send`` ve ``MPI_Recv``\ , engellenmeyen asenkron sürümlerini içerir: ``MPI_Isend`` ve ``MPI_Irecv``. Bu işlevler hemen geri dönerek programın akışı üzerinde daha fazla kontrol sahibi olmanızı sağlar. Onları çağırdıktan sonra, gönderme veya alma arabelleğini değiştirmek güvenli değildir, ancak program diğer işlemlere devam etmekte serbesttir. Arabelleklerdeki verilere ihtiyaç duyduğunda, ``MPI_Wait`` ve ``MPI_Test`` işlevlerini kullanarak iletişim sürecinin tamamlandığından emin olması gerekir.

MPI_Isend
^^^^^^^^^

.. code-block:: c

   int MPI_Isend(
      void* data,
      int count,
      MPI_Datatype datatype,
      int destination,
      int tag,
      MPI_Comm communicator,
      MPI_Request* request)

**data:** gönderilen verinin başlangıcına işaret eden değişken

**count:** yollanacak eleman sayısı

**datatype:** yollanan verinin tipi

**destination:** verilerin gönderileceği programın sıra numarası

**tag:** bir mesaj etiketi (integer)

**communicator:**  programlar arası iletişimi sağlayan obje

**request:** isteğin yapısına ilişkin işaretçi

MPI_Irecv
^^^^^^^^^

.. code-block:: c

   int MPI_Irecv(
      void* data,
      int count,
      MPI_Datatype datatype,
      int source,
      int tag,
      MPI_Comm communicator,
      MPI_Request* request)

**data:** alınacak verinin yazılacağı değişkenin başlangıcına işaret eden işaretçi

**count:** alınacak eleman sayısı

**datatype:** alınacak verinin tipi

**source:** verilerin alınacağı programın sıra numarası

**tag:** bir mesaj etiketi (integer)

**communicator:** programlar arası iletişimi sağlayan obje

**status:** MPI komutunun çıkış durumunu yazmak için bir işaretçi

**request:** isteğin yapısına ilişkin işaretçi

Asenkron fonksiyonlarda senkron fonksiyonlara kıyasla ek olarak bir request parametresi gerekir. Bu, program tarafından başlatılan her bir ayrı aktarımı takip etmek için kullanılır. ``MPI_Test`` işlevini kullanarak bir aktarımın durumunu kontrol etmek için kullanabilir veya aktarım tamamlanana kadar beklemek için ``MPI_Wait``\ 'i çağırabilirsiniz.

Test and Wait
-------------

``MPI_Test``\ , bir istek tarafından belirtilen aktarımın durumunu döndürür ve ``MPI_Wait``\ , geri dönmeden önce aktarımın tamamlanmasını bekler. İstek, ``MPI_Isend`` veya ``MPI_Irecv`` tarafından oluşturulabilir.

MPI_Test
^^^^^^^^

.. code-block:: c

   int MPI_Test(
      MPI_Request* request,
      int * flag,
      MPI_Status* status)

**request:** test edilecek istek

**flag:** yollanacak eleman sayısı

**status:** bu komutun sonucunun yazılacağı işaretçi

MPI_Wait
^^^^^^^^

.. code-block:: c

   int MPI_Wait(
      MPI_Request* request,
      MPI_Status* status)

**request:** beklenicek istek

**status:** bu komutun sonucunun yazılacağı işaretçi

Bu işlevler, ``MPI_Send`` ve ``MPI_Recv``\ 'ye benzer şekilde kullanılabilir. Bir önceki derste bahsettiğimiz “Hello World!” mesajı gönderen programda ``MPI_Send`` ve ``MPI_Recv``\ 'i, ``MPI_ISend``\ , ``MPI_IRecv`` ve ``MPI_Wait`` kullanarak nasıl değiştirebileceğinizi aşağıdaki örnekten bakabilirsiniz.

.. code-block:: c

   #include <stdio.h>
   #include <mpi.h>

   int main(int argc, char** argv) {
     int rank, n_ranks;
     int my_first, my_last;
     int numbers = 10;
     MPI_Request request;

     // mpi programını başlatmak için Init fonksiyonunu çağırıyoruz
     MPI_Init(&argc, &argv);

     // mpi tarafından 2 veya 2 den fazla programın varlığını kontrol ediyoruz
     // eğer sadece bir program varsa programımız çökecektir
     MPI_Comm_size(MPI_COMM_WORLD,&n_ranks);
     if( n_ranks < 2 ){
       printf("This example requires at least two ranks");
       MPI_Finalize();
       return(1);
     }

     // programın sırasını elde etmek için Comm_rank fonksiyonunu çağırıyoruz
     MPI_Comm_rank(MPI_COMM_WORLD,&rank);

       // eğer programın sırası 0 ise send komutunu kullanarak sırası 1 olan 
     // programa Hello, world!\n mesajını yolluyoruz
       // bu örnekte bir önceki örnekten farklı olarak 
     // asenkron yollama fonksiyonunu kullanıyoruz
     if( rank == 0 ){
        char *message = "Hello, world!\n";
        MPI_Isend(message, 16, MPI_CHAR, 1, 0, MPI_COMM_WORLD, &request);
     }

       // eğer programın sırası 1 ise sırası 0 olan programdan
       // 16 uzunluğunda bir karakter listesi bekliyoruz
       // MPI_Irecv ve MPI_Wait fonksiyonları arasında 
       // beklediğimiz mesajı içermeyen işlemler gerçekleştirerek
       // iletişimi ve işlemi aynı anda yapabiliriz
     if( rank == 1 ){
        char message[16];
        MPI_Status status;
        MPI_Irecv(message, 16, MPI_CHAR, 0, 0, MPI_COMM_WORLD, &request);
        MPI_Wait( &request, &status );
        printf("%s",message);
     }

     // Call finalize at the end
     return MPI_Finalize();
   }

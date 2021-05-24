
MPI_Send ve MPI_Recv
====================

Bu bölümde başlıkta da belirttiğimiz gibi, bir programdan diğerine veri yollamak için temel iki *MPI* kütüphanesi fonksiyonu kullanacağız. (\ ``MPI_Send / MPI_Recv``\ )

``MPI_Send / MPI_Recv`` fonksiyonları programlar arası iletişim araçları olmakla birlikte, *MPI* kütüphanesinin barındırdığı diğer fonksiyonların basit yapı taşlarıdır. Bu fonksiyonlar iki program arasında iletişimi sağladığından dolayı noktadan noktaya iletişim olarak sınıflandırılır.


.. image:: assets/mpi_ortam.png
   :target: assets/mpi_ortam.png
   :alt: assets/mpi_ortam.png

*MPI* arayüzünde iletişim oldukça basittir. Program 0, program 1'e mesaj yollamak istediğinde, mesajda yollanacak veriyi bir tamponda birleştirir ve ``MPI_Send`` komutunu kullanarak yollar. Tampon oluşturulması verilerin birlikte gönderilmesini sağlar ve yollanan verinin gecikmesini minimuma indirger. Program 1 ise mesaj alacağını bilerek ``MPI_Recv`` komutunu kullanarak Program 0 dan mesaj bekler ve yollanan veriyi tek bir mesajda alır. Mesaj ``MPI_Send`` çağırılmış olsa bile alıcı program tarafından ``MPI_Recv`` çağırılmadan yollanmaz.

MPI_Send
--------

.. code-block:: c

   int MPI_Send(
      void* data,
      int count,
      MPI_Datatype datatype,
      int destination,
      int tag,
      MPI_Comm communicator)

**data:** gönderilen verinin başlangıcına işaret eden değişken

**count:** yollanacak eleman sayısı

**datatype:** yollanan verinin tipi

**destination:** verilerin gönderileceği programın sıra numarası

**tag:** bir mesaj etiketi (integer)

**communicator:**  programlar arası iletişimi sağlayan obje

MPI_Recv
--------

.. code-block:: c

   int MPI_Recv(
      void* data,
      int count,
      MPI_Datatype datatype,
      int source,
      int tag,
      MPI_Comm communicator,
      MPI_Status* status)

**data:** alınacak verinin yazılacağı değişkenin başlangıcına işaret eden işaretçi

**count:** alınacak eleman sayısı

**datatype:** alınacak verinin tipi

**destination:** verilerin alınacağı programın sıra numarası

**tag:** bir mesaj etiketi (integer)

**communicator:** programlar arası iletişimi sağlayan obje

**status:** MPI komutunun çıkış durumunu yazmak için bir işaretçi

Mesaj etiketi iki program arasında birden fazla mesaj gönderilir ise bu mesajlar arasında ayrım yapabilmek için kullanılmaktadır. Communicator ise paralel bir şekilde çalışan programlarımızın kayıtlı olduğu ve bu programların arasındaki iletişimi sağlayan objedir.

Örnek Program
-------------

"Hello World!" dizinini sıra numarası 0 olan programdan 1 olan programa yollamak için uyarlanmış bir örnek programı aşağıdaki kod bloğunda bulabilirsiniz.

.. code-block:: c

   #include <stdio.h>
   #include <mpi.h>

   int main(int argc, char** argv) {
     int rank, n_ranks;

     // mpi programını başlatmak için Init fonksiyonunu çağırıyoruz
     MPI_Init(&argc, &argv);

     // mpi tarafından 2 veya 2 den fazla programın varlığını kontrol ediyoruz
     // eğer sadece bir program varsa programımız çökecektir
     MPI_Comm_size(MPI_COMM_WORLD,&n_ranks);
     if( n_ranks != 2 ){
       printf("This example requires exactly two ranks\n");
       MPI_Finalize();
       return(1);
     }

     // programın sırasını elde etmek için Comm_rank fonksiyonunu çağırıyoruz
     MPI_Comm_rank(MPI_COMM_WORLD,&rank);

       // eğer programın sırası 0 ise send komutunu kullanarak sırası 1 olan 
     // programa Hello, world!\n mesajını yolluyoruz
     if( rank == 0 ){
        char *message = "Hello, world!\n";
        MPI_Send(message, 16, MPI_CHAR, 1, 0, MPI_COMM_WORLD);
     }

       // eğer programın sırası 1 ise sırası 0 olan programdan
       // 16 uzunluğunda bir karakter listesi bekliyoruz
     if( rank == 1 ){
        char message[16];
        MPI_Status  status;
        MPI_Recv(message, 16, MPI_CHAR, 0, 0, MPI_COMM_WORLD, &status);
        printf("%s",message);
     }

       // son olarak mpi programını bitirmek için finalize fonksiyonunu çağırıyoruz 
     // ve sonucu dönüyoruz
     return MPI_Finalize();
   }

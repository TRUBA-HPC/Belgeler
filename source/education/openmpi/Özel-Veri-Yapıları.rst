
Özel Veri Yapıları
==================

Özel veri türleri tanımlama kabiliyeti, programcıların kodlarını okunabilirliği ve sürdürülebilirliği artıracak şekilde yapılandırmasına olanak tanıdığından, modern bir programlama dilinin ayırt edici özelliklerinden biridir. MPI standardı programlama dillerinin hem bu özelliğini desteklemek hem de işlemciler arasında transfer edilen mesaj sayısını en aza indirebilmek için özel veri yapılarını desteklemektedir.

Önceklikle MPI'ın hangi basit data yapılarını desteklediğini görelim:

`Desteklenen Data Yapıları <https://www.notion.so/3c320768e3194ef2b60d8a84841819e6>`_

C programlama dilinde veri tipleri, standart tarafından tanımlanmış ve derleyici tarafından icra edilen, primitif yapılardır. MPI data yapıları ise derleyici tarafından farklı veri yapıları olarak gözükmez, özel veri yapılarının hepsi derleyici tarafından ``MPI_Datatype``\ 'ın türleri olarak algılanmaktadır. Bu yüzden  özel veri yapılarını kullanırken dikkat edilmesi gereken unsurlar bulunmaktadır.

C programa dilinde özel bir veri yapısı aşağıdaki gibi tanımlanabilir:

.. code-block:: c

   struct pair{
       int first,
       char second
   }

 Bu şekilde tanımlanan ``pair``  veri yapısı yeni bir veri yapısıdır. C standardı bu yeni data yapısının sorunsuz bir şekilde kullanılması için gereklilikleri belirler ve derleyici de gereken makine kodunu oluşturur. Böylece kullanıncı için yeni oluşturulan bu veri yapısının temel veri yapılarından bir farkı yoktur, fakat bunların hepsi derleme zamanında gerçekleşir.

MPI'da özle veri yapılarını kullanmak için kullanıcının heterojen mimarilerde sorunsuz bir şekilde mesaj yollayıp alabilmesi için alt düzey bilgiler vermesi gerekmektedir.

Özel Veri Yapılarının MPI'da Temsil Edilişi
-------------------------------------------

Veri türü imzası yeni oluşturulan ver türündeki basit verilerin türlerini depolar.

$Type signature[𝚃]=[𝙳𝚊𝚝𝚊𝚝𝚢𝚙𝚎0,…,𝙳𝚊𝚝𝚊𝚝𝚢𝚙𝚎𝑛−1]$

Tip haritası, MPI tarafından algılan data türlerini anahtar ve bunların bayt cinsinden büyülüklerini değer olarak tutar.

$Typemap[𝚃]={𝙳𝚊𝚝𝚊𝚝𝚢𝚙𝚎0:Displacement0,…,𝙳𝚊𝚝𝚊𝚝𝚢𝚙𝚎𝑛−1:Displacement𝑛−1}$

Yer ``displacements``\ , veri tipinin tanımladığı arabelleğe görecedir.

Bir ``int``\ 'nin 4 bayt bellek aldığını varsayarsak, ``pair`` veri türünün tip haritası şöyle olur:

$Typemap[𝙿𝚊𝚒𝚛]={𝚒𝚗𝚝:0,𝚌𝚑𝚊𝚛:4}$

Tür haritası ve imzası bilgisi, türün MPI'da kullanılabilmesi için yeterli değildir. Temel alınan programlama dili, temel veri türlerinin mimariye özgü hizalanmasını zorunlu kılabilir. Türü MPI'a kaydedebilmek için birkaç konsepte daha ihtiyacımız var. Bir tip haritası, 𝑚, verildiğinde aşağıdakileri tanımlayabiliriz:

**Alt Sınır:**

Veri türünün kapsadığı ilk baytı temsil eder.

$LB[𝑚]=min_𝑗[Displacement_𝑗]$

**Üst Sınır:**

$UB[𝑚]=max_𝑗[Displacement_𝑗+𝚜𝚒𝚣𝚎𝚘𝚏(Datatype_𝑗)]+Padding$

**Boyut:**

$Extent[𝑚]=UB[𝑚]−LB[𝑚]$

C programlama dilinde verilerin bellekte düzgün tanımlanmış adreslerde olması gerekir, başka bir deyişle verilerin hizalanması gerekir. Herhangi bir öğenin bayt cinsinden adresi, o öğenin bayt cinsinden boyutunun katı olmalıdır. Buna doğal hizalama denir. ``pair`` veri yapımız için ilk öğe bir ``int``\ 'dir ve 4 baytlık yer kaplar. Bir ``int``\ , 4 bayt sınırlarına hizalanır: bellekte yeni bir ``int`` tahsis ederken, derleyici hizalama sınırına ulaşmak için dolgu ekler. ``second`` bir karakterdir ve sadece 1 bayt gerektirir, bu yüzden de her adrese tanımlanabilir.

$p𝚊𝚒𝚛.𝚏𝚒𝚛𝚜𝚝→Displacement0=0,𝚜𝚒𝚣𝚎𝚘𝚏(𝚒𝚗𝚝)=4$

$p𝚊𝚒𝚛.𝚜𝚎𝚌𝚘𝚗𝚍→Displacement1=4,𝚜𝚒𝚣𝚎𝚘𝚏(𝚌𝚑𝚊𝚛)=1$

Başka bir ``pair`` öğesi eklerken, bir sonraki ``int`` baytının uygun bir adresten başlayabilmesi için, 3 baytlık bir dolgu ile hizalama sınırına ulaşmamız gerekir. Böylece:

$LB[𝙿𝚊𝚒𝚛]=min[0,4]=0$

$UB[𝙿𝚊𝚒𝚛]=max[0+4,4+1]+3=8$

$Extent[𝙿𝚊𝚒𝚛]=UB[𝙿𝚊𝚒𝚛]−LB[𝙿𝚊𝚒𝚛]=8$

Bir sonraki bölümde yukarıda anlatılan detayları göz önünde bulundurarak bir MPI veri türü tanımlaycağız.

MPI ile özel veri yapısı yaratma
--------------------------------

Yukarıda C kodunu gösterdiğimiz özel veri türü, ``pair``\ , MPI'da tanımlamak için öncelikle verinin imza tipini belirtiyoruz.

.. code-block:: c

   MPI_Datatype typesig[2] = {MPI_INT, MPI_CHAR};

``pair``\ 'in içerdiği verilerin sayısını belirtiyoruz.

.. code-block:: c

   int block_lengths[2] = {1, 1};

``pair`` veri türünün içinde barındırdığı verilerin başlangıç adreslerini ``displacements``\ 'ta depoluyoruz. Bu yukarda bahsettiğimiz sebeplerden dolayı gerçekleştirmemiz gereken bir adım.

.. code-block:: c

   MPI_Aint displacements[2];
   MPI_Get_address(&my_pair.first, &displacements[0]);
   MPI_Get_address(&my_pair.second, &displacements[1]);

Yukarda örneğini verdiğimiz ``pair`` veri türünün iki alanı var dolayısıyla ``MPI_Type_create_struct`` çağrısında ``count = 2``\ 'dir.  

.. code-block:: c

   MPI_Datatype mpi_pair;
   MPI_Type_create_struct(2, block_lengths, displacements, typesig, &mpi_pair);
   MPI_Type_commit(&mpi_pair);

Veri yapısının kullandıktan sonra serbest bırakıyoruz.

.. code-block:: c

   MPI_Type_free(&mpi_pair);

Paketleme ve Çözme
------------------

MPI yapıları aynı olmayan verileri birlikte yollayabilmek için paketleme ve çözme alt yapısı sağlamaktadır. Böylece birlikte yollamak istediğimiz farklı veri yapılarını her zaman yeni bir veri yapısı tanımlayarak yollamak zorunda kalmayız. Paketleme sonucu ortaya çıkan paketlenmiş arabellek ``MPI_PACKED`` türündedir ve MPI tarafından tanınan herhangi bir tür heterojen temel veri türü koleksiyonunu içerebilir.


.. image:: assets/pack-unpack.png
   :target: assets/pack-unpack.png
   :alt: assets/pack-unpack.png


Yukarıdaki figürden de gösterildiği gibi farklı veri yapılarına ait olan değerler tek bir mesaja bitişik bir şekilde paketlenir ve alıcı da aynı şekilde çözülür.

MPI_Pack
^^^^^^^^

.. code-block:: c

   int MPI_Pack(const void *inbuf,
                int incount,
                MPI_Datatype datatype,
                void *outbuf,
                int outsize,
                int *position,
                MPI_Comm comm)

**inbuf:** yollayacağımız verinin işaretçisi

**incount:** paketleyeceğimiz veri miktarı

**datatype:** paketleyeceğimiz verinin türü

**outbuf:** yollayacağımız mesajı temsil eden arabelleğinin işaretçisi

**outsize:** yollayacağımız mesajın büyüklüğü

**position:** ``outbuf`` içindeki konumları tanımlayan bir **giriş/çıkış** parametresidir. ``inbuf``\ 'taki veriler ``outbuf`` + ``*position``\ 'a kopyalanacaktır. Fonksiyon geri döndükten sonra, ``*position`` değeri, çıkış verisindeki yeni kopyalanan verileri izleyen ilk konumu gösterir. Bu, ``MPI_Pack``\ 'e bir sonraki çağrıya konum olarak geçmek için kullanışlıdır.

**comm:** programlar arası iletişimi sağlayan obje

MPI_Unpack
^^^^^^^^^^

.. code-block:: c

   int MPI_Unpack(const void *inbuf,
                  int insize,
                  int *position,
                  void *outbuf,
                  int outcount,
                  MPI_Datatype datatype,
                  MPI_Comm comm)

**inbuf:** aldığımız mesajı temsil eden arabelleğin işaretçisi

**insize:** aldığımız mesajın büyüklüğü

**position:** ``outbuf`` içindeki konumları tanımlayan bir giriş/çıkış parametresidir. ``inbuf`` veriler ``outbuf + *position`` kopyalanacaktır. Fonksiyon geri döndükten sonra, ``*position`` değeri, çıkış verisindeki yeni kopyalanan verileri izleyen ilk konumu gösterir. Bu, ``MPI_Pack``\ 'e bir sonraki çağrıya konum olarak geçmek için kullanışlıdır.

**outbuf:** çıkardığımız veriyi temsil eden arabelleğin işaretçisi

**outcount:** çıkardığımız verideki eleman miktarı

**datatype:** çıkardığımız verinin türü

**comm:** programlar arası iletişimi sağlayan obje

Pokemonlar ile Paketleme/Çıkarma Örneği
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: c

   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   #include <mpi.h>

   #define STRLEN 25

   /*
     Bu örnekte sanal bir pokemonun hareketlerini birer mesaj olarak göndereceğiz.
     Bu niteliklerin her birisini paketleyerek yollayıp, aldığımızda çıkartacağız.
   */

   int main(int argc, char *argv[]) {
     int rank;
     int size;
     // marker used by MPI_Pack and MPI_Unpack
     int position;

     // pokemonun ismi
     char name[STRLEN];
     // pokemonun canı
     double life_points;
     // pokemunun gerçekleştirdiği zarar
     int damage;
     // güç katsayısı
     double multiplier;

     // stdio.h deki BUFSIZ'ı yeterli büyüklükte olduğunu düşünerek kullanıyoruz
     char message[BUFSIZ];

     MPI_Init(&argc, &argv);

     MPI_Comm comm = MPI_COMM_WORLD;

     MPI_Comm_size(comm, &size);
     MPI_Comm_rank(comm, &rank);

     // 0'ıncı sıraya sahip olan işlem diğer bütün işlemlere pokemunun hareketini temsil eden bir mesaj yollayacak
     if (rank == 0) {
       sprintf(name, "Blastoise");
       life_points = 150.0;
       damage = 40;
       multiplier = 1.32;

       position = 0;
       // paketleme işlemini gerçekleştiriyoruz
       MPI_Pack(&name, STRLEN, MPI_CHAR, message, BUFSIZ, &position, comm);

       printf("packed name, position = %d\n", position);

       MPI_Pack(&life_points, 1, MPI_DOUBLE, message, BUFSIZ, &position, comm);
       printf("packed life_points, position = %d\n", position);

       MPI_Pack(&damage, 1, MPI_INT, message, BUFSIZ, &position, comm);
       printf("packed damage, position = %d\n", position);

       MPI_Pack(&multiplier, 1, MPI_DOUBLE, message, BUFSIZ, &position, comm);
       printf("packed multiplier, position = %d\n", position);

       // mesajı diğer bütün işlemlere yolluyoruz
       MPI_Bcast(message, BUFSIZ, MPI_PACKED, 0, comm);
     } else {
       // diğer bütün işlemlerde mesajı alıyoruz
       MPI_Bcast(message, BUFSIZ, MPI_PACKED, 0, comm);

       position = 0;
       // veri çıkarımına başlıyoruz
       // buarada yolladığımız mesajın uzunluğunu bilmeliyiz
       // bilmediğimiz durumlarda bu bilgiyi mesajın sonuna veya başına gömebiliriz
       MPI_Unpack(message, BUFSIZ, &position, &name, STRLEN, MPI_CHAR, comm);
       printf("unpacked name, position = %d\n", position);

       MPI_Unpack(message, BUFSIZ, &position, &life_points, 1, MPI_DOUBLE, comm);
       printf("unpacked life_points, position = %d\n", position);

       MPI_Unpack(message, BUFSIZ, &position, &damage, 1, MPI_INT, comm);
       printf("unpacked damage, position = %d\n", position);

       MPI_Unpack(message, BUFSIZ, &position, &multiplier, 1, MPI_DOUBLE, comm);
       printf("unpacked multiplier, position = %d\n", position);

       printf("rank %d:\n", rank);
       printf("  name = %s\n", name);
       printf("  life_points = %2.2f\n", life_points);
       printf("  damage = %d\n", damage);
       printf("  multiplier = %2.2f\n", multiplier);
     }

     MPI_Finalize();

     return EXIT_SUCCESS;
   }

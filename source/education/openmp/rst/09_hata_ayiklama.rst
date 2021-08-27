Hata Ayıklama
=============

OpenMP programlarında hata ayıklamak için ``gdb`` kullanılabilir.

``gdb``\ ’ın temel kullanımını anlatan bir belgeye `bu
adresten <http://www.belgeler.org/howto/gdb-NASIL.html>`__
ulaşabilirsiniz.

Hata ayıklamanın sağlıklı ilerleyebilmesi için ``g++`` derleyecisi
çağrılırken ``-g`` eklenmesi gereklidir. Bu şekilde derleyeci hata
ayıklamak için ``gdb`` tarafından kullanılabilecek bazı bilgileri de
programa ekler.

``gdb``\ ’nin standart komutlarının yanında, iş parçacıklarıyla ilgili
aşağıdaki ek komutlar kullanılabilir:

-  ``info threads``: iş parçacıkları ile ilgili çeşitli bilgiler verir.
   ``*`` ile işaretlenen iş parçacağı aktiftir.

::

   (gdb) info threads
     Id   Target Id             Frame
   * 1    process 35 thread 13  main (argc=1, argv=0x7ffffff8)
     2    process 35 thread 23  0x34e5 in sigpause ()
     3    process 35 thread 27  0x34e5 in sigpause ()
       at threadtest.c:68

-  ``break <satır> thread <iş parçacığı numarası>``: Sadece bu iş
   parçacağı belirtilen noktada durur. (Belirtilen iş parçacığı bu
   noktaya geldiğinde tüm iş parçacıkları duracaktır.)
-  ``thread <iş parçacığı numarası>``: Belirtilen iş parçacığına geçiş
   yapar. (tekrar ``info threads`` çalıştırılarak aktif parçacığın
   değiştiği gözlemlenebilir.)

Daha detaylı bilgi için `bu kaynağa
(İngilizce) <https://sourceware.org/gdb/onlinedocs/gdb/Threads.html>`__
göz atılabilir.


OpenMPI
=======

Yüksek Performanslı Hesaplamada (HPC), çok sayıda bilgisayar, hızlı bir ağ ile birbirine bağlanır. Bir HPC sistemini verimli bir şekilde kullanmak, iyi tasarlanmış bir paralel algoritma gerektirir. Birbirine bağlı bu bilgisayarlar arasında program düzeyinde iletişimi sağlamak için kullanılan araçlardan bir tanesi *MPI* (Message Passing Interface)dir. *MPI* mesaj aktarma arayüzü olarak adlandırılmış programlar arasında bir çok farklı şekilde iletişim şeklini destekleyen bir standarttır. Bu standartın nerdeyse bütün platformlarda (Linux, Windows, OS X) çalıştırılabilen ve birçok farklı dil (C, C++, Fortran, Python) tarafından desteklenen alternatifleri bulunmaktadır.

Bu dokümanda *MPI* arayüzünün en önemli fonksiyonları işlenirken, genel olarak paralel programlama hakkında da bilgiler verilecek, ve *MPI* kullanarak programlarınızı nasıl hızlandırabileceğiniz anlatılacaktır.

.. toctree::
    :maxdepth: 1

    Slurm-ile-MPI-kullanımı.rst
    Seri-ve-Paralel-Bölgeler.rst
    MPI_Send-ve-MPI_Recv.rst
    Engellemeyen-İletişim.rst
    Toplu-Islemler.rst


Yakında eklenecek eğitimler:

* Paralel Paradigmalar ve Paralel Algoritmalar
* Toplu İşlemler
* Özel Veri Yapıları
* Sanal Topolojiler
* MPI-2 ve MPI-3
* Performans Ölçme ve Eniyileme

Materyal bu `eğitimden <https://pdc-support.github.io/introduction-to-mpi/>`_ yararlanarak EuroCC projesi için TRUBA üzerinde hazırlanmıştır.

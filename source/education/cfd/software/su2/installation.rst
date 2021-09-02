******************
1 - SU2 Kurulumu
******************
Yüksek başarımlı sunucularda benzetimler, çok kullanıcılı ortamlarda, size 
ayrılan kota dahilinde işlemci sayısında gerçekleştirilir. Tasarımları ve 
işletme ilkeleri gereği bu tür sunucular benzetimleri işlemleme isteği olarak 
bir sıraya sokmakta, ve sırası gelince çalıştırmaktadır. TÜBİTAK ULAKBİM 
sunucularında da çok sayıdaki araştırmacı sıraya girmektedir. Dolayısı ile ön 
çalışmaların tamamının bu sunucularda gerçekleştirilmesi hem çok zahmetli, 
hem de maliyetli olacaktır. Dolayısı ile büyük ve zaman alıcı benzetimlere 
başlamadan önce, mevcut yerel iş istasyonlarında, konfigürasyon dosyalarının 
ve ağların hazırlanması çalıştırma betiklerinin hazırlanması ve basit ağlarda 
çözümlerin alınması veya yakınsamanın görülmesi tavsiye edilir. Bu sebeple 
yerel iş istasyonunuzda bir kurulum yapılması gerekir.

1.1 - Kapsam
============
Bu kurulum kılavuzu SU2 yazılımının kaynak kodlarından Linux ortamına 
kurulmasına odaklanmıştır. Windows ve diğer sistemler ve de binary kurulumlar
için SU2 sitesinde çözümler mevcuttur. Linux sürümü olarak herhangi bir 
varsayımda bulunulmamıştır. İş istasyonunuzda mevcut kuruluma göre paket 
yöneticileri ile gerekli ön kurulumların yapılacağı varsayılmıştır.

1.2 - Kurulum Hangi Özellikleri Kapsamalıdır?
=============================================
SU2 kurulumunun yüksek başarımlı sunucularda koşulacağı düşünülerek aşağıdaki
özellikler ile koşulması tavsiye edilir.

1.2.1. MPI
----------
*MPI* (Message Passing Interface) bir paralel haberleşme protokolüdür. SU2 
yazılımını büyük problemler için kullandığınızı düşünerek, tüm işlemci 
çekirdeklerini bir arada kullanarak çözüm almak için bir MPI kütüphanesi 
kurmanız tavsiye edilir.

Temel olarak iki adet açık kaynak kodlu MPI kütüphanesi bulunur. Bunlar 
*OpenMPI* ve de *MPICH*'dir ve hemen hemen tüm *Linux* sürümlerinde ikisi de 
bulunur. İstenildiği takdirde açık kaynak olmayan MPI kütüphaneleri de 
mevcuttur. herhangi bir MPI kütüphanesinin paket yöneticileri tarafından 
kurulması paralel hesaplama için gereklidir yeterlidir. Bunun yanı sıra eğer 
derlemeyi de bilgisayarınızda yapacaksınız gerekli header dosyaları için 
geliştirme paketlerini de kurmayı unutmayın. Bu paketler, Linux dağıtımları 
arasında değişkenlik göstermekle birlikte ``-dev`` uzantılı paketlerdir. 
Örneğin openmpi paketini kurduysanız openmpi-dev paketini de kurmalısınız.

.. note::
    Eğer bilgisayarınızda birden fazla MPI kurulumu varsa, SU2 derlemesinde
    ve çalıştırmasında kullanmak isteyeceğiniz MPI kütüphanesini seçmek 
    isteyebilirsiniz. BU amaçla farklı dağıtımların farklı çözümleri olabilmek
    ile birlikte bilinen bir çözüm de ``mpi-selector`` programıdır. Bu sayede aynı
    bilgisayar üzerinde pek çok farklı MPI sürümü kullanabilirsiniz. 

    Aynı şekilde, eğer ULAKBİM sunucularına derlediğiniz SU2 yazılımı 
    isterseniz, aynı işletim sisteminde ve mevcut MPI sürümlerinden birisi ile
    kendi iş istasyonunuzda derlediğiniz sürümü aktarabilirsiniz. Sunucularda
    mevcut MPI sürümleri için sistem yardım dokümanlarına başvurabilirsiniz.

1.2.2. CGNS
-----------
*CGNS* (CFD General Notation System) HAD yazılımları arasında çözüm ağı ve veri
alışverişi yapılması için geliştirilmiş bir formattır. Hemen hemen tüm art 
işlemciler ve çoğu ağ üreteci bu formatta dosyaları üretebilmekte/ 
işleyebilmektedir. Gerçek SU2 formatının yanı sıra bu formatta çıktı 
alabilmek için bilgisayarınıza bu kütüphaneyi ve dev paketlerini kurmanız 
tavsiye edilir.

1.2.3. Derleyici
----------------
SU2 derlenmesi için bir derleyiciye ihtiyacınız bulunmaktadır. Tüm Linux 
sunumları bir derleyici içeren meta paket sunmaktadır. *Ubuntu* ve türevleri 
için ``build-essential`` meta paketi bu işlevi görmektedir. Benzeri paketler 
çoğu sürümde bulunmaktadır.

SU2 *C++* tabanlı bir yazılımdır. C++ derleyicisi olarak *GCC* tabanlı bir 
derleyicinin bulunması yeterli olacaktır. Aynı şekilde *Intel* ve *clang* 
temeli derleyiciler de kullanılabilmektedir. Standart olmayan bir derleyici 
kullanmak isterseniz lütfen ilgili dokümanlara ve forumlara başvurunuz.

Bunu yanı sıra paralel derleme sırasında MPI derleyicileri kullanılmaktadır. 
İlgili kısımdaki MPI geliştirme paketleri kurulduğunda bu derleyiciler de 
kurulmaktadır.

1.2.4. GNU Autotools
--------------------
SU2'nun önceki versiyonları *Autotools* bazlı bir konfigürasyon sistemi 
kullanmaktadır. Dolayısı ile derlenebilmesi için ``automake``, ``autoconf`` 
paketlerinin de kurulması gerekmektedir. Tüm Linux sürümlerinde bu paketler
bulunmaktadır.

1.2.5. Meson ve Ninja
---------------------
SU2'nun güncel versiyonları *meson* ve *ninja* isimli konfigürasyon ve derleme 
sistemine geçmiştir. Eğer 7 ve sonraki versiyonları kurmak istiyorsanız bu 
derleme sistemlerini de yüklemelisiniz.

1.2.6 Python3
--------------
Tüm SU2 betiklerinin doğru olarak çalışabilmesi için iş istasyonunuzda 
*Python3* bulunması gerekmektedir. Python paketleri Linux sürümleri arasında
farklı alt paketlere bölünmüş olarak bulunabilmektedir.

1.3 - İndirme
=============
SU2, GNU Lesser General Public License, versiyon 2.1 kapsamında 
lisanslanmıştır. Dolayısı ile ücretsiz olarak kullanılabilir. Bu açık lisans 
hüküm ve koşullar için ayrıntılar `burada`_ bulunabilir.

Hem kaynak kodları hem de çalıştırılabilir dosyalar SU2 `indirme portalında`_
bulunabilir. 

.. _burada: https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html
.. _indirme portalında: https://su2code.github.io/download.html

1.4 - Kurulum İşlemi
====================
ULAKBİM sunucularında SU2 sürümleri kurulu olarak bulunmaktadır. Kendi iş 
istasyonunuzda derlemek isterseniz, asgari ihtiyaç olarak C/C++ derleyicisi 
ve de Python3 bulunan bir Linux bilgisayarda, indirip açtığınız dosyanın kök 
dizininde şu komutu girin:

.. code-block:: bash

 ./meson.py build 

Bu komut gerekli konfigürasyon betiklerini oluşturacaktır. Ardından SU2 
yazılımının derlenmesi ve de kurulması gerekecektir. Bu işlem için de: 

.. code-block:: bash

 ./ninja -C build install

İleri kurulum seçenekleri için lütfen kurulum kılavuzunu takip edin.

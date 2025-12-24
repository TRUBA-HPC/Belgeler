.. _truba_komutlari:

================
TRUBA Komutları
================

.. grid:: 2
    :gutter: 2
    
    .. grid-item-card:: :ref:`lssrv`
        :text-align: center 
    .. grid-item-card:: :ref:`avci`
        :text-align: center


.. _lssrv:


Kuyruk Bilgisi
--------------

**lssrv** komutu, TRUBA sisteminde tanımlı olan kuyrukların durumunu görüntülemek için kullanılır.

Kullanımı
~~~~~~~~~

Terminalde 

.. code-block::

   lssrv

komutunu yazdığınızda aşağıdaki gibi bir ekran çıktısı verecektir. 

.. image:: /assets/pratik-uyg/lssrv-new.png

Ekran çıktısında

- TRUBA sisteminde tanımlı olan güncel kuyruk isimleri 
- Kuyruklardaki boş CPU sayısı
- Kuyruklardaki toplam CPU sayısı
- Sırada bekleyen ve durumu ``Resource`` olan iş sayısı
- Sırada bekleyen toplam iş sayısı
- Kuyruklardaki toplam node sayısı
- Maksimum iş verme süresi
- İş başına talep edilebilecek minimum node sayısı
- İş başına talep edilebilecek maximum node sayısı 
- Node başına CPU sayısı
- CPU başına RAM kapasitesi

Ayrıca ``sinfo`` komutunu kullanarak kuyrukların mevcut doluluk durumunu görebilirsiniz.

.. _avci:



Modül Arama Aracı
------------------

**Avcı**, HPC ortamlarında `module avail` komutuyla listelenen yazılım modülleri arasında kolay arama yapmanızı sağlar. Arama sonuçlarında yüklü modüller vurgulanır ve eşleşmeler renklendirilerek gösterilir.


Kullanım
~~~~~~~~

.. code-block:: bash

   avci [opsiyonlar] <arama_terimi>

Opsiyonlar
~~~~~~~~~~

- ``-exact``  
  Modül adında tam eşleşme aranmasını sağlar. (örn. sadece `openmpi` olan modüller bulunur, `openmpi/4.1.7` gibi versiyonlu olanlar atlanabilir)

- ``-no-color``  
  Renkli çıktı özelliğini devre dışı bırakır. Örn. log dosyasına yazarken veya terminalde renk istemediğinizde kullanışlıdır.

- ``-help``  
  Yardım bilgisini gösterir.

Örnekler
~~~~~~~~

1. **Basit Arama:**

   .. code-block:: bash

      avci gcc

   ``gcc`` içeren tüm modülleri arar. Çıktı renklidir, yüklü modüller yeşil renkte gösterilir.

2. **Tam Eşleşme:**

   .. code-block:: bash

      avci -exact openmpi

   Sadece adı tam olarak ``openmpi`` olan modülleri listeler (sürüm dahil değildir).

3. **Renkli Çıktıyı Devre Dışı Bırakma:**

   .. code-block:: bash

      avci -no-color cuda

   Renk kullanılmadan, ``cuda`` içeren modüller listelenir.

4. **Yardım Menüsü:**

   .. code-block:: bash

      avci -help

   Kullanım ve opsiyonlar hakkında bilgi verir.

Özellikler
~~~~~~~~~~

- `module avail` komutunu çalıştırarak ortamda mevcut modülleri listeler.
- `module list` ile yüklü olan modülleri belirler ve arama sonucunda bu modülleri işaretler.
- Arama terimini içeren modül adlarını vurgular.
- Kategori başlıklarını (örneğin ``/arf/sw/modulefiles/`` gibi) gruplayarak gösterir.
- Hatalı çalışmalarda kullanıcıyı bilgilendirir.

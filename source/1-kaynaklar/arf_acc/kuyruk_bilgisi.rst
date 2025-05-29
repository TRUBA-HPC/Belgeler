.. _arf_acc_kuyruk_bilgisi:

===============
Kuyruk Bilgisi
===============


Terminalde 

.. code-block::

   lssrv

komutunu yazdığınızda aşağıdaki gibi bir ekran çıktısı verecektir. 

.. image:: /assets/pratik-uyg/lssrv-new.png

Ekran çıktısında

- TRUBA sisteminde tanımlı olan güncel kuyruk isimleri (:ref:`partitions`)
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

Ayrıca 

.. code-block:: 

    sinfo

komutunu kullanarak kuyrukların mevcut doluluk durumunu görebilirsiniz. 


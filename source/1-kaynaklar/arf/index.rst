.. _arf:

=====
ARF
=====


.. grid:: 3

    .. grid-item-card:: :ref:`arf_baglanti`
        :text-align: center
    .. grid-item-card:: :ref:`arf_depolama_kaynaklari`
        :text-align: center
    .. grid-item-card:: :ref:`arf_kuyruk_bilgisi`
        :text-align: center
    .. grid-item-card:: :ref:`arf_hesaplama_kumeleri`
        :text-align: center


.. toctree::
   :hidden:
   :caption: ARF Rehberi

   baglanti.rst
   kuyruk_bilgisi.rst
   arf_depolama_kaynaklari.rst
   hesaplama_kumeleri.rst
   truba_komutlari.rst


.. image:: /assets/arf/arf.jpg

ARF hesaplama kümesi için ``arf-ui(1-2-3-4-5)`` olmak üzere birçok sunucu kullanıcı arayüzü olarak hizmete sunulmuştur. Bu hesaplama kümesinde bulunan ``orfoz`` ismini atadığımız hesaplama sunucularında iş koşturmak için arf kullanıcı arayüzleri kullanılacaktır. 

Kümenin genel özellikleri aşağıdaki gibidir:

- Hesaplama sunucu sayısı: 504
- Hesaplama sunucu adı: orfoz[1-504]
- İşlemci:  2x Intel(R) Xeon(R) Platinum 8480+ (toplam 112 çekirdek)
- Bellek:   256 GB
- Network: 200Gbit NDR infiniband
- Tmp : 750GB name
- Merkezi depolama : `/arf` (1.6Pbyte)
- Ev dizini: `/arf/home`
- Yazılım: `/arf/sw/(apps,comp,lib)`
- İşletim sistemi: Rocky Linux 9.2

Güncel kurulu yazılımları 

.. code-block:: bash

	module available

komutu ile listeleyebilirsiniz. Örnek SLURM betik dosyaları ``/arf/sw/scripts`` dizininde bulunmaktadır.

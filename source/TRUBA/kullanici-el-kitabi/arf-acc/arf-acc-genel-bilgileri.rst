.. _arf-acc-genel-bilgileri:

===================================
ARF ACC Kümesi Hakkında Genel Bilgiler
===================================

ARF ACC hesaplama kümesinde bulunan ``kolyoz`` ismini atadığımız `Lenovo ThinkSystem SD650-N V3 <https://www.lenovo.com/us/en/p/servers-storage/servers/supercomputing/thinksystem-sd650-n-v3-high-density-server/len21ts0028>`_ hesaplama sunucularından oluşan ``kolyoz-cuda`` kuyruğunun genel özellikleri ve bir sunucunun üstten görünümü aşağıdaki gibidir:

.. image:: /assets/arf-acc/arf-acc.png
   :width: 100%


- Hesaplama sunucu sayısı: 24
- Hesaplama sunucu adı: kolyoz[1-24]
- İşlemci:  2x Intel(R) Xeon(R) GOLD 6548Y+ (toplam 64 çekirdek)
- Hızlandırıcı: 4 x NVIDIA H100 80GB HBM3 with 4x NVLink connected SXM5 GPUs
- Bellek:   1 TB
- Network: 4 x 200Gb NDR infiniband
- Tmp : 6TB
- Merkezi depolama : `/arf` (500 TB wekaFS)
- Ev dizini: `/arf/home`
- Yazılım: `/arf/sw/(apps,comp,lib)`
- İşletim sistemi: Rocky Linux 9.4 (BLue Onyx)

.. warning:: 

	Dosya sistemleri hakkında ayrıntılı bilgiye :ref:`yuksek-performansli-dosya-sistemleri` bölümünden erişebilirsiniz. ARF ACC için hesaplama sırasında yüksek performans için ``/arf`` dosya sistemi kullanılmalıdır.

.. _arf_acc_kuyruk_bilgisi:

===============
Kuyruk Bilgisi
===============

ARF ACC hesaplama kümesinde, GPU tabanlı iki ana kuyruk bulunmaktadır: ``kolyoz-cuda`` ve ``palamut-cuda``. Bu kuyruklar, yüksek performanslı GPU hesaplama gereksinimleri için özel olarak ayrılmıştır ve yalnızca yetkili kullanıcılar tarafından kullanılabilir.

.. admonition:: Erişim Politikası
   :class: important

   ``kolyoz-cuda`` ve ``palamut-cuda`` kuyrukları, yalnızca araştırma merkezleri tarafından yürütülen altyapı projeleri ve TÜBİTAK ULAKBİM ile sözleşmeli projeler kapsamında erişime açıktır. Diğer kullanıcılar için ``barbun-cuda`` ve ``akya-cuda`` kuyrukları önerilir.

Kuyrukların teknik ve donanım özellikleri aşağıda özetlenmiştir:

.. list-table:: Kuyruk ve Donanım Özellikleri
   :widths: 18 10 10 18 18 18 18 18 18 18
   :header-rows: 1

   * - Kuyruk Adı
     - Yıl
     - Sunucu Adet
     - Sunucu Modeli
     - CPU/GPU
     - İşlemci Modeli
     - Bellek
     - Ağ Kartı
     - İşletim Sistemi
     - Maksimum Süre
   * - palamut-cuda
     - 2021
     - 9
     - HP Proliant XL675d Gen10 Plus
     - 128 çekirdek & 8x Nvidia A100 GPU
     - AMD EPYC 7742 2.24GHz
     - 1 TB & 8x80 GB HBM
     - 4x HDR (200Gbps) Infiniband
     - Rocky Linux 9.4
     - 3 gün
   * - kolyoz-cuda
     - 2024
     - 24
     - Lenovo ThinkSystem SD650-N V3
     - 64 çekirdek & 4x Nvidia H100 GPU
     - Intel Xeon GOLD 6548Y+ 2.5GHz
     - 1 TB & 4x80 GB HBM
     - 4x NDR (200Gbps) Infiniband
     - Rocky Linux 9.4
     - 3 gün

.. note::
   Her iki kuyrukta da iş gönderimi için **en az 16 çekirdek ve en az 1 GPU** talep edilmelidir. GPU kullanılmayan işler bu kuyruklarda çalıştırılamaz.

   Çoklu GPU ve çoklu sunucu kullanımı için, her bir GPU başına 16 çekirdek ve katları talep edilmelidir. Örneğin, toplamda 8 GPU olmak üzere 2 sunucuda 4'er görev ve 4'er GPU kullanmak için:

   .. code-block:: bash

      srun -N 2 -n 8 -c 16 --gres=gpu:4 <komut>
      sbatch -N 2 -n 8 -c 16 --gres=gpu:4 <betik_dosyasi>


**Yüksek I/O Gereksinimi:**

- palamut-cuda: Her sunucuda 12 TB NVMe disk `/localscratch` altında sunulmaktadır.
- kolyoz-cuda: Her sunucuda 7 TB NVMe disk `/tmp` altında sunulmaktadır.

Geçici dosya ve veri işlemlerinizde bu dizinleri kullanarak I/O performansınızı artırabilirsiniz.

Kuyruk ve donanım detaylarının güncel durumunu görmek için ``cuda-ui`` arayüzünde aşağıdaki komutu kullanabilirsiniz:

.. code-block:: bash

   scontrol show partition=<kuyruk_adi>

Daha fazla bilgi ve güncel kullanım politikaları için sistem yöneticinizle iletişime geçebilirsiniz.
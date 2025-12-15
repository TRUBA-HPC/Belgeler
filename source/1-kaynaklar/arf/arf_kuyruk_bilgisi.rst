.. _arf_kuyruk_bilgisi:

==============
Kuyruk Bilgisi
==============

ARF hesaplama kümesinde farklı donanım ve özelliklere sahip çeşitli kuyruklar bulunmaktadır. Her kuyruk, farklı iş yükleri ve kullanıcı gereksinimleri için optimize edilmiştir. Aşağıdaki tabloda tüm kuyrukların teknik ve donanım özellikleri özetlenmiştir:

.. list-table:: ARF Kuyrukları ve Donanım Özellikleri
   :widths: 12 12 12 12 12 12 12 12 12
   :header-rows: 1
   :align: center

   * - Kuyruk
     - Sunucu Modeli
     - Sunucu Adet
     - İşlemci Modeli
     - Çekirdek /Sunucu
     - Toplam Bellek
     - GPU
     - Maksimum Süre
     - İşletim Sistemi
   * - orfoz
     - Orfoz
     - 504
     - 2x Intel Xeon Platinum 8480+
     - 112 (110 kullanılabilir)                          
     - 256 GB
     - Yok
     - 3 gün
     - Rocky Linux 9.2
   * - barbun
     - Barbun
     - 119
     - 2x Intel Xeon Gold 6248R
     - 40                              
     - 384 GB
     - Yok
     - 3 gün
     - Rocky Linux 9.2
   * - barbun-cuda
     - Barbun
     - 24
     - 2x Intel Xeon Gold 6248R
     - 40                                 
     - 384 GB
     - 2x Nvidia P100 16GB
     - 3 gün
     - Rocky Linux 9.2
   * - akya-cuda
     - Akya
     - 24
     - 2x Intel Xeon Gold 6248R
     - 40                            
     - 384 GB
     - 4x Nvidia V100 16GB NVLink
     - 3 gün
     - Rocky Linux 9.2
   * - hamsi
     - Hamsi
     - 144
     - 2x Intel Xeon Gold 6338
     - 56 (54 kullanılabilir)                          
     - 192 GB
     - Yok
     - 3 gün
     - Rocky Linux 9.2
   * - smp
     - Orkinos
     - 1
     - 4x Intel Xeon Gold 6248R
     - 224                          
     - 4 TB
     - Yok
     - 3 gün
     - Rocky Linux 9.2
   * - debug
     - Çeşitli (orfoz, hamsi, barbun, barbun-cuda, akya-cuda)
     - 200
     - Çeşitli
     - Çeşitli
     - Çeşitli
     - Çeşitli
     - 4 saat
     - Rocky Linux 9.2

.. admonition:: Genel Kullanım Kuralları
   :class: important

   - Her kuyruk için minimum çekirdek ve (varsa) GPU gereksinimleri aşağıda belirtilmiştir. İşlerinizin bu gereksinimlere uygun olması zorunludur.
   - Bellek ve süre limitlerine dikkat ediniz. Aksi takdirde işleriniz otomatik olarak sonlandırılabilir.
   - GPU kuyruklarında sadece GPU kullanan işler çalıştırılabilir.

**Örnek SLURM Betiği (orfoz/hamsi için):**

.. code-block:: bash

   #!/bin/bash
   #SBATCH -p orfoz
   #SBATCH -A kullanici_adi
   #SBATCH -J jobname
   #SBATCH -N 1
   #SBATCH -n 1
   #SBATCH -c 112
   #SBATCH --time=3-00:00:00

**Kuyruklara Özel Bilgiler ve Minimum Gereksinimler**

- **orfoz:** En az 56 çekirdek, maksimum 3 gün, 256GB RAM/sunucu.
- **hamsi:** En az 28 çekirdek, maksimum 3 gün, 192GB RAM/sunucu.
- **barbun:** En az 20 çekirdek, maksimum 3 gün, 384GB RAM/sunucu.
- **barbun-cuda:** En az 20 çekirdek ve 1 GPU, maksimum 3 gün, 384GB RAM/sunucu, 2x Nvidia P100 16GB GPU.
- **akya-cuda:** En az 10 çekirdek ve 1 GPU, maksimum 3 gün, 384GB RAM/sunucu, 4x Nvidia V100 16GB GPU, /tmp altında 1.4TB NVMe disk (yüksek I/O için).
- **debug:** Kısa süreli test işleri, maksimum 4 saat, çeşitli sunucular.

**Yüksek I/O Gereksinimi ve Geçici Disk Kullanımı:**

- Tüm sunucularda /tmp dizini NVMe disk olarak yapılandırılmıştır. Yüksek I/O gerektiren işlerinizde bu alanı kullanmanız önerilir.
- Özellikle akya-cuda sunucularında 1.4TB NVMe disk /tmp altında sunulmaktadır.

.. warning::
   GPU kuyruklarına (barbun-cuda, akya-cuda) gönderilen işlerin GPU kullanabilen ve GPU talep eden işler olması zorunludur. GPU kullanımı ile ilgili ayrıntılı bilgi için :ref:`gpu-kilavuzu` sayfasını inceleyiniz.

**Interaktif İşler ve Debug Kuyruğu**

Interaktif iş çalıştırma ve debug kuyruğu kullanımı için :ref:`interaktif-is-calistirma` bölümüne bakınız.

Her kuyruk ve donanım hakkında güncel bilgiye ilgili kullanıcı arayüzüne bağlandıktan sonra aşağıdaki komut ile ulaşabilirsiniz:

.. code-block:: bash

   scontrol show partition=<kuyruk_adi>

Daha fazla bilgi ve güncel kullanım politikaları için sistem yöneticinizle iletişime geçebilirsiniz.



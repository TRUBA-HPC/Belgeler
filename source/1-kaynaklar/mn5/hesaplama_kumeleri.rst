.. _mn5_hesaplama_kumeleri:

=====================
Hesaplama Kümeleri
==================

MareNostrum 5 süperbilgisayarı, farklı donanım yapılarına sahip iki ana bölümden oluşur: **Genel Amaçlı İşlem Kümesi (GPP)** ve **Hızlandırılmış GPU Kümesi (ACC)**. Bu iki küme, farklı hesaplama gereksinimlerine cevap verecek şekilde tasarlanmıştır.

## GPP (General Purpose Partition)

GPP bölümü, Intel'in 4. nesil Xeon "Sapphire Rapids" işlemcileri üzerine kurulu 6.408 düğümden oluşur. Bunlardan 72 düğüm yüksek bant genişlikli bellek (HBM) ile donatılmıştır. Genel amaçlı hesaplamalar için kullanılır.

Toplamda:

* **726.880 işlemci çekirdeği**
* **1.75 PiB RAM**
Düğüm türleri ve özellikleri:

.. list-table:: 
   :widths: 20 15 15 20 30
   :header-rows: 1
   :align: center

   *  - Düğüm Türü
      - Düğüm Sayısı
      - Çekirdek/Düğüm
      - Bellek/Düğüm
      - Çekirdek Başına Kullanılabilir Bellek

   *  - GPP
      - 6.192
      - 112
      - 256 GiB
      - 2 GiB

   *  - GPP-HighMem
      - 216
      - 112
      - 1.024 GiB
      - 9 GiB

   *  - GPP-Data
      - 10
      - 112
      - 2.048 GiB
      - 18 GiB

   *  - GPP-HBM
      - 72
      - 112
      - 128 GiB (HBM2)
      - 1 GiB

Her düğümde yaklaşık 1 TB NVMe yerel disk, DDR5 RAM ve ConnectX-7 NDR200 InfiniBand ağı bulunmaktadır. GPP, GPP-HighMem ve GPP-Data düğümleri doğrudan yüksek bant genişliğine sahip Infiniband altyapısına bağlıdır.

## ACC (Accelerated Partition)

ACC bölümü, yüksek performanslı hesaplama ve yapay zeka uygulamaları için tasarlanmıştır. Bu bölümde toplam **1.120 düğüm** bulunur ve her düğüm:

* **2x Intel Xeon Platinum 8460Y+ (80 çekirdek toplam)**
* **4x NVIDIA Hopper H100 (64 GB HBM2 bellekli)**
* **512 GiB sistem belleği**
* **480 GB NVMe yerel depolama**
* **800 Gb/sn toplam InfiniBand bant genişliği**

Bu yapılandırma sayesinde ACC bölümü, karmaşık paralel iş yüklerini GPU hızlandırmalı şekilde çalıştırmak için uygundur.

## İnfiniband Ağı

Tüm sistem, üç katmanlı "fat-tree" mimarili bir InfiniBand ağıyla bağlanır. Toplamda **324 adet QM9790** anahtar kullanılmıştır.

* **Katman 1**: Düğüm bağlantılarını içerir
* **Katman 2**: Anahtarları birbirine bağlar
* **Katman 3**: Çekirdek anahtarları içerir

GPP için 3 ada, depolama için 1 ada ve ACC için 7 ada olacak şekilde yapılandırılmıştır. İleri seviye yönlendirme ve adaptif yönlendirme (Up/Down Routing) ile hata toleransı sağlanmıştır.

Daha fazla bilgi ve topoloji şemaları için:
`https://www.bsc.es/marenostrum/marenostrum-5/hardware-architecture <https://www.bsc.es/marenostrum/marenostrum-5/hardware-architecture>`\_

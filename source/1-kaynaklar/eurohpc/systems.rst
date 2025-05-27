.. _eurohpc_systems:

=====================
EuroHPC Sistemleri
=====================

EuroHPC Ortak Girişimi kapsamında, pre-exascale ve petascale süper bilgisayarların (EuroHPC süper bilgisayarları) Avrupa Birliği’ndeki süper bilgi işlem merkezlerinde konumlandırılması ve bu merkezler tarafından işletilmesi planlanmaktadır.

Kurulacak olan süper bilgisayarlar mimari, hesaplama bölümleri, depolama ve kaynak yöneticisi açısından birbirinden farklı olacaklardır. Erişime açık olan sistemlerin karşılaştırması aşağıdaki tabloda verilmiştir. Eylül 2021'de `sistemler hakkında detaylı rapor <https://eurohpc-ju.europa.eu/system/files/2022-03/EuroHPC%20Systems%20Report-Sep2021.pdf>`_  da yayınlanmıştır.

.. list-table:: EuroHPC Sistemleri
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Sistem
     - Sistem yeteneği
     - Kullanıcı Belgeleri
     - Hesaplama Bölümleri
     - Depolama
     - Kaynak yöneticisi
   * - LUMI
     - Pre-exascale
     - https://docs.lumi-supercomputer.eu/
     - :ref:`LUMI-C (3 Types), LUMI-G, LUMI-D (2 Types) <lumi-partitions>`
     - 7 PB Lustre (NVMe), 80 PB Lustre, 30 PB Ceph
     - Slurm
   * - Leonardo
     - Pre-exascale
     - https://leonardo-supercomputer.cineca.eu
     - :ref:`CPU <leonardo-partitions>`
     - 5.4 PB Lustre (NVMe and SSD), 106 PB Lustre (NVMe and HDD)
     - Slurm
   * - Deucalion
     - Petascale
     - *-*
     - :ref:`CPU <deucalion-partitions>`
     - 430 TB Lustre (NVMe), 10.6 PB Lustre
     - Slurm
   * - Discoverer
     - Petascale
     - https://sofiatech.bg/en/petascale-supercomputer/
     - :ref:`CPU Standard, CPU Large Memory <discoverer-partitions>`
     - 2 PB Lustre (NVMe)
     - Slurm
   * - Karolina
     - Petascale
     - https://docs.it4i.cz/karolina/introduction/
     - :ref:`CPU, GPU, Data Analytics, Cloud <karolina-partitions>`
     - 1.2 PB Lustre (NVMe), 31 TB NFS
     - PBS
   * - MeluXina
     - Petascale
     - https://docs.lxp.lu/
     - :ref:`CPU, GPU, FPGA, Large Memory, Cloud <meluxina-partitions>`
     - 0.5 PB Lustre (NVMe), 19.5 PB Lustre, 96 TB Ceph
     - Slurm
   * - Vega
     - Petascale
     - https://doc.vega.izum.si/
     - :ref:`CPU Standard, CPU Large Memory, GPU, Cloud <vega-partitions>` 
     - 1 PB Lustre (NVMe), 23 PB Ceph
     - Slurm


.. _lumi-partitions:

-------------------------
LUMI Hesaplama Bölümleri
-------------------------

.. list-table:: LUMI Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - LUMI-C (Type 1)
     - 1376
     - 2x AMD EPYC 7763 (64 Cores, 2.45 GHz)
     - *-*
     - 256 GB
     - *-*
   * - LUMI-C (Type 2)
     - 128
     - 2x AMD EPYC 7763 (64 Cores, 2.45 GHz)
     - *-*
     - 512 GB
     - *-*
   * - LUMI-C (Type 3)
     - 32
     - 2x AMD EPYC 7763 (64 Cores, 2.45 GHz)
     - *-*
     - 1024 GB
     - *-*
   * - LUMI-G (Not yet available)
     - 2560
     - 1x AMD Trento (64 Cores)
     - 4x AMD Instinct MI250X (128 GB Memory)
     - 512 GB
     - *-*
   * - LUMI-D (Type 1)
     - 4
     - 2x AMD EPYC 7742 (64 Cores, 2.25 GHz)
     - *-*
     - 8 TB
     - 25 TB SSD
   * - LUMI-D (Type 2)
     - 8
     - 2x AMD EPYC 7742 (64 Cores, 2.25 GHz)
     - 8x NVIDIA A40 (48 GB Memory)
     - 2 TB
     - 14 TB SSD


.. _leonardo-partitions:

-------------------------------
Leonardo Hesaplama Bölümleri
-------------------------------

.. list-table:: Leonardo Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - Booster (Intel Ice-Lake)
     - 3456
     - 1 x CPU Intel Xeon 8358 (32 cores, 2.6 GHz)
     - 4 x NVidia custom Ampere GPU 64GB HBM2
     - 512 (8 x 64) GB RAM DDR4 3200 MHz
     - *-*
   * - Data-Centric (Intel Sapphire Rapids)
     - 1536
     - 2x Intel Sapphire Rapids (56 cores, TDP 350 W)
     - *-*
     - 512 (16 x 32) GB RAM DDR5 4800 MHz
     - 8 TB NVM

.. _deucalion-partitions:

------------------------------
Deucalion Hesaplama Bölümleri
------------------------------

.. list-table:: Deucalion Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - ARM
     - 1632
     - Fujitsu A64FX (52 cores, 2.0GHz)
     - *-*
     - 16 GB HBM2
     - *-*
   * - x86
     - 500
     - AMD EPYC Rome 7742 (64 cores, 2.25 GHz)
     - *-*
     - 256 GB
     - *-*
   * - GPU
     - 33
     - 2 x AMD EPYC Rome 7742 (64 cores, 2.25 GHz) 
     - 4x NVIDIA A100 (80 GB)
     - 512 GB
     - 

.. _discoverer-partitions:

-------------------------------
Discoverer Hesaplama Bölümleri
-------------------------------

.. list-table:: Discoverer Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - CPU Standard
     - 1110
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 256 GB
     - *-*
   * - CPU Large Memory
     - 18
     - 2x AMD EPYC 7763 (64 Cores, 2.45 GHz)
     - *-*
     - 1 TB
     - *-*

.. _karolina-partitions:

-----------------------------
Karolina Hesaplama Bölümleri
-----------------------------

.. list-table:: Karolina Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - CPU
     - 720
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 256 GB
     - *-*
   * - GPU
     - 72
     - 2x AMD EPYC 7763 (64 Cores, 2.45 GHz)
     - 8x NVIDIA A100 (40GB Memory)
     - 1 TB
     - *-*
   * - Data Analytics
     - 1
     - 32 x Intel Xeon-SC 8268 (24 Cores, 2.9 GHz)
     - *-*
     - 24 TB
     - *-*
   * - Cloud
     - 36
     - 2x AMD EPYC 7H12 (64 Cores, 2.5 GHz)
     - *-*
     - 256 GB
     - 960 GB NVMe


.. _meluxina-partitions:

-------------------------------
MeluXina Hesaplama Bölümleri
-------------------------------

.. list-table:: MeluXina Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - CPU
     - 573
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 512 GB
     - *-*
   * - GPU
     - 200
     - 2x AMD EPYC 7452 (32 Cores, 2.35 GHz)
     - 4x NVIDIA A100 (40GB Memory)
     - 512 GB
     - 1.92 TB SSD
   * - FPGA
     - 20
     - 2x AMD EPYC 7452 (32 Cores, 2.35 GHz)
     - 2x Intel Stratix 10MX (16 GB)
     - 512 GB
     - 1.92 TB SSD
   * - Large Memory
     - 20
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 4 TB
     - 1.92 TB SSD
   * - Cloud
     - 20
     - 2x AMD Rome (64 Cores, 2.6 GHz)
     - *-*
     - 512 GB
     - *-*

.. _vega-partitions:

-------------------------
Vega Hesaplama Bölümleri
-------------------------

.. list-table:: Vega Hesaplama Bölümleri 
   :widths: 25 25 25 25 25 25
   :header-rows: 1

   * - Bölüm
     - Sunucu sayısı
     - CPU
     - GPU
     - Bellek
     - Lokal depolama
   * - CPU Standard
     - 768
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 256 GB
     - 1.92 TB M.2 SSD
   * - CPU Large Memory
     - 192
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - *-*
     - 1 TB
     - 1.92 TB M.2 SSD
   * - GPU
     - 60
     - 2x AMD EPYC 7H12 (64 Cores, 2.6 GHz)
     - 4x NVIDIA A100 (40GB Memory)
     - 512 GB
     - 1.92 TB M.2 SSD
   * - Cloud
     - 30
     - 2x AMD EPYC 7502 (32 Cores, 2.5 GHz)
     - *-*
     - 512 GB
     - 2x 7.6 TB U.2 SSD


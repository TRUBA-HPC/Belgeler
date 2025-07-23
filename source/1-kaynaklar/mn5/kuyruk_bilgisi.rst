.. _mn5_kuyruk_bilgisi:

==================
Kuyruk Bilgisi
==================

.. warning::

   Bu dokümantasyon, MareNostrum 5 (MN5) resmi sayfasının belirli bölümleri Türkçeye çevrilerek **Haziran 2025** tarihinde hazırlanmıştır. Sistemde yapılan güncellemeler veya değişiklikler bu belgeye yansımamış olabilir. **En güncel ve doğrulanmış bilgiye ulaşmak için lütfen BSC'nin resmi MN5 belgelerine başvurunuz:**

   https://www.bsc.es/supportkc/docs/MareNostrum5/intro/


MN5 sistemi üzerinde farklı kullanım senaryolarına uygun olarak tanımlanmış birçok kuyruk (Queue/QoS) mevcuttur. Her bir kuyruğun **çekirdek sayısı**, **maksimum süre (walltime)** ve **erişim tipi** gibi sınırlamaları farklılık gösterir.

Anlık olarak hangi kuyruklara erişiminiz olduğunu ve bu kuyruklara ait limitleri öğrenmek için şu komutu kullanabilirsiniz:

.. code-block:: bash

   bsc_queues

Standart Kuyruklar
------------------

Aşağıda, MareNostrum 5'in GPP (Genel Amaçlı İşlemciler) ve ACC (Hızlandırılmış GPU) bölümlerine ait standart kuyruk bilgileri özetlenmiştir:

**GPP Kuyrukları**

.. list-table:: GPP Kuyrukları
   :widths: 15 25 10 25 15
   :header-rows: 1

   * - Kuyruk Adı
     - Maks. Düğüm (Çekirdek)
     - Süre
     - Slurm QoS Adı
     - Slurm Bölüm Adı
   * - BSC
     - 125 (14.000)
     - 48 saat
     - gp_bsc{case,cs,es,ls}
     - gpp
   * - Data
     - 4 (448)
     - 72 saat
     - gp_data
     - gpdata
   * - Debug
     - 32 (3.584)
     - 2 saat
     - gp_debug
     - gpp
   * - EuroHPC
     - 800 (89.600)
     - 72 saat
     - gp_ehpc
     - gpp
   * - HBM
     - 50 (5.600)
     - 72 saat
     - gp_hbm
     - hbm
   * - Interactive
     - 1 (32)
     - 2 saat
     - gp_interactive
     - gpinteractive
   * - RES Class A
     - 200 (22.400)
     - 72 saat
     - gp_resa
     - gpp
   * - RES Class B
     - 200 (22.400)
     - 48 saat
     - gp_resb
     - gpp
   * - RES Class C
     - 50 (5.600)
     - 24 saat
     - gp_resc
     - gpp
   * - Training
     - 32 (3.584)
     - 48 saat
     - gp_training
     - gpp

**ACC Kuyrukları**

.. list-table:: ACC Kuyrukları
   :widths: 15 25 10 25 15
   :header-rows: 1

   * - Kuyruk Adı
     - Maks. Düğüm (Çekirdek)
     - Süre
     - Slurm QoS Adı
     - Slurm Bölüm Adı
   * - BSC
     - 25 (2.000)
     - 48 saat
     - acc_bsc{case,cs,es,ls}
     - acc
   * - Debug
     - 8 (640)
     - 2 saat
     - acc_debug
     - acc
   * - EuroHPC
     - 100 (8.000)
     - 72 saat
     - acc_ehpc
     - acc
   * - Interactive
     - 1 (40)
     - 2 saat
     - acc_interactive
     - accinteractive
   * - RES Class A
     - 50 (4.000)
     - 72 saat
     - acc_resa
     - acc
   * - RES Class B
     - 50 (4.000)
     - 48 saat
     - acc_resb
     - acc
   * - RES Class C
     - 10 (800)
     - 24 saat
     - acc_resc
     - acc
   * - Training
     - 4 (320)
     - 48 saat
     - acc_training
     - acc

.. note::

   Her BSC QoS kuyruğu için toplam kullanım limiti:  
   - GPP bölümü için en fazla **320 düğüm**  
   - ACC bölümü için en fazla **80 düğüm**  
   Bu limitler, eşzamanlı çalışan işler toplamına göre belirlenmiştir. Eğer işiniz **QOSGrpNodeLimit** nedeniyle bekliyorsa, ilgili limit altına düşülmesini beklemeniz gerekir.

Ek Kuyruklar
------------

Standart kuyruklara ek olarak, daha büyük veya uzun süreli işler için özel kuyruklar da tanımlanabilir. Bu kuyruklara erişim için aşağıdaki kriterler aranır:

- Uygulamanın yüksek ölçeklenebilirlik ve performans göstermesi
- Mevcut sistem yükü
- Teknik gerekliliklerin yerine getirilmesi

Özel kuyruklara erişim talepleri için sistem yöneticileriyle iletişime geçmeniz gerekmektedir.

Daha fazla bilgi ve güncel kuyruk limitleri için resmi MareNostrum 5 belgelerine başvurabilirsiniz:

`https://www.bsc.es/support/MN5-queues <https://www.bsc.es/support/MN5-queues>`_

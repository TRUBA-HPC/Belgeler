.. _hesaplama_kumeleri:

==========================
TRUBA Hesaplama Kümeleri
==========================

TRUBA, Türkiye’nin önde gelen yüksek başarımlı hesaplama altyapısı olarak, farklı yıllarda temin edilen ve sürekli güncellenen çeşitli sunucu aileleriyle araştırmacılara hizmet vermektedir. Her sunucu ailesi, işlemci, çekirdek, bellek ve GPU kapasitesi açısından farklılık göstermektedir. Kullanıcılar, ihtiyaçlarına uygun kaynakları ve kuyrukları seçerek hesaplama işlerini yürütebilirler.


Sunucu Aileleri
----------------

TRUBA altyapısında yer alan başlıca sunucu aileleri ve öne çıkan teknik özellikleri aşağıda özetlenmiştir:

.. list-table:: TRUBA Kaynakları
   :widths: 25 25 25 25 25 25 25 25
   :header-rows: 1

   * - Yıl
     - Adet
     - CPU/GPU
     - İşlemci Modeli
     - SPECfp_rate_base2006
     - Teorik Gflops
     - Bellek
     - Tanımı 
   * - 2016
     - 1
     - 14 çekirdek x 16 CPU
     - Xeon E7-4850 v3 2.20GHz
     - *-*
     - 7.9 Tflops
     - 4 TB 
     - orkinos
   * - 2017
     - 128 
     - 14 çekirdek x 2 CPU 
     - Xeon E5-2690 v3 2.60GHz
     - 970 
     - 1164 Gflops
     - 256 GB 
     - sardalya
   * - 2018
     - 120
     - 20 çekirdek x 2 CPU
     - Xeon 6148 2.40GHz
     - 1400
     - 2048Gflops
     - 384 GB
     - barbun
   * - 2018
     - 24
     - 20 çekirdek x 2CPU & 2xNvidia P100 GPU
     - Xeon 6148 2.40GHz
     - 1400
     - 2048Gflops & 9400Gflops 
     - 384 GB & 2x16 GB HBM2
     - barbun-cuda
   * - 2018
     - 24
     - 20 çekirdek x 2CPU & 4xNvidia V100 GPU
     - Xeon 6148 2.40GHz
     - 1400 
     - 2048Gflops & 4x7800Gflops
     - 384 GB & 4x16 GB HBM 
     - akya-cuda
   * - 2021
     - 144
     - 28 çekirdek x 2 CPU
     - Xeon 6258R 2.70GHz
     - *-*
     - 3.234 Tflops
     - 192 GB 
     - hamsi
   * - 2021
     - 9
     - 64 çekirdek x 2CPU & 8xNvidia A100 GPU
     - AMD 7742 2.24GHz
     - *-*
     - 4.600Gflops & 8x9.7Tflops
     - 1 TB & 8x80GB HBM
     - palamut-cuda
   * - 2023
     - 504
     - 56 çekirdek x 2CPU 
     - Intel(R) Xeon(R) Platinum 8480+ 2.0GHz
     - *-*
     - 7 Tflops
     - 256 GB
     - orfoz
   * - 2024
     - 24
     - 32 çekirdek x 2CPU & 4xNvidia H100 GPU
     - Intel(R) Xeon(R) GOLD 6548Y+ 2.5GHz
     - *-*
     - 5Tflops & 4x34Tflops
     - 1 TB & 4x80GB HBM
     - kolyoz-cuda 

Her sunucu ailesi, yüksek hızlı Infiniband ağları ile birbirine bağlıdır ve ortak dosya sistemlerine erişim sunar. GPU kümelerinde güncel NVIDIA sürücüleri ve CUDA desteği mevcuttur. Bazı kümelerde yüksek I/O gerektiren işler için NVMe diskler scratch alanı olarak sunulmaktadır.


Kuyruklar (Partitions)
----------------------

TRUBA’da işler, farklı özelliklere sahip kuyruklara (partition) gönderilir. Her kuyruk, belirli bir sunucu ailesi üzerinde çalışır ve maksimum çalışma süresi, çekirdek/GPU sayısı, bellek limiti gibi parametrelerle tanımlanır.

.. list-table:: Kuyruklar (partitions)
   :widths: 20 20 10 15 15 15 15 10
   :header-rows: 1

   * - Kuyruk
     - Sunucu
     - Adet
     - Maks. Süre
     - Min. Çekirdek
     - DefMemPerCore
     - MaxMemPerCore
     - Durum
   * - debug
     - orfoz, hamsi, barbun, barbun-cuda, akya-cuda
     - 200
     - 4 saat
     - 1
     - Kuyruğa göre değişir.
     - Kuyruğa göre değişir.
     - Aktif
   * - smp
     - orkinos
     - 1
     - 3 gün
     - 4
     - 17000MB
     - 18400MB
     - Özel
   * - barbun
     - barbun
     - 119
     - 3 gün
     - 20
     - 8500MB
     - 9500MB
     - Aktif
   * - barbun-cuda
     - barbun-cuda
     - 24
     - 3 gün
     - 20
     - 8500MB
     - 9500MB
     - Aktif
   * - akya-cuda
     - akya-cuda
     - 24
     - 3 gün
     - 10
     - 8500MB
     - 9500MB
     - Aktif
   * - hamsi
     - hamsi
     - 144
     - 3 gün
     - 28
     - 3400MB
     - 3400MB
     - Aktif
   * - orfoz
     - orfoz
     - 504
     - 3 gün
     - 56
     - 2000MB
     - 2295MB
     - Aktif
   * - palamut-cuda
     - palamut
     - 9
     - 3 gün
     - 16
     - 7500MB
     - 16384MB
     - Aktif
   * - kolyoz-cuda
     - kolyoz
     - 24
     - 3 gün
     - 16
     - 16GB
     - 16GB
     - Aktif

Kuyruk ve kaynak durumları için ``sinfo`` ve ``scontrol show partition=<kuyruk_adı>`` komutları kullanılabilir.

Kullanım Notları ve Erişim
---------------------------

- Her kuyrukta, çekirdek başına ve toplamda bellek limitleri uygulanır. Betiklerde `--mem` veya `--mem-per-core` parametreleri ile bellek talep edilebilir.
- GPU kuyruklarında, işlerin GPU kullanacak şekilde yapılandırılması zorunludur. Örneğin, palamut-cuda kuyruğunda her GPU için 16 çekirdek talep edilmesi önerilir.
- Bazı kuyruklar (ör. kolyoz-cuda, palamut-cuda) sadece belirli projelere ve kullanıcı gruplarına açıktır. Erişim için özel kullanıcı arayüzleri ve VPN bağlantısı gerekebilir.
- İşlerin `debug` kuyruğunda belirli bir sunucu ailesinde çalışması isteniyorsa, betiklerde ``#SBATCH --constraint=<sunucu_adı>`` parametresi kullanılabilir. Örneğin, orfoz kuyruğunda çalıştırmak için ``#SBATCH --constraint=orfoz`` parametresi kullanılabilir.
- Yüksek I/O gerektiren işler için bazı kümelerde NVMe diskler scratch alanı olarak sunulmaktadır.


Ek Bilgiler
--------------------------

- Tüm kuyrukların varsayılan çalışma süresi 2 dakikadır. Betik dosyasında zaman bilgisi girilmeyen işler 2 dakika sonunda otomatik olarak sonlandırılır.
- Kuyruklarda minimum çekirdek ve/veya GPU talep sınırları uygulanır. Sistem verimliliği için bu sınırların altında iş gönderilmemelidir.

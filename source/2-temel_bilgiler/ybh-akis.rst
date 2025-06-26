.. _ybh-akis:

.. image:: /assets/openvpn-howto/images/ybh-akis.png

YBH Sistemi Kullanım Akışı
===========================

Yüksek Başarımlı Hesaplama (YBH) sistemine erişim ve iş gönderme sürecini özetlemektedir.

1. Yerel Makineden Bağlantı
---------------------------

Kullanıcı, yerel bilgisayarından YBH sistemine şu adımlarla bağlanır:

- **OpenVPN** ile kuruma güvenli bağlantı sağlanır.
- Ardından **SSH (Secure Shell)** protokolü kullanılarak kullanıcı arayüzüne giriş yapılır.

2. Kullanıcı Arayüzü
---------------------

Kullanıcı arayüzünde yapılması gerekenler:

- Hesaplama görevi için gerekli dosyalar hazırlanır:

  - Hesaplama uygulamasına veya analizine ait kod dosyaları
  - SLURM iş betiği dosyası

3. Görev Gönderimi
-------------------

Hazırlanan SLURM betiği SLURM zamanlayıcısına aşağıdaki komut ile gönderilir:

.. code-block:: bash

   sbatch job.slurm

4. Hesaplama Kaynakları
------------------------

Görev SLURM tarafından uygun kaynaklara (CPU veya GPU) yönlendirilerek çalıştırılır.

Sistem, kaynakları otomatik olarak tahsis eder ve kullanıcı görevini ilgili düğümlerde yürütür.

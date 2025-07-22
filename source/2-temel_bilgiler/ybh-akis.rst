.. _ybh-akis:

.. image:: /assets/openvpn-howto/images/ybh-akis.png

YBH Sistemi Kullanım Akışı
===========================

Yüksek Başarımlı Hesaplama (YBH) sistemlerinde işler, doğrudan sunucularda çalıştırılmaz; bunun yerine bir kuyruk (queue) sistemi üzerinden yürütülür. Kullanıcılar, kendi bilgisayarlarından önce sisteme güvenli bir şekilde bağlanır ve ardından kullanıcı arayüzü (login node) üzerinden sistemle etkileşime geçerler. Hesaplama veya analiz işleri, kullanıcı arayüzünde hazırlanır ve bir iş betiği (ör. SLURM betiği) ile kuyruk yöneticisine gönderilir.

Kuyruk sistemi, aynı anda çok sayıda kullanıcının kaynak talebini adil ve verimli bir şekilde yönetmek için kullanılır. Kullanıcılar işlerini kuyruklara gönderir; bu işler, sistemdeki mevcut kaynaklara (CPU, GPU, bellek vb.) ve önceliklere göre sırayla çalıştırılır. Böylece, kaynakların aşırı yüklenmesi ve çakışmalar önlenir.

Kısacası, YBH ortamında işler doğrudan başlatılmaz; kullanıcı arayüzü üzerinden hazırlanan işler, kuyruk sistemine gönderilir ve uygun kaynaklar tahsis edildiğinde otomatik olarak çalıştırılır. Bu yaklaşım, hem kaynakların etkin kullanımını sağlar hem de çok kullanıcılı ortamda düzeni korur.

1. Yerel Makineden Bağlantı
---------------------------

Kullanıcı, yerel bilgisayarından YBH sistemine şu adımlarla bağlanır:

- **OpenVPN** ile kuruma güvenli bağlantı sağlanır. Detaylı bilgi için :ref:`open-vpn` sayfasını ziyaret edebilirsiniz.
- Ardından **SSH (Secure Shell)** protokolü kullanılarak kullanıcı arayüzüne giriş yapılır. Detaylı bilgi için :ref:`ssh-baglanti` sayfasını ziyaret edebilirsiniz.

2. Kullanıcı Arayüzü
---------------------

Kullanıcı arayüzünde yapılması gerekenler:

- Hesaplama görevi için gerekli dosyalar hazırlanır:

  - Hesaplama uygulamasına veya analizine ait kod dosyaları
  - SLURM iş betiği dosyası. Deta

Kullanici arayuz bilgileri icin :ref:`ARF hesaplama kümesi <arf>` sayfasını ziyaret edebilirsiniz.

SLURM betiği icin :ref:`SLURM betiği <slurm-betik>` sayfasını ziyaret edebilirsiniz.

3. Görev Gönderimi
-------------------

Hazırlanan SLURM betiği SLURM zamanlayıcısına aşağıdaki komut ile gönderilir:

.. code-block:: bash

   sbatch job.slurm

Daha fazla bilgi için :ref:`SLURM komutları <basic_slurm_commands>` sayfasını ziyaret edebilirsiniz.

4. Hesaplama Kaynakları
------------------------

Görev SLURM tarafından uygun kaynaklara (CPU veya GPU) yönlendirilerek çalıştırılır.

Sistem, kaynakları otomatik olarak tahsis eder ve kullanıcı görevini ilgili düğümlerde yürütür.

* ARF hesaplama kümesi için :ref:`ARF kuyruk bilgisi <arf_kuyruk_bilgisi>` sayfasını ziyaret edebilirsiniz.
* ARF-ACC hesaplama kümesi için :ref:`ARF-ACC kuyruk bilgisi <arf_acc_kuyruk_bilgisi>` sayfasını ziyaret edebilirsiniz.

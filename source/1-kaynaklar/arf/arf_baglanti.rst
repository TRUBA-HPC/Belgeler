.. _arf_baglanti:

========
Bağlantı
========

ARF hesaplama kümesine erişim için aşağıdaki kullanıcı arayüz sunucularını kullanabilirsiniz:

.. list-table:: ARF kullanıcı arayüz sunucuları
   :widths: 25 25
   :header-rows: 1
   :align: center

   * - Adres
     - IP (tür)
   * - arf-ui1.yonetim
     - 172.16.6.11  (ssh)
   * - arf-ui2.yonetim
     - 172.16.6.12  (ssh)
   * - arf-ui3.yonetim
     - 172.16.6.13  (ssh)
   * - arf-ui4.yonetim
     - 172.16.6.14  (ssh)
   * - arf-ui5.yonetim
     - 172.16.6.15  (ssh)
   * - openondemand.yonetim
     - 172.16.6.20 (web / görsel)

SSH ile bağlantı için örnek komut:

.. code-block:: bash

   ssh -l <kullanici-adiniz> 172.16.6.11

Open OnDemand erişimi için tarayıcınızdan şu adresi kullanabilirsiniz:

   https://openondemand.yonetim

Kuyrukların güncel durumunu görmek için:

.. code-block:: bash

   sinfo -p orfoz

Kuyruk yapılandırmasını görmek için:

.. code-block:: bash

   scontrol show partition=<kuyruk_adi>

Bağlantı ve erişim sırasında sorun yaşamanız durumunda sistem yöneticinizle iletişime geçebilirsiniz.




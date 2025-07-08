.. _arf_acc_baglanti:

========
Bağlantı
========

ARF ACC hesaplama kümesine erişim ve iş gönderimi yalnızca ``cuda-ui`` kullanıcı arayüzü üzerinden gerçekleştirilmektedir. Aşağıda bağlantı yöntemleri ve erişim adresleri özetlenmiştir.

.. list-table:: Bağlantı Adresleri
   :widths: 25 25 25 25
   :header-rows: 1
   :align: center

   * - Tür
     - Sunucu
     - Adres
     - IP
   * - SSH
     - cuda-ui.yonetim
     - cuda-ui.yonetim
     - 172.16.6.16
   * - Web
     - cuda-ui.yonetim
     - https://cuda-ui.yonetim
     - 172.16.6.16
   * - Web-Monitör
     - grafana.yonetim
     - http://grafana.yonetim:3000/login
     - 172.16.6.25

.. note::
   ARF ACC'ye erişim için öncelikle OpenVPN bağlantınızın aktif olması gerekmektedir. OpenVPN bağlantısı sağlandıktan sonra aşağıdaki komut ile ``cuda-ui`` arayüzüne SSH ile erişebilirsiniz:

.. code-block:: bash

   ssh -l <kullanici-adiniz> 172.16.6.16

Bağlantı ve erişim sırasında sorun yaşamanız durumunda sistem yöneticinizle iletişime geçebilirsiniz.

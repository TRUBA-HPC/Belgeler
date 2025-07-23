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
  ARF ACC'ye erişim sağlayabilmek için öncelikle OpenVPN bağlantınızın aktif olması gerekmektedir. OpenVPN bağlantısı :ref:`open-vpn` sayfasından sağlanabilir. 
   
  Bağlantı sağlandıktan sonra aşağıdaki komut ile ``cuda-ui`` arayüzüne SSH ile bağlanabilirsiniz:

  .. code-block:: bash

    ssh -l <kullanici-adiniz> 172.16.6.16

Herhangi bir sorun yaşarsanız, yardım ve destek almak için lütfen :ref:`truba_iletisim` sayfasındaki teknik destek iletişim bilgilerini kullanarak bizimle iletişime geçiniz.
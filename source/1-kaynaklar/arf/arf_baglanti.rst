.. _arf_baglanti:

========
Bağlantı
========

ARF hesaplama kümesine erişim için aşağıdaki kullanıcı arayüz sunucularını kullanabilirsiniz:

.. list-table:: ARF kullanıcı arayüz sunucuları
   :widths: 25 25 25 25
   :header-rows: 1
   :align: center

   * - Tür
     - Sunucu
     - Adres
     - IP
   * - SSH
     - arf-ui1.yonetim
     - arf-ui1.yonetim
     - 172.16.6.11
   * - SSH
     - arf-ui2.yonetim
     - arf-ui2.yonetim
     - 172.16.6.12
   * - SSH
     - arf-ui3.yonetim
     - arf-ui3.yonetim
     - 172.16.6.13
   * - SSH
     - arf-ui4.yonetim
     - arf-ui4.yonetim
     - 172.16.6.14
   * - SSH
     - arf-ui5.yonetim
     - arf-ui5.yonetim
     - 172.16.6.15
   * - Web
     - openondemand.yonetim
     - https://openondemand.yonetim
     - 172.16.6.20
   * - Web-Monitör
     - grafana.yonetim
     - http://grafana.yonetim:3000/login
     - 172.16.6.25

.. note::
  ARF hesaplama kümesine erişim sağlayabilmek için öncelikle OpenVPN bağlantınızın aktif olması gerekmektedir. OpenVPN bağlantısı :ref:`open-vpn` sayfasından sağlanabilir. 
   
  Bağlantı sağlandıktan sonra aşağıdaki komut ile istenilen kullanıcı arayüzüne SSH ile bağlanabilirsiniz:

    .. code-block:: bash

      ssh <kullanici-adiniz>@<ip-adresi>

Herhangi bir sorun yaşarsanız, yardım ve destek almak için lütfen :ref:`truba_iletisim` sayfasındaki teknik destek iletişim bilgilerini kullanarak bizimle iletişime geçiniz.




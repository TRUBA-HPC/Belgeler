.. _arf-baglanti:

================================
ARF Kullanici Arayuzune Baglanti
================================

ARF hesaplama kümesi erişim adresleri şu şekildedir:


.. list-table:: 
   :widths: 30 40 40
   :header-rows: 1
   :align: center

   * - Sunucu
     - Kampus ici
     - Open VPN

   * - arf-ui1
     - arf-ui1.yonetim
     - 172.16.6.11

   * - arf-ui2
     - arf-ui2.yonetim
     - 172.16.6.12

   * - Open OnDemand
     - http://openondemand.yonetim
     - http://172.16.6.20

   * - Grafana
     - http://grafana.yonetim:3000/login
     - http://172.16.6.25:3000/login


Open VPN bağlantınız olduğu varsayılarak ARF hesaplama kümesine `<kullanıcı-adınız>` kısmını kendi kullanıcı adınız ile değiştirerek 

.. tabs::

    .. tab:: arf-ui1

        .. code-block:: bash

            ssh -l <kullanici-adiniz> 172.16.6.11

    .. tab:: arf-ui2

        .. code-block:: bash
    
            ssh -l <kullanici-adiniz> 172.16.6.12


ile bağlantı sağlayabilirsiniz.
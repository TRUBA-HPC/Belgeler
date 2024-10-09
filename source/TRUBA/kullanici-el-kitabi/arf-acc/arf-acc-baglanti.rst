.. _arf-acc-baglanti:

================================
ARF ACC Kullanıcı Arayüzüne Bağlantı
================================

ARF ACC hesaplama kümesinde yer alan ``kolyoz`` hesaplama sunucularından oluşan ``kolyoz-cuda`` kuyruğu yalnızca ``cuda-ui`` kullanıcı arayüzü üzerinden iş gönderimine izin verecektir.

Kullanıcı arayüzüne erişim için aşağıdaki adresleri kullanabilirsiniz:


.. list-table:: 
   :widths: 40 60
   :header-rows: 1
   :align: center

   * - Sunucu
     - Open VPN

   * - cuda-ui
     - 172.16.6.16

   * - Open OnDemand
     - http://172.16.6.16

   * - Grafana
     - http://172.16.6.25:3000/login

OpenVPN bağlantınız olduğu varsayılarak kişisel makinenizden ARF ACC hesaplama kümesine `<kullanici-adiniz>` kısmını kendi kullanıcı adınız ile değiştirerek 

.. tabs::

    .. tab:: cuda-ui

        .. code-block:: bash

            ssh -l <kullanici-adiniz> 172.16.6.16

ile bağlantı sağlayabilirsiniz.

Herhangi bir kullanıcı arayüzündeyseniz (``babrun1, arf-ui1, arf-ui2``) doğrudan terminalden

.. code-block::  

    ssh 172.16.6.16 

ile ``cuda-ui`` kullanıcı arayüzüne bağlanabilirsiniz.

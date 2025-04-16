.. _arf-acc-baglanti:

================================
Kullanıcı Arayüzüne Bağlantı
================================

ARF ACC hesaplama kümesinde yer alan ``kolyoz`` hesaplama sunucularından oluşan ``kolyoz-cuda`` kuyruğu yalnızca ``cuda-ui`` kullanıcı arayüzü üzerinden iş gönderimine izin verecektir.

Kullanıcı arayüzüne erişim için aşağıdaki adresleri kullanabilirsiniz:


.. list-table:: 
   :widths: 25 25 25 25
   :header-rows: 1
   :align: center


   *  - Tür 
      - Sunucu
      - Adres
      - IP

   *  - ssh
      - cuda-ui.yonetim
      - cuda-ui.yonetim
      - 172.16.6.16

   *  - web
      - cuda-ui.yonetim
      - https://cuda-ui.yonetim
      - 172.16.6.16

   *  - web-monitör
      - grafana.yonetim
      - http://grafana.yonetim:3000/login
      - 172.16.6.25

OpenVPN bağlantınız olduğu varsayılarak kişisel makinenizden ARF ACC hesaplama kümesine `<kullanici-adiniz>` kısmını kendi kullanıcı adınız ile değiştirerek 

.. tabs::

    .. tab:: cuda-ui

        .. code-block:: bash

            ssh -l <kullanici-adiniz> 172.16.6.16

ile bağlantı sağlayabilirsiniz.

Herhangi bir kullanıcı arayüzündeyseniz (``barbun1, arf-ui1, arf-ui2``) doğrudan terminalden

.. code-block::  

    ssh 172.16.6.16 

ile ``cuda-ui`` kullanıcı arayüzüne bağlanabilirsiniz.

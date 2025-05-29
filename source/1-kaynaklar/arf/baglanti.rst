.. _arf_baglanti:

========
Bağlantı
========


ARF hesaplama kümesi erişim adresleri şu şekildedir:


.. list-table:: 
  :widths: 25 25 25 25
  :header-rows: 1
  :align: center

  * - Tür 
    - Sunucu
    - Adres
    - IP

  * - ssh
    - arf-ui1.yonetim
    - arf-ui1.yonetim
    - 172.16.6.11

  * - ssh
    - arf-ui2.yonetim
    - arf-ui2.yonetim
    - 172.16.6.12

  * - ssh
    - arf-ui3.yonetim
    - arf-ui3.yonetim
    - 172.16.6.13

  * - ssh
    - arf-ui4.yonetim
    - arf-ui4.yonetim
    - 172.16.6.14
  * - ssh
    - arf-ui5.yonetim
    - arf-ui4.yonetim
    - 172.16.6.15

  * - web
    - openondemand.yonetim
    - `https://openondemand.yonetim <https://172.16.6.20>`_
    - 172.16.6.20

  * - web-monitör
    - grafana.yonetim
    - `http://grafana.yonetim:3000/login <http://172.16.6.25:3000/login>`_
    - 172.16.6.25



OpenVPN bağlantınız olduğu varsayılarak kişisel makinenizden ARF hesaplama kümesine `<kullanici-adiniz>` kısmını kendi kullanıcı adınız ile değiştirerek 

.. tabs::

    .. tab:: arf-ui1

        .. code-block:: bash

            ssh -l <kullanici-adiniz> 172.16.6.11

    .. tab:: arf-ui2

        .. code-block:: bash
    
            ssh -l <kullanici-adiniz> 172.16.6.12


ile bağlantı sağlayabilirsiniz.

..
  * Orfoz hesaplama sunucularına sadece ``arf-ui`` kullanıcı arayüzü üzerinden iş gönderilebilecektir.

  Orfoz kuyruğuna is kosturmak icin ``barbun1`` kullanıcı arayüzü üzerinden arf-ui arayüz sunucusuna 

  .. code-block::

    ssh arf-ui1.yonetim
    
  veya

  .. code-block::  

    ssh arf-ui2.yonetim

  ile geçiş yapabilirdiniz. Veya yukarıda da belirtildiği gibi OpenVPN bağlantısı aktif iken doğrudan terminalden

  .. code-block::  

    ssh 172.16.6.11 
    
  ile arf-ui1,

  .. code-block::  

    ssh 172.16.6.12 
    
  ile arf-ui2 kullanıcı arayüzlerine bağlanabilirsiniz.
  
  SSH anahtalarını henüz oluşturmamış kullanıcılar, bu sunucuya geçiş yapabilmek için ``barbun1`` kullanıcı arayüz sunucusuna bağlı iken ssh anahtarlarını ``ssh-keygen`` komutu ile aşağıdaki gibi oluşturabilirler:

  .. code-block::

    $>ssh-keygen (Sorulan tüm soruları “Enter” tuşuna basarak geçiniz)
    
    $>cp -p .ssh/id_rsa.pub /arf/home/$USER/.ssh/authorized_keys


.. warning::
  Derleme, pre-process, post-process işlerinizi kullanıcı arayüzü sunucuları yerine, ``debug`` kuyruğunda interaktif olarak  gerçekleştirebilirsiniz.

  debug kuyruğundan interaktif shell almak icin

  .. code-block:: 
    
    srun -n 1 -N 1 -p debug --time=30:00 --pty /bin/bash -i

  komutunu kullanabilir ya da `Open OnDemand <https://172.16.6.20/>`_  web arayüzünde linux desktop alarak islemlerinizi gerçekleştirebilirsiniz.



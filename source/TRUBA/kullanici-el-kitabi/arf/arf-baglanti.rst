.. _arf-baglanti:

================================
ARF Kullanıcı Arayüzüne Bağlantı
================================

ARF hesaplama kümesi erişim adresleri şu şekildedir:


.. list-table:: 
   :widths: 40 60
   :header-rows: 1
   :align: center

   * - Sunucu
     - Open VPN

   * - arf-ui1
     - 172.16.6.11

   * - arf-ui2
     - 172.16.6.12

   * - Open OnDemand
     - http://172.16.6.20

   * - Grafana
     - http://172.16.6.25:3000/login

OpenVPN bağlantınız olduğu varsayılarak kişisel makinenizden ARF hesaplama kümesine `<kullanıcı-adınız>` kısmını kendi kullanıcı adınız ile değiştirerek 

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

  Orfoz kuyruğuna is kosturmak icin ``levrek1`` kullanıcı arayüzü üzerinden arf-ui arayüz sunucusuna 

  .. code-block::

    ssh arf-ui1.yonetim
    
  veya

  .. code-block::  

    ssh arf-ui2.yonetim

  ile geçiş yapabilirler. SSH anahtalarını henüz oluşturmamış kullanıcılar, bu sunucuya geçiş yapabilmek için ``levrek1`` kullanıcı arayüz sunucusuna bağlı iken ssh anahtarlarını ``ssh-keygen`` komutu ile aşağıdaki gibi oluşturabilirler:

  .. code-block::

    $>ssh-keygen (Sorulan tüm soruları “Enter” tuşuna basarak geçiniz)
    
    $>cp -p .ssh/id_rsa.pub /arf/home/$USER/.ssh/authorized_keys


.. warning::
  Derleme, pre-process, post-process işlerinizi ``arf-ui1,arf-ui2`` kullanıcı arayüzü sunucuları yerine, ``debug`` kuyruğunda interaktif olarak  gerçekleştirebilirsiniz.

  debug kuyruğundan interaktif shell almak icin

  .. code-block:: 
    
    srun -n 1 -N 1 -p debug --time=30:00 --pty /bin/bash -i

  komutunu kullanabilir ya da `Open OnDemand <https://172.16.6.20/>`_  web arayüzünde linux desktop alarak islemlerinizi gerçekleştirebilirsiniz.
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


OpenVPN bağlantınız aktif olduğunda, kişisel bilgisayarınızdan ARF hesaplama kümesine erişmek için aşağıdaki şekilde bağlantı kurabilirsiniz. Burada `<kullanici-adiniz>` kısmını kendi kullanıcı adınızla değiştirmeniz gerekmektedir ve `x` yerine bağlanmak istediğiniz arf-ui sunucusunun numarasını (1-5 arası) yazmalısınız:

.. tabs::

    .. tab:: arf-uiX

        .. code-block:: bash

            ssh -l <kullanici-adiniz> 172.16.6.x

Örneğin, kullanıcı adınız `epsilon` ve arf-ui2 sunucusuna bağlanmak istiyorsanız:

.. code-block:: bash

    ssh -l epsilon 172.16.6.12



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
  Derleme, pre-process, post-process işlerinizi kullanıcı arayüzü sunucuları yerine, ``debug`` kuyruğunda interaktif olarak  gerçekleştirebilirsiniz. İnteraktif is calistirma rehberi icin :ref:`interaktif-is-calistirma` sayfasini inceleyebilirsiniz.




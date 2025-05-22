.. _interaktif-is-calistirma:

=========================
İnteraktif İş Çalıştırma
=========================

.. warning::

  Kullanıcılar derleme ya da benzeri yük getiren işlerini kesinlikle ``arf-ui`` sunucuları üzerinde gerçekleştirmemelidirler. Bu tür işler için ``debug`` kuyruğundan srun ile interaktif kaynak talep edilmeli ve işlemler hesap sunucularında gerçekleştirilmelidir. Ayrıca Open OnDemand üzerinden Linux Desktop alınarak kısa süreli görsel ve interaktif işlerin gerçekleştirilmesi mümkündür. İnteraktif iş çalıştırmak için ``debug`` kuyruğundan kaynak talep edilmelidir.
  
  ``debug`` kuyruğu farklı sunucu türlerinden oluştuğundan, derleme yapmak için kullanacağınız sunucu türünü -C (constraint) parametresi ile seçebilirsiniz. Sunucu türü belirtilmez ise, sistem otomatik olarak atama yapacaktır. ``debug`` kuyruğundan ``srun`` ile kaynak talebi için aşağıdaki komut sekmelerini inceleyebilirsiniz.


.. tabs::

    .. tab:: debug

        .. code-block:: bash

            srun -p debug -N 1 -n 1 -c 110 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i

    .. tab:: orfoz

        .. code-block:: bash
      
            srun -p debug -C orfoz -N 1 -n 1 -c 55 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i
  
    .. tab:: hamsi

        .. code-block:: bash
      
            srun -p debug -C hamsi -N 1 -n 1 -c 54 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i
  
    .. tab:: barbun

        .. code-block:: bash
      
            srun -p debug -C barbun -N 1 -n 1 -c 20 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i
  
    .. tab:: barbun-cuda

        .. code-block:: bash
      
            srun -p debug -C barbun-cuda -N 1 -n 1 -c 20 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i

    .. tab:: akya-cuda

        .. code-block:: bash
      
            srun -p debug -C akya-cuda -N 1 -n 1 -c 10 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i






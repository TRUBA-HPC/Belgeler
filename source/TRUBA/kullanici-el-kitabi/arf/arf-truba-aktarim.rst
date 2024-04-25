.. _arf-truba-aktarim:

=====================================
TRUBA ve ARF Arasında Dosya Aktarımı
=====================================


Kullanıcıların ARF hesaplama kümedesinde ev dizinlerinin adresi 
  
    .. code-block::
    
      /arf/home/kulaniciadi 

olarak tanımlıdır. ARF kümesine ayrılmış disk alanı (/arf) , mevcut disk alanından (/truba) tamamen bağımsızdır. Kullanıcıların tüm uygulamalarının ve çalışma dosyalarının /arf/home/kulaniciadi dizini altında olması gerekmektedir. Sadece kullanıcı arayüzü sunucularının ``(arf-ui1 veya arf-ui2)`` /truba depolama sistemine erişimi vardır. ``orfoz`` hesaplama sunucularının /truba dosya sistemine erişimi yoktur. O nedenle kullanıcılar, verilerini /arf/home/$USER dizinine taşımalı, ihtiyaç duyduğu uygulamaları yine bu dizine kurmalıdır. 

Kullanıcı arayüzünde iken (``arf-ui1, arf-ui2``) `/truba/home/$USER/kaynak-dosya` dizininde bulunan dosyayı `/arf/home/$USER/hedef-dosya` olarak kopyalamak için 

.. tabs::

    .. tab:: truba -> arf 

        .. code-block:: bash

            cp -r /truba/home/$USER/kaynak-dosya /arf/home/$USER/hedef-dosya 

    .. tab:: arf -> truba 

        .. code-block:: bash
    
            cp -r /arf/home/$USER/kaynak-dosya /truba/home/$USER/hedef-dosya

.. warning:: 
	Diğer hesaplama kümelerinde olduğu gibi, ARF hesaplama kümesinde de kota uygulaması mevcuttur. Küme test aşamasında olduğu için ev dizini kotaları  (kapasite ve dosya sayısı) düşük tutulmuştur. Şu an için güncel kotalar aşağıdaki gibidir:

.. code-block::

	Kapasite: 100GB 
	Dosya sayısı: 100K 

ARF kumesinde bulunan `/arf` dosya sisteminin kapasitesi kısıtlı olduğu için kullanıcılar  sadece çalışacakları verileri bu dosya sistemine taşımalı, ihtiyaç ortadan kalktıktan sonra, sistemden silmeli ya da `/truba` dosya sistemine taşımalıdır. Dosya sayısı kısıtından dolayı kullanıcılar ev dizinlerine Anaconda, miniconda ya da türevlerini kurmak yerine merkezi kurulumlari kullanabilirler. 

ARF kümesinde yer alan orfoz sunucularına bağlanmak için ilgili bilgilere :ref:`hesaplama-kumeleri` sayfasında yer alan :ref:`orfoz-node` içeriğinden erişebilirsiniz.


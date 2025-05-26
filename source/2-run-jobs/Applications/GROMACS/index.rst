=================================
GROMACS Kılavuzu
=================================


GROMACS, yüzlerce hatta milyonlarca parçacık içeren sistemler için Newton’un hareket denklemlerini kullanarak moleküler dinamik simülasyonları gerçekleştiren açık kaynak kodlu bir paket yazılımdır. Proteinler, lipidler ve nükleik asit gibi çok sayıda birbiriyle karmaşık etkileşime sahip biyokimyasal moleküller için tasarlanmıştır, ancak birbiriyle etkileşmeyen sistemlerin hesaplamalarını da oldukça hızlı yapmaktadır. Program açık kaynak yazılım olduğu için GROMACS'in kendi sayfasında yayınlanan kullanıcı kitabını referans alarak kolaylıkla kendi ev dizininize indirebilir ve derleyebilirsiniz. 

TRUBA’ya terminalden bağlantı sağladıktan sonra arf-uiX (X=1,2,3,4,5) kullanıcı arayüzünde terminalden

.. code-block::

  module available

komutunu yazdığınızda ARF sisteminde kurulu olan temel programlar listelenecektir. 

ARF hesaplama kümesinde yer alan ``orfoz`` sunucularında GROMACS 2023.3 ve GROMACS 2024.1 versiyonları bulunmaktadır. İlgili module isimleri aşağıdaki gibidir:

.. code-block::

  apps/gromacs/2023.3

.. code-block::

  apps/gromacs/2024.1-oneapi2024

arf-ui kullanıcı arayüz sunucularından birisine bağlı iken örnek SLURM betik dosyalarına aşağıdaki dizinden erişim sağlayabilirsiniz:

.. code-block::

  /arf/sw/scripts/gromacs


GROMACS için ilgili çalışma dosyalarınızı hazırladıktan sonra terminalden

.. code-block::

  sbatch slurmfilename.slurm

Komutu ile sistemde çalışmak üzere submit edebilirsiniz.

.. _gromacs_preprocessing:

-------------------------------------------------------------------
TRUBA'da GROMACS'in İnteraktif Kullanımı (Pre-process işlemi için)
-------------------------------------------------------------------

Hesaplamalarınız için CUDA destekli GROMACS programını kullanacaksanız eğer girdi (input) dosyanızı oluştururken de ilgili GROMACS versiyonunu kullanmanız gerekmektedir. GROMACS-CUDA modulunu terminalden interaktif olarak kullanıyorsanız ilgili işlemi barbun1 kullanıcı arayüz makinelerinde gerçekleştirmeniz maalesef mümkün değildir, bu işlem için de yine ``barbun-cuda`` hesaplama kümesini kullanmanız gerekmektedir. Bunu iki şekilde yapabilirsiniz:

1-  İlgili pre-process işlemi için "srun" komutu ile interaktif olarak node rezervasyonu yapmanız gerekli. Eğer ilgili işlem 15 dakikayı aşmayan bir işlem ise debug kuyrugundan interaktif node talebini aşağıdaki gibi yapabilirsiniz:


.. code-block:: bash

   srun -p debug -C barbun-cuda -N 1 -n 20 --gres=gpu:1 --time=00:15:00 --job-name "precalc" --pty bash -i

15 dakikayı aşan işlemler için ise ``debug`` kuyruğunu kullanmanız mümkün olmayacaktır. Dolayısıyla aşağıdaki komut ile interaktif node rezervasyonu yapabilirsiniz:

.. code-block:: bash

   srun -p barbun-cuda -N 1 -n 20 --gres=gpu:1 --time=01:00:00 --job-name "precalc" --pty bash -i

Bu komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili hesaplama kümesine bağlanacaksınız. Burada ilgili modulleri yükledikten sonra interaktif olarak işinizi çalıştırabilirsiniz. 
    
.. warning::

  Burada dikkat etmeniz gereken husus, eğer interaktif bilgi girişini sağladıktan sonra uzun sürecek olan bir işlemse terminalden bağlantınızın kopma ihtimaline karşılık ilgili çalıştırma komutunuzu (mpirun ile başlayan) ``nohup`` komutu ile arka planda çalıştırmanız veya ``screen`` komutu ile yeni bir terminalde işinizin arka planda çalışmasını sağlayabilirsiniz. ``screen`` komutunun opsiyonları ile ilgili olarak https://kb.iu.edu/d/acuy ve https://www.pixelbeat.org/lkdb/screen.html linklerinde yer alan sayfaları inceleyebilirsiniz.


2- Hesaplama kümeleri yoğun olarak kullanıldığı için ``srun`` komutu ile interaktif node rezervasyonu uzun bekleme süreleri gerektirebilir. Dolayısı ile GROMACS ile interaktif olarak yapacağınız pre-process işlemi aşağıdaki adımları takip ederek hesaplama kümelerinde kuyruğa girmek üzere gönderebilirsiniz.


İnteraktif bilgi girişi yapmanızı gerektiren pre-process işlemleri için ``expect`` komutunun özelliklerini kullanabilirsiniz.



ARF sisteminde kurulu olan GROMACS versiyonları dışında başka bir versiyona ihtiyacınız söz konusu ise GROMACS'in kendi sayfasında yayınlanan kullanım yönergesinden bilgi edinebilirsiniz (`GROMACS Kurulum Yönergesi <https://manual.gromacs.org/2024.4/install-guide/index.html>`_). GROMACS'in paralel çalışması için gerekli derleyici ve kütüphaneleri (Intel OneAPI, OpenMPI, vb.) sistemde halihazırda kurulu bulunan moduller arasından yükleyebilirsiniz.

.. _gromacs_arf_uyg:

-----------------------------------------
ARF'ta GROMACS Programı Nasıl Kullanılır?
-----------------------------------------


ARF kümesindeki sunucularda  hali hazırda kurulan olan GROMACS versiyonları için örnek SLURM betik dosyalarına ``/arf/sw/scripts/gromacs`` dizini altından erişim sağlayabilirsiniz.

Orfoz hesaplama kümesinde GROMACS 2024.1 versiyonunu kullanarak işinizi çalıştırmak için aşağıdaki betik dosyasını referans alabilirsiniz. 

.. note::

  İşlerinizi performanslı bir şekilde çalıştırmak için GROMACS kullanıcı el kitabında belirtildiği gibi ``ntmpi``, ``ntomp`` gibi parametreleri kullanmayı test edebilirsiniz:

  https://manual.gromacs.org/2024.2/user-guide/mdrun-performance.html



.. code-block:: bash

	#!/bin/bash
  #SBATCH -p orfoz
  #SBATCH -A kullanici_adi
  #SBATCH -J jobname
  #SBATCH -N 1
  #SBATCH -n 110
  #SBATCH -c 1
  #SBATCH -C weka
  #SBATCH --time=3-00:00:00

  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  module purge
  module load apps/gromacs/2024.1-oneapi2024

  #BURAYA is calistirma komutunuzu yaziniz
  
  mpirun gmx_mpi mdrun -v -s benchmark.tpr

  exit




   


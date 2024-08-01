.. _gromacs_preprocess:

==================================================================
TRUBA'da GROMACS'in İnteraktif Kullanımı (Pre-process işlemi için)
==================================================================


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

Çalıştıracağınız  programın komutunu ve de bilgi girişi yapmanız gereken sorulara ait anahtar kelimeleri bir betik dosyası içerisinde yazabilirsiniz. Bu betik dosyasının ismi ``run-QA.sh`` olsun. Bu scriptin içerisinde ilgili çalıştırma komutunuz yer almalı. Çalıştıracağınz işin listeleyeceği sorulara göre ilgili betik dosyasını (gmx-hamsi-cpu.slurm) düzenleyebilirsiniz. 

.. code-block:: bash

    ########################
    ####### run-QA.sh ######
    ########################
    #!/bin/bash

    command line (buraya lütfen ilgili çalıştırma komutunuzu yazınız)

    echo "group number for Protein or first Protein or first group: "

    read $REPLY

    echo "group number of Ligand or second Protein or second group:"

    read $REPLY

İnteraktif olarak giriş isteyen bilgilere verilecek cevapları bir betik dosyası içerisine aşağıdaki gibi yazabilirsiniz. Betik dosyasının ismi ``run-interactive.sh`` olsun. ``run-interactive.sh`` scripti öncelikle ``run-QA.sh`` scriptini çalıştırıyor. ``run-interactive.sh`` scripti programın size yönelttiği ilk sorunun (Enter the group number for Protein or first Protein or first group) son satırı olan “Select a group:” kelime bloğunu arıyor ve ilgili kelime bloğu ile karşılaşınca vereceği cevabı içeriyor. ``Select a group:`` anahtar kelimesi ekrana geldiğinde ``send`` komutu ile ilgili cevabı gönderiyor. Benzer şekilde ikinci soru (Enter the group number of Ligand or second Protein or second group) için de aynı işlem söz konusu. İkinci soru bloğu da yine ``Select a group:``  ile bittiği için yine bu kelime bloğunu görünce verilecek cevabı sunuyor.

Burada send komutu ile önce "run-QA.sh” dosyasındaki ilk soru için “1” seçeceği, ikinci soru için “14” seçenek iletiliyor. Çalıştıracağınz işin seçimlerine göre ilgili betik dosyasını düzenleyebilirsiniz.

.. code-block:: bash

    ##########################
    ### run-interactive.sh ###
    ##########################
    #!/usr/bin/expect -f

    set timeout -1

    spawn ./run-QA.sh

    expect "Select a group:"

    send -- "1\r"

    expect "Select a group:"

    send -- "14\r"

    expect eof


İşinizi çalıştırmanız için ise SLURM betik dosyası oluşturmanız gerekli. İşinizi çalıştırmanız için oluşturduğumuz SLURM betik dosyasının ismi de ``gmx-gpu.slurm`` olsun. SLURM betik dosyasını aşağıdaki gibi oluşturup hesaplama kümelerinde sıraya girmesi için submit edebilirsiniz. İlgili module isimlerini ve PATH leri programınızın gerekliliklerine göre düzenlemeyi unutmayınız. Süreyi ve de hesaplama kuyruğu gibi parametreleri de kontrol ediniz.

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p barbun-cuda
    #SBATCH --nodes=1
    #SBATCH --ntasks=20
    #SBATCH --gres=gpu:1
    #SBATCH -A accountname
    #SBATCH -J gromacs-pre
    #SBATCH --time=00-2:00:00
    #SBATCH --output=slurm-%j.out
    #SBATCH --error=slurm-%j.err

    module purge

    module load centos7.3/comp/gcc/7
    module load centos7.3/lib/openmpi/4.0.1-gcc-7.0.1
    module load centos7.3/comp/python/3.6.5-gcc
    module load centos7.3/lib/cuda/10.1

    module load centos7.3/app/plumed/2.7.2-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA
    module load centos7.3/app/gromacs/2021-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA

    export OMP_NUM_THREADS=1

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    ./run-interactive.sh

    exit

İlgili SLURM betik dosyanızı hesaplama kümelerine 

.. code-block:: bash

    sbatch gmx-gpu.slurm

komutu ile gönderdikten sonra işlem sırasına alıacak ve de sonuç olarak GROMACS girdi dosyanız oluşturulacaktır.


Yukarıdaki işlem basamakları GPU destekli GROMACS versiyonu için örnek oalrak verilmiştir. Centos7.3 işletim sistemi olan barbun hesaplama kümesindeki veya Centos7.9 işletim sistemi olan hamsi hesaplama kümelerinde yer alan diğer GROMACS versiyonları için de benzer adımları gerçekleştirebilirsiniz. Örneğin hamsi hesaplama kümesinde kurulu olan "centos7.9/app/gromacs/2021.2-impi-mkl-oneapi-2021.2-GOLD" modulunu kullanarak hesaplamalarınızı yapmayı planlıyorsanız SLURM betik dosyanızın formatı aşağıdaki gibi olmalıdır:


.. code-block:: bash

    #!/bin/bash
    #SBATCH -p hamsi
    #SBATCH -A account_name
    #SBATCH -J gromacs-pre
    #SBATCH -N 1
    #SBATCH -n 28
    #SBATCH --time=1-12:00:00
    #SBATCH --output=slurm-%j.out
    #SBATCH --error=slurm-%j.err

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    export OMP_NUM_THREADS=1
    export OMPI_MCA_btl_openib_allow_ib=1

    module purge

    module load centos7.9/comp/gcc/7
    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
    module load centos7.9/app/gromacs/2021.2-impi-mkl-oneapi-2021.2-GOLD

    ./run-interactive.sh

    exit

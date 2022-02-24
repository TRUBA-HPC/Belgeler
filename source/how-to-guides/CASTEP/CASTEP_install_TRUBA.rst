========================================
TRUBA'da CASTEP Kurulumu
========================================

Aşağıda CASTEP programının ``19.11`` versiyonunun TRUBA sisteminde derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip ederek CASTEP programını kendi kullanıcı hesabınızla ev dizininize kurabilirsiniz.

-------------------------------------
Barbun Hesaplama Kümesi'nde Kurulum
-------------------------------------

**1.** CASTEP programını derlemek için bir klasör oluşturup ilgili klasöre gidiniz. Kullanmak istediğiniz versiyon için edindiğiniz kurulum dosyalarını klasöre kopyalayınız.

.. code-block::

    mkdir CASTEP
    cd CASTEP

Sıkıştırılmış arşiv dosyalarını açınız ve kurulum dosyalarının olduğu ilgili klasöre gidiniz.

.. code-block::

    tar -xzvf CASTEP-19.11.tar.gz
    cd CASTEP-19.11

**2.** Kurulumu ``barbun`` hesaplama kümesinde optimize bir şekilde yapmak için``srun`` komutu ile ``barbun`` kuyruğundaki 1 tane makineden 4 tane CPU'yu (Barbun kümesindeki CPU kullanımı için bakınız: :ref:`barbun-node`) kendi kullanıcınız için interaktif olarak ayırabilirsiniz. Aşağıdaki komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili node'a bağlanacaksınız. Hesaplama kuyruğunu ve süreyi kurallar dahilinde değiştirebilirsiniz (:ref:`partitions`).

.. code-block:: bash

   srun -A kullaniciadi -p barbun -N 1 --ntasks-per-node=4 --time=02:00:00 --constraint=barbun --job-name "castep-install" --pty bash -i

**3.** TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Barbun node'unda ``centos 7.3`` işletim sistemi yüklü bulunmaktadır.

Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

**4.** Kurulum için Intel modülünü yükleyiniz.

.. code-block:: bash

    module load centos7.3/comp/intel/PS2018-update2

Aşağıdaki komut ile Intel MKL path i hakkında bilgi elde edebilirsiniz:

.. code-block::

    echo $MKLROOT

.. note::

    Intel 2018 için terminalde görüntüleyeceğiniz çıktı: 

    .. code-block::

        /truba/sw/centos7.3/comp/intel/PS2018-update2/compilers_and_libraries_2018.2.199/linux/mkl

**5.** Intel derleyicisi, Intel MPI ve Intel MKL ile kurulumu gerçekleştirmek için aşağıdaki komut satırını kulanabilirsiniz. Kurulum için belirtilen klasörün yolunu kendi kullanıcınız için kontrol ediniz:

.. code-block::

    make COMMS_ARCH=mpi FFT=mkl FFTLIBDIR=$MKLROOT/lib/intel64_lin MATHLIBS=mkl10 MATHLIBDIR=$MKLROOT/lib/intel64_lin INSTALL_DIR=/truba/home/USERNAME/CASTEP/CASTEP-19.11/bin-barbun-intel-PS2018

**6.** Kurulum bittikten sonra obj klasörü altında ``linux_x86_64_ifort18--mpi`` isimli bir klasör ve ``linux_x86_64_ifort18--mpi.mk`` dosyasını göreceksiniz. Yeni oluşturulan bu klasör ve dosyayı aşağıdaki komut ile tanımladığınız bin klasörüne taşıyınız.

.. code-block::

    mv obj/linux_x86_64_ifort18*  $INSTALL_DIR

Paralel olarak iş çalıştırmanızı sağlayacak oln "castep.mpi" çalıştırılabilir dosyası (castep.mpi),``linux_x86_64_ifort18--mpi`` klasörü altında yer almaktadır.

:ref:`Kurulumunu yaptığınız CASTEP programını TRUBA sisteminde çalıştırmak  için örnek olarak verilen SLURM dosyasını incelemek için tıklayınız... <castep-slurm>`



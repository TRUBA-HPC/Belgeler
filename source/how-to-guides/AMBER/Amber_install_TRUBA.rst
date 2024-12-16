.. _amber-install:

==============================
ARF Kümesinde Amber Kurulumu
==============================

Kendi yerel bilgisayarınızdan TRUBA'ya ilgili AMBER kurulum dosyalarını aktarmak için Filezilla gibi açık kaynak kodlu olan ve grafik arayüz sağlayan FTP istemcisini veya yerel bilgisayarınızın terminali üzerinden ``scp`` komutunu kullanabilirsiniz. Bu işlem adımları için aktif bir OpenVPN bağlantınızın olması gerekmektedir.

.. code-block:: bash

    scp -r /source/folder/path/Amber*tar.bz2 username@172.16.6.11:/arf/home/username

Kurulum yapmak üzere, aktif bir OpenVPN bağlantınız varken, ``arf-ui`` kullanıcı arayüz sunucularından birisine (:ref:`openvpn-info`) bağlanınız. 

.. code-block:: bash

    ssh username@172.16.6.11


Amber programını derlemek için ev dizininizde bir klasör oluşturup ilgili klasöre gidiniz ve gerekli kurulum dosyalarını bu klasöre taşıyınız. 

.. code-block:: bash

    mkdir amber-install
    cd amber-install 
    mv AmberTools24.tar.bz2 Amber24.tar.bz2 amber-install 

Sıkıştırılmış arşiv dosyalarını açınız:

.. code-block:: bash

    tar xvfj AmberTools24.tar.bz2  
    tar xvfj Amber24.tar.bz2 

.. note::

    Arşiv dosyaları ``amber24_src`` isimli klasöre açılacaktır. 

Amber programı kullanım kitapçığındaki standart `CMake prosedürünü <https://ambermd.org/pmwiki/pmwiki.php/Main/CMake-Common-Options>`_ izler. Kurulumu ``CMake`` ile yapmak için ilgili modülü yükleyiniz:

.. code-block:: bash

   module load comp/cmake/3.31.1


.. note::

    Aşağıdaki kurulum yönergesi ``GNU`` derleyicileri içindir. INTEL veya farklı derleyiciler için Amber kullanıcı dökümanını inceleyebilirsiniz.

.. grid:: 2
   
    .. grid-item-card:: :ref:`amber_cpu_seri_kurulum`
        :text-align: center   
    .. grid-item-card::  :ref:`amber_cpu_oepnmp_kurulum`
        :text-align: center
    .. grid-item-card:: :ref:`amber_cpu_mpi_kurulum`
        :text-align: center
    .. grid-item-card:: :ref:`amber_cpu_cuda_kurulum`
        :text-align: center


-------------------------------------------
CPU İçeren Hesaplama Kümeleri İçin Kurulum
-------------------------------------------

Kurulumu hangi sunucu için yapmayı planlıyorsanız ``debug`` kuyruğundan ``srun`` ile interaktif sunucu rezervasyonu yapmanız gerekmektedir. Bu dokümantasyonda örnek olarak kurulum orfoz sunucusu üzerinde gerçekleştirilmiştir.


.. tabs::

    .. tab:: orfoz

        .. code-block:: bash
      
            srun -p debug -C orfoz -N 1 -n 1 -c 55 -A kullanici_adi -J amber --time=0:30:00 --pty /usr/bin/bash -i
  
    .. tab:: hamsi

        .. code-block:: bash
      
            srun -p debug -C hamsi -N 1 -n 1 -c 54 -A kullanici_adi -J amber --time=0:30:00 --pty /usr/bin/bash -i
  
    .. tab:: barbun

        .. code-block:: bash
      
            srun -p debug -C barbun -N 1 -n 1 -c 20 -A kullanici_adi -J amber --time=0:30:00 --pty /usr/bin/bash -i


TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından kurulum işlemlerine başlamadan önce

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modüle dosyalarını kaldırmanız önerilmektedir.

Amber programını GNU derleyicileri ile kurmak için bağlandığınız sunucuda yer alan ``GCC`` versiyonunu 

.. code-block:: bash

   gcc --version

komutu ile kontrol edebilirsiniz. Eğer ilgili ``GCC`` versiyonu, programın gereksinimlerini karşılayan bir versiyonsa ayrıca bir ``GCC`` modülü yüklemenize gerek yoktur. Sunucudaki ``GCC`` versiyonundan daha üst bir versiyona ihtiyaç söz konusu ise ``module available`` komutu ile listelediğiniz ``GCC`` versiyonlarından uygun olanını ``module load`` komutu ile yükleyebilirsiniz. Bu kurulum yönergesinde sistemde varsayılan olarak yer alan ``GCC`` versiyonu ile devam edilecektir.


.. _amber_cpu_seri_kurulum:

Seri Kurulum
--------------

Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd amber_src
    cd build

Kuruluma dair gerekli değişiklikleri yapmak için ``run_cmake`` komut dosyasını düzenlemeniz gerekmektedir. Dosyayı terminal üzerinden düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz. Seri kurulum için herhangi bir değişiklik yapmadan kuruluma devam edilebilir. 

.. note::

    GNU derleyicileri dışında farklı bir derleyici ile kurulum yapılması planlanıyorsa ``run_cmake`` komut dosyasında ``-DCOMPILER`` parametresi için ilgili derleyici belirtilmelidir.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Tanımladığınız derleyicilerin path'leri listelenecektir ve devamında da gerekli olan (miniconda vb.) kurulum dosyalarını internet üzerinden indirerek kurulum için gerekli ortam hazırlanacaktır. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler vb.) listelenmektedir. Seri kullanım için kurulum yaptığımızdan ekran görüntüsünde ``MPI, OpenMP, CUDA`` gibi parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-serial.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /arf/home/username/amber-install/amber24/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /arf/home/username/amber-install/amber24_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /arf/home/username/amber-install/amber24/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/arf/home/username/amber-install/amber24/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /arf/home/username/amber-install/amber24/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/arf/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

Seri kurulum sonucunda kurulum dizininizin altında ``bin`` klasöründe ``sander`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME
    make test.serial

Amber programı için öğretici örneklere programın kendi web sayfasından ulaşabilirsiniz (https://ambermd.org/tutorials/).

.. warning::

    Seri olan kod sadece tek çekirdek üzerinde çalışır o nedenle TRUBA sisteminde birden fazla tek çekirdekli işi :ref:`GREASY <greasy-kilavuzu>` ile çalıştırabilirsiniz.

.. _amber_cpu_openmp_kurulum:

OpenMP ile Kurulum
--------------------

Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /arf/home/username/amber-install/amber_src
    cd build

CMake ile kurulum için öncelikle ilgili modülü yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load comp/cmake/3.31.1

OpenMP ile kurulum için ``run_cmake`` komut dosyasında ``-DOPENMP=TRUE`` olarak düzenleyip kaydetmeniz gerekmektedir. Dosyayı terminal üzerinde düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz.

.. warning::

    ``OMP`` olan kod, sadece node içerisinde paralellik sağlar. İşinizi tek bir sunucuya gönderdiğinizde, belirlediğiniz çekirdek sayısına göre  (``export OMP_NUM_THREADS=`` ) işleri çekirdeklere dağıtır.


Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. ``OpenMP`` ile kurulum yaptığımızdan ekran görüntüsünde OpenMP parametresinin ``ON``,  ``MPI, CUDA`` gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-openmp.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /arf/home/username/amber-install/amber24/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /arf/home/username/amber-install/amber24_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /arf/home/username/amber-install/amber24/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/arf/home/username/amber-install/amber24) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /arf/home/username/amber-install/amber24/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/arf/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.


OpenMP ile kurulum sonucunda kurulum dizininizin altında ``bin`` klasöründe ``sander.OMP`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    make test.openmp

.. _amber_cpu_mpi_kurulum:

MPI ile Kurulum
--------------------

MPI, işleri hem sunucun kendi içerisinde hem de birden fazla sunucu arasında dağıtarak paralelleştirme sağlar. Amber'in paralel (MPI) sürümünü derlemek için aşağıdaki adımları izleyiniz (seri sürümü başarıyla kurduktan sonra).

Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /arf/home/username/amber-install/amber_src
    cd build

GNU derleyicileri ve de OpenMPI kütüphanesi ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load comp/cmake/3.31.1
   module load lib/openmpi/5.0.4


MPI ile kurulum için ``run_cmake`` komut dosyasında ``-DMPI=TRUE`` olarak düzenleyip kaydetmeniz gerekmektedir. Dosyayı terminal üzerinde düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. ``MPI`` ile kurulum yaptığımızdan ekran görüntüsünde MPI parametresinin ``ON``, ``OpenMP, CUDA`` gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-mpi.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /arf/home/username/amber-install/amber24/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /arf/home/username/amber-install/amber24_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /arf/home/username/amber-install/amber24/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/arf/home/username/amber-install/amber24/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /arf/home/username/amber-install/amber24/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/arf/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

MPI ile kurulum sonucunda kurulum dizininizin altında (/arf/home/username/amber-install/amber24) ``bin`` klasöründe ``sander.MPI`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    export DO_PARALLEL="mpirun -np 2"

    make test.parallel


.. _amber_cpu_cuda_kurulum:

CUDA ile Kurulum
--------------------

CUDA, NVIDIA GPU'larında çalışan özel uygulamalar oluşturmak için NVIDIA'nın yazılım geliştirme kitidir. Amber öncelikle ``pmemd.cuda`` da CUDA'yı kullanır, ancak aynı zamanda AmberTools'daki ``cpptraj, mdgx, pbsa`` gibi diğer bazı uygulamaları hızlandırmak için de kullanılır. Mevcut durumda Amber 24 versiyonu, 7.5 ile 12.4 dahil CUDA sürümlerini desteklemektedir.

.. warning::

    CUDA ile kurulum için barbun-cuda veya akya-cuda hesaplama kümelerinden interaktif olarak ``srun`` komutu ile rezervasyon yapabilirsiniz. Kurulumu GPU kartı olan CUDA hesaplama kümesinde gerçekleştirmeniz gerekmektedir.


.. tabs::

    .. tab:: barbun-cuda

        .. code-block:: bash
      
            srun -p debug -C barbun-cuda -N 1 -n 1 -c 20 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i

    .. tab:: akya-cuda

        .. code-block:: bash
      
            srun -p debug -C akya-cuda -N 1 -n 1 -c 10 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i


Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /arf/home/username/amber-install/amber_src
    cd build

GNU derleyicileri ve de CUDA ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load comp/cmake/3.31.1
   module load lib/cuda/12.4

CUDA dizinini aşağıdaki komut ile kontrol edebilirsiniz:

.. code-block:: bash

    echo $CUDA_HOME

İlgili komutun çıktısı aşağıdaki gibi olacaktır:

.. code-block:: bash

    /arf/sw/lib/cuda/12.4

CUDA ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/arf/sw/lib/cuda/12.4``) ekleyip kaydetmeniz gerekmektedir. Dosyayı terminal üzerinde düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. ``CUDA`` ile kurulum yaptığımızdan ekran görüntüsünde ``CUDA`` parametresinin ``ON``,  ``OpenMP, MPI`` gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-cuda.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /arf/home/username/amber-install/amber24/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /arf/home/username/amber-install/amber24_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /arf/home/username/amber-install/amber24/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/arf/home/username/amber-install/amber24/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /arf/home/username/amber-install/amber24/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/arf/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

CUDA ile kurulum sonucunda kurulum dizininizin altında (/arf/home/username/amber-install/amber24) ``bin`` klasöründe ``pmemd.cuda`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME
    export CUDA_VISIBLE_DEVICES=0
    make test.cuda.serial

CUDA ve MPI ile Kurulum
--------------------------

CUDA seri kurulumu başarıyla tamamladıktan sonra CUDA ve MPI ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE``, ``-DMPI=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/arf/sw/lib/cuda/12.4``) ekleyip kaydetmeniz gerekmektedir. Dosyayı terminal üzerinde düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz.

.. warning::

    CUDA ile kurulum için cuda hesaplama kümelerinden interaktif olarak ``srun`` komutu ile rezervsyon yapabilirsiniz. Kurulumu GPU kartı olan CUDA hesaplama kümesinde gerçekleştirmeniz gerekmektedir.

.. tabs::

    .. tab:: barbun-cuda

        .. code-block:: bash
      
            srun -p debug -C barbun-cuda -N 1 -n 1 -c 20 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i

    .. tab:: akya-cuda

        .. code-block:: bash
      
            srun -p debug -C akya-cuda -N 1 -n 1 -c 10 --gres=gpu:1 -A kullanici_adi -J test --time=0:30:00 --pty /usr/bin/bash -i
    
Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /arf/home/username/amber-install/amber_src
    cd build

GNU derleyicileri, CUDA ve de OpenMPI kütüphanesi ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load comp/cmake/3.31.1
   module load lib/cuda/12.4
   module load lib/openmpi/5.0.4-cuda-12.4

CUDA dizinini aşağıdaki komut ile kontrol edebilirsiniz:

.. code-block:: bash

    echo $CUDA_HOME

İlgili komutun çıktısı aşağıdaki gibi olacaktır:

.. code-block:: bash

    /arf/sw/lib/cuda/12.4

CUDA ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/arf/sw/lib/cuda/12.4``) ekleyip kaydetmeniz gerekmektedir. Dosyayı terminal üzerinde düzenlemek için ``vi, vim, nano, emacs`` gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. CUDA ve MPI ile kurulum yaptığımızdan ekran görüntüsünde CUDA ve MPI parametrelerinin ``ON``,  OpenMP parametresinin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-mpi-cuda.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /arf/home/username/amber-install/amber24/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /arf/home/username/amber-install/amber24_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /arf/home/username/amber-install/amber24/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/arf/home/username/amber-install/amber24/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /arf/home/username/amber-install/amber24/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/arf/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

CUDA ile kurulum sonucunda kurulum dizininizin altında (/arf/home/username/amber-install/amber24) ``bin`` klasöründe ``pmemd.cuda.MPI`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    export DO_PARALLEL="mpirun -np 2"

    export CUDA_VISIBLE_DEVICES=0

    make test.cuda.parallel

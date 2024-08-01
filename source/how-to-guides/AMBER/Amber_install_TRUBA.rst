.. _amber-install:

==========================
TRUBA'da Amber Kurulumu
==========================

-------------------------------------
Barbun Hesaplama Kümesinde Kurulum
-------------------------------------

Amber programını derlemek için ev dizininizde bir klasör oluşturup ilgili klasöre gidiniz ve gerekli kurulum dosyalarını bu klasöre kopyalayınız.

.. code-block:: bash

    mkdir amber-install
    cd amber-install 
    cp AmberTools22.tar.bz2 Amber22.tar.bz2 amber-install 

Sıkıştırılmış arşiv dosyalarını açınız:

.. code-block:: bash

    tar xvfj AmberTools22.tar.bz2  
    tar xvfj Amber22.tar.bz2 

Arşiv dosyaları ``amber22_src`` isimli klasöre açılacaktır.

.. note::

   Amber22.tar.bz2 isimli sıkıştırılmış dosyaya Amber lisansına sahipseniz erşiminiz olacaktır.


Kurulumu ``barbun`` kuyruğu için optimize bir şekilde kurmak için terminalden ``barbun1`` kullanıcı arayüzüne (:ref:`openvpn-info`) bağlanarak kurulum işlemlerinize başlayabilirsiniz.

.. note::

    CUDA ile kurulum için cuda hesaplama kümelerinden interaktif olarak ``srun`` komutu ile rezervsyon yapabilirsiniz. Kurulumu GPU kartı olan CUDA hesaplama küümesinde gerçekleştirmniz gerekmektedir.

    srun -A username -p barbun-cuda -N 1 -n 20 --gres=gpu:1 --time=00-02:30:00 --job-name "amber" --pty bash -i


TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından kurulum işlemlerine başlamadan önce

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

Barbun hesaplama kümesinde ``Centos 7.3`` işletim sistemi yüklü bulunmaktadır. 
Amber programı kullanım kitapçığındaki standart `CMake prosedürünü <https://ambermd.org/pmwiki/pmwiki.php/Main/CMake-Common-Options>`_ izler. Kurulumu ``CMake`` ile yapmak için ilgili modülü yükleyiniz:

.. code-block:: bash

   module load centos7.3/comp/cmake/3.18.0


.. note::

    Aşağıdaki kurulum yönergesi ``GNU`` derleyicileri içindir. INTEL veya farklı derleyiciler için Amber kullanıcı dökümanını inceleyebilirsiniz.


Seri Kurulum
--------------

Amber programını GNU derleyicileri ile kurmak için programın gereksinimlerini karşılayan, uyumlu olan GCC modülünü yükleyebilirsiniz. 

.. code-block:: bash

    module load centos7.3/comp/gcc/10.4 


Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd amber_src
    cd build

Kuruluma dair gerekli değişiklikleri yapmak için ``run_cmake`` komut dosyasını düzenlemeniz gerekmektedir. Çoğu kullanıcının bunu yapması gerekmez. Seri kurulum için herhangi bir değişiklik yapmadan kuruluma devam edeceğiz. 

.. note::

    GNU derleyicileri dışında farklı bir derleyici ile kurulum yapılması planlanıyorsa ``run_cmake`` komut dosyasında ``-DCOMPILER`` parametresi için ilgili derleyici belirtilmelidir.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Tanımladığınız derleyicilerin path'leri listelenecektir ve devamında da gerekli olan (miniconda vb.) kurulum dosyalarını internet üzerinden indirerek kurulum için gerekli ortam hazırlanacaktır. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler vb.) listelenmektedir. Seri kullanım için kurulum yaptığımızdan ekran görüntüsünde MPI, OpenMP, CUDA gibi parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-serial.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /truba/home/username/amber-install/amber22/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /truba/home/username/amber-install/amber22_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /truba/home/username/amber-install/amber22/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/truba/home/username/amber-install/amber22/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /truba/home/username/amber-install/amber22/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/truba/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

Seri kurulum sonucunda kurulum dizininizin altında ``bin`` klasöründe ``sander`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME
    make test.serial

Amber programı için öğretici örneklere programın kendi web sayfasından ulaşabilirsiniz (https://ambermd.org/tutorials/).

.. warning::

    Seri olan kod sadece tek çekirdek üzerinde çalışır o nedenle TRUBA sisteminde sadece ``single`` kuyruğunda kullanabilirsiniz.


OpenMP ile Kurulum
--------------------

Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /truba/home/username/amber-install/amber_src
    cd build

CMake ve de GNU derleyicileri ile kurulum için öncelikle ilgili modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load centos7.3/comp/cmake/3.18.0
   module load centos7.3/comp/gcc/10.4


OpenMP ile kurulum için ``run_cmake`` komut dosyasında ``-DOPENMP=TRUE`` olarak düzenleyip kaydetmeniz gerekmektedir. Bunun için vi, vim, nano, emacs gibi editörleri kullanabilirsiniz.

.. warning::

    OMP olan kod, sadece node içerisinde paralellik sağlar. İşinizi tek bir node'a gönderdiğinizde, belirlediğiniz çekirdek sayısına göre  (``export OMP_NUM_THREADS=`` ) işleri çekirdeklere dağıtır.


Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. OpenMP ile kurulum yaptığımızdan ekran görüntüsünde OpenMP parametresinin ``ON``,  MPI, CUDA gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-openmp.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /truba/home/username/amber-install/amber22/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /truba/home/username/amber-install/amber22_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /truba/home/username/amber-install/amber22/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:


.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/truba/home/username/amber-install/amber22/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /truba/home/username/amber-install/amber22/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/truba/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.


OpenMP ile kurulum sonucunda kurulum dizininizin altında ``bin`` klasöründe ``sander.OMP`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    make test.openmp


MPI ile Kurulum
--------------------

MPI, işleri hem node içerisinde hem de nodelar arasında dağıtarak paralelleştirme sağlar. Amber'in paralel (MPI) sürümünü derlemek için aşağıdaki adımları izleyiniz (seri sürümü başarıyla kurduktan sonra).

Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /truba/home/username/amber-install/amber_src
    cd build

GNU derleyicileri ve de OpenMPI kütüphanesi ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load centos7.3/comp/cmake/3.18.0

   module load centos7.3/comp/gcc/10.4
   module load centos7.3/lib/openmpi/4.1.4-gcc-10.4


MPI ile kurulum için ``run_cmake`` komut dosyasında ``-DMPI=TRUE`` olarak düzenleyip kaydetmeniz gerekmektedir. Bunun için vi, vim, nano, emacs gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. MPI ile kurulum yaptığımızdan ekran görüntüsünde MPI parametresinin ``ON``,  OpenMP, CUDA gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-mpi.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /truba/home/username/amber-install/amber22/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /truba/home/username/amber-install/amber22_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /truba/home/username/amber-install/amber22/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/truba/home/username/amber-install/amber22/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /truba/home/username/amber-install/amber22/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/truba/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

MPI ile kurulum sonucunda kurulum dizininizin altında (/truba/home/username/amber-install/amber22) ``bin`` klasöründe ``sander.MPI`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    export DO_PARALLEL="mpirun -np 2"

    make test.parallel



CUDA ile Kurulum
--------------------

CUDA, Nvidia GPU'larında çalışan özel uygulamalar oluşturmak için Nvidia'nın yazılım geliştirme kitidir. Amber öncelikle ``pmemd.cuda`` da CUDA'yı kullanır, ancak aynı zamanda AmberTools'daki ``cpptraj, mdgx, pbsa`` gibi diğer bazı uygulamaları hızlandırmak için de kullanılır. Mevcut durumda Amber, 7.5 ile 11.x dahil CUDA sürümlerini desteklemektedir (yalnızca 11.2'ye kadar test edilmiştir).

.. warning::

    CUDA ile kurulum için cuda hesaplama kümelerinden interaktif olarak ``srun`` komutu ile rezervsyon yapabilirsiniz. Kurulumu GPU kartı olan CUDA hesaplama küümesinde gerçekleştirmniz gerekmektedir.

    srun -A username -p barbun-cuda -N 1 -n 20 --gres=gpu:1 --time=00-02:30:00 --job-name "amber" --pty bash -i


Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /truba/home/username/amber-install/amber_src
    cd build

GNU derleyicileri ve de CUDA ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load centos7.3/comp/cmake/3.18.0
   module load centos7.3/comp/gcc/10.4
   module load centos7.9/lib/cuda/11.1

CUDA dizini aşağıdaki gibi tanımlanmalıdır:

.. code-block:: bash

    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.1

CUDA ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/truba/sw/centos7.9/lib/cuda/11.1``) ekleyip kaydetmeniz gerekmektedir. Bunun için vi, vim, nano, emacs gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. CUDA ile kurulum yaptığımızdan ekran görüntüsünde CUDA parametresinin ``ON``,  OpenMP, MPI gibi diğer parametrelerin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-cuda.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /truba/home/username/amber-install/amber22/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /truba/home/username/amber-install/amber22_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /truba/home/username/amber-install/amber22/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/truba/home/username/amber-install/amber22/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /truba/home/username/amber-install/amber22/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/truba/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

CUDA ile kurulum sonucunda kurulum dizininizin altında (/truba/home/username/amber-install/amber22) ``bin`` klasöründe ``pmemd.cuda`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME
    export CUDA_VISIBLE_DEVICES=0
    make test.cuda.serial

CUDA ve MPI ile Kurulum
--------------------------

CUDA seri kurulumu başarıyla tamamladıktan sonra CUDA ve MPI ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE``, ``-DMPI=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/truba/sw/centos7.9/lib/cuda/11.1``) ekleyip kaydetmeniz gerekmektedir. Bunun için vi, vim, nano, emacs gibi editörleri kullanabilirsiniz.

.. warning::

    CUDA ile kurulum için cuda hesaplama kümelerinden interaktif olarak ``srun`` komutu ile rezervsyon yapabilirsiniz. Kurulumu GPU kartı olan CUDA hesaplama kümesinde gerçekleştirmeniz gerekmektedir.

    srun -A username -p barbun-cuda -N 1 -n 20 --gres=gpu:1 --time=00-02:30:00 --job-name "amber" --pty bash -i



Kurulum için amber_src dizini altındaki ``build`` klasörüne gidiniz.

.. code-block:: bash

    cd /truba/home/username/amber-install/amber_src
    cd build

GNU derleyicileri, CUDA ve de OpenMPI kütüphanesi ile kurulum için öncelikle ilgili ve de uyumlu modülleri yüklemeniz gerekmektedir:

.. code-block:: bash

   module purge 
   module load centos7.3/comp/cmake/3.18.0

   module load centos7.3/comp/gcc/10.4
   module load centos7.3/lib/openmpi/4.1.4-gcc-10.4
   module load centos7.9/lib/cuda/11.1

CUDA dizini aşağıdaki gibi tanımlanmalıdır:

.. code-block:: bash

    export CUDA_HOME=/truba/sw/centos7.9/lib/cuda/11.1

CUDA ile kurulum için ``run_cmake`` komut dosyasında ``-DCUDA=TRUE`` ve de kullandığınız CUDA versiyonuna göre CUDA için root klasörünün yolunu  (buradaki örnek kurulum için ``-DCUDA_TOOLKIT_ROOT_DIR=/truba/sw/centos7.9/lib/cuda/11.1``) ekleyip kaydetmeniz gerekmektedir. Bunun için vi, vim, nano, emacs gibi editörleri kullanabilirsiniz.

Kurulumu başlatmak için aşağıdaki komutu terminalden yazınız:

.. code-block:: bash

    ./run_cmake

Bu işlem adımı ile birlikte ekranda çıkan bilgilerde öncelikle tanımladığınız derleyicilerin path'leri listelenecektir ve gerekli çevre değişkenleri kontrol edilecektir. Süreç sorunsuz olarak ilerlediğinde terminalde aşağıdaki ekran görüntüsüne benzer bir çıktı elde edeceksiniz. Burada kuruluma dair ayrıntılar (derleyiciler, kütüphaneler, kurulum dizini vb.) listelenmektedir. CUDA ve MPI ile kurulum yaptığımızdan ekran görüntüsünde CUDA ve MPI parametrelerinin ``ON``,  OpenMP parametresinin ``OFF`` durumda olduğunu göreceksiniz.

.. figure:: /assets/amber-howto/amber-mpi-cuda.png
   :align: center
   :figwidth: 600px

İlgili ekran çıktısının sonunda Amber programının nereye kurulacağına dair bilgi ile birlikte sonraki adımda uygulamanız gereken komut bilgileri yer alacaktır:

.. code-block:: bash

    -- Amber will be installed to /truba/home/username/amber-install/amber22/
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /truba/home/username/amber-install/amber22_src/build

    If the cmake build report looks OK, you should now do the following:

    make install
    source /truba/home/username/amber-install/amber22/amber.sh

    Consider adding the last line to your login startup script, e.g. ~/.bashrc

Yukarıdaki ekran çıktısında yaptığınız kontrol sonucunda kurulum parametrelerinin doğru olduğunu düşünüyorsanız kurulum adımına geçebilirsiniz:

.. code-block:: bash

    make install

Bu işlem uzun sürecektir. Kurulum adımı, kurulum dizininizde (/truba/home/username/amber-install/amber22/) bir ``amber.sh`` kaynak dosyası oluşturacaktır. Bu dosya, ``source`` edildiğinde kabuk (shell) ortamınızı Amber için doğru şekilde kuracaktır:

.. code-block:: bash

    source /truba/home/username/amber-install/amber22/amber.sh 

.. note::

    Kaynak dosyasının ``source`` edilmesi gerektiğini, çalıştırılmaması gerektiğini unutmayın. Bu komutları oturum açma kaynak dosyanıza (``/truba/home/username/.bashrc`` gibi) ekleyebilirsiniz. İlgili komut Amber'i içeren bir dizi iş akışı için gerekli olan ``AMBERHOME`` ortam değişkenini ayarlar.

CUDA ile kurulum sonucunda kurulum dizininizin altında (/truba/home/username/amber-install/amber22) ``bin`` klasöründe ``pmemd.cuda.MPI`` isimli çalıştırılabilir dosya oluşacaktır.

Kurulum tamamlandıktan sonra kontrol etmek amacıyla test adımına geçebilirsiniz.

.. code-block:: bash

    cd $AMBERHOME

    export OMPI_MCA_btl_openib_allow_ib=1
    export OMP_NUM_THREADS=1

    export DO_PARALLEL="mpirun -np 2"

    export CUDA_VISIBLE_DEVICES=0

    make test.cuda.parallel

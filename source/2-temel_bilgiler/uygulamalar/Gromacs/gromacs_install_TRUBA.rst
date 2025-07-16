.. _gromacs-install:

==========================
TRUBA'da GROMACS Kurulumu
==========================

Kullanıcılarımız tarafından sıklıkla kullanılan, açık kaynak kodlu olan ve GNU GPL lisansı altında sunulan yazılımlar altyapımızda yer almaktadır. TRUBA’ya terminalden bağlantı sağladıktan sonra barbun1 kullanıcı arayüzünde terminalden

.. code-block::

  module available

komutunu yazdığınızda TRUBA sisteminde kurulu olan temel programlar listelenecektir. Module isimlendirmesi ile ilgili bilgilere TRUBA :ref:`moduller-truba` sayfamızdan ulaşabilirsiniz.

Centos7.3 işletim sistemi olan ``barbun-cuda`` hesaplama kümesinde GROMACS 2021'in CUDA opsiyonu ile kurulu olan versiyonu bulunmaktadır. İlgili module ismi:

.. code-block::

  centos7.3/app/gromacs/2021-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA

İlgili versiyonda ``plumed patch`` de yer almaktadır. Bu versiyonu kullanmak için örnek slurm betik dosyasına ``/truba/sw/scripts/gromacs`` klasörü altından ulaşabilirsiniz. Dosya ismi: ``gromacs-2021-openmpi-4.0.1-python-3.6.5-gcc-7-GOLD-CUDA.slurm``

Hamsi hesaplama kümesinde ise Centos 7.9 işletim sistemi yüklüdür ve burada GROMACS 2021.2 versiyonu bulunmaktadır. İlgili modüle ismi:

.. code-block::

  centos7.9/app/gromacs/2021.2-impi-mkl-oneapi-2021.2-GOLD

Bu versiyonu kullanmak için örnek slurm betik dosyasına ``/truba/sw/scripts/gromacs`` klasörü altından ulaşabilirsiniz. Dosya ismi: ``gromacs-2021.2-impi-mkl-oneapi-2021.2-GOLD.slurm``

Aşağıda GROMACS programının gromacs-2021.2 versiyonunun TRUBA altyapısında derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip ederek GROMACS programını kendi ev dizininizde kurabilirsiniz.

.. _hamsi-gromacs-install:

--------------------------------------------------------------------------------------
Hamsi Sunucularında GROMACS Programının GNU Derleyicileri ve OpenMPI İle Kurulması
--------------------------------------------------------------------------------------

**1.** Öncelikle kaynak kodunu aşağıdaki komut yardımıyla kendi ev dizininize indiriniz.

.. code-block:: bash

  wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz

Kendi ev dizininizde **gromacs** adlı yeni bir dizin oluşturup kaynak kodunu buraya taşıyınız. Kaynak kodu arşiv formatlı olduğundan dosyayı açmanız gerekmektedir. Aşağıdaki komutları sırasıyla uygulayınız ve ilgili dizine gidiniz.

.. code-block:: bash
  
  mkdir gromacs
  mv gromacs-2021.2.tar.gz gromacs  
  cd gromacs                        
  tar -zxvf gromacs-2021.2.tar.gz 
  cd gromacs-2021.2/ 

**2.** 
İkinci adım olarak /truba/home/kullaniciadi/gromacs/gromacs-2021.2 adlı dizin içinde ``build`` klasörü oluşturmanız gerekmektedir. Sonrasında yapılacak derleme işlemleri bu klasör altında gerçekleştirilecektir. Bu yüzden bu klasör altında olduğunuzu ``pwd`` komutu ile kontrol ediniz.

.. code-block:: bash

  mkdir build
  cd build


**3.**
Kurulumu ``hamsi`` kümelerinde yapmak için bu kümelerden kendi kullanıcınız için boş bir node sağlamanız gerekmektedir (:ref:`hamsi kümesi ile ilgili ayıntılı bilgilere ulaşmak için tıklayınız. <hamsi-node>`). Bunun için **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir. Aşağıdaki komut satırını kendi terminalinizde uyguladığınızda ilgili hesaplama kümesinden kendi kullanıcınıza node rezerve etmek için sıraya gireceksiniz.

.. code-block:: bash
 
  srun -A kullaniciadi -p hamsi -N 1 --ntasks-per-node=28 --time=01:00:00  --job-name "install" --pty bash -i  


**4.**
Kurulumun doğru bir şekilde yapılabilmesi için gerekli ortamların hazır olması gerekmektedir. Bu yüzden program için gerekli modulleri yüklemelisiniz. Fakat daha öncesinde çalışan ve programın derlenmesine engel olacak bir modul varsa çakışma olmaması adına onu kapatmanız gerekmektedir. Öncelikle ``module purge`` komutu ile çalışan modülleri kapatınız ve sonrasında derleme için gerekli olan modulleri yükleyiniz. Modullerin isimlerini ``module avail`` komutuyla görebilirsinz.  

.. warning:: 

  Kurulum için ayrıca CMake protokolüne de ihtiyacınız bulunmaktadır. Bu noktada dikkat etmeniz gereken en önemli şey CMake parametrelerini doğru seçmektir. Örneğin; sadece CPU destekli kurmak için GPU desteğinin kapalı tutulması gerekir (-DGMX_GPU=OFF). Paralel olarak TRUBA altyapısında çalıştıracağınız için MPI desteğini açık tutmanız gerekmektedir (-DGMX_MPI=on). Bunun gibi pek çok özelliğe `Cmake Flags <https://manual.gromacs.org/documentation/2021.2/install-guide/index.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar (GNU Compiler ve OPEN MPI) için aşağıdaki komut satırlarını terminalinizden uygulayınız. 

.. code-block:: bash

  module purge

  module load centos7.9/comp/cmake/3.18.0
  module load centos7.9/comp/gcc/7
  module load centos7.9/lib/openmpi/4.1.1-gcc-7

  export CC=mpicc
  export CXX=mpic++

  cmake .. -DCMAKE_C_COMPILER=mpicc  -DCMAKE_CXX_COMPILER=mpic++ -DGMX_MPI=on  -DGMX_SIMD=AVX_512 -DGMX_BUILD_OWN_FFTW=ON  -DGMX_GPU=OFF  -DCMAKE_INSTALL_PREFIX=/truba/home/kullanıcı_adi/bin

  make  #bu işlem uzun sürecektir. Tamamlandıktan sonra aşağıdaki kod satırlarını yazmanız tavsiye edilir.
  
  make check
  
  make install


-------------------------------------------------------------------------------------
Barbun Sunucularında GROMACS Programının GNU Derleyicileri ve OPEN MPI ile Kurulması
-------------------------------------------------------------------------------------

Barbun sunucularında centos7.3 işletim sistemi kuruludur. Bu nedenle ilgili modülleri centos7.3 kurulu olanlardan yükleyeceğiz. Modülleri listelemek için ``module avail`` komutunu kullanabilirsiniz. Aşağıda verilen adımları izleyerek kendi ev dizininize kurulum yapabilirsiniz.

**1.** Öncelikle kaynak kodunu aşağıdaki komut yardımıyla kendi ev dizininize alınız

.. code-block:: bash

  wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz

Kendi ev dizininizde **gromacs** adlı yeni bir dizin oluşturup kaynak kodunu buraya taşıyınız. Kaynak kodu arşiv formatlı olduğundan dosyayı açmanız gerekmektedir.
Aşağıdaki komutları sırasıyla uygulayınız ve ilgili dizine gidiniz.

.. code-block:: bash
  
  mkdir gromacs
  mv gromacs-2021.2.tar.gz gromacs  
  cd gromacs                        
  tar -zxvf  gromacs-2021.2.tar.gz 
  cd gromacs-2021.2/ 

**2.** 
İkinci adım olarak /truba/home/kullaniciadi/gromacs/gromacs-2021.2 adlı dizin içinde ``build`` klasörü oluşturmanız gerekmektedir. Sonrasında yapılacak derleme işlemleri bu klasör altında gerçekleştirilecektir. Bu yüzden bu klasör altında olduğunuzu ``pwd`` komutu ile kontrol ediniz.

.. code-block:: bash

  mkdir build
  cd build

Kurulumu ``barbun`` kümelerinde yapmak için bu kümelerden boş bir işlemci sağlamamız gerekmektedir. Bunun için **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir. Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash 
 
  srun -A kullaniciadi -p barbun -N 1 -n 4 --time=02:00:00 --job-name "install-gromacs" --pty bash -i

**4.**

Kurulumu doğru bir şekilde yapabilmemiz için gerekli ortamların hazır olması gerekmektedir. Bu yüzden program için gerekli modulleri yüklememiz gerekir. Fakat daha öncesinde çalışan ve derlememize engel olacak bir module varsa çakışma olmaması adına onu kapatmamız gerekir. Öncelikle ``module purge`` komutu ile çalışan modülleri kapatalım ve sonrasında derleme için gerekli olan modulleri yükleyelim. 

.. warning:: 

  Kurulum için ayrıca CMake protokolüne de ihtiyacınız bulunmaktadır. Bu noktada dikkat etmemiz gereken en önemli şey CMake optionlarını doğru seçmektir. Örneğin CPU destekli kuracağımız için GPU desteğini kapalı tutmamız gerekir (-DGMX_GPU=OFF). Paralel olarak altyapımızda çalıştıracağınız için  MPI desteğini de açık tutuyoruz (-DGMX_MPI=on). Bunun gibi pek çok özelliğe `Cmake Flags <https://manual.gromacs.org/documentation/2021.2/install-guide/index.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar için aşağıdaki komut satırından mevcut modülleri ve versiyonları görüntüleyip kurduktan sonra devam edebilirsiniz.

.. code-block:: bash
  
  module purge
  
  module av
  module load <gerekli versiyonlar>
  export CC=mpicc
  export CXX=mpic++

  cmake .. -DCMAKE_C_COMPILER=mpicc  -DCMAKE_CXX_COMPILER=mpic++ -DGMX_MPI=on  -DGMX_SIMD=AVX_512 -DGMX_BUILD_OWN_FFTW=ON  -DGMX_GPU=OFF  -DCMAKE_INSTALL_PREFIX=/truba/home/kullaniciadi/bin
  
  make 
  
  make install




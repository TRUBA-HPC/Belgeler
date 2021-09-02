==========================
TRUBA'da GROMACS Kurulumu
==========================
Aşağıda GROMACS programının gromacs-2021.2 versiyonunun TRUBA altyapısında derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip 
ederek GROMACS kurulumunu kendi sayfanızda kurabilirsiniz.

-----------------------------------------------------------------------------
Hamsi Sunucularında Gromacs Programının GNU ve OPEN MPI ile  Kurulması
-----------------------------------------------------------------------------

**1.** Öncelikle kaynak kodunu aşağıdaki komut yardımıyla kendi ev dizininize alınız

.. code-block:: bash

    wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz

Kendi home dizinizde **gromacs** adlı yeni bir dizin oluşturup kaynak kodunu buraya kopyalayınız. Kaynak kodu arşiv formatlı olduğundan dosyayı ayıklamanız gerekmektedir.
Aşağıdaki komutları sırasıyla uygulayarak ayıklanmış dosyayı gromacs dizinine kopyalayınız.

.. code-block:: bash
  
  mkdir gromacs
  cp gromacs-2021.2.tar.gz gromacs  
  cd gromacs                        
  tar -zxvf  gromacs-2021.2.tar.gz 
  cd gromacs-2021.2/ 

**2.** 
İkinci adım olarak /truba/home/kullanıcı_ismi/gromacs/gromacs-2021.2 adlı dizin
içinde build klasörü oluşturmanız gerekmektedir. Sonrasında yapacağımız işlemleri bu klasör altında tamamlayacağız. Bu yüzden bu klaör altında olduğunuzu kontrol ediniz.

.. code-block:: bash

 mkdir build
 cd build



**3.**
Kurulumu ``hamsi`` kümelerinde yapmak için bu kümelerden boş bir işlemci sağlamamız gerekmektedir. Bunu için **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir.Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash
  
  srun -N 1 -A kullanıcı_adı  -p hamsi --ntasks-per-node=28 --time=03:00:00  --job-name "install" --pty bash -i


**4.**
Kurulumu doğru bir şekilde yapabilmemiz için gerekli ortamların hazır olması gerekmektedir. Bu yüzden program için gerekli modulleri yüklememiz gerekir. Fakat daha öncesinde 
çalışan ve derlememize engel olacak bir module varsa çakışma olmaması adına onu kapatmamız gerekir. Öncelikle ``module purge`` komutu ile çalışan modülleri kapatalım ve sonrasında derleme
için gerekli olan modulleri yükleyelim. Modullerin isimlerini ``module avail`` komutuyla görebilirsinz.  

.. warning:: Kurulum için ayrıca CMake protokolüne de ihtiyacınız bulunmaktadır. Bu noktada dikkat etmemiz gereken en önemli şey CMake optionlarını doğru seçmektir. Örneğin CPU destekli kuracağımız için GPU desteğini kapalı tutmamız gerekir (-DGMX_GPU=OFF). Paralel olarak altyapımızda çalıştıracağınız için  MPI desteğini de açık tutuyoruz (-DGMX_MPI=on). 
Bunun gibi pek çok özelliği `Cmake Flags <https://manual.gromacs.org/documentation/2021.2/install-guide/index.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar için aşağıdaki komut satırını terminalinizden uygulayınız. 


.. code-block:: bash

  module purge
  module load centos7.9/comp/cmake/3.18.0
  module load centos7.9/comp/gcc/7
  module load centos7.9/lib/openmpi/4.1.1-gcc-7


.. code-block:: bash
 
 export CC=mpicc
 export CXX=mpic++

  cmake .. -DCMAKE_C_COMPILER=mpicc  -DCMAKE_CXX_COMPILER=mpic++ -DGMX_MPI=on  -DGMX_SIMD=AVX_512 -DGMX_BUILD_OWN_FFTW=ON  -DGMX_GPU=OFF  -DCMAKE_INSTALL_PREFIX=/truba/home/kullanıcı_adiniz/bin
  make  #bu işlem uzun sürecektir. Tamamlandıktan sonra aşağıdaki kod satırlarını yazmanız tavsiye edilir.
  make check
  make install


-----------------------------------------------------------------------------
Barbun Sunucularında Gromacs Programının GNU ve OPEN MPI ile  Kurulması
-----------------------------------------------------------------------------

Kuruluma başlamadan önce Barbun sunucularında centos7.3 işletim sistemi kuruludur. Bu nedenle ilgili modülleri centos7.3 kurulu olanlardan yükleyeceğiz. Modülleri listelemek için
``module avail`` komutunu kullanabilirsiniz. Aşağıda verilen adımları izleyerek kendi ev dizininize kurulum yapabilirsiniz.

**1.** Öncelikle kaynak kodunu aşağıdaki komut yardımıyla kendi ev dizininize alınız

.. code-block:: bash

    wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.2.tar.gz

Kendi home dizinizde **gromacs** adlı yeni bir dizin oluşturup kaynak kodunu buraya kopyalayınız. Kaynak kodu arşiv formatlı olduğundan dosyayı ayıklamanız gerekmektedir.
Aşağıdaki komutları sırasıyla uygulayarak ayıklanmış dosyayı gromacs dizinine kopyalayınız.

.. code-block:: bash
  
  mkdir gromacs
  cp gromacs-2021.2.tar.gz gromacs  
  cd gromacs                        
  tar -zxvf  gromacs-2021.2.tar.gz 
  cd gromacs-2021.2/ 

**2.** 
İkinci adım olarak /truba/home/kullanıcı_ismi/gromacs/gromacs-2021.2 adlı dizin
içinde build klasörü oluşturmanız gerekmektedir. Sonrasında yapacağımız işlemleri bu klasör altında tamamlayacağız. Bu yüzden bu klaör altında olduğunuzu kontrol ediniz.

.. code-block:: bash

  mkdir build
  cd build


Kurulumu ``barbun`` kümelerinde yapmak için bu kümelerden boş bir işlemci sağlamamız gerekmektedir. Bunu için **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir.Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash 
 
  srun -N 1 -A kullanıcıadı -p short -n 4 --time=03:00:00 -C barbun --job-name "install-gromacs" --pty bash -i


**4.**
Kurulumu doğru bir şekilde yapabilmemiz için gerekli ortamların hazır olması gerekmektedir. Bu yüzden program için gerekli modulleri yüklememiz gerekir. Fakat daha öncesinde 
çalışan ve derlememize engel olacak bir module varsa çakışma olmaması adına onu kapatmamız gerekir. Öncelikle ``module purge`` komutu ile çalışan modülleri kapatalım ve sonrasında derleme
için gerekli olan modulleri yükleyelim. 

.. warning:: Kurulum için ayrıca CMake protokolüne de ihtiyacınız bulunmaktadır. Bu noktada dikkat etmemiz gereken en önemli şey CMake optionlarını doğru seçmektir. Örneğin CPU destekli kuracağımız için GPU desteğini kapalı tutmamız gerekir (-DGMX_GPU=OFF). Paralel olarak altyapımızda çalıştıracağınız için  MPI desteğini de açık tutuyoruz (-DGMX_MPI=on). 
Bunun gibi pek çok özelliği `Cmake Flags <https://manual.gromacs.org/documentation/2021.2/install-guide/index.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar için aşağıdaki komut satırını terminalinizden uygulayınız. 

.. code-block:: bash
  
  module purge
  module load centos7.3/comp/cmake/3.18.0
  module load centos7.3/comp/gcc/7
  module load centos7.3/lib/openmpi/4.0.1-gcc-7.0.1

 
.. code-block:: bash
   
   export CC=mpicc
   export CXX=mpic++

.. code-block:: bash 
  
   cmake .. -DCMAKE_C_COMPILER=mpicc  -DCMAKE_CXX_COMPILER=mpic++ -DGMX_MPI=on  -DGMX_SIMD=AVX_512 -DGMX_BUILD_OWN_FFTW=ON  -DGMX_GPU=OFF  -DCMAKE_INSTALL_PREFIX=/truba/home/kullanıcı_adiniz/bin
  
   make 
   make check
   make install




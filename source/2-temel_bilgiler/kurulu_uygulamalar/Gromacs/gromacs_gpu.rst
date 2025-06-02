
GROMACS Programının GPU Destekli Derlenmesi
===============================================

GROMACS programını GPU destekli olarak iki şekilde kurabiliriz. Bunlardan ilki hiç module yüklemeden, derleme yapmadan Yüksek Başarımlı Hesaplama' da 
en çok tercih edilen **Apptainer** container kullanmaktır. İkincisi ise TRUBA' da mevcut modüllerin yüklenmesi ile yapılan derlemedir. Aşağıdaki kurulum
öğreticisinde iki şekilde de gösterilecektir.

---------------------------------------------------
Apptainer Container Kullanarak GROMACS Kullanımı
---------------------------------------------------

TRUBA kuyruklarında **Apptainer** kullanarak Gromacs kapsayıcısını ev dizininize yeni bir dizin oluştururak içerisine kayıt ediniz. Bunun için aşağıda verilen 
kod satırlarını terminalinize yazınız.

.. code-block:: bash

   mkdir gromacs-gpu
   cd gromacs-gpu
   apptainer build gromacs-2021.sif docker://nvcr.io/hpc/gromacs:2021

.. warning:: Daha üst versiyonlarını kontrol etmek için linki verilen sayfaya bakabilirsiniz: https://ngc.nvidia.com/catalog/containers/hpc:gromacs

Kaydetme işlemi tamamlandıktan sonra gromacs uygulamasının gpu destekli hali sorunsuz çalışacaktır. Fakat slurm betik dosyanızı buna uygun düzenlemeniz 
gerekmektedir. Sizin için hazırlanan gpu destekli slurm betik dosyası için **TRUBA'da GROMACS Programı Nasıl Kullanılır?** kısmına geçebilirsiniz.

--------------------------------------------------------
GROMACS Programının Palamut-Cuda Kümelerinde Derlenmesi
--------------------------------------------------------
GROMACS programının gromacs-2021.3 versiyonunun TRUBA sisteminde GPU destekli derlenmesi için gerekli adımlar aşağıda verilmiştir. Siz de bu adımları takip 
ederek kurulumu kendi dizininizde kurabilirsiniz.

**1.** 
İlk olarak gromacs-derleme adında bir dizin oluşturunuz. Kurulum için gerekli kaynak kodu bu dizine kopyaladıktan sonra, ``tar`` komutuyla sıkıştırlmış dosyaları açınız.
Bu ilk iki işlem için gerekli terminal komutları aşağıda sıralanmıştır.

.. code-block:: bash
   
   mkdir gromacs-derleme
   cd gromacs-derleme
   wget ftp://ftp.gromacs.org/gromacs/gromacs-2021.3.tar.gz
   tar -xzvf gromacs-2021.3.tar.gz
   cd gromacs-2021.3

**2.** 
İkinci adım olarak /truba/home/kullaniciadi/gromacs-derleme/gromacs-2021.3 adlı dizin içinde ``build`` klasörü oluşturmanız gerekmektedir. Sonrasında yapılacak derleme işlemleri bu klasör altında gerçekleştirilecektir. Bu yüzden bu klasör altında olduğunuzu ``pwd`` komutu ile kontrol ediniz.

.. code-block:: bash

  mkdir build
  cd build

Kurulumu ``palamut-cuda`` kümelerinde yapmak için bu kümelerden boş bir işlemci sağlamamız gerekmektedir. Bunun için **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir. Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash 

   srun -N 1 -n 16 -A kullanici_adi -p palamut-cuda --gres=gpu:1 --time=02:00:00  --job-name "install" --pty bash -i
 
**3.**
Kurulumu doğru bir şekilde yapabilmemiz için gerekli ortamların hazır olması gerekmektedir. Bu yüzden program için gerekli modulleri yüklememiz gerekir. 
Fakat daha öncesinde çalışan ve derlememize engel olacak bir module varsa çakışma olmaması adına onu kapatmamız gerekir. 
Öncelikle ``module purge`` komutu ile çalışan modülleri kapatalım ve sonrasında derleme için gerekli olan modulleri yükleyelim. 

.. warning:: 

  Kurulum için ayrıca CMake protokolüne de ihtiyacınız bulunmaktadır. Bu noktada dikkat etmemiz gereken en önemli şey CMake optionlarını doğru seçmektir. 
  Bu protokol için kullanılan tag'ler için `Cmake Flags <https://manual.gromacs.org/documentation/2021.2/install-guide/index.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar için aşağıdaki komut satırını terminalinizden uygulayınız. 

.. code-block:: bash

   Cmake, CUDA ve GCC verisyonlarınızın kurmak istediğiniz GROMACS versiyonu ile uyumuna dikkat ediniz. 
   `module av` komutu ile sistemdeki mevcut modülleri görebilirsiniz.



**4.**
Bütün ortamlar yüklendikten sonra aşaıdaki komut satırlarını sırasıyla terminalinize yazarak kurulumu tamamlayabilirsiniz.

.. code-block:: bash
 
  make
  make check
  make install

=============================================
LAMMPS Programının GPU Destekli Derlenmesi
=============================================

LAMMPS programını GPU destekli olarak iki şekilde kurabiliriz. Bunlardan ilki hiç module yüklemeden, derleme yapmadan Yüksek Başarımlı Hesaplama' da 
en çok tercih edilen **Singularity** container kullanmaktır. Fakat bu standart kullanım içindir. Hesaplamalarınızda ihtiyaç duyacağınız ekstra özel 
kütüphaneler için standart ikinci kurulumu yapmanız gerekmektedir. İkincisi ise TRUBA' da mevcut modüllerin yüklenmesi ile yapılan derlemedir. Aşağıdaki kurulum
öğreticisinde iki şekilde de gösterilecektir.

--------------------------------------------------
Singularity Container Kullanarak LAMMPS Kullanımı
--------------------------------------------------

TRUBA kuyruklarında **Singularity** kullanarak LAMMPS kapsayıcısını ev dizininize yeni bir dizin oluştururak içerisine kayıt ediniz. Bunun için aşağıda verilen 
kod satırlarını terminalinize yazınız.

.. code-block:: bash

   mkdir lammps-gpu
   cd lammps-gpu
   singularity build lammps-2021.sif docker://nvcr.io/hpc/lammps:10Feb2021

.. warning:: Daha üst versiyonlarını kontrol etmek için linki verilen sayfaya bakabilirsiniz: https://ngc.nvidia.com/catalog/containers/hpc:lammps

Kaydetme işlemi tamamlandıktan sonra LAMMPS uygulamasının gpu destekli hali sorunsuz çalışacaktır. Fakat slurm betik dosyanızı buna uygun düzenlemeniz 
gerekmektedir. 

.. code-block:: bash

   #!/bin/bash
   #SBATCH -p orfoz
   #SBATCH -A accountname
   #SBATCH -J lammps_test
   #SBATCH -N 1
   #SBATCH --ntasks=110 # orfoz sunucularinda node basina 55 veya 110 cekirdek talep edilebilir.
   #SBATCH --cpus-per-task=1
   #SBATCH -C weka
   #SBATCH --time=3-00:00:00

   export OMP_NUM_THREADS=1


   echo "SLURM_NODELIST $SLURM_NODELIST"
   echo "NUMBER OF CORES $SLURM_NTASKS"

   module purge

   module load comp/oneapi/2024

   module load apps/lammps/2Aug2023_update2-oneapi-2024

   mpirun lmp -var latconst 3.9 -in in.lattice


   exit

--------------------------------------------------------
LAMMPS Programının Palamut-Cuda Kümelerinde Derlenmesi
--------------------------------------------------------
LAMMPS programının lammps-patch_31Aug2021 versiyonunun TRUBA sisteminde GPU destekli derlenmesi için gerekli adımlar aşağıda verilmiştir. Siz de bu adımları takip 
ederek kurulumu kendi dizininizde kurabilirsiniz.

**1.** 
İlk olarak lammps-derleme adında bir dizin oluşturunuz. Kurulum için gerekli kaynak kodu bu dizine kopyaladıktan sonra, ``tar`` komutuyla sıkıştırlmış dosyaları açınız.
Bu ilk iki işlem için gerekli terminal komutları aşağıda sıralanmıştır.

.. code-block:: bash
   
   mkdir lammps-derleme
   cd derleme-derleme
   wget https://github.com/lammps/lammps/archive/refs/tags/patch_31Aug2021.tar.gz
   tar -xzvf patch_31Aug2021.tar.gz
   cd lammps-patch_31Aug2021

**2.** 
İkinci adım olarak /truba/home/kullaniciadi/lammps-derleme/lammps-patch_31Aug2021 adlı dizin içinde ``build`` klasörü oluşturmanız gerekmektedir. Sonrasında yapılacak derleme işlemleri bu klasör altında gerçekleştirilecektir. Bu yüzden bu klasör altında olduğunuzu ``pwd`` komutu ile kontrol ediniz.

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
  Bu protokol için kullanılan tag'ler için `Cmake Flags <https://docs.lammps.org/Build_extras.html>`_ linkinden erişebilirsiniz.

Gerekli ortamlar için aşağıdaki komut satırını terminalinizden uygulayınız. Bu sürümlerin değişiklik gösterebileceği göz önünde bulundurularak sistemi "module av" komutu ile kontrol etmeniz gerektiğini hatırlatırız.

.. code-block:: bash
  
   module load apps/lammps/29Aug2024_update1_oneapi-2024-orfoz    
   module load apps/lammps/29Aug2024_update1_oneapi-2024-hamsi


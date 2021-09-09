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
gerekmektedir. Sizin için hazırlanan gpu destekli slurm betik dosyası örneği aşağıda verilmiştir.

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p palamut-cuda
  #SBATCH -A kullanici_adi
  #SBATCH -J lammps
  #SBATCH -N 1	#number of nodes
  #SBATCH -n 16	#number of cpus
  #SBATCH --gres=gpu:1 
  #SBATCH --time=00-01:00:00
  #SBATCH --mail-type=ALL
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

  export OMP_NUM_THREADS=1

  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  export SIF=/truba/home/kullanici_adi/lammps-gpu/lammps-2021.sif

  singularity run --nv  $SIF lmp < input_file

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

Gerekli ortamlar için aşağıdaki komut satırını terminalinizden uygulayınız. 

.. code-block:: bash
  
   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
   module load centos7.9/lib/openmpi/4.1.1-intel-oneapi-2021.2
   module load centos7.9/comp/cmake/3.18.0
   module load centos7.9/comp/gcc/7
   module load centos7.9/lib/cuda/11.4
   export CC=mpiicc CXX=mpiicpc FC=mpiifort
   cmake ../cmake  -D PKG_GPU=yes -D GPU_API=cuda -D GPU_ARCH=sm_80  -D BUILD_MPI=on -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes -D PKG_KSPACE=yes -D PKG_USER-MEAMC=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL 

**4.**
 Son olarak ``cmake --build .`` komutunu çalıştırarak LAMMPS derlemesini tamamlayınız. Build adlı dosyanın içinde **lmp** executable ile programı çalıştırabilirsiniz.

Aşağıdaki slurm betik örneğini kullanarak programı kullanabilirsiniz. 

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p palamut-cuda
  #SBATCH -A kullanici_adi
  #SBATCH -J lammps
  #SBATCH -N 1    #number of nodes
  #SBATCH -n 16   #number of cpus
  #SBATCH --gres=gpu:1 
  #SBATCH --time=00-01:00:00
  #SBATCH --mail-type=ALL
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

  module purge
  source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
  module load centos7.9/lib/openmpi/4.1.1-intel-oneapi-2021.2
  module load centos7.9/comp/gcc/7
  module load centos7.9/lib/cuda/11.4

  export OMP_NUM_THREADS=1

  echo "SLURM_NODELIST $SLURM_NODELIST"
  echo "NUMBER OF CORES $SLURM_NTASKS"

  LAMMPS_DIR=/truba/home/kullanici_adi/lammps-derleme/lammps-patch_31Aug2021/build

  mpirun $LAMMPS_DIR/lmp  < input_dosyasının_adi >out
  exit

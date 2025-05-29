.. _lammps_install_truba:

========================================
TRUBA'da LAMMPS Kurulumu
========================================

------------------------------------
Barbun Hesaplama Kümesi'nde Kurulum
------------------------------------

Kurulumu ``barbun`` kuyruğu için optimize bir şekilde yapmak istiyorsanız iki yol izleyebilirsiniz:

#. ``barbun1`` kullanıcı arayüzüne bağlanarak doğrudan kurulum işlemini başlatabilirsiniz.
#. Ya da ``srun`` komutu ile ``barbun`` kuyruğundaki 1 makineden 4 CPU'yu interaktif olarak ayırabilirsiniz. Örneğin:

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p barbun --ntasks-per-node=4 --time=01:00:00 --job-name "lmp install" --pty bash -i

.. note::

   Kurulum için gerekli süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyin.

Sistemde kurulu yazılımları listelemek için:

.. code-block:: bash

   module available

Mevcut ortamınızda yüklü modülleri görmek için:

.. code-block:: bash

   module list

Önceki modül çakışmalarını önlemek için:

.. code-block:: bash

   module purge

Gerekli modülleri yükleyin:

.. code-block:: bash
   
   module load komutunu kullanarak yükleyebilirsiniz.

LAMMPS kaynak kodunu klonlayın ve derleme dizinini oluşturun:

.. code-block:: bash

   git clone -b stable https://github.com/lammps/lammps.git lammps-stable
   cd lammps-stable
   mkdir build-intel18-openmpi4
   cd build-intel18-openmpi4

Derleyici değişkenlerini tanımlayın:

.. code-block:: bash

   export CC=mpicc CXX=mpic++ FC=mpif90

Aşağıdaki örnek, çeşitli LAMMPS paketlerinin etkinleştirildiği bir CMake komutudur:

.. code-block:: bash

   cmake ../cmake -D BUILD_MPI=on \
   -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
   -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
   -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes \
   -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes \
   -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes \
   -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes -D PKG_KSPACE=yes \
   -D PKG_USER-MEAMC=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL

.. note::

   PLUMED ve MSCG gibi bazı özel paketler için GSL kütüphanesi gereklidir. Bu kütüphaneyi Conda ile kurmak için:

   :ref:`anaconda-miniconda-kurulum`

   .. code-block:: bash

      conda install -c conda-forge gsl 

LAMMPS’i derlemek için:

.. code-block:: bash

   cmake --build .

Bu işlemler tamamlandığında `build-intel18-openmpi4` dizininde çalıştırılabilir `lmp` dosyası yer alacaktır.

------------------------------------
Hamsi Hesaplama Kümesi'nde Kurulum
------------------------------------

Kurulumu ``hamsi`` kuyruğu için optimize bir şekilde yapmak için, ``srun`` komutu ile 28 CPU’yu aşağıdaki gibi ayırabilirsiniz:

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00 --job-name "install" --pty bash -i

.. note::

   Süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyin.

Modül sistemini temizleyip uygun modülleri yükleyin:

.. code-block:: bash

   module purge
   source /truba/sw/comp/intel/oneapi-2021.2/setvars.sh
   module load cmake/3.18.0

LAMMPS’i klonlayıp derleme dizinini oluşturun:

.. code-block:: bash

   git clone -b stable https://github.com/lammps/lammps.git lammps-stable
   cd lammps-stable
   mkdir build-oneapi21-impi
   cd build-oneapi21-impi

.. note::

   Eğer OpenMPI ile kurmak isterseniz, aşağıdaki modülü yükleyip farklı bir klasörde kuruluma devam edebilirsiniz:

   .. code-block:: bash

      module load openmpi/4.1.1-intelOneApi-2021.2

Intel derleyicilerini tanımlayın:

.. code-block:: bash

   export CC=mpiicc CXX=mpiicpc FC=mpiifort

LAMMPS paketlerini etkinleştirerek CMake komutunu çalıştırın:

.. code-block:: bash

   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$CFLAGS \
   cmake ../cmake -D BUILD_MPI=on \
   -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
   -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" \
   -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes \
   -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes \
   -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes \
   -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes -D PKG_KSPACE=yes \
   -D PKG_USER-MEAMC=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL

GSL paketi gerekiyorsa:

.. code-block:: bash

   conda install -c conda-forge gsl

Derlemeyi başlatın:

.. code-block:: bash

   cmake --build .

``build-oneapi21-impi`` dizininde çalıştırılabilir ``lmp`` dosyasını bulacaksınız.

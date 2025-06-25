.. _lammps_install_truba:

========================================
TRUBA'da LAMMPS Kurulumu
========================================

------------------------------------
Orfoz Hesaplama Kümesi'nde Kurulum
------------------------------------

Kurulumu ``orfoz`` kuyruğu için optimize bir şekilde yapmak istiyorsanız ``srun`` komutu ile ``orfoz`` kuyruğunda interaktif olarak sunucu ayırabilirsiniz. Örneğin:

.. code-block:: bash

   srun -p debug -C orfoz -N 1 -n 55 -A kullanici_adi -J lmp-install --time=0:50:00 --pty /usr/bin/bash -i

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


LAMMPS programını Intel derleyicileri ve kütüphaneleri (Intel MKL, IntelMPI) ile kurmak için aşağıdaki gibi modülleri yükleyebilirsiniz. 

.. code-block:: bash

   module load comp/oneapi/2024
   module load lib/netcdf/c-4.9.2-fortran-4.6.1-cxx-4.3.1-oneapi-2024
   module load comp/python/intelpython3

LAMMPS modülü, LAMMPS kullanım kitapçığındaki standart `CMake prosedürünü <https://lammps.sandia.gov/doc/Build_cmake.html>`_ izler. Kurulumu CMake ile yapmak için ilgili modülü yükleyiniz:

.. code-block:: bash

   module load comp/cmake/3.31.1


Kurulum yapmak istediğiniz LAMMPS versiyonu için kaynak kodunu kullanıcı ev dizininize indiriniz ve derleme dizinini oluşturun:

.. code-block:: bash

   wget https://github.com/lammps/lammps/archive/refs/tags/stable_29Aug2024_update1.tar.gz
   tar -xzf stable_29Aug2024_update1.tar.gz
   mv lammps-stable_29Aug2024_update1 lammps-stable
   rm stable_29Aug2024_update1.tar.gz

   cd lammps-stable
   mkdir build-orfoz
   cd build-orfoz



Aşağıdaki örnek, çeşitli LAMMPS paketlerinin etkinleştirildiği bir CMake komutudur:

.. code-block:: bash

   
   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$CFLAGS CC=mpiicx CXX=mpiicpx FC=mpiifort cmake ../cmake -D CMAKE_INSTALL_PREFIX=/arf/home/username/lammps-stable -D BUILD_MPI=on -D PKG_BODY=yes -D PKG_MISC=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_MC=yes -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_MOLFILE=yes -D PKG_MOLECULE=yes -D PKG_KSPACE=yes -D PKG_REAXFF=yes  -D PKG_ML-SNAP=yes -D PKG_ML-IAP=yes -D PKG_DIFFRACTION=yes -D PKG_MEAM=yes -D PKG_MOLFILE=yes -D PKG_PHONON=yes -D PKG_SMTBQ=yes -D PKG_RIGID=yes -D PKG_QEQ=yes -D PKG_EXTRA-COMPUTE=yes -D PKG_GRANULAR=yes -D PKG_BPM=yes -D PKG_DPD-BASIC=yes -D PKG_DPD-MESO=yes -D PKG_DPD-REACT=yes -D PKG_DPD-SMOOTH=yes -D PKG_ELECTRODE=yes -D PKG_EXTRA-DUMP=yes -D PKG_EXTRA-FIX=yes -D PKG_EXTRA-MOLECULE=yes -D PKG_EXTRA-PAIR=yes -D PKG_NETCDF=yes -D PKG_EFF=yes -D FFT=MKL


.. warning:: 

   Yukarıdaki komutta `CMAKE_INSTALL_PREFIX` parametresini kendi kurulum dizininize göre değiştirmeniz gerekmektedir. Örneğin, `CMAKE_INSTALL_PREFIX=/arf/home/kullanici_adi/lammps-stable` şeklinde ayarlayın.

LAMMPS’i derlemek için:

.. code-block:: bash

   make -j28
   make install   

Bu işlemler tamamlandığında `lammps-stable` dizininde çalıştırılabilir `lmp` dosyası yer alacaktır.


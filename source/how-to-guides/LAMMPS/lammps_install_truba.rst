==========================
TRUBA'da LAMMPS Kurulumu
==========================
TRUBA sisteminde kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

Aşağıdaki komutları kullanarak Intel Parallel Studio'nun güncel versiyonunu load ediniz:

.. code-block:: bash

   module load centos7.3/comp/intel/PS2018-update2
   module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

LAMMPS modulü, LAMMPS kullanım kitapçığındaki standart `CMake prosedürünü <https://lammps.sandia.gov/doc/Build_cmake.html>`_ izler. Kurulumu CMake ile yapmak için ilgili modülü load ediniz:

.. code-block:: bash

   module load centos7.3/comp/cmake/3.18.0

Kurulum yapmak istediğiniz klasörün altında LAMMPS için derleme ortamını hazırlayınız:

.. code-block:: bash

   git clone  -b stable https://github.com/lammps/lammps.git lammps-stable
   cd lammps-stable
   mkdir build-intel18-openmpi4
   cd build-intel18-openmpi4

C/C++ ve Fortran90 derleyicilerin tanımlamalarını yapınız:

.. code-block:: bash

   export CC=mpicc CXX=mpic++ FC=mpif90

``-D PKG_NAME=value`` komutu ile kurulmasını istediğiniz paketleri belirtebilirsiniz. Paket ayrıntıları için LAMMPS kullanma kitapçığını inceleyebilirsiniz (https://lammps.sandia.gov/doc/Packages.html).

Örnek olarak aşağıdaki kurulum komutuna MANYBODY, DIPOLE, PHONON, REAXC gibi kullanıcı paketleri eklenmiştir:

.. code-block:: bash

   cmake ../cmake -D BUILD_MPI=on -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes  -D PKG_KSPACE=yes -D PKG_USER-MEAMC=yes -D PKG_USER-PLUMED=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL

Daha sonrasında CMake ile build komutunu çalışarak LAMMPS’i derleyiniz:

.. code-block:: bash

   cmake --build .

Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``build-intel18-openmpi4`` dizininde ``bin`` klasörü altında çalıştırılabilir ``lmp`` dosyası yer alacaktır.


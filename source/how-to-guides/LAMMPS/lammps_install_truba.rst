========================================
TRUBA'da LAMMPS Kurulumu
========================================

------------------------------------
Barbun Hesaplama Kümesi'nde Kurulum
------------------------------------

Kurulumu ``barbun`` kuyruğu için optimize bir şekilde kurmak istiyorsanız öncelikle ``srun`` komutu ile ``barbun`` kuyruğundaki 1 tane makineden 4 tane CPU'yu (Barbun kümesindeki CPU kullanımı için bakınız : :ref:`barbun-node`)   kendi kullanıcınız için interaktif olarak ayırabilirsiniz. Aşağıdaki komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili node'a bağlanacaksınız. 

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p short --ntasks-per-node=4 --time=01:00:00 --constraint=barbun --job-name "lmp install" --pty bash -i

.. note::

   Kurulum için öngördüğünüz süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyebilirsiniz.

TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

Barbun node'unda ``centos 7.3`` işletim sistemi yüklü bulunmaktadır. LAMMPS programını Intel derleyicileri, Intel MKL ve OpenMPI ile kurmak için aşağıdaki gibi uyumlu olan güncel modülleri yükleyebilirsiniz. 

.. code-block:: bash

   module load centos7.3/comp/intel/PS2018-update2
   module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

LAMMPS modülü, LAMMPS kullanım kitapçığındaki standart `CMake prosedürünü <https://lammps.sandia.gov/doc/Build_cmake.html>`_ izler. Kurulumu CMake ile yapmak için ilgili modülü yükleyiniz:

.. code-block:: bash

   module load centos7.3/comp/cmake/3.18.0

Kurulum yapmak istediğiniz klasörün altında LAMMPS için derleme ortamını hazırlayınız:

.. code-block:: bash

   git clone  -b stable https://github.com/lammps/lammps.git lammps-stable
   cd lammps-stable
   mkdir build-intel18-openmpi4
   cd build-intel18-openmpi4

Bulunduğunuz klasör lammps_stable/build-intel18-openmpi4 olmalı. C/C++ ve Fortran90 derleyicilerin tanımlamalarını yapınız:

.. code-block:: bash

   export CC=mpicc CXX=mpic++ FC=mpif90

``-D PKG_NAME=yes`` komutu ile kurulmasını istediğiniz paketleri belirtebilirsiniz. Paket ayrıntıları için LAMMPS kullanma kitapçığını inceleyebilirsiniz (https://lammps.sandia.gov/doc/Packages.html).

Örnek olarak aşağıdaki kurulum komutuna MANYBODY, DIPOLE, PHONON, REAXC gibi bazı kullanıcı paketleri eklenmiştir:

.. code-block:: bash

   cmake ../cmake -D BUILD_MPI=on -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes -D PKG_KSPACE=yes -D PKG_USER-MEAMC=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL


.. note::

   Özellikle `PLUMED <http://gensoft.pasteur.fr/docs/lammps/12Dec2018/Build_extras.html#user-plumed-package>`_ ve `MSCG <http://gensoft.pasteur.fr/docs/lammps/12Dec2018/Build_extras.html#mscg-package>`_ paketlerine hesaplamalarınız için ihtiyacınız varsa eğer Conda ile GSL paketini kurmanız gerekmektedir. Conda kurulumu için aşağıdaki linki ziyaret edebilirsiniz:

   `Ev dizininize Anaconda kurulumu <https://docs.truba.gov.tr/GPU/deep-learning/virtual-env.html#ev-dizininize-anaconda-kurun>`_

   Conda ile GSL paketini de aşağıdaki komut ile kurabilirsiniz:

   .. code-block:: bash

      conda install -c conda-forge gsl 

Daha sonra CMake ile build komutunu çalışarak LAMMPS’i derleyiniz:

.. code-block:: bash

   cmake --build .


Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``build-intel18-openmpi4`` dizininde çalıştırılabilir ``lmp`` dosyası yer alacaktır.

------------------------------------
Hamsi Hesaplama Kümesi'nde Kurulum
------------------------------------

Kurulumu ``hamsi`` kuyruğu için optimize bir şekilde kurmak istiyorsanız öncelikle ``srun`` komutu ile ``hamsi`` kuyruğundaki 1 tane makineden 28 tane CPU'yu (``hamsi`` kümesindeki CPU kullanımı için bakınız: :ref:`hamsi-node`) kendi kullanıcınız için interaktif olarak ayırabilirsiniz. Aşağıdaki komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili node'a bağlanacaksınız. 

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00 --constraint=barbun --job-name "install" --pty bash -i

.. note::

   Süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyebilirsiniz.

TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

Hamsi node'unda ``centos 7.9`` işletim sistemi yüklü bulunmaktadır. Aşağıdaki komutları kullanarak Intel OneAPI'nin güncel versiyonunu yükleyiniz:

.. code-block:: bash

   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

LAMMPS modülü, LAMMPS kullanım kitapçığındaki standart `CMake prosedürünü <https://lammps.sandia.gov/doc/Build_cmake.html>`_ izler. Kurulumu CMake ile yapmak için ilgili modülü yükleyiniz:

.. code-block:: bash

   module load centos7.9/comp/cmake/3.18.0

Kurulum yapmak istediğiniz klasörün altında LAMMPS için derleme ortamını hazırlayınız:

.. code-block:: bash

   git clone  -b stable https://github.com/lammps/lammps.git lammps-stable
   cd lammps-stable
   mkdir build-oneapi21-impi
   cd build-oneapi21-impi

.. note::

   Eğer kurulumu OpenMPI ile yapmak isterseniz Intel OneAPI ile uyumlu OpenMPI kütüphanesini de yüklemeniz gerekmektedir. OpenMPI ile kurulum için dilerseniz ``build-oneapi21-openmpi4-1`` isimli bir klasör açıp kurulum işlemlerine bu klasörde devam edebilirsiniz.
   
 .. code-block:: 
 
     module load centos7.9/lib/openmpi/4.1.1-intelOneApi-2021.2

   

Bulunduğunuz klasör lammps_stable/build-oneapi21-impi olmalı. C/C++ ve Fortran90 derleyicilerin tanımlamalarını yapınız:

.. code-block:: bash

   export CC=mpiicc CXX=mpiicpc FC=mpiifort

``-D PKG_NAME=yes`` komutu ile kurulmasını istediğiniz paketleri belirtebilirsiniz. Paket ayrıntıları için LAMMPS kullanma kitapçığını inceleyebilirsiniz (https://lammps.sandia.gov/doc/Packages.html).

Örnek olarak aşağıdaki kurulum komutuna MANYBODY, DIPOLE, PHONON, REAXC gibi bazı kullanıcı paketleri eklenmiştir:

.. code-block:: bash

   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$CFLAGS CC=mpiicc CXX=mpiicpc FC=mpiifort cmake ../cmake -D BUILD_MPI=on -D BLAS_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D LAPACK_LIBRARIES="-L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl" -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_MC=yes -D PKG_LATTE=yes -D PKG_MLIAP=yes -D PKG_SNAP=yes -D PKG_SPIN=yes -D PKG_PYTHON=yes -D PKG_USER-MOLFILE=yes -D PKG_MOLECULE=yes -D PKG_USER-PHONON=yes -D PKG_USER-REAXC=yes  -D PKG_KSPACE=yes -D PKG_USER-MEAMC=yes -D PKG_USER-SMTBQ=yes -D PKG_USER-DIFFRACTION=yes -D FFT=MKL

.. note::

   Özellikle `PLUMED <http://gensoft.pasteur.fr/docs/lammps/12Dec2018/Build_extras.html#user-plumed-package>`_ ve `MSCG <http://gensoft.pasteur.fr/docs/lammps/12Dec2018/Build_extras.html#mscg-package>`_ paketlerine hesaplamalarınız için ihtiyacınız varsa Conda ile GSL paketini kurmanız gerekmektedir. Conda kurulumu için aşağıdaki linki ziyaret edebilirsiniz:

   `Ev dizininize Anaconda kurulumu <https://docs.truba.gov.tr/GPU/deep-learning/virtual-env.html#ev-dizininize-anaconda-kurun>`_

   Conda ile GSL paketini de aşağıdaki komut ile kurabilirsiniz:

   .. code-block:: bash

      conda install -c conda-forge gsl 

Daha sonra CMake ile build komutunu çalışarak LAMMPS’i derleyiniz:

.. code-block:: bash

   cmake --build .


Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``build-intel18-openmpi4`` dizininde çalıştırılabilir ``lmp`` dosyası yer alacaktır.


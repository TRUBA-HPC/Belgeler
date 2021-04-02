===================================================
Kendi Bilgisayarıma LAMMPS'i Nasıl Yüklerim?
===================================================

--------------------------
Debian/Ubuntu Linux için:
--------------------------

1- Ön Hazırlık
---------------

Sisteminizde bazı paketlerin kurulu olması gerekmektedir. Bunları

.. code-block:: bash
 
   sudo apt install <paket adları>

ile kurabilirsiniz. Gerekli paket listesi aşağıdaki gibidir:

.. code-block:: bash

   gcc gfortran cmake autoconf automake autotools-dev libopenmpi-dev libopenmpi3  mpi-default-bin openmpi-bin openmpi-common libopenblas-base libopenblas-dev

2- LAMMPS’ın İndirilmesi
-------------------------

LAMMPS’ın kaynak kodunun indirilmesi için iki yöntem mevcuttur. Detaylara

- https://lammps.sandia.gov/doc/Install_tarball.html

- https://lammps.sandia.gov/doc/Install_git.html 

adreslerinden ulaşabilirsiniz.

* https://lammps.sandia.gov/download.html sayfasından LAMMPS Stable seçeneğini seçin, ve “Download now” tuşuna basın. Bilgisayarınıza indirdiğiniz dosyayı:

.. code-block:: bash

   tar zxvf lammps*.tar.gz 

komutu ile açabilirsiniz.

* veya  sisteminizde git yüklü ise:

.. code-block:: bash

   git clone -b stable https://github.com/lammps/lammps.git lammps-stable

ile lammps-stable klasörüne LAMMPS’i klonlayabilirsiniz.

3- LAMMPS'in Derlenmesi
-------------------------

LAMMPS’ın derlenmesi için iki yöntem mevcuttur. Burada CMAKE yöntemini kullanacağız. Detaylara `<https://lammps.sandia.gov/doc/Build_cmake.html>`_ adresinden ulaşabilirsiniz.

* LAMMPS kodunu açtığınız klasörün içine gidin (örneğin ``cd lammps-stable``), burada build klasörü oluşturun, ve içine gidin:

.. code-block:: bash

   mkdir build 
   cd build

* Bulunduğunuz yer lammps_stable/build olmalı.

* Aşağıdaki komut ile CMake’i çalıştırın. CMake sisteminizi tarayarak gerekli ayarları yapacaktır. Ekteki komutla ReaxFF dahil birkaç yaygın paket kurulmaktadır.

.. code-block:: bash

  cmake ../cmake -D PKG_BODY=yes -D PKG_CLASS2=yes -D PKG_DIPOLE=yes -D PKG_MANYBODY=yes -D PKG_USER-REAXC=yes -D PKG_USER-MEAMC=yes

* cmake size sisteminizde bulduğu özellikleri, ve LAMMPS’a dahil olacak paketleri özet geçecektir.

.. code-block:: bash

  -- Enabled packages: BODY;CLASS2;DIPOLE;MANYBODY;USER-MEAMC;USER-REAXC

* Aşağıdaki komut ile LAMMPS’ı derleyebilirsiniz (sondaki noktaya dikkat ediniz,  ve build klasörünün içinde olduğunuzdan emin olunuz):

.. code-block:: bash

   cmake --build . 
   make install
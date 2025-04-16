========================================
TRUBA'da Quantum Espresso Kurulumu
========================================

-------------------------------------
Barbun Hesaplama Kümesi'nde Kurulum
-------------------------------------

Quantum Espresso programını derlemek için bir klasör oluşturup ilgili klasöre gidiniz. Kullanmak istediğiniz versiyon için kurulum dosyalarını `QE GitHub sayfasından <https://github.com/QEF/q-e/releases>`_ edinebilirsiniz ve bulunduğunuz dizine ``wget`` komutu ile indirebilirsiniz. Aşağıdaki komut bloğunda QE6.7 versiyonu için olan link belirtilmiştir.

.. code-block:: bash

    mkdir espresso
    cd espresso
    wget https://github.com/QEF/q-e/archive/refs/tags/qe-6.7.0.tar.gz

Sıkıştırılmış arşiv dosyalarını açınız ve kurulum dosyalarının olduğu ilgili klasöre gidiniz.

.. code-block:: bash

    tar -xzvf qe-6.7.0.tar.gz
    cd q-e-qe-6.7.0

Kurulumu ``barbun`` kuyruğu için optimize bir şekilde kurmak istiyorsanız öncelikle ``srun`` komutu ile ``barbun`` kuyruğundaki 1 tane makineden 4 tane CPU'yu (Barbun kümesindeki CPU kullanımı için bakınız: :ref:`barbun-node`) kendi kullanıcınız için interaktif olarak ayırabilirsiniz. Aşağıdaki komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili node'a bağlanacaksınız. 

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p barbun --ntasks-per-node=4 --time=01:00:00 --job-name "qe-install" --pty bash -i

.. note::

   Kurulum için öngördüğünüz süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyebilirsiniz.

TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Barbun node'unda ``centos 7.3`` işletim sistemi yüklü bulunmaktadır.

Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle

.. code-block:: bash

   module purge

komutu ile kullanıcınızda tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.


Intel Derleyicileri, Intel MKL ve Intel MPI ile Kurulum
-----------------------------------------------------------

Quantum Espresso programını Intel derleyicileri, Intel MKL ve Intel MPI ile kurmak için Intel Parallel Studio modülünü aşağıdaki komut ile yükleyebilirsiniz. 

.. code-block:: bash

   module load centos7.3/comp/intel/PS2018-update2

Kullanacağınız hesaplama kümesinin (bakınız :ref:`hesaplama-kumeleri`) Intel işlemcilerine has özelliklerini kullanarak hızlandırma için ``-xHost`` parametresini ekleyiniz.

.. warning::
   
   ``-xHost`` ile derlediğiniz program derleme sırasında kullandığınız işlemciden farklı işlemcilerde daha yavaş çalışabilir veya hiç çalışmayabilir

Intel derleyicilerinin kullanılmasını sağlamak için gerekli shell parametrelerini aşağıdaki örnek derleme komutunda gösterildiği gibi satır içi de girebilirsiniz. Kurulumu gerçekleştireceğiniz klasörü de ``--prefix`` parametresi ile belirtebilirsiniz. 

.. code-block:: bash
   
   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$FLAGS MPIF90=mpiifort CC=mpiicc CXX=mpiicpc ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

Configure adımından sonra ``make.inc`` dosyasını ``vim`` veya ``nano`` ile açarak kütüphanelerle ilgili kontroller yapılmalıdır. Yukarıda belirtilen kurulum konfigürasyonu için örnek ``make.inc`` dosyasına aşağıdaki link aracılığıyla ulaşabilirsiniz.

* :download:`make.inc dosyasının bir kopyasını indirmek için tıklayınız.... </assets/qe-howto/config-files/make.inc-barbun-impi-intel18>`

Gerekli kontrolleri yaptıktan sonra ``make all`` ve ``make install`` komutları ile Quantum Espresso'yu derleyiniz:

.. code-block:: bash

   make all
   make install

.. warning ::

   ``make all`` komutu Quantum Espresso programının sağladığı tüm executable dosyaların oluşturulmasını sağlar (pw.x, ph.x, bands.x, vb.). Eğer sadece belirli executable dosyalara ihtiyacınız varsa ``make all`` komutu yerine ilgili executable'ı belirterek, örneğin ``make pw``, kurulumu özelleştirebilirsiniz ve böylece programın derlenmesi daha kısa sürede tamamlanacaktır.

Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``q-e-qe-6.7.0`` dizininde ``bin`` klasörü altında çalıştırılabilir dosyalar yer alacaktır.

.. note ::

   ``bin`` klasörünün ismini yaptığınız kurulum konfigürasyonu için hatırlatıcı/bilgi verici olması açısından özelleştirebilirsiniz:

   .. code-block::

      mv bin bin-barbun-impi-intel18


Intel Derleyicileri, Intel MKL ve Open MPI ile Kurulum
----------------------------------------------------------

Quantum Espresso programını Intel derleyicileri, Intel MKL ve OpenMPI ile kurmak için Intel Parallel Studio ve uyumlu OpenMPI modülünü aşağıdaki komutlar ile yükleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

.. code-block:: bash

   module purge
   module load centos7.3/comp/intel/PS2018-update2
   module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

Kullanacağınız hesaplama kümesinin (bakınız :ref:`hesaplama-kumeleri`) Intel işlemcilerine has özelliklerini kullanarak hızlandırma için ``-xHost`` parametresini ekleyiniz.

.. warning::
   
   ``-xHost`` ile derlediğiniz program derleme sırasında kullandığınız işlemciden farklı işlemcilerde daha yavaş çalışabilir veya hiç çalışmayabilir.

Intel derleyicilerinin kullanılmasını sağlamak için gerekli shell parametrelerini aşağıdaki örnek derleme komutunda gösterildiği gibi satır içi de girebilirsiniz. Kurulumu gerçekleştireceğiniz klasörü de ``--prefix`` parametresi ile belirtebilirsiniz. 

.. code-block:: bash
   
   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$FLAGS MPIF90=mpif90 CC=mpicc CXX=mpic++ ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

Configure adımından sonra ``make.inc`` dosyasını ``vim`` veya ``nano`` ile açarak kütüphanelerle ilgili kontroller yapılmalıdır. Yukarıda belirtilen kurulum konfigürasyonu için örnek ``make.inc`` dosyasına aşağıdaki link aracılığıyla ulaşabilirsiniz.

* :download:`Intel ve OpenMPI kurulumuna dair oluşan, düzenlenen make.inc dosyasının bir kopyasını indirmek için tıklayınız.... </assets/qe-howto/config-files/make.inc-barbun-openmpi-4.0.1-intel18>`

Gerekli kontrolleri yaptıktan sonra ``make all`` ve ``make install`` komutları ile Quantum Espresso'yu derleyiniz:

.. code-block:: bash

   make all
   make install

.. warning ::

   ``make all`` komutu Quantum Espresso programının sağladığı tüm executable dosyaların oluşturulmasını sağlar (pw.x, ph.x, bands.x, vb.). Eğer sadece belirli executable dosyalara ihtiyacınız varsa ``make all`` komutu yerine ilgili executable'ı belirterek, örneğin ``make pw``, kurulumu özelleştirebilirsiniz ve böylece programın derlenmesi daha kısa sürede tamamlanacaktır.

Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``q-e-qe-6.7.0`` dizininde ``bin`` klasörü altında çalıştırılabilir dosyalar yer alacaktır.

.. note ::

   ``bin`` klasörünün ismini yaptığınız kurulum konfigürasyonu için hatırlatıcı/bilgi verici olması açısından özelleştirebilirsiniz:

   .. code-block::

      mv bin bin-barbun-openmpi4-intel18


-------------------------------------
Hamsi Hesaplama Kümesi'nde Kurulum
-------------------------------------

Quantum Espresso programını derlemek için bir klasör oluşturup ilgili klasöre gidiniz. Kullanmak istediğiniz versiyon için kurulum dosyalarını `QE GitHub sayfasından <https://github.com/QEF/q-e/releases>`_ edinebilirsiniz ve bulunduğunuz dizine ``wget`` komutu ile indirebilirsiniz. Aşağıdaki komut bloğunda QE6.7 versiyonu için ola link belirtilmiştir.

.. code-block:: bash

    mkdir espresso
    cd espresso
    wget https://github.com/QEF/q-e/archive/refs/tags/qe-6.7.0.tar.gz

Sıkıştırılmış arşiv dosyalarını açınız ve kurulum dosyalarının olduğu ilgili klasöre gidiniz.

.. code-block:: bash

    tar -xzvf qe-6.7.0.tar.gz
    cd q-e-qe-6.7.0

Kurulumu ``hamsi`` kuyruğu için optimize bir şekilde kurmak istiyorsanız öncelikle ``srun`` komutu ile ``hamsi`` kuyruğundaki 1 tane makineden 28 tane CPU'yu (Hamsi kümesindeki CPU kullanımı için bakınız: :ref:`hamsi-node`) kendi kullanıcınız için interaktif olarak ayırabilirsiniz. Aşağıdaki komutu yazdığınızda bekleme listesine gireceksiniz. Sıranız geldiğinde doğrudan ilgili node'a bağlanacaksınız. 

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00 --job-name "qe-install" --pty bash -i

.. note::

   Kurulum için öngördüğünüz süreyi kurallar dahilinde değiştirebilirsiniz. Ayrıntılı bilgi için :ref:`partitions` sayfasını inceleyebilirsiniz.

TRUBA sisteminde genel olarak kurulu olan programlar hakkındaki bilgiye

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Hamsi node'unda ``centos 7.9`` işletim sistemi yüklü bulunmaktadır.  Kullanıcınızda yüklenmiş modülleri 

.. code-block:: bash

   module list

komutu ile listeleyebilirsiniz.


Intel Derleyicileri, Intel MKL ve Intel MPI ile Kurulum
-----------------------------------------------------------

Quantum Espresso programını Intel derleyicileri, Intel MKL ve Intel MPI ile kurmak için Intel OneAPI modülünü aşağıdaki komutlar ile yükleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

.. code-block:: bash

   module purge
   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

Kullanacağınız hesaplama kümesinin (bakınız :ref:`hesaplama-kumeleri`) Intel işlemcilerine has özelliklerini kullanarak hızlandırma için ``-xHost`` parametresini ekleyiniz.

.. warning::
   
   ``-xHost`` ile derlediğiniz program derleme sırasında kullandığınız işlemciden farklı işlemcilerde daha yavaş çalışabilir veya hiç çalışmayabilir.

Intel derleyicilerinin kullanılmasını sağlamak için gerekli shell parametrelerini aşağıdaki örnek derleme komutunda gösterildiği gibi satır içi de girebilirsiniz. Kurulumu gerçekleştireceğiniz klasörü de ``--prefix`` parametresi ile belirtebilirsiniz. 

.. code-block:: bash
   
   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$FLAGS MPIF90=mpiifort CC=mpiicc CXX=mpiicpc ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

Configure adımından sonra ``make.inc`` dosyasını ``vim`` veya ``nano`` ile açarak kütüphanelerle ilgili kontroller yapılmalıdır. Yukarıda belirtilen kurulum konfigürasyonu için örnek ``make.inc`` dosyasına aşağıdaki link aracılığıyla ulaşabilirsiniz.

* :download:`hamsi node'unda Intel OneAPI ile kurulum için oluşan/düzenlenen make.inc dosyasının bir kopyasını indirmek için tıklayınız... </assets/qe-howto/config-files/make.inc-hamsi-impi-inteloneapi>`

Gerekli kontrolleri yaptıktan sonra ``make all`` ve ``make install`` komutları ile Quantum Espresso'yu derleyiniz:

.. code-block:: bash

   make all
   make install

.. warning ::

   ``make all`` komutu Quantum Espresso programının sağladığı tüm executable dosyaların oluşturulmasını sağlar (pw.x, ph.x, bands.x, vb.). Eğer sadece belirli executable dosyalara ihtiyacınız varsa ``make all`` komutu yerine ilgili executable'ı belirterek, örneğin ``make pw``, kurulumu özelleştirebilirsiniz ve böylece programın derlenmesi daha kısa sürede tamamlanacaktır.

Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``q-e-qe-6.7.0`` dizininde ``bin`` klasörü altında çalıştırılabilir dosyalar yer alacaktır.

.. note ::

   ``bin`` klasörünün ismini yaptığınız kurulum konfigürasyonu için hatırlatıcı/bilgi verici olması açısından özelleştirebilirsiniz:

   .. code-block::

      mv bin bin-hamsi-impi-oneapi


Intel Derleyicileri, Intel MKL ve Open MPI ile Kurulum
----------------------------------------------------------

Quantum Espresso programını Intel derleyicileri, Intel MKL ve OpenMPI ile kurmak için Intel OneAPI modülünü ve uyumlu olan OpenMPI modülünü aşağıdaki komutlar ile yükleyebilirsiniz. Herhangi bir çakışma olmaması açısından öncelikle tanımlı olan tüm modül dosyalarını kaldırmanız önerilmektedir.

.. code-block:: bash

   module purge
   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
   module load centos7.9/lib/openmpi/4.1.1-intel-oneapi-2021.2

Kullanacağınız hesaplama kümesinin (bakınız :ref:`hesaplama-kumeleri`) Intel işlemcilerine has özelliklerini kullanarak hızlandırma için ``-xHost`` parametresini ekleyiniz.

.. warning::
   
   ``-xHost`` ile derlediğiniz program derleme sırasında kullandığınız işlemciden farklı işlemcilerde daha yavaş çalışabilir veya hiç çalışmayabilir.

Intel derleyicilerinin kullanılmasını sağlamak için gerekli shell parametrelerini aşağıdaki örnek derleme komutunda gösterildiği gibi satır içi de girebilirsiniz. Kurulumu gerçekleştireceğiniz klasörü de ``--prefix`` parametresi ile belirtebilirsiniz. 

.. code-block:: bash
   
   FLAGS="-xHost"; CFLAGS=$FLAGS CXXFLAGS=$FLAGS MPIF90=mpif90 CC=mpicc CXX=mpic++ ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

Configure adımından sonra ``make.inc`` dosyasını ``vim`` veya ``nano`` ile açarak kütüphanelerle ilgili kontroller yapılmalıdır. 

Gerekli kontrolleri yaptıktan sonra ``make all`` ve ``make install`` komutları ile Quantum Espresso'yu derleyiniz:

.. code-block:: bash

   make all
   make install

.. warning ::

   ``make all`` komutu Quantum Espresso programının sağladığı tüm executable dosyaların oluşturulmasını sağlar (pw.x, ph.x, bands.x, vb.). Eğer sadece belirli executable dosyalara ihtiyacınız varsa ``make all`` komutu yerine ilgili executable'ı belirterek, örneğin ``make pw``, kurulumu özelleştirebilirsiniz ve böylece programın derlenmesi daha kısa sürede tamamlanacaktır.

Yukarıdaki kurulum adımları tamamlandığında bulunduğunuz ``q-e-qe-6.7.0`` dizininde ``bin`` klasörü altında çalıştırılabilir dosyalar yer alacaktır.

.. note ::

   ``bin`` klasörünün ismini yaptığınız kurulum konfigürasyonu için hatırlatıcı/bilgi verici olması açısından özelleştirebilirsiniz:

   .. code-block::

      mv bin bin-hamsi-openmpi-oneapi

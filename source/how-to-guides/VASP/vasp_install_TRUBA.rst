==========================
TRUBA'da VASP Kurulumu
==========================

-----------------------------------------------------------------------------------
Barbun Sunucularında VASP Programının Intel Derleyiciler ve OpenMPI ile  Derlenmesi
-----------------------------------------------------------------------------------
VASP programının 6.2.0 versiyonunun TRUBA sisteminde derlenmesi için gerekli adımlar aşağıda verilmiştir. Siz de bu adımları takip 
ederek VASP kurulumunu kendi dizinizde kurabilirsiniz.


**1.**  Öncelikle VASP programını derlemek için gerekli ortam hazılanır. **derleme** adında bir klasör oluşturulup gerekli dosyalar buraya kopyalanır.
 
.. code-block:: bash

  $>mkdir derleme
   $> cp vasp.6.2.0.tar.gz derleme/
   $> cd derleme

**2.** Sıkıştırılmış arşiv dosyaları açılır.

.. code-block:: bash

   $>tar -zxvf vasp.6.2.0.tar.gz
   
**3.** VASP programını ``barbun`` kümelerinde derlemek için, bu sunuculardan **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir. 
 Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash 
 
  srun -N 1 -A kullanıcıadı -p barbun -n 4 --time=02:00:00 --job-name "install-gromacs" --pty bash -i


**4.** Intel Parallel Studio'nun güncel versiyonu load edilir. Program barbun sunucuları üzerinden derlendiği için centos7.3' ün modulleri load edilir. 

.. code-block:: bash

    $>module load centos7.3/comp/intel/PS2018-update2
    $>module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

**5.** Program openmpi ile derleneceği için, verilen adresteki  **/truba/home/kullanıcı_adı/derleme/vasp.6.2.0/arch/ makefile.include.linux_intel_omp** dosyayı bu adrese kopyalayınız **/truba/home/kullanıcı_adı/derleme/vasp.6.2.0**. Bu işlemden sonra kopyalanan dosyanın ismi,
``makefile.include`` olarak değiştiriniz. Bu işlemlerin hepsi aşağıda komut satırı olarak verilmiştir. 

.. code-block:: bash 

    $>cp /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/arch/makefile.include.linux_intel_omp /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/
    $>mv makefile.include.linux_intel_omp makefile.include


**6.** Bütün bu işlemlerden sonra ``make`` komutu kullanarak derleme işlemine geçilir. Derleme uzun sürecektir. Derleme sırasında birden fazla çekirdek kullanmak için
``make -j 8`` komutunu kullanabilirsiniz. 

.. code-block:: bash 
   
   $>make -j 8

Derleme sırasında **bin** ve **build** dizinleri  kullanılmış olacaktır. Farklı parametrelerle farklı derlemeler yapabilmek için bin dizini farklı adla kayıt edilip, 
dizinler silinerek yeniden oluşturulmalıdır.   

.. code-block:: bash

  $> cp -r bin bin-derleme1
  $> rm -rf bin build
  $> mkdir bin build


-----------------------------------------------------------------------------
Hamsi Sunucularında VASP Programının Intel Derleyiciler ile  Kurulması
-----------------------------------------------------------------------------
VASP programının 6.2.0 versiyonunun TRUBA sisteminde derlenmesi için gerekli adımlar aşağıda verilmiştir. Siz de bu adımları takip 
ederek VASP kurulumunu kendi dizinizde kurabilirsiniz.


**1.** 
Öncelikle VASP programını derlemek için gerekli ortam hazılanır. **derleme** adında bir klasör oluşrurulup 
gerekli dosyalar buraya kopyalanır.
 
.. code-block:: bash

  $>mkdir derleme
   $> cp vasp.6.2.0.tar.gz derleme/
   $> cd derleme

**2.** 
Sıkıştırılmış arşiv dosyaları açılır.

.. code-block:: bash

   $>tar -zxvf vasp.6.2.0.tar.gz
   
**3.** 
VASP programını ``hamsi`` kümelerinde derlemek için, bu sunuculardan **srun** komutu ile boş sunucu isteği yapmanız gerekmektedir. 
Aşağıdaki komut satırını kendi terminalizde uyguladığınızda boş işlemci için sıraya gireceksiniz.

.. code-block:: bash 
 
   srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00  --job-name "install-vasp" --pty bash -i


**4.** 
Intel Parallel Studio'nun güncel versiyonu load edilir. Program **hamsi** sunucuları üzerinden derlendiği için centos7.3' ün modulleri load edilir. 

.. code-block:: bash

    $>source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh
    

**5.** 
Program openmpi ile derleneceği için, verilen adresteki  **/truba/home/kullanıcı_adı/derleme/vasp.6.2.0/arch/ makefile.include.linux_intel_omp** dosyayı bu adrese kopyalayınız **/truba/home/kullanıcı_adı/derleme/vasp.6.2.0**. Bu işlemden sonra kopyalanan dosyanın ismi,
``makefile.include`` olarak değiştiriniz. Bu işlemlerin hepsi aşağıda komut satırı olarak verilmiştir. 

.. code-block:: bash 

    $>cp /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/arch/makefile.include.linux_intel_omp /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/
    $>mv makefile.include.linux_intel_omp makefile.include

**6.** 
Bütün bu işlemlerden sonra ``make`` komutu kullanarak derleme işlemine geçilir. Derleme uzun sürecektir. Derleme sırasında birden fazla çekirdek kullanmak için
``make -j 8`` komutunu kullanabilirsiniz. 

.. code-block:: bash 
   
   $>make -j 8

Derleme sırasında **bin** ve **build** dizinleri  kullanılmış olacaktır. Farklı parametrelerle farklı derlemeler yapabilmek için bin dizini farklı adla kayıt edilip, 
dizinler silinerek yeniden oluşturulmalıdır.   

.. code-block:: bash

  $> cp -r bin bin-derleme1
  $> rm -rf bin build
  $> mkdir bin build











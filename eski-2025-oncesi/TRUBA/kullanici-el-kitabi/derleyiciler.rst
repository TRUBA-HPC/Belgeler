.. _derleyiciler:

=============
Derleyiciler
=============

Mart 2018 itibari ile SMP kümesinde hizmet veren Orkinos1 sunucusu haric tüm hesap sunucularının büyük kısmında CentOS7.3 işletim sistemi yüklü bulunmaktadır. Orkinos1 sunucu üzerinde RedHat7.2 işletim sistemi bulunmaktadır.

GCC ve Intel derleyicilerinin farklı versiyonları sistemde halihazırda yüklü bulunmaktadır. ``module avail`` komutu ile bakıldığında, yüklü derleyiciler "comp" altında listelenmektedir.

.. code-block::

   centos7.3/comp/cmake/3.10.1
   centos7.3/comp/cmake/3.18.0
   centos7.3/comp/gcc/6.4
   centos7.3/comp/gcc/7
   centos7.3/comp/gcc/9.2
   centos7.3/comp/intel/PS2013-SP1
   centos7.3/comp/intel/PS2016-update3
   centos7.3/comp/intel/PS2017-update1
   centos7.3/comp/intel/PS2018-update2
   centos7.3/comp/intel/PS2019-update1
   centos7.3/comp/python/3.5.5-intel
   centos7.3/comp/python/3.6.5-gcc

Bu listeye yeni derleyeciler eklenebileceği için, her derleme öncesinde ``module avail`` komutu ile güncel uygulama/kütüphane ve derleyiciler kontrol edilmelidir.

Intel Derleyiciler
------------------

Intel işlemcili sunucularda, işlemcilerin sağladığı ekstra performans özelliklerini (özellikle AVX2 ve AVX-512) verimli bir şekilde kullanabilmek için intel derleyicilerinin son versiyonlarının kullanılmasını önermekteyiz. Bu derleyicileri kullanmaya başlamadan önce kullanılacak versiyonla ilgili çevre değişkenler (PATH, LD_LIBRARY_PATH vs..) ayarlanmalıdır. Çevre değişkenlerini ayarlamak için modül mekanizması kullanılabileceği gibi paketle birlikte gelen betikler de kullanılabilir.

.. code-block::

   source /truba/sw/centos7.3/comp/intel/PS2018-update2/bin/compilervars.sh intel64

ya da

.. code-block::

   module load centos7.3/comp/intel/PS2018-update2

komutları ile kullanılacak derleyiciler yüklenebilir.

Çevre değişkenleri ayarlandığında, intel derleyicileri (icc, ifort, icpc vs) ile birlikte pek çok performans kütüphanesi (Intel-mpi, MKL) ve geliştirme aracı (ipp, itune vs) kullanılabilir hale gelmektedir. Bu araçların kullanımı hakkında ayrıntılı bilgiye `üreticinin web sayfasından <https://software.intel.com/content/www/us/en/develop/tools/oneapi/commercial-base-hpc.html#gs.1ju7gd>`_ ulaşılabilir.

Eğer kullanıcının yaptığı tüm derlemelerde Intel derleyicilerinin aynı versiyonu kullanılıyor ise, çevre değişkenlerini sisteme her login olunduğunda yeniden ayarlamak yerine, ``.profile`` (ya da ``.bashrc``) dosyası içerisinde ayarlanarak kullanılabilir.

Intel oneAPI Derleyicileri
---------------------------

Modern bilgisayar mimarilerinde yüksek bilgi işlem performansı elde etmek için optimize olmuş, ölçeklendirilmiş kodlar kullanmak gereklidir. 
İş yükü çeşitliliğinin artmasıyla beraber, yüksek performans için, tek bir mimari her iş için en uygunu olmayabilir. Bu durum  çok çeşitli mimarilere duyulan ihtiyacı artırmıştır.
Gerekli performansı elde etmek için CPU, GPU, AI ve FPGA hızlandırıcılarında dağıtılan  skaler, vektör, matris ve SVMS mimarilerinin bir karışımı gereklidir. Bunların yanında  CPU ve hızlandırıcılar için kodlama
farklı diller, kitaplıklar ve araçlar gerektiriyor. Bu durum her bir donanım platformunun tamamen farklı yazılım yatırımları  gerektirdiği anlamına gelir.

oneAPI programlama Data Parallel C++ (DPC++) adlı açık kaynak programlama diliyle, paralelliği ifade etmek için  C++ özelliklerini kullanarak 
CPU'ların ve hızlandırıcıların programlanmasını basitleştirir. oneAPI ayrıca mevcut C/C++ veya Fortran koduyla OpenMP*  özelliğini kullanan CPU'larda 
ve hızlandırıcılarda programlamayı destekler. TRUBA' da oneAPI için çevre değişkenlerini ayarlamak ve module olarak eklemek için:

.. code-block:: bash

   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

.. note::

   Intel oneApi derleyicisi ücretsiz olarak sunulmaktadır. 

   Ücretsiz sunulan Intel araçlarına ulaşmak için : https://software.intel.com/content/www/us/en/develop/articles/free-intel-software-developer-tools.html


Referans: https://software.intel.com/content/www/us/en/develop/documentation/oneapi-programming-guide/top/introduction-to-oneapi-programming.html

GCC Derleyiciler
-----------------

Tüm sistemlerde GCC'nin Centos7.3 işletim sistemi ile birlikte gelen 4.8.5 versiyonu varsayılan olarak kurulu durumdadır. Kullanmak için herhangi bir modül yüklemeye ya da çevre değişkeni ayarlamaya gerek yoktur. Güncel işlemcilerin güncel özelliklerini kullanabilmek için GCC'nin daha yeni versiyonunu kullanmak isteyen kullanıcılar, GCC'nin güncel versiyonlarını moduller arasından kontrol edip yükleyebilirler.

.. code-block::

   $> module avail
      centos7.3/comp/gcc/6.4
      centos7.3/comp/gcc/7
      centos7.3/comp/gcc/9.2
   $> module load centos7.3/comp/gcc/9.2

CUDA
-----

CUDA kütüphanesinin farklı versiyonları ``/truba/sw/centos7.3/lib/cuda`` dizini altında yüklüdür. Kütüphaneler ve araçlar doğrudan bu dizin altından kullanılabileceği gibi, ilgili kütüphanelerin modülleri yüklenerek de kullanılabilir. Sistemde kurulu olan mevcut versiyonlar:

.. code-block::

   centos7.3/lib/cuda/10.0
   centos7.3/lib/cuda/10.1
   centos7.3/lib/cuda/7.5
   centos7.3/lib/cuda/9.0
   centos7.3/lib/cuda/9.2

İlgili kütüphanelerin dizinlerinde ``(/truba/sw/centos7.3/lib/cuda/x.x)`` ayrıca örnek CUDA kodları ve uygulama örnekleri bulunmaktadır. Kurulum alanında yer alan örnekler kaynak yöneticisi aracılığı ile CUDA destekli kuyruklarda çalıştırılabilir.

Nümerik Kütüphaneler
----------------------

İşlemci üreticileri tarafından sağlanan ve ilgili işlemci markası için optimize edilmiş AMD ACML ve Intel MKL'nin farklı versiyonları ile birlikte `BLAS <http://www.netlib.org/blas/>`_, `LAPACK <http://www.netlib.org/lapack/>_, `BLACS <https://www.netlib.org/blacs/>`_, `SCALAPACK <http://www.netlib.org/scalapack/scalapack_home.html>`_, `FFTW <http://www.fftw.org>`_ vb. gibi pek çok temel matematik kütüphanesinin farklı versiyonları, farklı işlemci aileleri için optimize edilmiş olarak merkezi alanda yüklü bulunmaktadır. Kullanılacak kütüphanenin, mevcut işletim sistemi için derlenmiş olması önemlidir. Bu nedenle kullanılacak modülün mevcut işletim sistemi adı (centos7.3) ile başlaması ya da eğer modül kullanılmayacaksa, kütüphanelerin ``/truba/sw/centos7.3/lib`` dizini altında kurulu olan kütüphanelerden seçilmesi gerekmektedir.

Intel MKL
^^^^^^^^^^

Yaptığımız denemelerde, küme üzerinde Intel derleyici ve kütüphanelerinin kullanılmasının, uygulamanın performansını arttırdığı gözlemlenmiştir. Kullanıcıların, uygulama derleme sırasında, işlemci ailesi ile uyumlu olan Intel derleyicilerini ve kütüphanelerini kullanmaları önerilmektedir.

MKL kütüphanesi, Intel deryeyicileri ``module load`` komutu ile yüklendiği zaman otomatik olarak kullanılır duruma gelmektedir. Ayrıntılı bilgi için [Intel Derleyicileri]

MKL kütüphanesinin kullanımı ve özellikleri hakkında detaylı bilgiye `Intel MKL web sayfasından <https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/onemkl.html#gs.1ju1hh>`_ ulaşılabilir. Ayrıca **Intel Developer Forum**'da uygulama örneklerine ve diğer kullanıcıların tecrübelerine ulaşılabilir.

AMD ACML
^^^^^^^^

AMD Core Math Library (ACML) kütüphanesinin farklı versiyonları **/truba/sw/centos7.3/lib/acml/** altında kurulu bulunmaktadır.

.. code-block::

   centos7.3/lib/acml/5.3.1-gfortan64
   centos7.3/lib/acml/5.3.1-gfortan64_mp
   centos7.3/lib/acml/6.1.0-gfortan64
   centos7.3/lib/acml/6.1.0-gfortan64_mp

FFTW3
^^^^^^

FFTW3'ün ``3.3.7`` versiyonu altyapıdaki farklı işlemci aileleri için yüklü bulunmaktadır. Aşağıdaki modüller yüklenerek ``(module load centos7.3/lib/fftw/package-version)`` kullanılabilir, ya da kurulu olduğu dizinden ``(/truba/sw/centos7.3/lib/fftw/)`` doğrudan kullanılabilir.

.. code-block::

   centos7.3/lib/fftw/3.3.7-gcc-4.8.5-AMDOPT
   centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V1
   centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V3-E5V4
   centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V1
   centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V3-E5V4

FFTW3 modülü yüklendiği zaman, aşağıdaki ``FFTW`` kütüphanelerine erişim sağlanabilmektedir:

* standart (statik ve dinamik,intel derleyicilerle)
* float (statik ve dinamik,intel derleyicilerle)
* long double(statik ve dinamik,intel derleyicilerle)
* mpi standart (statik ve dinamik, impi ve intel derleyicilerle)
* mpi float (statik ve dinamik, impi ve intel derleyicilerle)
* mpi long double (statik ve dinamik, impi ve intel derleyicilerle)

BLAS/LAPACK
^^^^^^^^^^^^

Temel matematik ve matris kütüphaneleridir. Bu nümerik lineer cebir kütüphanelerinin sağladığı pek çok rutin, aynı zamanda ACML ve MKL tarafından optimize bir şekilde sağlanmaktadır. Kütüphanelerin modül dosyaları aşağıdaki gibidir:

.. code-block::

   centos7.3/lib/lapack/3.4.2-gcc-4.8.5
   centos7.3/lib/lapack/3.4.2-intel-PS2013
   centos7.3/lib/lapack/3.6.1-gcc-4.8.5-GOLD
   centos7.3/lib/lapack/3.7.0-gcc-4.8.5

Ayrıca, ilgili kütüphaneleri kullanmak isteyen kullanıcılar ``/truba/sw/centos7.3/lib/lapack`` dizini altından BLAS ve LAPACK kurulumlarını kullanabilirler.

BLACS/SCALAPACK
^^^^^^^^^^^^^^^

LAPACK kütüphanesinin dağıtık kullanılabilmesini sağlayan ve ekstra özellikler getiren matematik ve haberleşme kütüphaneleridir. İlgili modül dosyaları:

.. code-block::

   centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-acml-6.1.0-gcc-4.8.5-AMDOPT
   centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.4.2-gcc-4.8.5
   centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.4.2-PS2013
   centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.7.0-gcc-4.8.5
   centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.7.0-gcc-4.8.5-GOLD

Ayrıca, kütüphaneler doğrudan ``/truba/sw/centos7.3/lib/scalapack`` dizini altından kullanılabilirler.

=========
Modüller
=========

Modül dosyaları ve çevre değişkenleri
--------------------------------------

Herhangi bir uygulamayı çalıştırabilmek için sistemin, o uygulamanın dosyalarının, o uygulamayı derlerken kullanılan kütüphanelerin nerede olduğunu bilmesi gerekir. Bu bildirim ``LD_LIBRARY_PATH``, ``PATH`` ve diğer bazı çevre değişkenlerin ayarlanması ile yapılır. Bu değişkenlerin ayarlanması ile yapılmış olan değişikliği geri almak için ya logout olup tekrar login olmak ya da, bu değişkenlerin içerisinden, ilgili kısımın geri çıkarılması gerekmektedir. Bu işlem zor olmamakla birlikte, kullanılacak her uygulama için, her bağlantıda yapılması kullanıcılar üzerinde bir iş yükü oluşturmaktadır. Örnegin ortak uygulama alanında kurulu Espresso 5.0.2 uygulamasını çalıştırmak için LD_LIBRARY_PATH ve PATH değişkenlerine aşağıdaki gibi değerlerinin atanması gerekmektedir.

.. code-block::

   export LD_LIBRARY_PATH=/truba/sw/centos6.4/app/espresso/5.0.2-impi-mkl/lib:$LD_LIBRARY_PATH

.. code-block::

   export PATH=/truba/sw/centos6.4/app/espresso/5.0.2-impi-mkl/bin:$PATH

Çevre değişkenlerinin otomatik olarak ayarlanması, ya da yapılan ayarlanmanın geri alınmasını otomatize etmek için **module** dosyaları kullanılmaktadır.

Merkezi dosya sisteminde bulunan uygulama, kütüphane ve derleyicilerin bazıları için module dosyaları oluşturulmuştur. TRUBA üzerindeki mevcut **module** dosyalarının listesine ``module avail`` komutu ile ulaşabilirsiniz.

.. code-block::

   --------------------------------------------- /truba/sw/centos7.3/modulefiles ---------------------------------------------
   centos7.3/app/abinit/8.6.1-openmpi-1.8.8-gcc-4.8.5-AMDOPT               centos7.3/app/siesta/4.1-b3-mp-gcc-4.8.5-E5V1
   centos7.3/app/abinit/8.6.1-openmpi-1.8.8-gcc-4.8.5-E5V1                 centos7.3/app/siesta/4.1-b3-mp-gcc-4.8.5-E5V3-E5V4
   centos7.3/app/abinit/8.6.1-openmpi-1.8.8-gcc-4.8.5-E5V3-E5V4            centos7.3/app/siesta/4.1-b3-openmpi-1.8.8-gcc-4.8.5-AMDOPT
   centos7.3/app/cp2k/7.1.0-omp-gcc9.2-GOLD                                centos7.3/app/siesta/4.1-b3-openmpi-1.8.8-gcc-4.8.5-E5V1
   centos7.3/app/espresso/6.1-impi-mkl-PS2016                              centos7.3/app/siesta/4.1-b3-openmpi-1.8.8-gcc-4.8.5-E5V3-E5V4
   centos7.3/app/espresso/6.1-openmpi-1.8.8-gcc-4.8.5-AMDOPT               centos7.3/app/vmd/1.9.2
   centos7.3/app/espresso/6.1-openmpi-1.8.8-mkl-PS2013-E5V1                centos7.3/app/vmd/1.9.3-text
   centos7.3/app/espresso/6.1-openmpi-1.8.8-mkl-PS2013-E5V3                centos7.3/app/yambo/4.5.1-impi-mkl-PS2018
   centos7.3/app/espresso/6.1-openmpi-1.8.8-mkl-PS2013-E5V4                centos7.3/comp/cmake/3.10.1
   centos7.3/app/espresso/6.1-openmpi-1.8.8-mkl-PS2013-GOLD                centos7.3/comp/cmake/3.18.0
   centos7.3/app/espresso/6.2-impi-mkl-PS2018                              centos7.3/comp/gcc/6.4
   centos7.3/app/espresso/6.3-impi-mkl-PS2018                              centos7.3/comp/gcc/7
   centos7.3/app/espresso/6.3-impi-mkl-PS2018-GOLD                         centos7.3/comp/gcc/9.2
   centos7.3/app/espresso/6.4.1-impi-mkl-PS2019-GOLD                       centos7.3/comp/intel/PS2013-SP1
   centos7.3/app/espresso/6.6-impi-mkl-PS2018-GOLD                         centos7.3/comp/intel/PS2016-update3
   centos7.3/app/gamess/201712-openmpi-1.8.8-mkl-PS2013                    centos7.3/comp/intel/PS2017-update1
   centos7.3/app/gamess/201712-openmpi-1.8.8-mkl-PS2013-AMD                centos7.3/comp/intel/PS2018-update2
   centos7.3/app/gromacs/2018-impi-mkl-PS2016-GOLD-CUDA                    centos7.3/comp/intel/PS2019-update1
   centos7.3/app/gromacs/2018-impi-mkl-PS2018-E5V4                         centos7.3/comp/python/3.5.5-intel
   centos7.3/app/gromacs/2018-impi-mkl-PS2018-GOLD                         centos7.3/comp/python/3.6.5-gcc
   centos7.3/app/gromacs/2019-impi-mkl-PS2019-E5V4                         centos7.3/lib/acml/5.3.1-gfortan64
   centos7.3/app/gromacs/2019-impi-mkl-PS2019-GOLD                         centos7.3/lib/acml/5.3.1-gfortan64_mp
   centos7.3/app/gromacs/2020-impi-mkl-PS2018-E5V4                         centos7.3/lib/acml/6.1.0-gfortan64
   centos7.3/app/gromacs/2020-impi-mkl-PS2018-GOLD                         centos7.3/lib/acml/6.1.0-gfortan64_mp
   centos7.3/app/gromacs/2020-impi-mkl-PS2018-GOLD-CUDA                    centos7.3/lib/acml/6.1.0-gfortran64
   centos7.3/app/gromacs/4.6.5-openmpi-1.8.8-gcc-4.8.5-E5V1                centos7.3/lib/cuda/10.0
   centos7.3/app/gromacs/5.1.4-impi-mkl-PS2016                             centos7.3/lib/cuda/10.1
   centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-AMDOPT              centos7.3/lib/cuda/7.5
   centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-E5V1                centos7.3/lib/cuda/9.0
   centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-E5V3                centos7.3/lib/cuda/9.2
   centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-E5V3-cuda           centos7.3/lib/fftw/3.3.7-gcc-4.8.5-AMDOPT
   centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-E5V4                centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V1
   centos7.3/app/lammps/17Nov16-impi-mkl-PS2016                            centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V3-E5V4
   centos7.3/app/lammps/17Nov16-openmpi-1.8.8-gcc-4.8.5-AMDOPT             centos7.3/lib/fftw/3.3.7-gcc-7.0.1-GOLD
   centos7.3/app/lammps/17Nov16-openmpi-1.8.8-mkl-PS2013-E5V1              centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V1
   centos7.3/app/lammps/17Nov16-openmpi-1.8.8-mkl-PS2013-E5V3              centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V3-E5V4
   centos7.3/app/lammps/17Nov16-openmpi-1.8.8-mkl-PS2013-E5V4              centos7.3/lib/lapack/3.4.2-gcc-4.8.5
   centos7.3/app/lammps/4Feb21-openmpi-1.8.8-gcc-4.8.5                     centos7.3/lib/lapack/3.4.2-intel-PS2013
   centos7.3/app/matlab/R2018b                                             centos7.3/lib/lapack/3.6.1-gcc-4.8.5-GOLD
   centos7.3/app/namd/2017-11-10-multicore                                 centos7.3/lib/lapack/3.7.0-gcc-4.8.5
   centos7.3/app/namd/2017-11-10-multicore-cuda                            centos7.3/lib/openmpi/1.8.8-gcc-4.8.5
   centos7.3/app/namd/2.12-ibverbs                                         centos7.3/lib/openmpi/1.8.8-intel-PS2013
   centos7.3/app/namd/2.14-multicore                                       centos7.3/lib/openmpi/1.8.8-intel-PS2016
   centos7.3/app/namd/2.14-multicore-CUDA                                  centos7.3/lib/openmpi/3.0.0-gcc-7.0.1
   centos7.3/app/namd/2.9-multicore-cuda                                   centos7.3/lib/openmpi/4.0.1-gcc-7.0.1
   centos7.3/app/nwchem/6.8-openmpi-1.8.8-gcc                              centos7.3/lib/openmpi/4.0.1-intel-PS2018
   centos7.3/app/openfoam/8                                                centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-acml-6.1.0-gcc-4.8.5-AMDOPT
   centos7.3/app/openfoam/v1912                                            centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.4.2-gcc-4.8.5
   centos7.3/app/R/3.4.3-gcc                                               centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.4.2-PS2013
   centos7.3/app/R/4.0.2-gcc                                               centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.7.0-gcc-4.8.5
   centos7.3/app/root/v6.20.02-gcc4.8-cmake3.10                            centos7.3/lib/scalapack/2.0.2-openmpi-1.8.8-lapack-3.7.0-gcc-4.8.5-GOLD
   centos7.3/app/siesta/4.1-b3-mp-gcc-4.8.5-AMDOPT

Kullanılmak istenilen uygulama ya da kütüphane 

.. code-block::

   module load <module_adı>

komutu ile yüklenebilir. Yüklü modüllerin listesi 

.. code-block::

   module list
   
komutu ile görülebilir. Silinmek istenilen modül

.. code-block::
   
   module unload <module_adı> 
   
komutu ile silinebilir. Yüklü olan modüllerin hepsi

.. code-block::
   
   module purge 

komutu ile silinebilir. Ayrıntılı bilgi için `module kullanıcı kitabı sayfasını ziyaret edebilirsiniz <https://modules.readthedocs.io/en/latest/module.html>`_

İlgili modül hakkında detaylı bilgi almak için ``module show`` komutu kullanılabilir.

.. code-block::

   module show centos7.3/app/espresso/6.2-impi-mkl-PS2018
   -------------------------------------------------------------------
   /truba/sw/centos7.3/modulefiles/centos7.3/app/espresso/6.2-impi-mkl-PS2018:

   module-whatis	 loads the modules environment
   prepend-path	 --delim=: PATH /truba/sw/centos7.3/app/espresso/6.2-impi-mkl-PS2018/bin
   setenv		 ESPRESSO_DIR /truba/sw/centos7.3/app/espresso/6.2-impi-mkl-PS2018
   prepend-path	 --delim=: LD_LIBRARY_PATH /truba/sw/centos7.3/app/espresso/6.2-impi-mkl-PS2018/lib
   -------------------------------------------------------------------

Sistemdeki modül dosyaları ilgili programın/kütüphanenin derlendiği işletim sistemi ve işlemci modeline göre hiyerarşik olarak hazırlanmıştır. Aynı kütüphanelerle ve aynı işletim sistemi üzerinde derlenmiş uygulamalar farklı işlemciler üzerinde genelde çalışabilirken (örnegin Opteron işlemciler için hazırlanmış uygulamalar büyük ihtimalle Xeon işlemciler üzerinde de çalışacaktır), işletim sisteminin farklı olduğu durumda büyük ihtimal çalışmayacaktır.


Modül isimlendirme sistematiği 
-------------------------------

Merkezi alandaki uygulama veya kütüphaneler genel olarak ortak bir sistematik kullanılarak isimlendirilmektedir. Örnek olarak aşağıdaki modül dosyasını inceleyecek olursak:

.. code-block::

   centos7.3/app/siesta/4.1-b3-openmpi-1.8.8-gcc-4.8.5-E5V3-E5V4

**centos7.3** --> uygulamanın derlendiği işletim sistemi 

**app** --> modülün türü; uygulamalar için ``app``, kütüphaneler için ``lib``, derleyiciler için ``comp``

**siesta** --> uygulamanın / kütüphanenin adı

**4.1-b3** --> uygulamanın /kütüphanenin versiyonu

**openmpi-1.8.8** --> derleme sırasında kullanılan ``mpi`` kütüphanesi ve versiyonu. Openmp/thread için ``mp``, eğer herhangi bir paralelleştirme kullanılmamışsa ``serial`` ifadeleri gelebilir.

**gcc-4.8.5** --> derleme sırasında kullanılan derleyici. Eğer ``intel`` derleyiciler kullanılmışsa ``PS2013, PS2016`` vs gelebilir. Eğer herhangi bir matematik kütüphanesi derleme sırasında kullanılmışsa, bu alandan önce ``acml, mkl`` gibi ifadeler gelebilir. ``ACML`` sadece ``AMD`` işemciler ve ``gcc`` derleyici kullanılan uygulamalarda/kütüphanelerde, ``mkl`` ise intel derleyicilerle derlenen uygulamalarda/kütüphanelerde kullanılmaktadır.

**E5V3-E5V4** --> Derlemenin hangi işlemci modeli için yapıldığını gösteren etikettir.

Altyapıdaki donanımlar farklı tarihlerde farklı ihalelerle alınmış olduğu için, altyapıda farklı işlemci üreticilerinden farklı işlemci mimarileri ve farklı işletim sistemleri yüklü olabilmektedir. Güncel donanım işlemci bilgisi (2018-02-22) aşağıdaki gibidir. Sunucu aileleri ile ilgili ayrıntılı bilgiye ``TRUBA Kaynakları`` sayfasından ulaşabilirsiniz.

**Levrek sunucuları** --> Intel Xeon E5 2690 V1 (single, short, mid1,mid2,long kuyrukları) 

**Levrekv2 sunucuları** --> Intel Xeon E5 2680 V3 (cuda ve levrekv2 kuyrugu) 

**Sardalya sunucuları** --> Intel Xeon E5 2690 V4 (sardalya kuyruğu) 

**Orkinos sunucusu** --> Intel Xeon E7 4850 V3 (smp kuyruğu) 

**Barbun sunucuları** --> Intel Xeon Scalable GOLD 6148(barbun, barbun-cuda kuyrukları) 

**Akya sunucuları** --> Intel Xeon Scalable GOLD 6148(akya-cuda kuyruğu) 

Farklı işlemci modellerinde, işlemcinin ve sunucunun performansını toptan etkileyen, farklı komut setleri bulunmaktadır. Herhangi bir uygulama derlenirken uygulamanın hangi işlemci ve hangi sunucu için derleneceğini bilmek ve buna uygun optimizasyon seçeneklerini kullanmak önem taşımaktadır.

.. note::
   Merkezi alandaki uygulamalar/kütüphaneler derlenirken, işlemcilerden en yüksek performansı alabilmek için, ilgili işlemci modeli için tüm optimizasyon seçenekleri kullanılmaktadır. Uygulamanın hangi sunucu için derlendiği, modül dosyasının sonuna eklenmiş olan ``E5V1, E5V3, E5V4, AMDOPT, GOLD`` kısaltmaları ile belirtilmiştir. Uygulama hangi kuyruk üzerinde çalıştırılacaksa, o sunucu/işlemci ailesi için derlenmiş modül kullanılmalıdır.

.. note::
   İşlemci modeli ile ilgili herhangi bir ibare bulundurmayan modüller genel olarak herhangi bir sunucu üzerinde çalıştırılabilirler. Ayrıca genel olarak, versiyon numarası yüksek olan işlemciler, versiyon numarası düşük olan işlemcilerdeki komut setlerini barındırırlar. Bu nedenle versiyon numarası düşük olan bir uygulama/kütüphane modülü, versiyon numarası yüksek olan bir işlemci modelinde sorunsuz olarak çalıştırılabilirler. Ancak bunun tersi her zaman mümkün olmayabilir.


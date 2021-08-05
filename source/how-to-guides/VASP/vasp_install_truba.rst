==========================
TRUBA'da VASP Kurulumu
==========================
Aşağıda VASP programının 5.4 versiyonunun TRUBA sisteminde derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip ederek VASP kurulumunu kendi kullanıcı hesabınızda kurabilirsiniz.

**1.** Öncelikle VASP programını derlemek için gerekli ortamı hazılanır. **derleme** adında bir klasör oluşturulup gerekli dosyalar buraya kopyalanır.
 
.. code-block:: bash

   $>mkdir derleme
   $>cp vasp.5.lib.tar.gz derleme/
   $>cp vasp.5.4.tar.gz derleme/
   $>cd derleme

**2.** Sıkıştırılmış arşiv dosyaları açılır.

.. code-block:: bash

   $>tar -zxvf vasp.5.lib.tar.gz
   $>tar -zxvf vasp.5.4.tar.gz

**3.** Intel Parallel Studio'nun güncel versiyonu load edilir.

.. code-block:: bash

    $>source /truba/sw/centos7.3/comp/intel/PS2018-update2/bin/compilervars.sh intel64

**4.** Vasp.5.lib/makefile.linux_ifc_P4 dosyası düzenlenerek FC=ifc satırı FC=ifort ile 
değiştirilir ve bu  dosya makefile adı ile kaydedilir. Make komutu ile derleme gerçekleştirilir.

.. code-block:: bash
  
   $>cd vasp.5.lib
   $>nano makefile.linux_ifc_P4 # bu kısımda nano editörüyle gerekli değişiklikleri yapınız.
   $>cp makefile.linux_ifc_P4 makefile
   $>make

**5.** Vasp5.lib' sini derledikten sonra, vasp.5.4 dizinine geçerek **arch** dizini içerisinden uygun olan makefile dosyası ana dizine kopyalanır.

.. code-block:: bash
   
   $>cd ..
   $>cd vasp.5.4
   $>cp  arch/makefile.include.linux_intel makefile.include

.. note::

 Dosyada genel olarak herhangi bir değişiklik yapılmasına gerek yoktur. Ancak derlenecek uygulamanın işlemcinin 
 AVX komut setlerini kullanabilmesi isteniyorsa FFLAGS değişkenine işlemciye özel bazı eklemelerin yapılması gerekmektedir.
 Eğer işlemcinin özellikleri bilinmiyorsa -xHost parametresi eklenerek, derlemenin yapıldığı işlemciye özel en üst AVX
 komut setinin kullanılması sağlanabilir. AVX-512 komut setini kullanabilmek için -xHost ile derleme barbun1 sunucusu üzerinde,
 AVX-2 komut setini kullanabilmek için -xHost ile derleme sardalya1 sunucusu üzerinde yapılmalıdır. -xHost yerine cross-compile parametreleri 
 kullanılarak tek bir sunucu üzerinde farklı işlemci nesilleri için derleme yapmak mümkündür. Mevcut kümelerdeki işlemciler için  
 `TRUBA Kaynakları <http://wiki.truba.gov.tr/index.php/TRUBA_Kaynaklar%C4%B1>`_ sayfasına, AVX hakkında ayrıntılı bilgi için `Intel-avx <https://www.intel.com/content/www/us/en/architecture-and-technology/avx-512-overview.html>`_
 sayfasına bakınız.

.. code-block:: bash 
   
   $>nano makefile.include
   ...
   ...
   ...
   FFLAGS=-assume byterecl -xHost
   ...
   ...
   ... 

**6.** Makefile.include dosyasında gerekli değişikler yapıldıktan sonra derlemeye geçilebilr. Derleme oldukça uzun sürecektir. 
Derleme sırasında birden fazla çekirdek kullanmak ``make`` komutuna eklenecek **-j 8** parametresi ile sağlanabilir. 

.. code-block:: bash 
   
   $>make -j 8

Derleme sırasında **bin** ve **build** dizinleri  kullanılmış olacaktır. Farklı parametrelerle farklı derlemeler yapabilmek için bin dizini farklı adla kayıt edilip, 
dizinler silinerek yeniden oluşturulmalıdır.   

.. code-block:: bash

  $> cp -r bin bin-derleme1
  $> rm -rf bin build
  $> mkdir bin build

============================================
VASP 5.4 'ın CUDA Destekli Olarak Derlenmesi  
============================================

Vasp5.4.4 yukarıdaki yönergelere göre derlendikten sonra, **makefike.include** dosyasının **CUDA** kısmında **CUDA_ROOT** ile başlayan satır
aşağıdaki gibi değiştirilir.

.. code-block:: bash 

    CUDA_ROOT  = /truba/sw/centos7.3/lib/cuda/9.0

Sistemde CUDA kütüphanesinin farklı versiyonları mevcuttur. Mevcut versiyonlar /truba/sw/centos7.3/lib/cuda dizini altında bulunmaktadır. 
Ayrıca kullanıcı kendi ev dizinine yükleyeceği daha güncel bir CUDA versiyonunu da **makefile.include** dizininde tanımlayarak kullanabilir.
Bu değişiklik yapıldıktan sonra: Aşağıda verilen komut ile derleme  gerçekleştirilir. Uygulamayı derlerken kullanılmış olan tüm kütüphaneler,
uygulamayı çalıştırırken de betik dosyası içerisinde aynı şekilde kullanılmalıdır.     


.. code-block:: bash
 
     $>make -j 8 

.. warning::

 **VASP 5.4 için betik dosyasını (slurm)** 
 örnek betik dosyasına /truba/sw/scripts/vasp dizininden erişilebilir. Bu dizin içerisinde Vasp'ın farklı derlemeleri ve farklı versiyonları 
 için betik dosyaları bulunmaktadır. Kullanıcılar kendi ihtiyaçlarına ve kendi kurulum dizinlerine göre dosyaları düzenlemelidirler. 








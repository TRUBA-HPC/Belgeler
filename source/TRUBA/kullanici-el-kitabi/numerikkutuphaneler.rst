.. _numerik-kutuphaneler:

=========================
Nümerik Kütüphaneler
=========================

İşlemci üreticileri tarafından sağlanan ve ilgili işlemci markası için optimize edilmiş AMD ACML ve Intel MKL'nin farklı versiyonları ile birlikte BLAS, LAPACK, BLACS, SCALAPACK, FFTW vb. gibi pek çok temel matematik kütüphanesinin farklı versiyonları, farklı işlemci aileleri için optimize edilmiş olarak merkezi alanda yüklü bulunmaktadır. Kullanılacak kütüphanenin, mevcut işletim sistemi için derlenmiş olması önemlidir. Bu nedenle kullanılacak modülün mevcut işletim sistemi adı (centos 7.3 veya centos 7.9) ile başlaması ya da eğer modül kullanılmayacaksa, kütüphanelerin /`truba/sw/centos7.3/lib` veya `/truba/sw/centos7.9/lib` dizini altında kurulu olan kütüphanelerden seçilmesi gerekmektedir. 

Intel MKL
----------

Yaptığımız denemelerde, küme üzerinde Intel derleyici ve kütüphanelerinin kullanılmasının, uygulamanın performansını arttırdığı gözlemlenmiştir. Kullanıcıların uygulama derleme sırasında işlemci ailesi ile uyumlu olan Intel derleyicilerini ve kütüphanelerini kullanmaları önerilmektedir. 

MKL kütüphanesi, Intel derleyicileri yüklendiği zaman otomatik olarak kullanılır duruma gelmektedir. Ayrıntılı bilgi için `Intel'in web sayfasını <https://software.intel.com/content/www/us/en/develop/tools.html>`_ ziyaret edebilirsiniz.

MKL kütüphanesinin kullanımı ve özellikleri hakkında detaylı bilgiye `üreticinin web sayfasından <https://software.intel.com/content/www/us/en/develop/tools/oneapi/commercial-base-hpc.html#gs.53rpsw>`_ ulaşılabilir. Ayrıca Intel Developer Forum'da uygulama örneklerine ve diğer kullanıcıların tecrübelerine ulaşılabilir. 


AMD ACML
----------

* centos7.3/lib/acml/5.3.1-gfortan64
* centos7.3/lib/acml/5.3.1-gfortan64_mp
* centos7.3/lib/acml/6.1.0-gfortran64
* centos7.3/lib/acml/6.1.0-gfortan64_mp 

Kütüphanenin farklı versiyonları `/truba/sw/centos7.3/lib/acml/` altında kurulu bulunmaktadır. 

FTW3 
-------

FFTW3'ün 3.3.7 versiyonu altyapıdaki farklı işlemci aileleri için yüklü bulunmaktadır. Aşağıdaki modüller:

Centos 7.3

* centos7.3/lib/fftw/3.3.7-gcc-4.8.5-AMDOPT
* centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V1
* centos7.3/lib/fftw/3.3.7-gcc-4.8.5-E5V3-E5V4
* centos7.3/lib/fftw/3.3.7-gcc-7.0.1-GOLD
* centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V1
* centos7.3/lib/fftw/3.3.7-intel-PS2013-E5V3-E5V4

Centos 7.9

* centos7.9/lib/fftw/3.3.7-impi-oneapi-2021.2-GOLD
* centos7.9/lib/fftw/3.3.7-openmpi-4.1.1-gcc-4.8.5-GOLD
* centos7.9/lib/fftw/3.3.7-openmpi-4.1.1-gcc-7-GOLD


load edilerek kullanılabilir, ya da kurulu olduğu dizinden (Centos7.3 için `/truba/sw/centos7.3/lib/fftw/`, Centos7.9 için `/truba/sw/centos7.9/lib/fftw/`) direk kullanılabilir.


fftw3 modülü yüklendiği zaman, aşağıdaki fftw kütüphanelerine erişim sağlanabilmektedir:

* standart (statik ve dinamik,intel derleyicilerle)
* float (statik ve dinamik,intel derleyicilerle)
* long double(statik ve dinamik,intel derleyicilerle)
* mpi standart (statik ve dinamik, impi ve intel derleyicilerle)
* mpi float (statik ve dinamik, impi ve intel derleyicilerle)
* mpi long double (statik ve dinamik, impi ve intel derleyicilerle) 

BLAS/LAPACAK
--------------

Temel matematik ve matris kütüphaneleridir. Bu kütüphanelerin sağladığı pek çok rutin ACML ve MKL tarafından optimize bir şekilde sağlanmaktadır aynı zamanda. Kütüphanelerin modül bilgileri aşağıdaki gibidir:

* centos7.3/lib/lapack/3.4.2-gcc-4.8.5
* centos7.3/lib/lapack/3.4.2-intel-PS2013
* centos7.3/lib/lapack/3.6.1-gcc-4.8.5-GOLD
* centos7.3/lib/lapack/3.7.0-gcc-4.8.5

İlgili kütüphaneleri kullanmak isteyen kullanıcılar `/truba/sw/centos7.3/lib/lapack` dizini altından da BLAS ve LAPACK kurulumlarını kullanabilirler.


BLACS/SCALAPACK
------------------

LAPACK kütüphanesinin dağıtık kullanılabilmesini sağlayan ve ekstra özellikler getiren matematik ve haberleşme kütüphaneleridir. SCALAPACK kütüphaneleri doğrudan `/truba/sw/centos7.3/lib/scalapack` dizini altından kullanılabilirler.





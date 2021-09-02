-----------------------
oneApI Derleyicileri
-----------------------

Modern bilgisayar mimarilerinde yüksek bilgi işlem performansı elde etmek için optimize olmuş, ölçeklendirilmiş kodlar kullanmak gereklidir. 
İş yükü çeşitliliğinin artmasıyla beraber, yüksek performans için, tek bir mimari her iş için en uygunu olmayabilir. Bu durum  çok çeşitli mimarilere duyulan ihtiyacı artırmıştır.
Gerekli performansı elde etmek için CPU, GPU, AI ve FPGA hızlandırıcılarında dağıtılan  skaler, vektör, matris ve SVMS mimarilerinin bir karışımı gereklidir. Bunların yanında  CPU ve hızlandırıcılar için kodlama
farklı diller, kitaplıklar ve araçlar grektiriyor. Bu durum her bir donanım platformunun tamamen farklı yazılım yatırımları  gerektirdiği anlamına gelir.

oneAPI programlama Data Parallel C++ (DPC++) adlı açık kaynak programlama diliyle, paralelliği ifade etmek için  C++ özelliklerini kullanarak 
CPU'ların ve hızlandırıcıların programlanmasını basitleştirir. oneAPI ayrıca mevcut C/C++ veya Fortran koduyla OpenMP*  özelliğini kullanan CPU'larda 
ve hızlandırıcılarda programlamayı destekler. TRUBA' da oneAPI için çevre değişkenlerini ayarlamak ve module olarak eklemek için:

.. code-block:: bash

   source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

.. note::

   Intel oneApi derleyicisi ücretsiz olarak sunulmaktadır. 

   Ücretsiz sunulan Intel araçlarına ulaşmak için : https://software.intel.com/content/www/us/en/develop/articles/free-intel-software-developer-tools.html


-------

Referans: https://software.intel.com/content/www/us/en/develop/documentation/oneapi-programming-guide/top/introduction-to-oneapi-programming.html


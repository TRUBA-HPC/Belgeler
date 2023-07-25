=====================================================
Source Code Kullanarak Python Kurulumu
=====================================================

Aşağıdaki komutu terminalimizide çalıştırırız. Bu adım TRUBA sunucumuza bağlanmak için gereklidir. 
.. code-block:: console

    ssh -l [kullanıcı_adı]  [bağlanmak istediğimiz TRUBA sunucusu].ulakbim.gov.tr

1.Source Code indirilir. (Python 3.10.12 versiyonu için gereken komut satırı aşağıda verilmiştir. İndirilmek istenen versiyona göre güncellenebilir.)

.. code-block:: bash

    wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz

2.İndirdiğimiz .tgz uzantılı dosyayı yapılandırmak için :
.. code-block:: bash
  tar xvf Python-3.10.12.tgz
  cd Python-3.10.12 
  ./configure --enable-optimizations --with-ensurepip=install --prefix=/truba/home/{kullanıcı_adı} --with-pydebug komutunu kullanırız.
  make 
  make install
komutları sırasıyla uygulanır.
          
**Bu işlemleri yaparken PATH girdinize dikkat etmenizi öneririz. PATH ortam değişkenini tanımlamak için
 .bashrc dosyasından yararlanabilirsiniz.**

===================================
.bashrc dosyası
===================================
Kullanıcıların terminali kullanırken hazır olarak çalışmasını istediği bir dosyadır. 
- Ortam değişkenlerini ayarlama: .bashrc dosyası, PATH, PS1, EDITOR vb. gibi ortam değişkenlerini tanımlayabilir veya değiştirebilir. 
- Kısayol komutları tanımlama: `.bashrc` dosyası, sık kullanılan komutları veya uzun komut zincirlerini kısayol olarak tanımlayabilir.
- Alias (takma ad) tanımlama: `.bashrc` dosyası, sık kullanılan komutlara veya komut dizilerine takma adlar (alias) atayabilir.

.. code-block:: console
 .bashrc dosyasını vi[]() editörünü kullanarak düzenleyebilirsiniz. Python dosyasını kurarken prefix olarak /truba/home/{kullanıcı_adı} kullandığınızı varsayarsak kullanmanız gereken PATH değişkeni aşağıda verilmiştir.

.. code-block:: bash
 export LD\_LIBRARY\_PATH="/truba/home/bgorgun/sw/python3.10/lib:$LD\_LIBRARY\_PATH"
 export PATH="/truba/home/bgorgun/sw/python3.10/bin/:$PATH"
 alias python="python3"

   
Son adımda kontrol etmek için `python --version` komutunu çalıştırdığınızda yüklemek istediğiniz Python versiyonuna ulaşmalısınız.
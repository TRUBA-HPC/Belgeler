.. _R_Source_code:

==============================================
Kaynak kod kullanılarak R kurulumu 
==============================================
Kaynak koddan kurulum için :ref:`genelkurulum-kilavuzu` inceleyebilirsiniz.
Sistemimizde var olan R'ın farklı versiyonları kurmak için temelde şu adımlar izlenebilir.

- R kaynak kodu indir
- Dosyayı aç
- Klasör içine gir
- ./configure
- make 
- make install

Detaylı kurulum aşamaları ve yardım için şu sayfalar ziyaret edilebilir:

- `R Installation and Administration <https://cran.r-project.org/doc/manuals/r-patched/R-admin.html>`_
- `Install R from Source <https://docs.posit.co/resources/install-r-source/>`_
- `Using Intel® oneAPI Math Kernel Library (oneMKL) with R <https://www.intel.com/content/www/us/en/developer/articles/technical/using-onemkl-with-r.html>`_
Kurulum işlemlerimizi interaktif yapmak için bir sunucu isteyebiliriz.

.. code-block:: bash

    srun -N 1 -A iguzel -p hamsi --ntasks-per-node=28 --time=01:00:00 --job-name "R-install" --pty bash -i

``iguzel`` kullanıcı adını kendi kullanıcı adınız ile değiştirmelisiniz.

Sunucu gelip gelmediğini bağlı olunan makine ismine bakarak öğrenebiliriz.

.. code-block:: bash

    hostname


gcc ile derlenmiş R versiyonu kurmak için 
--------------------------------------------

.. code-block:: bash
    
    # İşlemleri hızlı yapabilmek için sunucu içinde klasöre geçiyoruz. 
    cd /tmp/
    # Yüklü modülleri kaldırıp derleyicimizi yüklüyoruz.
    module purge
    module load centos7.9/comp/gcc/7
    
    # R kaynak kodu indiriyoruz.
    wget https://cran.rstudio.com/src/base/R-4/R-4.2.2.tar.gz
    # Sıkıştırılmış dosyayı açıyoruz.
    tar -xzvf R-4.2.2.tar.gz
    # Kodumuzun bulunduğu dizine geçiş yapıyoruz.
    cd R-4.2.2
    
    # Programın kurulacağı dizini belirtiyoruz.
    install_dir_gcc=/truba/home/kullanici_adiniz/R/R-4.2.2-gcc
    
    # Kurulum öncesi derleyici ile birlikte ayarlıyoruz.
    ./configure --with-pcre1=yes --prefix=$install_dir_gcc --enable-memory-profiling --enable-R-shlib
    
    # Derleme işlemini 28 core ile yapıyoruz
    make -j28
    # prefix ile belirtilen dizine kurulum yapıyoruz.
    make install


intel ile derlenmiş R versiyonu kurmak için 
--------------------------------------------

.. code-block:: bash
    
    # İşlemleri hızlı yapabilmek için sunucu içinde klasöre geçiyoruz. 
    cd /tmp/
    # Yüklü modülleri kaldırıp derleyicimizi yüklüyoruz.
    module purge
    source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh intel64

    # R kaynak kodu indiriyoruz.
    wget https://cran.rstudio.com/src/base/R-4/R-4.2.2.tar.gz
    # Sıkıştırılmış dosyayı açıyoruz.
    tar -xzvf R-4.2.2.tar.gz
    # Kodumuzu bulunduğu dizine geçiş yapıyoruz.
    cd R-4.2.2

    # Programın kurulacağı dizini belirtiyoruz.
    install_dir_intel=/truba/home/kullanici_adiniz/R/R-4.2.2-intel

    # Kurulum öncesi derleyici ile birlikte ayarlıyoruz.
    export CC="icc"
    export CXX="icpc"
    export F77="ifort"
    export FC="ifort"
    MKL=" -L ${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl "
    ./configure --with-pcre1=yes --prefix=$install_dir_intel --enable-R-shlib --enable-memory-profiling --with-blas="$MKL" --with-lapack=yes
    
    # Derleme işlemini 28 core ile yapıyoruz
    make -j28
    # prefix ile belirtilen dizine kurulum yapıyoruz.
    make install
    


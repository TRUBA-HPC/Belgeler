.. _R_Source_code:

==============================================
Kaynak kod kullanılarak R kurulumu 
==============================================

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

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Kurulum için yönergeler (Tıklayınız)
    :color: info

    .. tab-set:: 

        .. tab-item:: GCC

            .. code-block:: bash
                
                    # İşlemleri hızlı yapabilmek için sunucu içinde klasöre geçiyoruz. 
                    cd /tmp/
                    # Yüklü modülleri kaldırıp derleyicimizi yüklüyoruz.
                    module purge
                    module load comp/gcc/14.1.0
                    
                    # R kaynak kodu indiriyoruz.
                    wget https://cran.rstudio.com/src/base/R-4/R-4.2.2.tar.gz
                    # Sıkıştırılmış dosyayı açıyoruz.
                    tar -xzvf R-4.2.2.tar.gz
                    # Kodumuzun bulunduğu dizine geçiş yapıyoruz.
                    cd R-4.2.2
                    
                    # Programın kurulacağı dizini belirtiyoruz.
                    install_dir_gcc=/arf/home/kullanici_adiniz/R/R-4.2.2-gcc
                    
                    # Kurulum öncesi derleyici ile birlikte ayarlıyoruz.
                    ./configure --with-pcre1=yes --prefix=$install_dir_gcc --enable-memory-profiling --enable-R-shlib
                    
                    # Derleme işlemini 28 core ile yapıyoruz
                    make -j28
                    # prefix ile belirtilen dizine kurulum yapıyoruz.
                    make install
        
        .. tab-item:: Intel

            .. code-block:: bash

                # İşlemleri hızlı yapabilmek için sunucu içinde klasöre geçiyoruz. 
                cd /tmp/
                # Yüklü modülleri kaldırıp derleyicimizi yüklüyoruz.
                module purge
                module load comp/oneapi/2022
                # R kaynak kodu indiriyoruz.
                wget https://cran.rstudio.com/src/base/R-4/R-4.2.2.tar.gz
                # Sıkıştırılmış dosyayı açıyoruz.
                tar -xzvf R-4.2.2.tar.gz
                # Kodumuzu bulunduğu dizine geçiş yapıyoruz.
                cd R-4.2.2

                # Programın kurulacağı dizini belirtiyoruz.
                install_dir_intel=/arf/home/kullanici_adiniz/R/R-4.2.2-intel

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



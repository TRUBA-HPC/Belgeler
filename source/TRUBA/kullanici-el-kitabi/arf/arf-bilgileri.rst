.. _arf-bilgileri:

=======================
ARF Hesaplama Kümesi
=======================

2023 yılı sonunda MODSIMMER Veri Merkezi'nde kurulumu gerçekleştirilen ve ARF ismini verdiğimiz yeni hesaplama kümemiz test kullanımına açılmış bulunmaktadır. Kümenin genel özellikleri aşağıdaki gibidir:

- Hesaplama sunucu sayısı: 504
- Hesaplama sunucu adı: orfoz[1-504]
- İşlemci:  2x Intel(R) Xeon(R) Platinum 8480+ (toplam 112 çekirdek)
- Bellek:   256 GB
- Network: 200Gbit NDR infiniband
- Tmp : 750GB name
- Merkezi depolama : `/arf` (1.6Pbyte)
- Ev dizini: `/arf/home`
- Yazılım: `/arf/sw/(apps,comp,lib)`
- İşletim sistemi: Rocky Linux 9.2

Güncel kurulu yazılımları 

.. code-block:: bash

	module available

komutu ile listeleyebilirsiniz. Aşağıda örnek kurulu olan modülleri bulabilirsiniz. 

.. dropdown::  :octicon:`codespaces;1.5em;secondary` Yüklü Modüller (Tıklayınız)
    :color: info
    
    .. tab-set:: 

        .. tab-item:: apps

            .. code-block:: bash

				apps/espresso/7.2-oneapi-2023.0           
				apps/gromacs/2023.3                       
				apps/gromacs/2024.1-oneapi2024            
				apps/julia/1.10.0                         
				apps/lammps/2Aug2023_update2-oneapi-2024  
				apps/matlab/2024a        
				apps/namd/2.14-ibverbs                                  
				apps/openfoam/11                                        
				apps/openfoam/v2312                                     
				apps/R/4.3.0-gcc-11.3.1                                 
				apps/R/4.3.2-oneapi-2024.0                              
				apps/rstudio/2023.12.1-402
				apps/siesta/4.1.5-oneapi-2023.0
				apps/wannier90/3.1.0-oneapi-2023.0
				apps/wannier90/3.1.0-oneapi-2024.0
				apps/wrf/4.5.2-hdf5-1.14.3-pnetcdf-netcdf-oneapi-2023.0                 

        .. tab-item:: comp

            .. code-block:: bash

				comp/cmake/3.28.1
				comp/nvhpc/nvhpc-23.11
				comp/oneapi/2022
				comp/oneapi/2023
				comp/oneapi/2024
				comp/python/3.12.0
				comp/python/ai-tools
				comp/python/data-analytics
				comp/python/intelpython3
				comp/python/miniconda3

        .. tab-item:: lib

            .. code-block:: bash

				lib/fftw/3.3.10-impi-oneapi-2024
				lib/hdf5/1.14.3-oneapi-2023.0
				lib/hdf5/1.14.3-oneapi-2024
				lib/hdf5/1.14.3-serial-oneapi-2023.0
				lib/hdf5/1.14.3-serial-oneapi-2024
				lib/libxc/6.2.2-oneapi-2023.0
				lib/netcdf/c-4.9.2-fortran-4.6.1-cxx-4.3.1-oneapi-2023.0
				lib/netcdf/netcdf-c-4.9.2-oneapi-2023.0
				lib/openblas/0.3.25
				lib/openmpi/5.0.0
				lib/pnetcdf/1.12.3-oneapi-2023.0
				lib/pnetcdf/1.13.0-oneapi-2024            
		                
Diğer hesaplama kümelerinde olduğu gibi, ARF hesaplama kümesinde de kota uygulaması mevcuttur. Küme test aşamasında olduğu için ev dizini kotaları  (kapasite ve dosya sayısı) düşük tutulmuştur. Şu an için güncel kotalar aşağıdaki gibidir:

.. code-block::

	Kapasite: 100GB 
	Dosya sayısı: 100K 

ARF kümesine ayrılmış disk alanı (/arf) , mevcut disk alanından (/truba) tamamen bağımsızdır. Sadece kullanıcı arayüzü sunucularının /truba depolama sistemine erişimi vardır. Hesaplama sunucularının /truba dosya sistemine erişimi yoktur. O nedenle kullanıcılar, verilerini /arf/home/$USER dizinine taşımalı, ihtiyaç duyduğu uygulamaları yine bu dizine kurmalıdır. 
 
Arf dosya sisteminin kapasitesi kısıtlı olduğu için kullanıcılar  sadece çalışacakları verileri bu dosya sistemine taşımalı, ihtiyaç ortadan kalktıktan sonra, sistemden silmeli ya da /truba dosya sistemine taşımalıdır. Dosya sayısı kısıtından dolayı kullanıcılar ev dizinlerine Anaconda, miniconda ya da türevlerini kurmamalıdır.

ARF kümesinde yer alan orfoz sunucularına bağlanmak için ilgili bilgilere :ref:`hesaplama-kumeleri` sayfasında yer alan :ref:`orfoz` içeriğinden erişebilirsiniz.


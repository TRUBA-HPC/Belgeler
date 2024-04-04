.. _arf-kumesi:

=======================
ARF Hesaplama Kümesi
=======================

2023 yılı sonunda MODSIMMER Veri Merkezi'nde kurulumu gerçekleştirilen ve ARF ismini verdiğimiz yeni hesaplama kümemiz test kullanımına açılmış bulunmaktadır. Kümenin genel özellikleri aşağıdaki gibidir:

Kullanıcı arayüzü sunucuları: 

.. code-block::

	arf-ui1.yonetim (172.16.6.11) 

.. code-block::

	arf-ui2.yonetim (172.16.6.12)

- Hesaplama sunucu sayısı: 504
- Hesaplama sunucu adı: orfoz[1-504]
- İşlemci  2x Intel(R) Xeon(R) Platinum 8480+ (toplam 112 çekirdek)
- Bellek   256 GB
- Network: 200Gbit NDR infiniband
- Tmp : 750GB name
- Merkezi depolama : /arf (1.6Pbyte)
- Ev dizini /arf/home
- Yazılım /arf/sw/(app,comp,lib,cont,src)
- İşletim sistemi: Rocky Linux 9.2

- Kurulu yazılımlar

	- Derleyiciler:
		- GCC 11.3.1
		- Intel Oneapi 2024
		- Intel Oneapi 2023
		- Intel Oneapi 2022
		- NVHPC
			
	- Paralel kütüphaneler:
		- OpenMPI-5.0.0
		- Intel-MPI (intel oneapi 2022,2023,2024)
		      
	- Matematik kütüphaneleri:
		- MKL (intel oneapi 2022,2023,2024)
		- fftw
		- openblas
			
	- Yüklü uygulamalar:
		- NAMD
		- Gromacs
		- Julia
		- openfoam	
		- R
		- Siesta
		- Matlab
		- LAMMPS
			
	- Yardımcı Kütüphaneler:
		- hdf5 (zlib,szip)
		- jasper
		- libpng
		- NetCDF (NetCDF-c, NetCDF-fortran, NetCDF-cxx)
		- PNetCDF
		- r-env


Diğer hesaplama kümelerinde olduğu gibi, ARF hesaplama kümesinde de kota uygulaması mevcuttur. Küme test aşamasında olduğu için ev dizini kotaları  (kapasite ve dosya sayısı) düşük tutulmuştur. Şu an için güncel kotalar aşağıdaki gibidir:

.. code-block::

	Kapasite: 100GB 
	Dosya sayısı: 100K 

ARF kümesine ayrılmış disk alanı (/arf) , mevcut disk alanından (/truba) tamamen bağımsızdır. Sadece kullanıcı arayüzü sunucularının /truba depolama sistemine erişimi vardır. Hesaplama sunucularının /truba dosya sistemine erişimi yoktur. O nedenle kullanıcılar, verilerini /arf/home/$USER dizinine taşımalı, ihtiyaç duyduğu uygulamaları yine bu dizine kurmalıdır. 
 
Arf dosya sisteminin kapasitesi kısıtlı olduğu için kullanıcılar  sadece çalışacakları verileri bu dosya sistemine taşımalı, ihtiyaç ortadan kalktıktan sonra, sistemden silmeli ya da /truba dosya sistemine taşımalıdır. Dosya sayısı kısıtından dolayı kullanıcılar ev dizinlerine Anaconda, miniconda ya da türevlerini kurmamalıdır.

ARF kümesinde yer alan orfoz sunucularına bağlanmak için ilgili bilgilere :ref:`hesaplama-kumeleri` sayfasında yer alan :ref:`orfoz` içeriğinden erişebilirsiniz.


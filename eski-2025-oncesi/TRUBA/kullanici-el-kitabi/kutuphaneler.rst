==================================
Mevcut Uygulamalar ve Kütüphaneler
==================================

TRUBA altyapısını kullanan araştırmacılarımızın kullanımına sunulmuş, farklı işletim sistemleri ve farklı işlemci mimarileri için derlenmiş, lisansı ücretsiz (açık kaynak kodlu) uygulamalar merkezi yazılım alanına (/truba/sw) yüklenmiş bulunmaktadır. Hiyerarşik olarak uygulamalar ``app``, kütüphaneler ``lib`` ve derleyiciler ``comp`` dizinine yerleştirilmiştir.

Quantum Espresso, NAMD, LAMMPS, Amber vb. gibi sık kullanılan açık kaynak  kodlu uygulamaların, LAPACK, Blas, FFTW, PETSc, MKL gibi kütüphanelerin ve Intel derleyicilerinin farklı versiyonları yazılım dizinlerine yüklenmiştir. Yazılımların yeni versiyonları çıktıkça ve talep oldukça yeni yazılımlar, yeni versiyonlar yüklenilmeye devam edilecektir.

.. note::
   TRUBA sisteminde ortak alanda bulunan yazılımlar tüm kullanıcılar düşünülerek hazırlandığı için genel opsiyonları ile derlenmiştir. İşlemci mimarisi için geçerli olan optimizasyonların haricinde, sunucu ailelerinde herhangi bir optimizasyon yapılmamıştır. Bu nedenle uygulamalar kullanıcıların bekledikleri performansları veremeyebilirler, ya da yapmak istedikleri hesaplama türünü gerçekleştiremiyor olabilirler. Bu ve benzeri durumlar için, kullanıcıların kullanmak istedikleri uygulamaları kendi ev dizinlerinde kendilerinin derlemelerini, ihtiyaç duydukları optimizasyonu gerçekleştirmelerini öneriyoruz.

Lisansı ücretli olan yazılımlar, küme üzerinde çalışmasına izin verecek lisans edinildikten sonra kullanıcı tarafından kendi ev dizininde derlenmeli ve oraya yüklenmelidir. Bu tür yazılımların lisansları, kullanımları, kurulumları vb. konularda her türlü sorumluluk kullanıcının kendisine aittir. Eğer yüklenecek lisanslı yazılım ``floating`` ya da benzeri bir lisanslama modeli ile lisans doğrulama servisine (flexlm vs) ihtiyaç duyuyorsa, ilgili servis kullanıcının kendi kurumu tarafından sağlanmalı ve buradaki hesaplama sunucularının bu servise erişmesine izin verilmelidir.

+-------------------+-----------+-----------+------------+
| Küme üzerinde sıklıkla kullanılan uygulamalar 	 |
+===================+===========+===========+============+
| Quantum Espresso  |	NAMD	| Amber     |	Siesta	 |
+-------------------+-----------+-----------+------------+
| Abinit            |	LAMMPS 	| Gamess    |	Gromacs	 |
+-------------------+-----------+-----------+------------+
| Gaussian	    |	Vasp	| Matlab    |	OpenFOAM |
+-------------------+-----------+-----------+------------+

+----------------+-----------+-----------+------------+
| Mevcut kütüphaneler                                 |
+================+===========+===========+============+
| BLAS/LAPACK    | SCALAPACK |  MKL      | ACML       |
+----------------+-----------+-----------+------------+
| FFTW           | CUDA      | OpenMPI   | Intel MPI  |
+----------------+-----------+-----------+------------+

+--------------------------------------+--------------------------------------+
| Mevcut derleyiciler                                                         |
+======================================+======================================+
| GNU derleyicileri                                                           |
+--------------------------------------+--------------------------------------+
| Intel derleyicileri:                                                        |
+--------------------------------------+--------------------------------------+
| * Intel composer XE 2013 sp1         |  * Intel Parallel Studio2016 update3 |
+--------------------------------------+--------------------------------------+
| * Intel Parallel Studio2017 update1  |  * Intel Parallel Studio2018 update2 |
+--------------------------------------+--------------------------------------+
| * Intel Parallel Studio2019 update1                                         |
+--------------------------------------+--------------------------------------+
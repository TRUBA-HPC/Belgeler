==================================================================================
Hesaplamalı Akışkanlar Dinamiği (HAD) / Computational Fluid Dynamics (CFD) - Giriş
==================================================================================

Hesaplamalı Akışkanlar Dinamiği (HAD), akışkanlar dinamiği problemlerinin 
(akışkanlar mekaniği ve ısı transferi problemlerinin) analizi ve çözümlenmesi
için sayısal yöntem ve algoritmaların kullanıldığı bir akışkanlar dinamiği 
bilimi dalıdır. Sıvı ve gazların katı yüzeyler ile etkileşimleri ve bu katı 
cisimlerin etrafındaki ve/veya içindeki akış alanları bilgisayar yardımı ile 
çözülür. HAD simülasyonlarının doğruluğu kullanılan matematiksel model ve 
sayısal yöntemlere bağlıdır. Çoğunlukla, paralel bilgisayarlar kullanılarak 
HAD simülasyonları yapılır.

**Hesaplamalı Akışkanlar Dinamiği Simülasyon Adımları (CFD Steps)**

* Ön-işlem Adımları (Pre-processing Steps)
   * Geometri Tanımı ve Katı Modelleme (Solid Modelling)
   * Çözüm Ağı Oluşturma (Grid Generation)
   * Çözüm Ağı Bölünme (Domain Decomposition)
* Akış Çözücü ile Hesaplamalar (Computations with Flow Solver)
   * HAD Simülasyonları (CFD Computations)
* Art-işlem Adımları (Post-processing Steps)
   * Hesaplama sonuçlarının değerlendirilmesi (Evaluation of Computational Results)
   * Görüntüleme (Visualization)

.. figure:: /assets/cfd-education/intro/CFDSteps.png
   :align: center
   :figwidth: 600px

   Şekil 1. Hesaplamalı Akışkanlar Dinamiği Simülasyon Adımları.

**Akışkanlar Dinamiği Temel Denklemleri (Fluid Dynamics Governing Equations)**

En temel denklemlerden çeşitli varsayımlarla basitleştirilmiş denklemlere 
akışkanlar dinamiği temel denklemleri (governing equations) aşağıdaki gibi 
sıralanabilir.

* Boltzmann Denklemleri
* Navier Stokes Denklemleri
* Euler Denklemleri
* Tam Potansiyel Denklemi
* Prandtl-Glauert Denklemi / Dalga Denklemi
* Potansiyel Denklemi / Laplace Denklemi

.. figure:: /assets/cfd-education/intro/CFDEqns.png
   :align: center
   :figwidth: 600px

   Şekil 2 . Akışkanlar Dinamiği Temel Denklemleri.

**HAD Simülasyonları (CFD Simulations)**

Hesaplamalı Akışkanlar Dinamiği (HAD) simülasyonlarında, çözülen akışlar 
aşağıdaki özelliklere sahip olabilirler:

* 2-boyutlu (2-D) / 3-boyutlu (3-D) / 4-boyutlu: 3-boyutlu ve zamana bağlı (3-D and unsteady)
* Daimi (Steady-state) / Zamana bağlı (Unsteady)
* Seyreltilmiş (Rarefied) / Sürekli Ortam (Continuum)
* Viskoz olmayan (Inviscid) / Viskoz (Viscous)
* Dönmeli (Rotational) / Dönmesiz (Irrotational)
* Sıkıştırılamaz (Incompressible) / Sıkıştırılabilir (Compressible)
* Doğrusal (Linear) / Doğrusal olmayan (Nonlinear)

**Sayısal Ayrıklaştırma Yöntemleri (Numerical Discretization Approaches)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde farklı sayısal 
ayrıklaştırma yöntemleri kullanılabilir:

* Sonlu Farklar Yöntemleri (Finite Difference Methods)
* Sonlu Hacim Yöntemleri (Finite Volume Methods)
* Sonlu Eleman Yöntemleri (Finite Element Methods)
* Spektral Yöntemler (Spectral Methods)
* Ağsız Yöntemler (Meshless Methods)

**Sayısal Yöntemler (Numerical Methods - Approximate Solution Methods)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme uygun 
farklı sayısal yöntemler kullanılır:

* Zamanda ilerleme yöntemleri (Zamana bağlı problem)
* Yinelemeli yöntemler (Daimi problem)
* Akı hesaplama yöntemleri (Sonlu Fark veya Sonlu Hacim)

**Sınır Koşulları (Boundary Conditions)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme uygun 
farklı sınır koşulları kullanılır:

* Duvar Sınır Koşulu (Wall Boundary Condition)
* Serbest Akış Sınır Koşulu (Freestream Boundary Condition)
* …

**Başlangıç Koşulları (Initial Conditions)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme uygun 
farklı başlangıç koşulları kullanılır:

* Başlangıç Akış Alanı Koşulu (Initial Flow Field Condition)
* Başlangıç Türbülans Koşulları (Initial Turbulence Conditions)
* …

**Çözüm Ağları (Computational Grids) ve Çözüm Ağı Oluşturma (Grid Generation)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme ve 
kullanılan sayısal yöntemlere uygun farklı çözüm ağları oluşturulur:

* Yapısal Çözüm Ağları (Structured Grids)
   * O-type
   * H-type
   * C-type
   * C-H type
   * Multi-Block
   * …
* Yapısal Olmayan Çözüm Ağları (Unstructured Grids)
* Karışık/Hibrit Çözüm Ağları (Mixed/Hybrid Grids)
* Üstüste Çözüm Ağları (Overset/Chimera Grids)

**Türbülans Modelleme (Turbulence Modeling)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme, akış ile
ilgili varsayımlara ve kullanılan sayısal yöntemlere uygun farklı türbülans 
modelleri kullanılır:

* DNS
* LES
   * SGS
* RANS
   * SA
   * k-epsilon
   * k-omega
   * k-omega-SST
   * RSM

**Duvar Fonksiyonları (Wall Functions)**

Hesaplamalı Akışkanlar Dinamiği (HAD) ile akış çözümlerinde probleme, akış ile
ilgili varsayımlara, kullanılan sayısal yöntemlere ve kullanılan türbülans 
modelleri ve çözüm ağlarına uygun duvar sınır koşullarını sağlamak için 
farklı duvar fonksiyonları kullanılır: 

* Log-Law Sınır Tabaka Modeli
* ...

**Geçiş Modelleri (Transition Models)**

Kanat kesiti/kanat aerodinamik hesaplamaları için Hesaplamalı Akışkanlar 
Dinamiği (HAD) ile akış çözümlerinde probleme, akış ile ilgili varsayımlara, 
kullanılan sayısal yöntemlere ve kullanılan türbülans modellerine uygun 
farklı sınır tabaka geçiş modelleri kullanılır:

* ...
  
Açık Kaynaklı HAD Yazılımları (Open Source CFD Software)
========================================================
* `OpenFOAM <https://www.openfoam.com>`_
* `SU2 <https://su2code.github.io>`_
* `Basilisk <http://basilisk.fr>`_
* `Nektar++ <https://www.nektar.info>`_
* ...
  
Çözüm Ağı Oluşturma Yazılımları (Grid Generation Software)
==========================================================

* `Gmsh <https://gmsh.info>`_
* `Salome <https://www.salome-platform.org>`_
* ...

Görüntüleme Yazılımları (Visualization Software)
================================================

* `Gnuplot <http://www.gnuplot.info>`_
* `Visit <https://hpc.llnl.gov/software/visualization-software/visit>`_
* `Paraview <https://www.paraview.org>`_
* `pgfplots <https://pgfplots.net>`_
* ...

----------

**EuroCC@Turkey Kış Okulu** "*Hesaplamalı Akışkanlar Dinamiği'ne Giriş 
ve Aerodinamik Simülasyonlar*" (Dr. Nilay SEZER UZOL, 9 Şubat 2021) ders notlarından hazırlanmıştır.

Şekil 1 ve Şekil 2: Prepared by Dr. Nilay SEZER UZOL, Haziran 2021.

----

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.

.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
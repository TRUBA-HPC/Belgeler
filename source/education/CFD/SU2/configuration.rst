.. |SU2| replace:: SU2

**********************
4 - Çalıştırma Dosyası
**********************
|SU2| yazılımının kurulumundan ve Çözüm ağı dosyasının hazırlanmasından sonra
çalıştırma dosyasını hazırlanması gerekir. Dosya ismi (``.su2``) olarak 
hazırlanır. Dosya içeriği şu şekildedir:

* Yukarıda belirtildiği gibi, |SU2|, farklı türde fiziksel problemleri 
  çözebilmektedir. Bu amaçla, girdi dosyasında ``SOLVER`` seçeneği kullanılarak
  problemin türü tanımlanır. Bu kılavuzda sadece sıkıştırılabilir akışlar için
  bilgi verilmiştir. İlgili çözücüler ``EULER`` ve ``NAVIER_STOKES`` olarak 
  verilmiştir. Diğer çözücüler için |SU2| rehberine başvurabilirsiniz.
* Bir simülasyon, önceki bir hesaplamada kaldığı yerden yeniden başlatılabilir.
  Bunun için ``RESTART_SOL`` parametresi kullanılır. Zamana bağlı bir problemde
  yeniden başlatma gerekiyorsa, ek olarak ``RESTART_ITER``, parametresi ile 
  yeniden başlatmak istediğiniz zaman ayarlanır:

.. code-block:: text
   
   % ------------------------- Çözücü ayarları -------------------------------%
   %
   % Çözücü Tipi EULER/NAVIER_STOKES 
   SOLVER= EULER
   %
   % Çözüm kaldığı yerden başlasın mı? (NO, YES)
   RESTART_SOL= NO
   %
   % Zamana bağlı akışlar için hangi adımdan yeniden başlasın 
   % (sadece RESTART_SOL= YES durumunda dikkate alınır)
   RESTART_ITER= 0
   %

* Eğer zamana bağlı bir simülasyon gerçekleştirecekseniz, ``TIME_DOMAIN`` 
  parametresi ile bunu kontrol edebilirsiniz. Eğer zamana bağlı bir simülasyon
  yapıyorsanız, her simülasyon adımının saniye cinsinden ne kadar olduğunu ve
  de azami kaç saniyeye kadar benzetimi gerçekleştireceğiniz belirtmelisiniz. 
  Ayrıca zaman adımlarının sayısını da verebilirsiniz.
* ``INNER_ITER`` parametresi, zamana bağlı akışlar için bir zaman adımı için 
  kaç iterasyon gerektirdiğini gösterirken, zamandan bağımsız akışlar için de 
  azami iterasyon sayısını gösterir. Zamandan bağımsız akışlar için ``ITER`` 
  parametresi de kullanılabilir.

.. code-block:: text

   % ------------------------- Zamana bağlı benzetim parametreleri -------------------------------%
   % zamandan bağımsız ise aşağıdaki parametreyi NO yapın
   TIME_DOMAIN= YES
   %
   % Zaman adımı (s)
   TIME_STEP= 1.0
   %
   % Toplam fiziksel zaman (s)
   MAX_TIME= 50.0
   %
   % iç iterasyon sayısı. Zamandan bağımsız benzetim için ITER de kullanılabilir. 
   INNER_ITER= 200
   %
   % Zaman adımı sayısı.
   TIME_ITER= 200
   %

* Benzetim için eğer tek hacim var ise ağ dosyasını vermelisiniz. Ağ dosyası 
  |SU2| formatında ya da derlenme durumuna göre CGNS formatında olabilir.
* Eğer yeniden başlatma isteyecekseniz, bunu ``RESTART_FLOW`` dosyası ile 
  sağlayabilirsiniz.
* Çıktı dosyalarını tablo halinde isterseniz, *TECPLOT* veya *CSV* formatında
  alabilirsiniz.
* Çözüm hacmi içerisinde art işlemlemeye uygun dosyaları TECPLOT, *PARAVIEW 
  (VTK)* formatlarında alabilirsiniz. Diğer opsiyonlar için |SU2| 
  dokümantasyonuna referans verilmektedir. 
* Yakınsama grafikleri sadece isim verildiğinde dosyaya yazılacaktır.
* Her parça için kuvvet ve momentler ``BREAKDOWN_FILE`` ile belirtilir. 
  Özellikle dış akışlarda kuvvet yakınsamasını gözlemek daha faydalı olacaktır.

.. code-block:: text

   % ------------------------- Girdi-Çıktı Dosyaları --------------------------%
   %
   % Ağ girdi dosyası
   MESH_FILENAME= mesh_NACA0012_inv.su2
   %
   % Ağ girdi dosyası formatı (SU2, CGNS)
   MESH_FORMAT= SU2
   %
   % Ağ çıktı dosyası
   MESH_OUT_FILENAME= mesh_out.su2
   %
   % Yeniden başlatma dosyası ismi
   SOLUTION_FILENAME= solution_flow.dat
   %
   % Çıktı tablo formatı (TECPLOT, CSV)
   TABULAR_FORMAT= TECPLOT
   %
   % Çıktı dosyaları
   % Çıktı format tipleri : (TECPLOT, TECPLOT_BINARY, SURFACE_TECPLOT,
   % SURFACE_TECPLOT_BINARY, CSV, SURFACE_CSV, PARAVIEW, PARAVIEW_BINARY, SURFACE_PARAVIEW,
   % SURFACE_PARAVIEW_BINARY, MESH, RESTART_BINARY, RESTART_ASCII, CGNS, STL)
   % default : (RESTART, PARAVIEW, SURFACE_PARAVIEW)
   OUTPUT_FILES= (RESTART, PARAVIEW, SURFACE_PARAVIEW)
   %
   % Yakınsama dosyası ismi (uzantısı olmadan)
   CONV_FILENAME= history
   %
   % Kuvvetler çıktı dosyası 
   BREAKDOWN_FILENAME= forces_breakdown.dat
   %
   % Yeniden başlatma için çıktı dosyası
   RESTART_FILENAME= restart_flow.dat

* Çözeceğiniz problem tipine göre çözücü tipi ``SOLVER`` parametresi ile 
  belirlenir. İlgili kısım için çözücüler ile ilgili kılavuza 
  başvurabilirsiniz.
* Eğer Navier-Stokes denklemleri çözecekseniz, bir türbülans modeli 
  seçmelisiniz. Spalart-Almaras ve SST modelleri ve varyantları için ilgili 
  bölüm ve `NASA Türbülans modelleri`_ sitesine başvurabilirsiniz.
* |SU2| transition modeli olan Baş-Çakmakçı modelini kullanabilmektedir. 
* Eğer çözümünüz eksenel simetrik ise bunu çözücü ayarlarında belirtmelisiniz. 
  Eksenel simetrik simülasyonlar sadece sıkıştırılabilir akışlar için 
  sağlanmıştır.

.. code-block:: text

   % Çözücü tipi (EULER, NAVIER_STOKES, RANS,
   % INC_EULER, INC_NAVIER_STOKES, INC_RANS,
   % NEMO_EULER, NEMO_NAVIER_STOKES,
   % FEM_EULER, FEM_NAVIER_STOKES, FEM_RANS, FEM_LES,
   % HEAT_EQUATION_FVM, ELASTICITY)
   SOLVER= EULER
   %
   % Türbülans modeli (NONE, SA, SA_NEG, SST, SA_E, SA_COMP, SA_E_COMP, SST_SUST)
   KIND_TURB_MODEL= NONE
   %
   % Transition modeli (NONE, BC)
   KIND_TRANS_MODEL= NONE
   % Eksenel simetrik simülasyon (NO, YES)
   AXISYMMETRIC= NO

.. _NASA Türbülans modelleri: https://turbmodels.larc.nasa.gov
******************
3 - Teori Kılavuzu
******************
3.1 - SU2 nedir ve hangi akışlarda kullanılabilir?
====================================================
SU2 Stanford Üniversitesinde ortaya çıkmış, Sabit kanat hava aracı 
üreticileri ile birlikte açık kaynak olarak geliştirilmesi ivmelendirilmiş bir
Hesaplamalı Akışkanlar Dinamiği (HAD) yazılımıdır. Dolayısı ile, aşağıdaki 
analiz koşulları için oldukça iyi bir seçenektir. Bu kılavuz da bu akışlar 
için gerekli teorik ve pratik bilgiyi vermeyi amaçlamaktadır.

* Tarihsel olarak SU2 sıkıştırılabilir akışlar için geliştirilmiştir. 
  Dolayısı ile yazılımın en güçlü olduğu taraf sıkıştırılabilir akışlardır.
* Sabit kanatlı uçak geliştirme hedefine uygun olarak Adjoint temelli bir 
  optimizasyon algoritmasına sahiptir.
* Hem ağdalı hem de ağdasız akışlar için çözücüleri mevcuttur.

Aşağıdaki özellikler ise zaman içerisinde eklenmiş olup, daha az olgun kabul
edilebilir:

* Sıkıştırılamaz akışlar
* Isı transferi modülü
* Çakışmayan ağlar
* Çok Bloklu çözücüler
* ve diğerleri...

3.2 - Temel Denklemler
======================
Herhangi bir akışkan bir maddenin korunumu, üç adet momentum korunumu, bir 
enerji korunumu denklemi ile bu denklem parametrelerini birbirine bağlayan bir
hâl denklemi (state equation) ile ifade edilebilir. İlk beş denklem 
diferansiyel veya integral formunda ifade edilebilir. Biz ilk beş denklemi 
yüzey normalleri ve tanjantları yönüne indirgersek dört denkleme 
indirgeyebilir ve integral formunda şu şekilde ifade edebiliriz.

.. math::
    \frac{\partial}{\partial t}\int\limits _{\varOmega}\mathbf{W}d\varOmega+\intop_{A}\mathbf{F}dA=S

    \mathbf{W}=\left[\begin{array}{c}
    \rho\\
    \rho U_{n}\\
    \rho U_{t}\\
    \rho e_{tot}
    \end{array}\right]\qquad\mathbf{F}=\left[\begin{array}{c}
    \rho U_{n}\\
    \rho U_{n}^{2}+p\\
    \rho U_{n}U_{t}\\
    \rho U_{n}h_{tot}
    \end{array}\right]

Denklemin sağ tarafında bulunan terim kaynak terimi olarak geçer. Sırası ile 
maddenin korunumu için sıfır, momentumun korunumu için kuvvetler ve son denklem
olan enerjinin korunumu için ise enerji enerji kaynağını ifade eder. 

Bu terimler arasında momentum kaynak terimi ayrı bir önem arz eder. Ağdalılık 
etkisi içeren kayma gerilmeleri ile yerçekimi terimleri burada ifade edilir. 
Momentum kaynak terimlerinin 0 olması durumunda ortaya çıkan denklem seti 
*Euler* denklemleri iken, bu terimin eklenmesi ile *Navier-Stoke* denklemleri
elde edilir.

Denklemim sol tarafında yer alan terimler, korunum değerlerini (İng 
*Conservative variables*) içerir. SU2 içerisinde daima korunum değerleri ile
işlem yapılır. Gerektiğinde yoğunluk (:math:`\rho`), hızlar ve basınçlar bu 
değerlerden hesaplanır.

Akı, :math:`F` her ağ yüzeyi üzerinde normal ve tanjant yönlerindeki değerler
ile hesaplanmaktadır.

Bu denklemlerim üzerine bir de hâl denklemi eklenmelidir. Zira enerji ve 
entalpi terimleri (:math:`e_{tot}`, :math:`h_{tot}`) açıldığında sıcaklık da 
ortaya çıkarak bir bilinmeyen daha ortaya çıkarır. Basınç, yoğunluk ve 
sıcaklığın birbirine termodinamik olarak bağlıdır ve bir hal denklemi ile ifade
edilebilir. SU2 ideal gaz denklemlerini varsayılan olarak kullanır. Ayrıca 
farklı gerçek gaz modelleri de kullanılmaktadır.

3.3 - Genel HAD mimarisi
========================
Sıkıştırılabilir akışlar için genel HAD yazılımları şu alt birimlerden oluşur:

* Ana denklem sağ tarafı 0 olacak şekilde düzenlenir. Böylece denklem setleri 
  bir ağdasız akım ve de ağdalılığı sağlayan kaynak terimlere ayrılır.
* Sıkıştırılabilir Ağdasız Akı hesaplama yöntemleri, viskozitenin etkin olup 
  olmamasından bağımsız olarak çözülmektedir.
  
  * Türbülans modelleme yöntemi olarak RANS kullanılmaktadır.
* Ağdalı akışlar, türbülanslı akışları içerecek şekilde türbülans modellerinin
  uygulanması ile modellenmektedir.
* Hâl denklemleri varsayılan olarak ideal gaz iken, diğer modeller de 
* uygulanabilmektedir.
* Sıkıştırılamaz akışlar için de çözücüler eklenmeye başlanmıştır. Bu modeller
  daha yeni tarihli olarak SU2 çözücüsüne eklenmektedir. 
  Sıkıştırılamaz akışlarda kaynak terimi her zaman bulunmaktadır.

3.4 - Akı (İng. *Flux*) hesaplayıcıları
=======================================
Akı hesaplamaları sonlu hacim tabanlı HAD çözücüleri için en önemli kısımlardan
birisidir. Öncelikle, sıkıştırılabilir akışlarda yerel şok dalgalarından 
dolayı çözüm süreksiz olabilir. Bu sebeple, gradyenlerin sürekliliğini varsayan
sayısal yöntemlerin kullanılması zordur. Bu özellikle ikinci derece çözücülerde
ortaya çıkmaktadır. Süreksizliklerin göz önüne alındığı çözücü yöntemlerinin 
kullanılması gerekmektedir.

SU2 çözücüsü sıkıştırılabilir akışlar için iki ana aileye ait çözücüleri 
kullanmaktadır.

3.4.1 - Merkezi (*Central*) çözücüler
-------------------------------------
Merkezi çözücüler, aslında gradyen temelli çözücülerdir. Dolayısı ile hesaplama
yükü göreli olarak azdır. İkinci derecede çözücülerde şok gibi yüksek 
gradyenlerin bulunduğu bölgelerde bu tür çözücülerin yakınsayabilmesi için 
yapay yayınım terimlerine ihtiyaç vardır. Bu sebeple kullanım alanları sınırlı
olmamakla birlikte her akış bölgesinde aynı hassasiyete sahip değildirler.

* Yüksek Mach sayılarında ve transonik bölge akışlarında yüksek gradyenlerin 
  çözülebilmesi için difüzyonun arttırılması gerekmektedir. Bu tür akışlarda 
  hassas çözüm isteniyorsa Akı ayrışması gibi yöntemlerin tercih edilmesi 
  uygun olacaktır. Yine de hem hızlı çözüm alabilmeleri, hem gürbüz olmaları,
  hem de yeterince çözüm hassasiyetine sahip olmaları nedeni ile bu tür 
  çözücüler kullanılabilmektedir.
* Çoğu merkezi algoritma ayarlanabilir bir ve birkaç yayınım terimine sahiptir.
  yayınım terimleri yükseltilerek şoklar etrafında çözüm alınması mümkün 
  olabilmektedir. Yaygın bir uygulama olarak yüksek yayınım katsayıları ile ilk
  yakınsama sağlandıktan sonra bu katsayılar azaltılarak daha hassas çözümler 
  alınabilmektedir. 
* Düşük Mach sayılarında yayınım daha az öneli olmaya başlayacaktır. Bu sebeple
   bu rejimlerde merkezi akı şemaları daha hızlı ve yüksek hassasiyette çözüm 
   alabilmektedirler.
* Sıkıştırılamaz akımlar için de merkezi şemalar aynı şekilde 
  kullanılabilmektedir.

SU2 birden fazla merkezi şemaya sahiptir. En çok bilinen iki şema *JST* 
(Jameson-Schmidt Turkel) ve *Lax-Friedrich* şemalarıdır. Özellikle JST 2. 
derece ve 4. derece yayınım parametreleri ile son derece gürbüz ve probleme 
uyarlanması kolaydır. LF metodu ise daha basit bir şema olup hesaplama yükü son
derece düşüktür.

3.4.2 - *Upwind* çözücüler
--------------------------
Upwinding terimi akışın geldiği yöne göre çözüm yönteminin yöneliminin 
belirlenmesi anlamına gelmektedir. Akılar, akışın geldiği yönden daha çok bilgi
alacak şekilde hesaplanır. Gradyen hesapları sadece ikinci derece metotlar için
kullanılırken, akı hesapları ortalama içermezler. Bu yöntemler çoğunlukla 
merkezi şemalara uygun olmakla birlikte kullanım alanları şu şekildedir.

* Süpersonik ve transonik akışlar için yüksek başarımlı ve gürbüz çözücülerdir.
  Özellikle şokların yakalanması gereken problemler için oldukça iyi bir 
  alternatiftir.
* Upwind çözücüler merkezi çözücülere göre daha yoğun bir işlem gücü 
  gerektirirler. Fizik ve dalga yönü temelli şemalardır. Fiziğin ve dalga yön
  ve şiddetlerinin benzetimleri daha gerçekçi yapıldıkça şemaların karmaşıklığı
  ve hesaplama maliyeti artmaktadır.
* Düşük Mach sayılarında yüksek difüzyon karakteri göstermektedirler. Bu durum
  sınır tabakası etrafında daha da görünür olmaktadır. Pek çok şema bu 
  bölgelerde doğru yakınsayabilmek için pre-conditioning denilen bir işleme 
  tabi tutulmaktadır. Eğer çok sayıda konfigürasyonda çözüm almak gerekiyorsa 
  bu tür metotların kullanıcının kontrolünü ve emeğini gerektireceği göz önünde
  bulundurulmalıdır.

Aşağıdaki Upwind şemalar SU2 içerisinde seçilebilmektedir:

* *Roe* Ailesi çözücüleri, *Riemann* temelli ve *FVS* temelli çözücüleri 
  ortasında bulunmaktadır. Oldukça popüler olan bu şemalar göreli olarak 
  gürbüzdürler. SU2 içerisinde 4 adet Roe şeması versiyonu vardır. Klasik 
  Roe dışındaki versiyonlar düşük hızlarda çözüm almaya yöneliktir.
* *AUSM* ailesi, *AUSM*, *AUSM+up*, *AUSM+up2* ve Kitamura'nın iki ayrı *SLAU* 
  versiyonundan olmak üzere bir kaç alternatif sunar. Özellikle yüksek 
  süpersonik akışlarda bu şemaların kullanılması faydalı olabilir.
* *HLLC* tüm akı algoritmalrı içerisinde en hassas, ancak en yüksek hesaplama
  maliyetli olanıdır. Yaklaşık Riemann problemi çözücüsü içeren olan bu akı 
  hesaplama yöntemi diğer çözücülere kıyasla daha az gürbüz olabilirler.

3.5 - *RANS* modelleri
======================
Türbülanslı akışların modellenebilmesi için Navier-Stokes denklemlerini 
çözmeniz gerekir. Bu sebeple iki değişiklik şarttır. Birincisi ağdalı akışlar
fiziksel bir şart olan “kaymayan duvar (İng. *no-slip-wall*) kuralına uyar. 
Bu kural, duvar ile temas halinde olan akışkan moleküllerinin hızının duvar 
hızına eşit olduğu, diğer bir deyişle duvara yapıştığı ve onun üzerinden 
kaymadığı kuralıdır. İkincisi, Türbülanslı akışlar dolayısı ile yırtılma 
gerilmesi yönünde ek gerilmeler olduğudur. Bu iki kural RANS (Reynolds Averaged
Navier Stokes) modelleri ile HAD çözümlemelerine dahil edilir.

Bu aşamada denklem setlerine türbülans modeller ile hesaplanan ek stresler Akı
hesaplayıcılarının üzerine eklenecektir. İki adet Türbülans modeli mevcuttur.

* *Spalart Almaras* modeli tek denklemli bir modedir. Her aşamada bir adet ek
  diferansiyel denklem çözer. Hem iç hem dış akışlar için yeterince iyi sonuç
  vermektedir. Girdi dosyalarında ``SA`` olarak anılır.
* :math:`k-\omega-SST` modeli klasik :math:`k-\omega` modelin için bazı 
  bölgelerde :math:`k-\epsilon` modeline geçişinin sağlanması ile 
  oluşturulmuştur. İki denklemli bir modeldir. Dolayısı ile SA modeline göre 
  bir miktar daha fazla hesaplama kaynağına ihtiyaç duyar. Dış akışlar için 
  yaygın olarak kullanılan bir modeldir. Girdi dosyalarında ``SST`` olarak anılır.

Akı hesaplayıcıları ile RANS modelleri istenilen kombinasyonda kullanılabilir.

.. note::
   Fiziksel çözümlemeler için eğer problemin detaylarına çok hakim değilseniz
   ve ağdalılık koşullarının baskın olduğunu bilmiyorsanız, Laminer modeller 
   kullanmamak daha güvenli olacaktır.

.. note::
   Türbülans Modelleri için ek teknik bilgiye `NASA Türbülans modelleri`_ sitesinden ulaşılabilir.

----------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.
       
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
.. _NASA Türbülans modelleri: https://turbmodels.larc.nasa.gov

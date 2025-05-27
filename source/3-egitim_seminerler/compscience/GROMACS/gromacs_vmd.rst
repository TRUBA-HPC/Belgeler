=================================
VMD İle Kullanımı
=================================

Etkileşimli Moleküler Dinamik (IMD), kullanıcıların çalışan bir moleküler dinamik (MD) simülasyonunu izlemesine ve bunlarla etkileşime girmesine olanak tanır. Bunu başarmak için GROMACS 5.0' da IMD protokolünü uygulanmıştır. Kullanıcı, bir fare veya kuvvet geri besleme cihazlarıyla atomları, kalıntıları veya parçaları çekerek simülasyonla etkileşime girebilir. 

------------------
Özellikleri
------------------

IMD, çalışan simülasyonların izlenmesine ve bunlarla etkileşime izin verir. IMD, 5.0 sürümünden itibaren GROMACS' a dahildir. Uygulamanın özellikleri şunlardır:

* Temiz Arayüz: MD döngüsü içinde sadece 4 döngü bulunmaktadır.

* Doğru periyodik sınır durumu uygulaması, moleküller giriş ‘.tpr’ deki gibi bütünleştirilmektedir.

* IMD grubu, yalnızca bir atom alt kümesiyle etkileşime girecek, iletecek ve görüntüleyecek şekilde ayarlanabilmektedir.

* Performans üzerinde ihmal edilebilir etkisi (özellikle istemci bağlantısı kesildiğinde) bulunmaktadır.

* Windows'ta da aynı başarı ile çalışmaktadır.

---------------------------------------
Kurulum ve Simülasyon Girdi Hazırlığı 
---------------------------------------

IMD' yi GROMACS ile kullanmanın en kolay yolu 5.x sürümünü indirmektir (bkz. www.gromacs.org). 

GROMACS uygulaması, yalnızca çalışan simülasyonun bir kısmı ile iletim ve etkileşime izin verir (örneğin su moleküllerinin iletilmemesi veya çekilmemesi gereken durumlarda). Grup, ``IMD-group .mdp`` seçeneği ile belirlenir. IMD grubu boş olduğunda, IMD protokolü devre dışı bırakılır ve mdrun' daki anahtarlar aracılığıyla etkinleştirilemez. Tüm sistemle etkileşim kurmak için IMD-grubu sistem olarak ayarlanmalıdır. Grompp kullanırken, VMD ile kullanılacak bir ``.gro`` dosyası yazılır (grompp' un -imd anahtarı). 

-----------------------
Simülasyonu Başlatma
-----------------------

VMD ve GROMACS arasındaki iletişim, TCP soketleri aracılığıyla sağlanır ve böylece yerel olarak veya uzak bir kümede çalışan bir mdrun' ın kontrol edilmesini sağlar. Bağlantı için bağlantı noktası mdrun' ın ``-imdport`` anahtarıyla belirtilebilir, varsayılan değer 8888'dir. Her N adımda istemci, VMD istemcisinden uygulanan kuvvetleri alır ve yeni konumları istemciye gönderir. İstemci ile iletişim sıklığı VMD' de ayarlanabilir. Varsayılan olarak simülasyon, bağlı hiçbir IMD istemcisi olmasa bile başlar ve çalışır. Bu davranış, mdrun' ın ``-imdwait`` anahtarı tarafından değiştirilir. Başlattıktan sonra ve istemcinin bağlantısı kesildiğinde, istemci yeniden bağlanana kadar entegrasyon durur. ``-imdterm`` anahtarı kullanıldığında VMD' de ``stop`` butonuna basılarak simülasyon sonlandırılabilir. Son olarak, simülasyonla etkileşimi açmak (yani VMD' den çekmek) için ``-imdpull`` anahtarı kullanılmalıdır. Bu nedenle, bir simülasyon yalnızca izlenebilir ancak ``-imdwait``, ``-imdterm`` veya ``-imdpull`` dan hiçbiri ayarlanmadığında VMD istemcisinden etkilenmez. IMD protokolü kimlik doğrulama gerektirmediğinden, simülasyonların güvenli olmayan bir ortamdan doğrudan erişilebilen bir ana bilgisayar üzerinde çalıştırılması önerilmez. TCP' nin güvenli kabuk yönlendirmesi, etkileşim halindeki ana bilgisayardan doğrudan erişilemeyen çalışan simülasyonlara bağlanmak için kullanılabilir. 

--------------------
VMD'den Bağlanma
--------------------

VMD' de öncelikle IMD grubuna karşılık gelen yapı yüklenmelidir ``(Dosya > Yeni Molekül > ...)``. Ardından IMD bağlantı penceresi kullanılmalıdır ``(Uzantılar  > Simülasyon  > IMD Connect (NAMD))``. IMD bağlantı penceresinde, ana bilgisayar adı ve bağlantı noktası belirtilmeli ve ardından 'Connect'e tıklanmalıdır. ``Detach Sim`` simülasyonu sonlandırmadan bağlantının kesilmesine izin verirken ``Stop Sim`` simülasyonu bir sonraki komşu arama adımında (-imdterm tarafından izin veriliyorsa) sonlandırır. Zaman adımı aktarım hızı, simülasyon ve IMD istemcisi arasındaki iletişim frekansının ayarlanmasını sağlar. Tutma hızının ayarlanması, yeni bir kare alındığında bunları atmak yerine her N. kareyi VMD'ye yükler. Görüntülenen enerjiler, NAMD simülasyonlarından görüntülenen enerjilerin aksine SI birimlerindedir.

--------------------------------------------------------------------
Örnek Uygulama: GROMACS ile Etkileşimli Streptavidin-Biotin Çözme
--------------------------------------------------------------------

Örneği çalıştırmak için lütfen Streptavidin-Biotin GROMACS giriş dosyalarını indirin (https://www.mpibpc.mpg.de/grubmueller/interactivemd bağlantısındaki File list'e bakınız).  Aşağıdaki kodları giriniz:

.. code-block::

    tar -xvzf imdexample.tgz
    cd imdexample/
    source /path/to/your/gromacs/installation/bin/GMXRC
    gmx grompp -f md.mdp -c npt.gro -maxwarn 1

GROMACS ön işlemcisi, VMD için girdi olarak kullanılacak olan ``imdgroup.gro`` dosyasını yazacaktır:

.. code-block::

    vmd imdgroup.gro

Streptavidin-Biotin kompleksinin bir temsili için:

.. code-block::

    Graphics > Representations > Selected Atoms: all > Coloring Method > Index > Drawing Method > New Cartoon

Rapor oluşturmak için:

.. code-block::

    Selected Atoms: resname BTN > Drawing Method > VDW > Coloring Method > Type

Moleküler dinamik simülasyonunu başlatmak için şunu yazınız:

.. code-block::

    gmx mdrun -s topol.tpr -imdwait -imdpull -imdterm

GROMACS komut satırında şunları görünür:

.. code-block::

    IMD: Enabled. This simulation will accept incoming IMD connections.
    IMD: Pausing simulation while no IMD connection present (-imdwait).
    IMD: Allow termination of the simulation from IMD client (-imdterm).
    IMD: Pulling from IMD remote is enabled (-imdpull).
    IMD: Turning on IMD - port for incoming requests is 8888.
    IMD: Setting up incoming socket.
    IMD: Listening for IMD connection on port 8888.
    IMD: Will wait until I have a connection and IMD_GO orders.

VMD istemcinize gidin ve şunları seçiniz:

.. code-block::

    Extensions> Simulation > IMD connect (NAMD)

Açılan pencerenin alanlarına şunu yazınız:

.. code-block::

    Hostname:localhost
    Port: 8888

Ardından, GROMACS'a simülasyonu başlatmasını bildirmek için ``Connect`` e tıklayn. İş istasyonunuzun (veya bunun yerine bir küme üzerinde çalışıyorsanız kümenizin) bilgi işlem gücüne bağlı olarak, zaman adımı aktarım hızını 1 veya daha yüksek bir değere ayarlamak isteyebilirsiniz. Bunun için:

.. code-block::

    Mouse> Force> Residue (or Atom)

Artık Biotin molekülünü Streptavidin bağlama cebinden çekebilirsiniz. Daha sonra, tekrar içeri almayı denemek isteyebilirsiniz.

Bu işlemler sonucunda aşağıdaki gibi bir görüntü elde etmelisiniz [https://www.mpibpc.mpg.de/grubmueller/interactivemd (Erişim tarihi: 23.08.2021)].

.. image:: ../../../../assets/compmatscience-gromacs-education/gmx_biotin.png
   :align: center
   :width: 300px
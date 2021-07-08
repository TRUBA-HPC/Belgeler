.. _grafik-ekran:

======================================
Grafik Ekran Bağlantısı (X-forwarding)
======================================

Kullanıcıların işlerini yapılandırmak, kuyruğa göndermek, gerektiğinde sonuçları kontrol etmek için kullandığı kullanıcı arayüzü sunucularında görsel uygulamalar çalıştırmak mümkündür. İşlerini, input dosyalarını aracı programlarla hazırlayan kullanıcılar ya da işin çıktısını local bilgisayara aktarmadan doğrudan sunucu üzerinde görmek isteyen kullanıcılar bu bağlantı türünü tercih edebilirler.

Sunucu üzerindeki görsel öğeyi kullanıcının kendi bilgisayarına aktarabilmesi için

* SSH bağlantısı sırasında X-forwarding seçenegi aktif hale getirilmeli
* Local bilgisayarda bir X-server uygulaması doğru biçimde kurulmuş ve çalışıyor durumda olmalı
* Local bilgisayardaki güvenlik duvarı ve benzeri yazılımların ayarları doğru şekilde yapılmalıdır. 


SSH bağlantısı sağlamak için farklı işletim sistemleri için pek çok farklı uygulama bulunmaktadır.

Windows sistemlerde en sık kullanılan SSH istemcisi Putty'dir. Putty'de X-forwarding seçeneği Connection > SSH > X11 altındadır. Diğer uygulamalarda bu seçeneğin nerede olduğuna dair uygulamanın yardım dökümanları kontrol edilmelidir.

MacOS kullanan kullanıcılar büyük ihtimal terminal arayüzü üzerinden bağlanacaklardır. Terminal ekranında ssh komutuna -XY parametresinin eklenmesi yeterlidir. Örneğin;

.. code-block::

    ssh -l kullanici_adi levrek1.ulakbim.gov.tr -XY

Linux işletim sistemi kullanan kullanıcıların da büyük çoğunluğu SSH için terminal arayüzünü tercih etmektedir. MacOS'de olduğu gibi ssh komutuna -XY eklenmesi yeterlidir.


.. note::

    SSH istemcilerinde olduğu gibi, X-server uygulamalarında da işletim sisteminden işletim sisteminde pek çok farklı uygulama mevcuttur. 

    * Windows kullanıcıları ücretsiz olan X-Ming yazılımını tercih edebilirler. X-Ming yazılımı kendi içerisinde yüklü olan Putty'i kullanabilecegi gibi, harici bir Putty kurulumu da kullanılabilir. Yapılandırmaya göre, sunucu üzerindeki tüm grafik ekran aktarılabileceği gibi, sadece uzak sunucuda çalıştırılacak olan uygulamanın penceresi de local bilgisayara aktarılabilmektedir. Ayrıntılar için kullanılacak X-server'in yardım dökümanlarına bakılmalıdır.


    * MacOS yüklü sistemlerde, XQuartz uygulaması X-server olarak kullanılabilir.

    * Linux yüklü sistemlerde, sistemin doğal parçası olarak server-client mimarisinde çalışan Xorg yüklü olarak gelmektedir. Xorg'da açılacak pencereler local uygulamalardan açılabileceği gibi, uzak bilgisayardan da açılabilmektedir. Herhangi bir yazılım yüklenmesine gerek yoktur. 
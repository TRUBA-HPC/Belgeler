.. _MATLAB-TRUBALisans:

=======================================
TRUBA'da MATLAB Lisansının Tanıtılması
=======================================

TRUBA üzerinde MATLAB çalıştırmak isteyen kullanıcıların **kendilerine ait bir lisansa** sahip olması gerekmektedir. Bu lisans **akademik ya da floating (kayar) lisans** olabilir.

Lisans türleri hakkında bilgiye `https://www.mathworks.com/pricing-licensing.html <https://www.mathworks.com/pricing-licensing.html>`_ adresinden erişebilirsiniz. Ayrıca üniversitelerin bilgi işlem merkezlerinden de lisansınız hakkında detaylı bilgi edinebilirsiniz.

MATLAB, sahip olunan lisans türüne göre TRUBA üzerinde farklı şekillerde çalıştırılabilir.

.. grid:: 1
   
    .. grid-item-card:: :ref:`MATLAB-akademik`
        :text-align: center
    .. grid-item-card::  :ref:`MATLAB-FloatingLisans`
        :text-align: center

.. _MATLAB-akademik:

-------------------------------------------------------------------
Akademik (TAH: Total Academic Headcount) Lisansı Olan Kullanıcılar
-------------------------------------------------------------------

EGI ile MATHWORKS arasındaki anlaşma sayesinde kullanıcılar, **"MATLAB Parallel Server lisansları"** ile EGI üyesi ülkelerin süperbilgisayar merkezlerinde MATLAB çalıştırabilmektedirler. Akademik lisansınızın Mathworks üzerinden doğrulanabilmesi için grafik ekrana ihtiyaç duyulmaktadır. Bu lisansa sahip olarak TRUBA üzerinde MATLAB çalıştıracaksanız birkaç metot bulunmaktadır.

- Kişisel bilgisayarınızda MATLAB çalıştırarak

- TRUBA üzerindeki kullanıcı arayüz sunucularından :ref:`grafik-ekran` alarak

.. _MATLAB-ARFUI:

ARF-UI Üzerinde MATLAB Çalıştırarak TRUBA'ya İş Göndermek İçin Akademik Lisans Tanımlaması
--------------------------------------------------------------------------------------------

Öncelikle kişisel lisansınızın TRUBA üzerinde aktif edilmesi gerekmektedir. Lisansınızı aktifleştirmek için **arf-ui** kullanıcı arayüz sunucularından herhangi birine grafik arayüzü desteği ile bağlanmak gereklidir. TRUBA kullanıcı arayüzlerine iki farklı şekilde grafik arayüzü bağlantısı yapılabilir.

1. :ref:`Open OnDemand <open_ondemand>` ile bağlanarak. “Interactive Apps” sekmesinden ``ARF Desktop`` **(Linux XFCE Desktop)** oturumu başlatılabilir. Linux Masaüstü üzerinde çalıştırılacak uygulamalar, küme üzerindeki hesaplama sunucularında çalıştırılmış olacaktır. Linux Masaüstünde **terminal** uygulamasından verilecek komutlarla sunucu üzerinde MATLAB da dahil olmak üzere herhangi bir görsel uygulama çalıştırılabilir.

2. ``ssh -XY username@sunucu_adi`` komutu aracılığıyla :ref:`grafik arayüz <sshXforward>` alarak
 
Arayüz sunucusunda terminal ekranı aldıktan sonra MATLAB ile küme profili oluşturmaya başlayabiliriz.

::

    # Sistemde yüklü MATLAB versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab-module.png
   :width: 800px

Sistem üzerinde farklı versiyonlar yüklü olabilir (R2021b, R2024a vb). Mevcut durumda ARF kümesinde R2024a versiyonu kurulu olarak bulunmaktadır.  İlgili versiyonu kullanmak için öncelikle bu yazılımı ``module load`` komutu ile yüklemeniz gerekecektir. 

::

    ## sisteminizde daha önceden yüklü modülleriniz olabilir. 
    ## Dolayısıyla herhangi bir çakışma olmaması için öncelikle yüklü modülleri temizleyiniz
    module purge

    ## modülü yüklemek için
    module load apps/matlab/2024a

    ## modülün doğru şekilde yüklendiğini doğrulamak için
    module list

    ## MATLAB'i calistirmak icin
    matlab -nosplash

MATLAB'ı ilk kez çalıştırdığınızda aşağıdaki gibi bir sorgu ekranı açılacak ve lisansınızı aktive etmeniz istenecektir.

.. image:: /assets/matlab-howto/matlab2.png
   :width: 800px



Lisans doğrulamasını gerçekleştirdikten sonra kendi (yerel) bilgisayarınızda MATLAB'ı çalıştırarak SLURM küme ayarlarını gerçekleştirebilirsiniz.

- Yerel bilgisarınızda kurulum ile ilgili önemli bilgilendirmeler için ve ilgili küme ayarlarını yapmak üzere gerekli işlem adımları için :ref:`local-MATLAB` yönergesini takip edebilirsiniz.

- Ayar dosyasını bir kez çalıştırmanız yeterlidir. Daha sonra :ref:`MATLAB-TRUBA_config` yönergelerini takip ederek hesaplama kümelerine iş gönderebilirsiniz.

.. warning::

    Kişisel bilgisayar üzerinden çalıştırdığınız MATLAB ile TRUBA kümesine iş göndermek için ``/arf/sw/scripts/matlab/matlabScripts/truba.nonshared.R2024a`` ayar dosyasını kullanmanız gerekecektir. Aksi takdirde işlerinizde hata ile karşılaşırsınız.


.. _MATLAB-FloatingLisans:

--------------------------------------------
Kayar (Floating) Lisansı Olan Kullanıcılar 
--------------------------------------------

Lisans doğrulaması, kullanıcının kendi kurumundaki lisans sunucusu tarafından yapılır. Bu nedenle kurumdaki lisans sunucusunun TRUBA sunucularına lisans doğrulaması için erişim izni vermesi gereklidir. TRUBA'nın çıkış IP adresi **193.140.99.241**'dir. Bu yetki ile ilgili kurumunuzun bilgi işlem daire başkanlığıyla iletişime geçiniz.

Kayar lisansına sahipseniz bir slurm betik dosyası hazırlayarak, işlerinizi ``sbatch`` komutu ile iş kuyruğuna gönderebilirsiniz. 

TRUBA üzerinde halihazırda bazı MATLAB versiyonları yüklü durumdadır. Bu yazılımlar zaman içerisinde yeni versiyonlar eklendikçe güncellenmektedir

Sistemde yüklü yazılımları ``module available`` komutu ile görebilirsiniz. 

::

    # Sistemde yüklü matlab versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab1.png
   :width: 800px

.. warning::

    TRUBA üzerinde küme yönetimi ve iş zamanlayıcı olarak :ref:`SLURM <slurm-betik>` kullanılmaktadır. Kümede iş çalıştırmadan önce :ref:`SLURM betik özellikleri <slurm-betik>` hakkında bilgi edinmiş olmanız beklenmektedir. İş göndereceğiniz hesaplama kümeleri ile ilgili bilgiye :ref:`hesaplama-kumeleri` sayfasından erişebilirsiniz.

Lisans dosyanızı TRUBA arayüz sunucusuna transfer ediniz. Bunu terminal aracılığıyla ``scp`` komutu ile yapabileceğiniz gibi SFTP yazılımları aracılğıyla da gerçekleştirebilirsiniz.

::

    ## username kısmını TRUBA kullanıcı adınızla değiştirmeyi unutmayin
    scp -r "lisans_dosyanızın_bilgisayarınızdaki_yeri" username@172.16.6.11:/arf/home/username/


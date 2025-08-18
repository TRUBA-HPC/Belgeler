.. _arf-gaussview-kilavuzu:

============================================================
ARF Hesaplama Kümesinde GaussView 6 Programının Kullanılması
============================================================

Kimyasal modelleme ve hesaplamalı kimya çalışmalarını kolaylaştırmak amacıyla tasarlanmış olan GaussView, kullanıcıların kompleks moleküler yapıların oluşturulması, görselleştirilmesi ve Gaussian hesaplamalarının yönetilmesi süreçlerinde büyük kolaylık sağlar.

GaussView 6, Gaussian 16 yazılımı için mevcut olan en gelişmiş ve güçlü grafik arayüzüdür. Gaussian 16'da bulunan tüm yeni modelleme yöntemleri ve yetenekleri için tam destek sağlar.

`GaussView'in sayfasından <https://gaussian.com/gv6main/>`_ program ve de kullanımı hakkında detaylı bilgilere ulaşabilirsiniz.


ARF kümesinde Open OnDemand servisi (http://172.16.6.20) üzerinden GaussView 6 paketini kullanabilirsiniz. Open OnDemand web tabanlı bir kullanıcı arayüzü servisidir. Bu arayüz, terminal tabanlı klasik kullanıcı arayüzü sunucusunun sağladığı tüm imkanlara ek olarak kullanıcılara pek çok ek özellik sunmaktadır. 

ARF kümesine erişim ve de Open OnDemand servisini kullanmak için TRUBA VPN bağlantısının başarılı bir şekilde sağlanmış olması gerekmektedir. 

* TRUBA VPN ile ilgili bilgilere ulaşmak için :ref:`open-vpn` sayfasını inceleyebilirsiniz.
* ARF kümesine bağlantı için :ref:`arf_baglanti` sayfasını inceleyebilirsiniz.


ARF kümesi Open OnDemand servisine internet tarayıcınızı kullanarak http://172.16.6.20 adresinden ulaşabilirsiniz. Karşınıza gelen ekranda TRUBA kullanıcı adı ve şifre bilginizi girmeniz gerekmektedir.

.. image:: /assets/gaussian/ondemand-signin.png
   :align: center
   :width: 600px

Kullanıcı adı ve şifre bilginizi girdikten sonra ARF menüsünden Desktop seçeneğine tıklayınız.

.. image:: /assets/gaussian/ondemand-desktop.png
   :align: center
   :width: 600px

Bundan sonraki adımda interaktif masaüstü talebinde bulunmanız gerekmektedir. Karşınıza gelen ekranda "Launch" sekmesine tıklayarak interaktif masaüstü için kaynak talebinde bulununuz. 

* Eğer GaussView 6 üzerinde yapacağınız işlemin (pre-process/post-process) 1 saatten fazla olacağını öngörüyorsanız süre bilgisini değiştiriniz. 

* Eğer sistemde tanımlı olan proje hesabınız üzerinden işlemlerinizi yapmak istiyorsanız Account kısmına proje hesabınızı (tbagXXX) belirtiniz.

.. image:: /assets/gaussian/ondemand-intdesktop.png
   :align: center
   :width: 600px


İnteraktif masaüstü talebinde bulunduktan sonra ilgili kaynağın sizin için ayrılması için bir süre beklemeniz gerekecektir.

.. image:: /assets/gaussian/ondemand-intsession.png
   :align: center
   :width: 600px

Kaynak talebiniz sistem tarafından karşılandığında aşağıdaki ekran karşınıza gelecektir. "Launch Desktop" butonuna tıklayarak devam edebilirsiniz.

.. image:: /assets/gaussian/ondemand-launchdesktop.png
   :align: center
   :width: 600px

İnteraktif masaüstü oturumunuz aşağıdaki ekranda olduğu gibi sizi karşılayacaktır. GausView programınız çalıştırabilmeniz için ilgili modülleri yüklemeniz gerekmektedir. Bu işlemi yapabilmek için aktif durumdaki interaktif masaüstü oturumunda terminal açmalısınız. Altta ortada yer alan menüden terminal ikonuna basarak terminal başlatabilirsiniz.

.. image:: /assets/gaussian/ondemand-activedesktop.png
   :align: center
   :width: 600px

Açılan terminali tam ekran yapabilirsiniz. Terminalde Gaussian ile ilgili modülleri listeleyebilmek için

.. code-block:: bash

   module available

komutunu yazınız. İlgili programlar arasında Gaussian için aşağıdaki modüllerin de listelendiğini göreceksiniz:

.. code-block:: bash

    apps/gaussian/g16-avx
    apps/gaussian/g16-avx2
    apps/gaussian/g16-legacy
    apps/gaussian/g16-sse4.2
    apps/gaussian/gview


.. image:: /assets/gaussian/ondemand-terminalmodule.png
   :align: center
   :width: 600px

İlgili modüller arasından aşağıdaki modülleri yükleyiniz:

.. code-block:: bash

 module load apps/gaussian/g16-avx 
 module load apps/gaussian/gview

Terminalde

.. code-block:: bash

   gview.sh

komutunu yazdığınızda GaussView 6 açılmaya başlayacaktır.

.. image:: /assets/gaussian/ondemand-gview.png
   :align: center
   :width: 600px

Açılan GaussView 6 ekranından /arf/home/kullaniciadi dizininizde yer alan Gaussian input, output dosyalarını açıp analizlerinizi gerçekleştirebilir, yapılarınızı oluşturabilirsiniz.

.. image:: /assets/gaussian/ondemand-gviewopenfile.png
   :align: center
   :width: 600px



















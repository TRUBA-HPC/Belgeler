=======================
Open OnDemand Menüler
=======================

Kullanıcılar 4 ana menüden tüm operasyonlarını gerçekleştirebilirler. 

Şu an ihtiyaç olmamakla birlikte, bu menülerin sayısı ileride arttırılabilir ya da çeşitlendirilebilir. 

.. image:: /assets/open-ondemand/images/openondemand-menu.png


--------------
File Menüsü
--------------

Bu menüden, hesabınızın erişim hakkı olduğu dosya sistemlerine ve ev dizininize web tabanlı dosya gezgini ile hızlıca erişebilirsiniz. 

.. image:: /assets/open-ondemand/images/400px-Menu_file.png

.. image:: /assets/open-ondemand/images/800px-File_browser.png

Web tabanlı dosya gezginini kullanarak:

- Levrek1 sunucusunda terminal açabilir
- Kişisel bilgisayarınızdan TRUBA'ya, TRUBA'dan kişisel bilgisayarınıza dosya transferi
- Dosya ve dizin oluşturma, silme, taşıma, yeniden isimlendirme
- Dosya düzenleme işlerinizi 

yapabilirsiniz. 


Alternatif olarak *Seyyah* adındaki özelleştirilmiş dosya gezginini de kullanmak mümkündür. Bu gezgin NortonCommender tarzı bir çift alanlı bir görünüm sunarak sistemdeki dizinler arasında dosya kopyalamaya ve taşımaya izin vermektedir. 

--------------
Jobs Menüsü
--------------

Bu menüden mevcut işlerinizin durumunu kontrol edebilir, yeni iş gönderebilirsiniz. 

.. image:: /assets/open-ondemand/images/openondemand-jobs.png

``Active Jobs`` sayfasından işlerinizin ayrıntılı durumunu görmeniz, işinizi iptal etmeniz, dosya gezgini ya da terminal ekranı açmanız mümkündür. 

.. image:: /assets/open-ondemand/images/700px-Active_jobs.png

*Job Composer* sayfasından yeni iş hazırlayabilir, daha önce hazırlamış olduğunuz işi yeniden kuyruğa gönderebilir, kuyrukta bekleyen ya da çalışan işlerinizi sonlandırabilir ve durumları hakkında özet bilgi alabilirsiniz.

----------------------------
İş Oluşturma ve Gönderme
----------------------------

.. image:: /assets/open-ondemand/images/700px-New_job.png


.. warning::

    Bu kısımda dikkat edilmesi gereken en önemli husus, OnDemand üzerinden oluşturulacak tüm işlerin (ne şekilde oluşturulduğunun bir önemi yok, ister yeni iş oluşturulsun, ister mevcut templateler kullanılarak, ister önceki işlerin yeniden gönderilmesi sureti ile ya da daha önce terminalden gönderdiğiniz bir işin dizininden otomatik olarak oluşturarak) otomatik olarak **/truba/home/$USER/ondemand/data/sys/myjobs/projects/default/** dizininde yeni bir dizinde oluşturulacağıdır.
    
Daha önce gönderdiğiniz başarılı ya da başarısız bir işi sıraya göndermek istediğinizde ilgili dizinin tüm içeriği yeni bir dizine kopyalanarak iş bu dizin içinden gönderilecektir. O nedenle diskte çok alan kaplayan input ve output dosyalarını iş ile aynı dizin içerisinde bulundurmak yerine, bu input ve output dosyalarını farklı bir dizin içinde bulundurmak, işinizin verileri bu dizinden okumasını ve bu dizine yazmasını sağlamak gereksiz disk kullanımını azaltacaktır. 

.. image:: /assets/open-ondemand/images/500px-New_job2.png

Herhangi bir yöntemle iş oluştururken, pencerenin sağ kısmında iş ile ilgili dosyaları görmek, onları düzenlemek mümkündür.

.. image:: /assets/open-ondemand/images/500px-New_job_detail.png
.. image:: /assets/open-ondemand/images/500px-New_job_template_detail.png
   :width: 400

İş oluşturulduktan sonra ``Job Options`` kısmına tıklayarak işin özelliklerini tanımlamak mümkündür. Eğer iş ''TRUBA Job Template'' i kullanılarak oluşturulduysa, job option sayfasında ``job_scripts`` alanından altyapıda daha önce kullanılmakta olan iş betiklerinden *(truba/sw/scripts)* birini seçmek de mümkündür. Bu seçimden sonra iş kaydedilir ve iş betiği dosyasında ihtiyaç duyulan düzenlemeler gerçekleştirilir. ``Jobs`` sayfasında ilgili iş seçilerek ``submit`` butonuna basılarak iş kuyruğa gönderilebilir. 

.. image:: /assets/open-ondemand/images/Job_options.png

--------------------
Cluster Menüsü
--------------------

.. image:: /assets/open-ondemand/images/700px-Menu_cluster.png

Bu menüde "_TRUBA Shell Access" linkinden levrek1 sunucusuna terminal ekranı açmak mümkündür. Aslında portalın neredeyse tüm sayfalarından terminal ekranına ulaşmak mümkündür.

-------------------------
Interactive Apps Menüsü
-------------------------

.. image:: /assets/open-ondemand/images/ondemand-menu_interactive_app.png

Bu menüdeki öğeleri altyapıda görsel arayüz üzerinden ve etkileşimli olarak çalıştırmak mümkündür.

Bu kısımda çalıştırılacak tüm işler otomatik olarak "interactive" kuyruğuna gönderilecektir.

**TRUBA_Desktop:** Linux XFCE4 Masaüstü. Normal bir linux masaüstü ekranında yapılabilecek tüm işlemler yapılabileceği gibi, bu ekran altından terminali veya görsel uygulamaları kurmak, kullanmak mümkündür.

.. note::

    Web tarayıcıları, internet sayfalarının (noVNC dahil) kullanıcıların bilgisayarlarındaki clipboard (copy-paste listesi) alanına erişime güvenlik nedeni ile izin vermezler. Kullanıcı bu izini tarayıcının ayarları içerisinden değiştirebilir. Her tarayıcıda farklı olmakla birlikte, Google-Chrome tarayıcısında bu ayar, adres çubuğunun en sonundaki pano simgesine tıklayarak değiştirilebilir. 
    
    .. image:: /assets/open-ondemand/images/300px-Google-chrome-clipboard.png

* **MATLAB:** Uygun lisansı olan kullanıcı, TRUBA'da hali hazırda yüklü olan MATLAB uygulamasını görsel arayüzle ve etkileşimli olarak çalıştırabilir. *Bu uygulamayı çalıştırabilmek için kullanıcının kendi kurumu tarafından doğrulanacak floating lisansı veya levrek167 hostu için tanımlanmış lisansının bulunması gerekmektedir.*

* **Mathematica:** Uygun lisansı olan kullanıcı, TRUBA'da hali hazırda yüklü olan Mathematica uygulamasını görsel arayüzle ve etkileşimli olarak çalıştırabilir. *Bu uygulamayı çalıştırabilmek için kullanıcın kendi kurumu tarafından doğrulanacak floating lisansı veya levrek167 hostu için tanımlanmış lisansının bulunması gerekmektedir.*

* **GNUPLOT:** Ücretsiz ve açık lisanslı uygulamalara bir örnektir.

* **Rstudio:** TRUBA'da halihazırda yüklü bulunan R-4.0.2 versiyonunu Rstudio uygulaması üzerinden kullanmaya olanak verir. 

.. note::

    Bu alana zaman içerisinde yeni uygulamalar eklenecektir. Ayrıca her kullanıcı kendi görsel ve etkileşimli uygulamasını da kendi sayfasına ekleyebilir. Ayrıntılı bilgi için `Open OnDemand sayfasına <https://osc.github.io/ood-documentation/latest/>`_ bakınız.

---------------------
Jupyter Notebook
---------------------

Bu öğe ``Jupyter Notebook`` uygulamasını kullanmanızı sağlamaktadır. Diğer görsel ve etkileşimli uygulamalardan farklı olarak, bu öğeyi çalıştırıp öğeye bağlantı sağladığınızda, uygulamaya uzak sunucu üzerinde açılan görsel bir ekran yerine, kendi web tarayıcınızda açılacak yeni bir sekmeden erişebilmektesiniz.

Jupyter'in Anaconda aracılığı ile TRUBA üzerinde kurulumu hakkında ayrıntılı bilgiye Jupyter sayfasından ulaşabilirsiniz: :ref:`jupyter-anaconda`

Anaconda, Jupyter'in yanında pek çok uygulamayı da kurmaktadır. Bazı durumlarda Anaconda ile yapılan kurulumlar (``.bashrc`` dosyasındaki path ve conda tanımları) bazı sorunlara neden olmakta ve interaktif desktop erişimini engellemektedir. Böyle bi durumla karşılaşıldığında, ``.bashrc`` dosyasındaki conda tanımları silinmeli ve jupyter anaconda kullanılmadan tek başına kurulmalıdır.

---------------------------
My Interactive Sessions
---------------------------

Bu menü altındaki sayfada, Open OnDemand üzerinden başlatılmış aktif ya da süresi geçmiş olan interaktif işlerinizi görebilir, aktif olanlara bağlantı sağlayabilirsiniz. 
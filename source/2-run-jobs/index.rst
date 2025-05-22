.. _run_jobs:

=================================
İş Çalıştırma
=================================


İşlerinizi gönderirken `SLURM <https://slurm.schedmd.com>`_ betiklerini kullanmanız gerekmektedir.  
BASH kabuk programlama dilinin tüm öğelerini bu betikte kullanarak, pek çok detaylı analizi iş kuyruklarında yaptırmak mümkündür.

.. admonition:: Başlangıç için Önerilen Belgeler

    SLURM kullanmaya başlamadan önce aşağıdaki üç dosyayı incelemeniz tavsiye edilir:

    - `Temel SLURM Komutları <basic_slurm_commands.html>`_
    - `SLURM Betik Özellikleri <slurm_file_properties.html>`_
    - `Örnek SLURM Betiği <example_slurm.html>`_

.. note::
    
    İnteraktif işlerinizi çalıştırma ile ilgili ayrıntılı bilgi için  `interaktif iş çalıştırma dokümanımızı  <interaktif_is_calistirma.html>`_ ziyaret edebilirsiniz.


.. admonition:: Önemli Not

   Sistemimizde yüklü programlara ``module av`` komutu ile erişebilirsiniz. 
   Kullanmak istediğiniz program sistemde mevcut değilse, kendi dizininiz olan 
   ``/arf/home/username`` altında kaynak koddan derleyerek veya bir container 
   (`Apptainer <../Apptainer/Apptainer.html>`_) yardımıyla kurabilirsiniz.




Aşağıda sistemimizde sıklıkla kullanılan bazı uygulamalara yönelik örnek kullanım senaryolarını bulabilirsiniz.  
Bu başlıklar, yüksek başarımlı hesaplama (HPC) ortamlarında yaygın olarak tercih edilen programlara aittir. 

.. toctree::
   :maxdepth: 4

   genel_kurulum.rst
   interaktif_is_calistirma.rst
   Applications/index.rst
   GPU/index.rst




    
    
    


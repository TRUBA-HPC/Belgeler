.. _truba_iletisim:

=============================
Teknik Destek Talebi
=============================

TRUBA sisteminde karşılaştığınız sorunları ``grid-teknik@ulakbim.gov.tr`` adresine iletebilirsiniz. Sorununuzun hızlı ve etkin bir şekilde çözülebilmesi için, e-posta gönderirken aşağıda belirtilen standart bilgileri eksiksiz olarak iletmeniz önemlidir. 

Lütfen işinizle ilgili yaşadığınız problemi bildirirken aşağıdaki şablonu kullanınız:

.. code-block:: 

    - TRUBA kullanıcı adı:
    - TRUBA proje adı (varsa):
  
    - İş numarası (Job ID):
    - Kullandığınız yazılım/paket + versiyon:
    - Yüklü modüller:
  
    - Çalıştığınız dizinin tam yolu: 
    - SLURM betik dosyanızın ismi:
    - İşin çalıştığı sunucuların bilgisi (Node List):
  
    - Hata kayıtları:
    - İlgili hatayı alabilmemiz için adım adım izlediğiniz işlemler:
    - Hata ile ilgili açıklama:

 

.. note::

    İşinizin numarasını ve hesaplama kümesinde hangi sunucu(lar)da çalıştığı bilgisini kayıt dosyasına yazdırmak için SLURM dosyanıza aşağıdaki satırları ekleyebilirsiniz:

    .. code-block:: bash

        echo "SLURM_JOB_ID $SLURM_JOB_ID"
        echo "SLURM_NODELIST $SLURM_NODELIST"

    Alternatif olarak kuyrukta bekleyen işlerinize ait iş numarasını ``squeue`` komutunu kullanarak öğrenebilirsiniz. Biten işlerinize ait iş numarasını ve sunucu bilgilerini görüntülemek için ise ``sacct`` komutunu kullanabilirsiniz. ``--starttime`` ve ``-j`` opsiyonlarını değiştirmeyi unutmayınız.
    
    .. code-block:: bash

        sacct --starttime 2025-05-01 # JobID bilgisini öğrenin.
        sacct  -j job_id --format="JobID,JobName%30,Partition,NodeList,Account,Start,AllocCPUS,State,ExitCode" # NodeList bilgisini öğrenin.

.. warning::

    Sorunlarınızı kişisel e-posta adreslerine göndermeyiniz ve telefonla iletişim kurmak yerine, lütfen teknik destek taleplerinizi e-posta yoluyla iletmeyi tercih ediniz. Yaşanan sorunların ve yapılan işlemlerin yazılı olarak kaydedilmesi, çözüm sürecinin takibi açısından büyük önem taşımaktadır.

    TRUBA sisteminin kullanımı, karşılaştığınız sorunlar veya taleplerinizle ilgili olarak mutlaka ``grid-teknik@ulakbim.gov.tr`` teknik destek e-posta adresini kullanınız. Size gönderilen yanıtlara cevap verirken, e-posta programınızda "Tümünü Cevapla" (Reply-All) seçeneğini kullanarak, yanıtınızın hem ``grid-teknik@ulakbim.gov.tr`` adresine hem de ilgili tüm kişilere ulaştığından emin olunuz.

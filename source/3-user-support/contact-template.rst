==============================================
TRUBA Ekibiyle İletişim Kurmak için Şablonlar
==============================================

TRUBA sistemini kullanırken karşılaştığınız sorunları ``grid-teknik@ulakbim.gov.tr`` adresine mail atabilirsiniz. Size hızlı dönüş yapılabilmesi için mail içeriğinde belirtilmesi faydalı olan standart parametreler bulunmaktadır. İşiniz ile ilgili yaşadığınız sorun hakkında mail gönderirken aşağıdaki şablonu kullanabilirsiniz:

.. warning::

    Sorunlarınızı kişisel mail adreslerine göndermeyiniz ve sorununuzla ilgili telefonla bilgi almak yerine mail göndermeyi tercih ediniz. Yaşadığınız sorunla ilgili tüm kayıtların tutulması önemlidir.

.. code-block:: 

    Sistemdeki kullanıcı adınız:
    Çalıştığınız dizin (/arf/scratch/kullaniciadi dizini altında çalıştığınız klasörün tam yolu):
    Kuyruğa gönderdiğiniz dosyanın ismi (SLURM betik dosyanızın ismi):
    İş numarası (Job ID):
    İşin çalıştığı sunucuların bilgisi (Node List):
    Hata kayıtları:
    Açıklama:

.. note::

    İşinizin numarasını ve hesaplama kümesinde hangi sunucu(lar)da çalıştığı bilgisini kayıt dosyasına yazdırmak için SLURM dosyanıza aşağıdaki satırları ekleyebilirsiniz:

    .. code-block:: bash

        echo "SLURM_JOB_ID $SLURM_JOB_ID"
        echo "SLURM_NODELIST $SLURM_NODELIST"

    Alternatif olarak kuyrukta bekleyen işlerinize ait iş numarasını ``squeue`` komutunu kullanarak öğrenebilirsiniz. Biten işlerinize ait iş numarasını ve sunucu bilgilerini görüntülemek için ise ``sacct`` komutunu kullanabilirsiniz. ``--starttime`` ve ``-j`` opsiyonlarını değiştirmeyi unutmayınız.
    
    .. code-block:: bash

        sacct --starttime 2021-12-01 # JobID bilgisini öğrenin.
        sacct  -j job_id --format="JobID,JobName%30,Partition,NodeList,Account,Start,AllocCPUS,State,ExitCode" # NodeList bilgisini öğrenin.

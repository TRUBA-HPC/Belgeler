.. _mn5_dosya_transferi:

=====================
Dosya Transferi
=====================


.. warning::

   Bu dokümantasyon, MareNostrum 5 (MN5) resmi sayfasının belirli bölümleri Türkçeye çevrilerek **Haziran 2025** tarihinde hazırlanmıştır. Sistemde yapılan güncellemeler veya değişiklikler bu belgeye yansımamış olabilir. **En güncel ve doğrulanmış bilgiye ulaşmak için lütfen BSC'nin resmi MN5 belgelerine başvurunuz:**

   https://www.bsc.es/supportkc/docs/MareNostrum5/intro/


BSC MareNostrum 5 kümesinden veri transferi yapmak için çeşitli yöntemler mevcuttur. Bu bölümde, dosya transferi için önerilen araçlar ve kullanım şekilleri açıklanmaktadır.

.. warning::

   Tüm `scp`, `sftp`, `rsync` gibi komutlar **sadece yerel makinenizden** başlatılmalıdır. Güvenlik nedeniyle küme içinden dış dünyaya bağlantı yasaktır.

Yöntemler
---------

1. **Doğrudan Giriş Düğümlerine Kopyalama**

   SSH tabanlı araçlarla (örneğin `scp`, `sftp`, `rsync`) aşağıdaki giriş düğümlerine bağlanabilirsiniz:

   - `glogin1.bsc.es` veya `glogin2.bsc.es` (GPP için)
   - `alogin1.bsc.es` veya `alogin2.bsc.es` (ACC için)

2. **Veri Transfer Makineleri (Önerilen)**

   Büyük miktarda veri aktarımı için özel olarak ayrılmış transfer makineleri mevcuttur. Bu makineler tüm GPFS dosya sistemini paylaşır ve aynı kullanıcı bilgileriyle SSH ile erişilebilir:

   - `transfer1.bsc.es`
   - `transfer2.bsc.es`
   - `transfer3.bsc.es`
   - `transfer4.bsc.es`

   Bu makineler üzerinden `scp`, `rsync`, `sftp` gibi protokoller desteklenir.

3. **GPFS’yi Yerel Makineye Bağlamak**

   Bu daha gelişmiş bir yöntem olup özel ayarlamalar gerektirir. Detaylı bilgi için sistem yöneticinizle iletişime geçmeniz önerilir.

Kullanım Örnekleri
------------------

**SCP ile dosya kopyalama**

.. code-block:: bash

   # Yerel dosyayı kümeye kopyala
   localsystem$ scp localfile username@transfer1.bsc.es:

   # Kümeden yerel makineye dosya indir
   localsystem$ scp username@transfer1.bsc.es:remotefile localdir

**RSYNC ile veri aktarımı**

.. code-block:: bash

   # Yerelden kümeye
   localsystem$ rsync -avzP localfile_or_localdir username@transfer1.bsc.es:

   # Kümekten yerele
   localsystem$ rsync -avzP username@transfer1.bsc.es:remotefile_or_remotedir localdir

.. note::

   `rsync` komutunu kullanırken `--chown={user}:{group}` parametresi kullanılması önerilir. Aksi halde veriler varsayılan grubunuza yazılarak kota dolumuna yol açabilir.

**SFTP ile dosya transferi**

.. code-block:: bash

   localsystem$ sftp username@transfer1.bsc.es
   sftp> get remotefile

   localsystem$ sftp username@transfer1.bsc.es
   sftp> put localfile

Windows Kullanıcıları İçin
--------------------------

Windows kullanıcıları için `WinSCP`, `MobaXterm`, `FileZilla` gibi araçlar güvenli dosya transferi sağlar.

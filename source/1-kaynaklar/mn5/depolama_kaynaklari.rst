.. _mn5_depolama_kaynaklari:

=====================
Depolama Kaynakları
===================

MareNostrum 5 kullanıcılarına çeşitli dosya sistemleri üzerinden erişilebilen depolama alanları sunulmaktadır. Bu alanlar kullanım amacı, kalıcılık süresi ve kota politikaları açısından farklılık göstermektedir. Bu bölümde yer alan bilgilerin dikkatlice incelenmesi önerilir.

## Dosya Sistemi Türleri

Her hesaplama düğümünde aşağıdaki üç tür dosya sistemi mevcuttur:

* **GPFS (General Parallel File System)**: Tüm düğümlerden erişilebilen, yüksek performanslı bir paralel dosya sistemi.
* **Yerel SSD**: Her düğümde bulunan, yalnızca o düğümden erişilebilen geçici NVMe depolama alanı.
* **Kök (root) dosya sistemi**: İşletim sistemini barındıran NFS-tabanlı uzaktan dosya sistemi.

.. caution::
Kullanıcı verilerinin `/tmp` dizininde saklanması kesinlikle yasaktır. Geçici veriler için sadece `$TMPDIR` ortam değişkeniyle tanımlanan yerel SSD alanı kullanılmalıdır.

## GPFS Dosya Sistemleri

IBM GPFS dosya sistemi aşağıdaki alanları sunar:

* `/gpfs/home`: Kullanıcıların kişisel veri ve kaynak kodlarını sakladığı ev dizinleri. Her kullanıcıya ait bir kota uygulanır.
* `/gpfs/apps`: Sistem genelinde yüklü uygulamalar ve kütüphaneler burada bulunur.
* `/gpfs/projects/<GRUP>`: Kullanıcı gruplarına ait kalıcı proje verilerinin saklandığı dizin. Grup bazlı kota uygulanır.
* `/gpfs/scratch/<GRUP>`: Geçici iş dosyalarının tutulduğu alan. Bu dizin sık sık temizlenebilir; kalıcı veri saklamak için uygun değildir.
* `/gpfs/tapes/<GRUP>`: Orta-uzun vadeli veri arşivleme için kullanılan 400 PB kapasiteli bant tabanlı depolama sistemi. Bu sistemin yedeklemesi yoktur.

.. caution::
`/gpfs/home` dizininden doğrudan iş çalıştırılması önerilmez. Bunun yerine `/gpfs/projects` veya `/gpfs/scratch` dizinleri kullanılmalıdır.

.. info::
`/gpfs/home`, `/gpfs/apps` ve `/gpfs/projects` dosya sistemlerinin artımlı yedeklemesi alınır. Ancak yine de kritik verilerinizi yedeklemeniz sizin sorumluluğunuzdadır.

## Yerel SSD Depolama

Her düğüm, `/scratch/tmp/$JOBID` yoluyla erişilebilen NVMe tabanlı yerel bir SSD ile donatılmıştır. Bu alan sadece iş süresince geçici verilerin tutulması için uygundur ve iş tamamlandığında sistem tarafından otomatik olarak silinir.

.. caution::
Bu alanda tutulan veriler sadece ilgili hesaplama düğümünden erişilebilir. Giriş düğümlerinden erişim mümkün değildir.

## Kök (Root) Dosya Sistemi

İşletim sistemi, düğümlerde yerel olarak değil, sunuculardan NFS aracılığıyla sağlanan kök dosya sistemi üzerinden çalışır. Bu sistem yalnızca işletim sistemi için ayrılmıştır; kullanıcılar bu alana dosya yazmamalıdır.

## Kota Bilgisi

Tüm kullanıcılar ve gruplar için belirlenmiş varsayılan bir disk kotası mevcuttur. Bu kotalar `bsc_quota` komutu kullanılarak sorgulanabilir:

.. code-block:: bash
  bsc_quota

Elde edilen çıktılar, her dosya sistemi için ayrı ayrı mevcut kullanım ve kota bilgilerini içerir. Ek alana ihtiyaç duyulması halinde, proje sorumlusu tarafından gerekçesiyle birlikte bir talep gönderilmesi gerekir.

Daha fazla bilgi ve güncel detaylar için MareNostrum 5 resmi sayfasına başvurabilirsiniz:
`https://www.bsc.es/marenostrum/marenostrum-5`\_

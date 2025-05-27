=====================
Bağlantı Bilgisi
=====================

.. important::

   Kullanıcı hesapları **kişisel ve devredilemez** olarak tanımlanmıştır. Projeye yeni bir kullanıcı erişimi veya kaynak artırımı gerekiyorsa, **sorumluluk proje yöneticisine** aittir.

Giriş (SSH ile Bağlanma)
------------------------

MareNostrum 5 sistemine bağlantı yalnızca **SSH (Secure SHell)** protokolü üzerinden gerçekleştirilmelidir. Genel giriş düğümleri (login nodes) kullanılarak şu şekilde bağlanabilirsiniz:

.. code-block:: bash

   mylaptop$ ssh {kullanici_adi}@glogin1.bsc.es
   mylaptop$ ssh {kullanici_adi}@alogin1.bsc.es

**Genel Giriş Düğümleri (Public Login Nodes):**

- **MareNostrum 5 GPP:**
  - glogin1.bsc.es
  - glogin2.bsc.es

- **MareNostrum 5 ACC:**
  - alogin1.bsc.es
  - alogin2.bsc.es

- **Depolama & Veri Transferi:**
  - transfer1.bsc.es
  - transfer2.bsc.es
  - transfer3.bsc.es
  - transfer4.bsc.es

.. note::

   Bu sunucular, MareNostrum 4 sistemindeki `dt01.bsc.es` düğümünün karşılığıdır.

**Kısıtlı Giriş Düğümleri (Sadece BSC Personeli İçin):**

- glogin4.bsc.es
- alogin4.bsc.es

.. note::

   Bu düğümler sadece **BSC iç ağı** ya da **VPN** bağlantısı üzerinden erişilebilir.
   Dış dünyaya çıkış (internet erişimi) mümkündür.
   MareNostrum 4'teki `mn0.bsc.es` sunucusuna denktir.

Dış Ağa Erişim
--------------

Güvenlik politikaları gereği:

- **Yalnızca login düğümleri dış ağdan erişilebilir durumdadır.**
- Hesaplar, doğrudan dış dünyaya bağlantı kuramaz (örneğin wget, curl gibi işlemler çalışmaz).
- Tüm **dosya transferleri**, yalnızca **kullanıcının kendi bilgisayarı** üzerinden yapılmalıdır.

Dosya Transfer Örnekleri (SCP)
------------------------------

**MareNostrum 5 → Yerel Makine:**

.. code-block:: bash

   mylaptop$ scp -r {kullanici_adi}@transfer1.bsc.es:"MN5_KAYNAK_klasor" "YEREL_HEDEF_klasor"

**Yerel Makine → MareNostrum 5:**

.. code-block:: bash

   mylaptop$ scp -r "YEREL_KAYNAK_klasor" {kullanici_adi}@transfer1.bsc.es:"MN5_HEDEF_klasor"

Parola Değiştirme
-----------------

.. important::

   Güvenlik sebebiyle **ilk girişte** parolanızı değiştirmeniz zorunludur.

1. `transfer1.bsc.es` sunucusuna giriş yapın:

.. code-block:: bash

   mylaptop$ ssh {kullanici_adi}@transfer1.bsc.es

2. Ardından parola değiştirme komutunu çalıştırın:

.. code-block:: bash

   transfer1$ passwd

Yeni şifreniz yaklaşık **5 dakika** içinde aktif hale gelecektir.


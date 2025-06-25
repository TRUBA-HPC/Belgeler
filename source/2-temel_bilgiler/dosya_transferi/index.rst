.. _dosya_transferi:

========================================
Dosya Transferi
========================================


TRUBA sistemine uzaktan erişim sağlamak ve veri aktarımı gerçekleştirmek için öncelikle VPN bağlantısının **aktif hale getirilmiş olması gerekmektedir**. VPN bağlantısı olmadan aşağıdaki işlemlerin gerçekleştirilmesi mümkün değildir. Eğer VPN bağlantınız yoksa, :ref:`open-vpn` bölümünden gerekli yönergeleri takip edebilirsiniz.

.. warning::
   
   VPN bağlantısı kurulduktan sonra, **daha hızlı veri aktarımı** için aşağıdaki kullanıcı arayüzlerinin tercih edilmesi önerilir:

   - ``arf-ui4 (172.16.6.14)``
   - ``arf-ui5 (172.16.6.15)``

Dosya Aktarımı Yöntemleri
-------------------------

TRUBA sistemine dosya aktarımı için farklı işletim sistemlerine uygun çeşitli yöntemler mevcuttur. Aşağıda en yaygın kullanılan yöntemler detaylı olarak açıklanmıştır.

.. note::
   
   Aşağıdaki örneklerde IP adresi yerine yukarıda belirtilen kullanıcı arayüzü IP adreslerini kullanmanız gerekmektedir.

.. grid:: 2
    
    .. grid-item-card:: :ref:`linux-macos-kullanici-arayuzu`
        :text-align: center
    .. grid-item-card:: :ref:`windows-kullanici-arayuzu`
        :text-align: center

.. _linux-macos-kullanici-arayuzu:

Linux ve macOS Kullanıcıları
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. `rsync` Kullanımı
^^^^^^^^^^^^^^^^^^^^

`rsync`, dosya aktarımında en verimli yöntemlerden biridir. Yalnızca değişen dosyaları aktararak **ağ trafiğini minimize eder** ve **hızlı senkronizasyon** sağlar.

**Temel Kullanım:**

.. code-block:: bash

    # Tek dosya aktarımı
    rsync -av dosya_adi kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/
    
    # Dizin aktarımı (recursive)
    rsync -av yerel_dizin/ kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/
    
    # Uzaktan yerel bilgisayara aktarım
    rsync -av kullanici_adi@<arayuz-ip-adresi>:/uzak/dizin/ yerel_dizin/

**Yaygın Kullanılan Parametreler:**

- ``-a``: Archive modu (dosya özelliklerini korur, recursive dahil)
- ``-v``: Verbose (detaylı çıktı)
- ``-z``: Sıkıştırma (yavaş ağlarda faydalı)
- ``-P``: İlerleme çubuğu ve kısmi aktarım desteği
- ``--delete``: Hedefte olmayan dosyaları siler
- ``-r``: Recursive (dizinler için, -a ile birlikte gereksiz)
- ``-n``: Dry run (test modu, gerçek aktarım yapmaz)
- ``--exclude``: Belirli dosya/dizinleri hariç tutar

**Gelişmiş Kullanım - Paralel Aktarım:**

Büyük veri setleri için GNU Parallel ile paralel aktarım:

.. code-block:: bash

    # 7 paralel işlem ile aktarım
    parallel -j 7 rsync -av {} kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/ ::: dosya1 dosya2 dosya3

2. `scp` Kullanımı
^^^^^^^^^^^^^^^^^^

`scp` (Secure Copy), SSH protokolü üzerinden güvenli dosya aktarımı sağlar.

**Temel Kullanım:**

.. code-block:: bash

    # Dosya aktarımı
    scp dosya_adi kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/
    
    # Dizin aktarımı (recursive)
    scp -r yerel_dizin/ kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/
    
    # Uzaktan yerel bilgisayara aktarım
    scp -r kullanici_adi@<arayuz-ip-adresi>:/uzak/dizin/ yerel_dizin/

**Faydalı Parametreler:**

- ``-r``: Recursive (dizinler için)
- ``-C``: Sıkıştırma
- ``-P port``: Özel port kullanımı
- ``-v``: Verbose (detaylı çıktı)
- ``-p``: Dosya izinlerini korur
- ``-i``: Özel SSH anahtarı kullanır

3. `sftp` Kullanımı
^^^^^^^^^^^^^^^^^^^

Etkileşimli dosya aktarımı için `sftp` kullanabilirsiniz:

.. code-block:: bash

    # SFTP oturumu başlatma
    sftp kullanici_adi@<arayuz-ip-adresi>
    
    # SFTP komutları
    put yerel_dosya uzak_dosya    # Yükleme
    get uzak_dosya yerel_dosya    # İndirme
    mput *.txt                    # Çoklu yükleme
    mget *.txt                    # Çoklu indirme
    lcd yerel_dizin               # Yerel dizin değiştirme
    cd uzak_dizin                 # Uzak dizin değiştirme
    ls                           # Uzak dizin listesi
    lls                          # Yerel dizin listesi
    quit                          # Çıkış

.. _windows-kullanici-arayuzu:

Windows Kullanıcıları
~~~~~~~~~~~~~~~~~~~~~

Windows işletim sisteminde dosya aktarımı için hem komut satırı hem de grafiksel arayüz seçenekleri mevcuttur.

**Komut Satırı Yöntemleri:**

Windows 10 ve sonrasında OpenSSH istemcisi varsayılan olarak gelir:

.. code-block:: powershell

    # PowerShell veya CMD'de
    scp dosya_adi kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/
    rsync -av yerel_dizin/ kullanici_adi@<arayuz-ip-adresi>:/hedef/dizin/

**Grafiksel Arayüz Uygulamaları:**

Aşağıdaki popüler uygulamalar sürükle-bırak yöntemiyle kolay dosya aktarımı sağlar:

- `MobaXTerm <https://mobaxterm.mobatek.net/>`_: Kapsamlı SSH istemcisi ve dosya yöneticisi
- `FileZilla <https://filezilla-project.org/>`_: Açık kaynak, çoklu protokol desteği
- `WinSCP <https://winscp.net/>`_: Özellikle SFTP/SCP için optimize edilmiş

Detaylı kurulum ve kullanım kılavuzları için:

- :ref:`MobaXTerm <mobaxterm>`
- :ref:`WinSCP <winscp>`

Bu uygulamalar sayesinde dosyalar sürükle-bırak yöntemiyle kolaylıkla indirilebilir veya yüklenebilir.

**Performans İpuçları:**

- Büyük dosyalar için `rsync` tercih edin
- Ağ bağlantınız yavaşsa sıkıştırma parametrelerini kullanın
- Çok sayıda küçük dosya için paralel aktarım yöntemlerini değerlendirin
- VPN bağlantınızın stabil olduğundan emin olun
- Aktarım öncesi `rsync -n` ile test yapın
- Gereksiz dosyaları `--exclude` ile hariç tutun










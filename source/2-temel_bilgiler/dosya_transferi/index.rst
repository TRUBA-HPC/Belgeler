.. _dosya_transferi:

========================================
Dosya Transferi
========================================


TRUBA sistemine uzaktan erişim sağlamak ve veri aktarımı gerçekleştirmek için öncelikle VPN bağlantısının **aktif hale getirilmiş olması gerekmektedir**. VPN bağlantısı olmadan aşağıdaki işlemlerin gerçekleştirilmesi mümkün değildir.

Kullanıcı Arayüzü Tavsiyesi
---------------------------
VPN bağlantısı kurulduktan sonra, **daha hızlı veri aktarımı** için aşağıdaki kullanıcı arayüzlerinin tercih edilmesi önerilir:

- ``arf-ui4 (172.16.6.14)``
- ``arf-ui5 (172.16.6.15)``


Windows İşletim Sistemi için
------------------------------

Windows işletim sisteminde dosya transferlerinizi terminaldeki komutların yanı sıra MobaXTerm, FileZilla ve WinSCP gibi araçlarla da gerçekleştirebilirsiniz.
İlgili içeriklere dokümantasyon sayfamızdan erişebilirsiniz.

.. toctree::
   :maxdepth: 1
   :caption: Dosya Transfer Araçları

   mobaxterm.rst
   winscp.rst




Veri Aktarımı için Yöntemler
----------------------------

### 1. `rsync` Kullanımı (Linux/macOS)

`rsync`, yalnızca kaynak dosyalar ile hedefteki mevcut dosyalar arasındaki **farkları** aktararak, **ağ üzerinden iletilen veri miktarını en aza indirir**. Bu özelliğiyle sıkça tercih edilen bir yöntemdir.

Temel kullanım örneği:

.. code-block:: bash

    rsync -av kullanıcı_adı@172.16.6.14:/dizin_adi yerel_dizin_adi

Daha hızlı veri aktarımı için paralel taşıma yöntemi de kullanılabilir. Örneğin GNU Parallel ile:

.. code-block:: bash

    parallel -j 7 rsync /sender /destination

> Bu yöntem, büyük ve çok sayıda dosya içeren dizinler için veri aktarım süresini önemli ölçüde kısaltabilir.

### 2. `scp` Kullanımı (Linux/macOS)

Alternatif olarak, `scp` komutu da kullanılabilir. Örnek kullanım:

.. code-block:: bash

    scp -r kullanıcı_adı@172.16.6.14:/dizin_adi .

### 3. Windows Kullanıcıları için

Windows kullanıcıları, aşağıdaki görsel arayüzlü uygulamaları kullanarak veri transferi gerçekleştirebilir:

- **WinSCP**: https://winscp.net/
- **FileZilla**: https://filezilla-project.org/

Bu uygulamalar sayesinde dosyalar sürükle-bırak yöntemiyle kolaylıkla indirilebilir veya yüklenebilir.

Önemli Notlar
-------------
- Yukarıdaki tüm işlemler için sistemde bir kullanıcı hesabınızın olması gerekmektedir.
- İlk bağlantıdan önce **VPN yapılandırma dosyasının ve TRUBA VPN istemcisinin doğru şekilde kurulmuş ve yapılandırılmış olması** gerekmektedir.
- Eğer VPN bağlantınız yoksa, https://docs.truba.gov.tr adresindeki :ref:`open-vpn` bölümünden gerekli yönergeleri takip edebilirsiniz.












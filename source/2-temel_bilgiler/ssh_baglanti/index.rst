.. _ssh-baglanti:   

========================================
SSH Bağlantısı
========================================

.. warning::

   Öncelikle, ULAKNET ağı içinde veya dışında olma durumunuz farketmeksizin, :ref:`OpenVPN bağlantısını başarılı bir şekilde sağlamalısınız <open-vpn>`.
   
   Bağlanmak istediğiniz arayüz IP adresini, :ref:`ARF bağlantı bilgileri <arf_baglanti>` adresinden öğrenebilirsiniz.

.. grid:: 2
    :gutter: 2
    
    .. grid-item-card:: :ref:`linux-macos-ssh`
        :text-align: center
    .. grid-item-card:: :ref:`windows-ssh`
        :text-align: center


.. _linux-macos-ssh:

Linux ve macOS
--------------------------------

Linux ve macOS işletim sistemlerinde TRUBA bilgisayarlarına bağlanmak için aşağıdaki adımları izleyebilirsiniz.

1. Terminal uygulamasını açınız.

2. Aşağıdaki komutu kullanarak TRUBA'ya bağlanabilirsiniz:

   .. code-block:: bash

      ssh kullanici_adi@<arayuz-ip-adresi>


3. İlk kez bağlanırken sistem sizden sunucunun güvenilirliğini onaylamanızı isteyecektir. "yes" yazarak devam edebilirsiniz.

4. Ardından kullanıcı şifrenizi girmeniz istenecektir. Şifrenizi girerken ekranda herhangi bir karakter görünmeyecektir, bu normal bir durumdur.

.. _windows-ssh:

Windows
-------

Windows 10 (1803 ve sonrası) ile birlikte Microsoft, OpenSSH istemcisini işletim sistemine **varsayılan** olarak entegre etmiştir. Bu sayede kullanıcılar, üçüncü parti yazılımlar (örneğin PuTTY, WinSCP) kullanmadan doğrudan ``ssh``, ``scp`` ve ``sftp`` gibi komutları PowerShell, Komut İstemi (CMD) veya Windows Terminal üzerinden çalıştırabilmektedir.

Kurulum Durumu Kontrolü
-----------------------

OpenSSH istemcisinin kurulu olup olmadığını doğrulamak için aşağıdaki komut terminalde çalıştırılabilir::

    ssh -V

Eğer kurulu değilse, aşağıdaki adımlar izlenerek yüklenebilir:

1. **Ayarlar > Uygulamalar > İsteğe Bağlı Özellikler** menüsüne gidin.
2. ``OpenSSH Client`` bileşeni listede yoksa, **"Özellik ekle"** seçeneği kullanılarak yükleyin.


.. note:: 

   Önceki yıllarda yaygın olarak kullanılan **PuTTY** ve **WinSCP** gibi araçlar hâlâ tercih edilebilir; ancak modern Windows sistemlerde OpenSSH istemcisi bu tür ihtiyaçların büyük çoğunluğunu karşılamaktadır.
   
.. toctree::
    :maxdepth: 1
    :caption: PuTTY ile SSH Bağlantısı

    putty.rst


**Kaynaklar**

- Microsoft Docs: `OpenSSH Overview <https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh-overview>`_
- Microsoft Docs: `Installation and First Use of OpenSSH on Windows <https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui&pivots=windows-server-2025>`_




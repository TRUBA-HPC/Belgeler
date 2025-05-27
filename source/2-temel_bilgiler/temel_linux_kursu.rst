.. _temel_linux_kursu:


Temel Linux Komutları
=====================

Bu bölümde, ARF sisteminde sıkça kullanılan temel Linux komutları ve dosya/dizin işlemleri hakkında bilgiler verilmektedir.

Dizin ve Dosya İşlemleri
------------------------

Yeni bir dizin oluşturmak için:

.. code-block:: bash

   mkdir /arf/scratch/kullanici_adi/yeni_dizin

Bir dosya oluşturmak için:

.. code-block:: bash

   touch /arf/scratch/kullanici_adi/yeni_dosya.txt

Bir dosyayı görüntülemek için:

.. code-block:: bash

   cat /arf/scratch/kullanici_adi/yeni_dosya.txt

Dosya ve Dizin Taşıma/Kopyalama
-------------------------------

Bir dosyayı kopyalamak için:

.. code-block:: bash

   cp /arf/scratch/kullanici_adi/dosya.txt /arf/scratch/kullanici_adi/dosya_kopya.txt

Bir dizini kopyalamak için:

.. code-block:: bash

   cp -r /arf/scratch/kullanici_adi/dizin /arf/scratch/kullanici_adi/dizin_kopya

Bir dosyayı taşımak veya yeniden adlandırmak için:

.. code-block:: bash

   mv /arf/scratch/kullanici_adi/dosya.txt /arf/scratch/kullanici_adi/dosya_yeni.txt

Dosya ve Dizin Silme
--------------------

Bir dosyayı silmek için:

.. code-block:: bash

   rm /arf/scratch/kullanici_adi/dosya.txt

Bir dizini ve içeriğini silmek için:

.. code-block:: bash

   rm -r /arf/scratch/kullanici_adi/dizin

Dosya ve Dizin İzinleri
-----------------------

Bir dosyanın izinlerini değiştirmek için:

.. code-block:: bash

   chmod 755 /arf/scratch/kullanici_adi/dosya.txt

Bir dosyanın sahibi ve grubunu değiştirmek için:

.. code-block:: bash

   chown kullanıcı_adi:grup_adi /arf/scratch/kullanici_adi/dosya.txt

Disk Kullanımı
--------------

Bir dizinin disk kullanımını görmek için:

.. code-block:: bash

   du -sh /arf/scratch/kullanici_adi/dizin

Diskteki boş alanı görmek için:

.. code-block:: bash

   df -h

Dosya Arama
-----------

Belirli bir dosyayı aramak için:

.. code-block:: bash

   find /arf/scratch/kullanici_adi -name "dosya.txt"

Dosya İçeriği Arama
-------------------

Bir dosya içinde belirli bir kelimeyi aramak için:

.. code-block:: bash

   grep "aranan_kelime" /arf/scratch/kullanici_adi/dosya.txt

Birden fazla dosyada arama yapmak için:

.. code-block:: bash

   grep -r "aranan_kelime" /arf/scratch/kullanici_adi/

Notlar
------

- ``/arf/scratch`` dizini, kullanıcıların geçici dosyalarını saklamaları için ayrılmıştır.
- Bu dizindeki veriler belirli aralıklarla temizlenebilir; önemli verilerinizi kalıcı dizinlerde saklamanız önerilir.
- Daha fazla bilgi için ARF kullanıcı belgelerine başvurabilirsiniz.



========================================
TRUBA'da Uygulama/Kütüphane Kurulumu
========================================

Yaygın kullanılmakta olan pek çok uygulamanın/kütüphanenin farklı versiyonlarının kurulumları hali hazırda merkezi dizinlere bulunmaktadır.


Merkezi kurulumları kullanabilmek için ilgili yazılımın ve bağlantılı kütüphanelerin modüllerinin "load" edilmesi yeterlidir.Sistemde hali hazırda kurulu olan programlar hakkındaki bilgiye terminalden

.. code-block:: bash

    module available

komutunu yazarak ulaşabilirsiniz. İlgili komutu yazdığınızda TRUBA sisteminde halihazırda kurulu olan derleyiciler, kütüphaneler ve de uygulamalar listelenecektir.

.. code-block:: bash

    module load {yüklenmek istenen modül}

    

.. warning::

   Kullanıcılarımıza merkezi dizinlerdeki kurulumları kullanmalarını öneririz. Ancak kullanılmak istenen yazılım merkezi dizinde kurulu değilse, ya da mevcut kurulum ihtiyacı karşılamıyorsa
   (versiyon, derleme seçenekleri vs), yazılımın kullanıcının kendi ev dizinine (/arf/home/), yine kullanıcı tarafından yapılması gerekmektedir.

İnternetten indirilecek yazılımlar binary paket (hazır derlenmiş) ya da kaynak kod olarak dağıtılır.   
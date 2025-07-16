.. _python-kilavuzu:

===============
Python Kılavuzu
===============

Bu belge TRUBA altyapısında Python ve ilgili platformların kullanımını kolaylaştırmak için oluşturulmuştur.

.. warning:: 
    
    * `/arf` ve `/truba` depolama sistemlerine anaconda, miniconda, conda  veya herhangi bir Python kütüphanesi kesinlikle yüklenmemelidir, pip ve türevleri kullanılmamalıdır. Küçük boyutlu yüzbinlerce dosyadan oluştuğu için, her kullanıcının kendi ev dizinine kurduğu bu tip kütüphaneler dosya sistemlerinin performanslarını büyük ölçüde düşürmekte ve çalışan işlerin yavaşlamasına neden olmaktadır.
    * `/arf/sw/lib` ve `/truba/sw/X/lib` dizinlerinde çok geniş kapsamlı conda kütüphaneleri hali hazırda yüklüdür. Ayrıca YBH sistemleri için oluşturulmuş conda konteynerleri kullanıcılarımızın kullanımına sunulmuş durumdadır. Kullanıcılarımız Python ve conda ihtiyaçları için bu kurulumları kullanabilir ya da kendi Python konteynerlerini oluşturabilirler. Detaylar aşağıdaki bağlantıdan erişilebilir.

.. toctree::
    :maxdepth: 1

    python.rst
    jupyter.rst
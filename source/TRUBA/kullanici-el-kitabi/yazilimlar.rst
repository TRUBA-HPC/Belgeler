.. _yazilimlar:

===========
Yazılımlar
===========

------
Genel
------

TRUBA gibi *batch* tabanlı sistemlerde, kullanıcıların işlerini interaktif olarak çalıştırmaları mümkün değildir. Kullanıcılar, kullanıcı arayüzüne bağlandıktan sonra işlerini ve dosyalarını kendi dizinlerinde yapılandırarak, işlerini slurm betik dosyası kullanarak iş kuyruklarına göndermek durumundadır. İş kuyruklarında işin sırası geldiğinde ve talep edilen hesaplama kaynağı oluştuğunda, iş otomatik olarak başlar ve betik dosyasında belirtilen hesapları yaptıktan sonra sonlanır. Bu nedenle kullanılacak uygulamaların Linux komut satırından başlatılıp, herhangi bir kullanıcı etkileşimine ihtiyaç olmadan (ihtiyaç duyulan parametreleri komut satırı argümanları ya da input dosyalarından almalıdır) çalışabilecek ve grafik ekrana ihtiyaç duymayacak özellikte olması gerekmektedir.

----------------------------------
Lisansı Ücretli Olan Uygulamalar
----------------------------------
Sistemde kurulu uygulamaların bir kısmı lisansı ücretli olan uygulamalardır. TRUBA altyapısında lisansı ücretli olan hiçbir uygulama (Intel derleyicileri hariç) sağlanmamaktadır. Bu tür uygulamaları kullanmak isteyen kullanıcılar TRUBA'da çalışmaya uygun lisansı da kendileri (ya da bağlı bulundukları kurum aracılığıyla) sağlamalıdır.

TRUBA'da kullanıcılar sadece kullanıcı arayüzü sunucusuna erişebilir. Ancak tüm hesaplamalar hesaplama sunucuları üzerinde gerçekleştirilir. İş kuyruklarına gönderilen işlerin hangi hesaplama sunucuları üzerinde çalışmaya başlayacağı önceden belli değildir. O nedenle kullanıcıların bilgisayar bağımsız (floating) bir lisansa ihtiyaçları bulunmaktadır. Ayrıca uygulama çalışmaya başladığında, kullanıcının lisansının doğrulanabilmesi için bir bir lisans sunucusuna ihtiyaç vardır. Bu lisans sunucusu, kullanıcı (ya da kurumu) tarafından sağlanmalı ve işletilmelidir. **Bu nedenle kullanıcının kurumundaki lisans sunucusunun TRUBA bilgisayarlarına (193.140.99.241) lisans doğrulaması için izin vermesi gerekmektedir.**
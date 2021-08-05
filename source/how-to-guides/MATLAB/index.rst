.. _matlab-kilavuzu:

=================================
MATLAB Kılavuzu
=================================


MATLAB, **lisansı ücretlli** olan bir uygulamadır. TRUBA lisansı ücretli olan hiçbir uygulamayı (Intel derleyicileri haric) sağlamamaktadır. Matlab kullanmak isteyen kullanıcılar burada çalışmaya uygun lisansı da kendileri (ya da bağlı bulundukları kurum) sağlamalıdır.

.. warning::

    TRUBA'da kullanıcılar sadece kullanıcı arayüzü sunucusuna erişebilir. Ancak tüm hesaplamalar hesaplama suncuları üzerinde gerçekleştirilir. İş kuyruklarına gönderilen işlerin hangi hesaplama sunucuları üzerinde çalışmaya başlayacağı önceden belli degildir. O nedenle kullanıcıların bilgisayar bağımsız (floating) bir lisansa ihtiyaçları bulunmaktadır. Ayrıca MATLAB çalışmaya başladığında, kullanıcının lisansının doğrulanabilmesi için bir lisans sunucusuna ihtiyaç vardır. Bu lisans sunucusu kullanıcı (ya da kurumu) tarafından sağlanmalı ve işletilmelidir. **Bu nedenle kullanıcının kurumundaki lisans sunucusun TRUBA bilgisayarlarlarına (193.140.99.241) lisans doğrulaması için izin vermesi gerekmektedir.**

TRUBA'da **MATLAB'ın R2018b** veriyonu tüm toolboxları ile **/truba/sw/centos7.3/app/matlab/R2018b** dizininde kurulu durumdadır. Ancak kullanıcının bu versiyonu kullanabilmesi için uygun lisansının bulunması gerekmektedir. MATLAB için örnek iş betiği ``/truba/sw/scripts`` dizini altında bulunmaktadır. Kullanıcılar çekirdek, node ve süre gibi parametrelerin yanında lisans dosyasının adresini ve input dosyalarını değiştirerek uygulamayı kullanmaya başlayabilirler.

Eğer kullanıcının mevcut lisansı, R2018b'yi çalıştırmaya uygun değilse, kullanıcı lisansına uygun versiyonu kendi ev dizinine kurup kullanabilir. Bu durumda betik dosyasındaki çevre değişkenleri (MATLAB_DIR, PATH, LD_LIBRARY_PATH vs) kendi kurulumuna göre değiştirmek durumundadır.

.. note::

    **TRUBA** gibi **batch** tabanlı sistemlerde, kullanıcıların işlerini interaktif olarak çalıştırmaları mükün değildir. Kullanıcılar kullanıcı arayüzüne bağlandıktan sonra işlerini ve dosyalarını yapılandırarak, işlerini iş kuyruklarına göndermek durumundadır. İş kuyruklarında işin sırası geldiğinde ve talep edilen hesaplama kaynağı oluştuğunda, iş otomatik olarak başlar ve yapması gerken hesapları yaptıktan sonra sonlanır. **Bu nedenle kullanılacak uygulamların linux komut satırından başlatılıp, herhangi bir kullanıcı etkileşimine ihtiyaç olmadan (ihtiyaç duyulan parametreleri komut satırı argümanları yada input dosyalarından almalıdır) çalışabilecek ve grafik ekrana ihtiyaç duymayacak özellikte olması gerekmektedir.**
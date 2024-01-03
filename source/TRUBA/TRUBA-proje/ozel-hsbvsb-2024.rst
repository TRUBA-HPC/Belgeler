.. _ozelkurum-hsbvsb-2024:

===============================================================================================================================
TRUBA Hizmetlerinden Özel Kurumlar için HSB ve VSB Hizmeti 2024
===============================================================================================================================


Hesaplama ve veri depolama ihtiyacı olan isteklilerin, ihtiyaçlarının TRUBA kaynakları tarafından karşılanabilmesi için 22 Ekim 2010 tarih ve 65 sayılı TÜBİTAK ULAKBİM Yönetim Kurulu'nda onaylanan "TÜBİTAK ULAKBİM tarafından Yüksek Başarımlı ve Grid Hesaplama Merkezi Üzerinden Yürütülecek Dış Destekli Projelere İlişkin Çerçeve İlkeler” kapsamında TRUBA kaynakları ücretlendirilebilmektedir.

Bu kapsamda proje önerisinde hesaplama ve veri depolama isteği bulunan kurumların TRUBA Hizmetleri'nden faydalanmak istemesi durumunda ilgili *Çerçeve İlkeler* kapsamında proforma fatura hazırlanarak, projesinin kabul edilmesinden sonra ilgili kurum ve TÜBİTAK ULAKBİM Müdürlüğü arasında imzalanan sözleşme kapsamında HSB ve VSB Hizmeti verilmekteydi. Günümüzde ilgili hizmetlerin saatlik birim bedelleri her yıl başında belirlenerek, web sayfasında ilan edilmektedir. Bu nedenle proforma hazırlanmamaktadır. İlgili hizmetin alımına karar verildikten sonra karşılıklı olarak sözleşme imzalanmaktadır.

**Özel Kurumlar** aşağıda yer alan ücret bedelleri ile projeleri için TRUBA Hizmetleri'nden faydalanmak üzere ücretlendirme çalışması yapabilirler. Ancak, ilgili çalışmayı tamamladıktan sonra kaynakların uygunluk durumu ve mevcut hesaplamanın doğruluğu ile ilgili ``trubaservis@ulakbim.gov.tr`` adresine e-posta göndermeleri beklenmektedir. Tarifenin web sayfasında yayınlaması nedeni ile uygunluk mesajı alan kurumlar, ilgili hesaplamayı proforma olarak kullanabileceklerdir. Talep edilirse, TÜBİTAK ULAKBİM Müdürlüğü tarafından proforma düzenlenecektir. 


+-----------------------+----------------------------+----------------------------------------------------+
|                                  Hesaplama Servis Birimi (HSB)                                          |
+=======================+============================+====================================================+
| Sunucu Tipi           | Saatlik İşlemci            | Sunucu Özelliği                                    |
|                       | Çekirdeği Bedeli [#note1]_ |                                                    |
+-----------------------+----------------------------+----------------------------------------------------+
| Akya-GPU [#note2]_    |    0,65 TL                 | Intel Xeon Gold 6148 2.40GHz, 2x20 çekirdek,       |
|                       |                            | çekirdek başına 9.6 GB bellek, EDR IB bağlantı,    |
|                       |                            | 4 x Tesla V100 16 GB GPU                           |
+-----------------------+----------------------------+----------------------------------------------------+
| Palamut-GPU           |    1,15 TL                 | AMD EPYC 7742 2.25GHz, 2x64 çekirdek,              |
|                       |                            | çekirdek başına 1.5 GB bellek, 4xHDR IB bağlantı,  |
|                       |                            | 8 x NVidia A100 80G GPU                            |
+-----------------------+----------------------------+----------------------------------------------------+
| Hamsi                 |    0,34 TL                 | Intel Xeon Gold 6258R 2.70GHz, 2x28 çekirdek,      |
|                       |                            | çekirdek başına 3.42 GB bellek, HDR100 IB bağlantı |
+-----------------------+----------------------------+----------------------------------------------------+
| Orfoz [#note3]_       |    0,28 TL                 | Intel Xeon Platinum 8480+ 2.0GHz, 2x56 çekirdek,   |
|                       |                            | çekirdek başına 2.28 GB bellek, NDR200 IB bağlantı |
+-----------------------+----------------------------+----------------------------------------------------+

.. [#note1] Saatlik hesaplama servis biriminin KDV hariç bedelidir.Herhangi bir hesaplama, veri depolama alanı olmadan kullanılamayacağı için ilgili bedele en az 1TB depolama alanı saatlik bedeli dahil edilmelidir.

.. [#note2] Akya-GPU kümesi için çekirdek/saat hesaplaması en az 10 çekirdek ve 10'un katları olarak, Palamut-GPU kümesi için çekirdek/saat hesaplaması en az 16 çekirdek ve 16'ın katları olarak yapılmalıdır. 

.. [#note3] Orfoz sunucuları 2023 yılı sonu itibari ile teslim alınmış olup, 2024 yılının ilk çeyreğinde servise alınacaktır. 


+----------------------+---------------------------+---------------------------------------------+
|                              Veri Servis Birimi (VSB)                                          |
+======================+===========================+=============================================+
| Depolama Tipi        | Saatlik 1 TB              | Sunucu Özelliği                             |
|                      | Depoloma Bedeli [#note4]_ |                                             |
+----------------------+---------------------------+---------------------------------------------+
| Depolama             |    0,33 TL                | Tüm hesaplama sunucuları tarafından         |
|                      |                           | görünen performans disk alanı               |
+----------------------+---------------------------+---------------------------------------------+

.. [#note4] Saatlik 1 TB veri servis birimin KDV hariç bedelidir. 

.. note:: 

   Hesaplamalarda 1 ay 30 gün, 1 yıl ise 360 gün (12ay x 30 gün) olarak hesaplanmaktadır. 


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hizmet Almak İsteyen Özel Kurumlar İçin Yaklaşık Maaliyet Belirlenmesi 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TÜBİTAK ULAKBİM tarafından işletilen TRUBA kaynaklarından proje kapsamında destek almak isteyen kurumlar, proje önerisinde bulunmadan önce ihtiyaç duydukları kaynak miktarlarına göre, yukarıdaki tablodan projeleri için ihtiyaç duyulan bütçeyi hazırlayabilirler. Her türlü soru ve sorun ``trubaservis@ulakbim.gov.tr`` e-posta adresine yönlendirilebilir. 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Özel Kurumlar İçin Sözleşme Düzenlenmesi
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TÜBİTAK ULAKBİM'den hizmet alacak olan özel kurumlar için, yukarıdaki tabloda yer alan işlemci saat bedeli üzerinden istenilen kaynak miktarları belirlenebilir. Karşılıklı olarak ihtiyaç duyulan HSB ve VSB değerleri üzerinden hizmet süresi boyunca kullanılacak çekirdek saat miktarı belirlenerek, en son HSB ve VSB değerlerine göre yeni sözleşme oluşturularak, Kurum Yetkilisi [#note5]_ ve TÜBİTAK ULAKBİM Müdürlüğü arasında imzalanır. İmzalanan sözleşme tarihlerine göre alınan hizmet aylık/dönemsel olarak Kurum adına faturalandırılır. Her türlü soru ve sorun trubaservis@ulakbim.gov.tr e-posta adresine yönlendirilebilir.

.. [#note5] Kurum yetkilisi, özel kurum tarafından ilgili hizmeti almaya yetkili kişi olmalıdır. Bu konuda TÜBİTAK ULAKBİM Müdürlüğü ek bilgi isteme hakkına sahiptir. 


Örnek Hesaplama - I
--------------------

Kullanıcılar, sunucuların teknik özelliklerini göz önünde bulundurarak (çekirdek hızı, çekirdek sayısı, bellek miktarı, işlemci mimarisi vs) kullanmak isteyecekleri sunucu grubunu belirleyebilirler. Merkezi dosya sistemi kullanılmadan herhangi bir hesaplama yapmak mümkün olmadığı için hizmet bedeline verileri saklamak için de bir bedel eklenmelidir. Eklenebilecek en az veri alanı büyüklüğü 1 TB'dır. Herhangi bir hesaplama ve veri saklama talebi için hizmet bedeli aşağıdaki gibi hesaplanabilir: 

 .. code-block::

    Toplam HSB = Toplam çekirdek zamanı x Talep Edilen Çekirdek Sayısı x Seçilen İşlemci Çekirdeğinin  Saatlik Bedeli
    Toplam VSB = Öngörülen veri saklama zamanı x TB Miktarı x Seçilen Veri Depolama Alanının Saatlik Bedeli


Mesela, projesi süresince 138.240 çekirdek saat [#note6]_ hesaplama yapmayı ve bu çalışmalarının sonuçlarını başlangıcından itibaren 120 gün süre [#note7]_ ile sistemde saklamayı öngören bir kullanıcı, ilgili hizmet tutarını aşağıdaki gibi hesaplayabilir [#note8]_ .

Eğer kullanıcı hesaplarını, Hamsi sunucuları üzerinde gerçekleştirmek ve verilerini 1TB depolama alanında saklamak istiyorsa:

 .. code-block::

    Toplam HSB = 138.240 saat x 0,34 TL = 47.001,60 TL
    Toplam VSB = 120 gün x 24 saat  x 1 TB x 0,33 = 950,40 TL
    Toplam Tutar = 47.001,60 TL + 950,40 TL = 47.952,00 TL (KDV Hariç)

.. [#note6] Aynı anda kullanılabilecek çekirdek sayısı sınırlıdır. En fazla aynı anda kullanılacak çekirdek sayısını bildirmek gerekmektedir. İlgili sayı proje yürütücüsü ve TÜBİTAK ULAKBİM Müdürlüğü arasında imzalanacak olan sözleşmede yer alacaktır.

.. [#note7] Bu süre, yapılacak hesaplamanın bitiş zamanından daha uzun olması gerekmektedir. Hesaplamaların bu süreden daha uzun çıkması durumunda, fazla süre ile kullanılan disk alanı bedeli son faturaya yansıtılacaktır.

.. [#note8] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir.



Örnek Hesaplama - II
--------------------

Hizmet bedelinin, çekirdek sayısı ve proje süresi üzerinden hesaplamak istenmesi durumunda aşağıdaki yol izlenebilir.

Mesela, projesi kapsamında 120 gün boyunca 112 çekirdek ile hesaplama yapmak ve 1 TB'a kadar depolama alanı kullanmak isteyen bir kullanıcı, toplam hizmet bedelini aşağıdaki gibi hesaplayabilir.

Eğer kullanıcı hesaplarını Hamsi sunucuları üzerinde gerçekleştirmek istiyorsa [#note9]_ :

 .. code-block::

    Toplam Çalışma Süresi  = 120 gün x 24 saat = 2880 Saat
    Toplam Çekirdek Zamanı = 120 gün x 24 saat x 112 = 322560 Saat
    Toplam HSB = 2880 Saat x 112 x 0,34 TL = 109.670,40 TL 
    Toplam VSB = 2880 saat x 1 TB x 0,33 = 950,40 TL 
    Toplam Tutar = 109.670,40 + 950,40 TL = 110.620,80 TL (KDV Hariç)

.. [#note9] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir. 

**GPU** ile hesaplama yapmak isteyen kullanıcılar, GPU'ların takılı oldugu sunuculardaki tüm çekirdekleri de fiyatlandırmak durumundadır. Örneğin 120 Gün boyunca 8 GPU kullanarak hesaplama yapmak isteyen bir kullanıcı, her biri 4 adet GPU bulunduran Akya sunucusunu kullanabilir. Akya sunucularındaki çekirdek sayısı 40'dır. Toplam 8 adet GPU kullanımı icin 2 adet Akya-GPU sunucusu ücretlendirilmelidir. Böyle bir hizmet talep edilmesi durumunda, hizmet tutarı aşağıdaki gibi hesaplanabilir [#note10]_ :

 .. code-block::

    Toplam Çalışma Süresi  = 120 gün x 24 saat = 2880 Saat
    Toplam Çekirdek Zamanı = 120 gün x 24 saat x 80 çekirdek = 230400 Saat
    Toplam HSB = 2880 Saat x 80 x 0,65 TL = 149.760,00 TL 
    Toplam VSB = 2880 saat x 1 TB x 0,33 = 950,40 TL 
    Toplam Tutar = 149.760,00 TL + 950,40 TL  = 150.710,40 TL (KDV Hariç)


.. [#note10] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir. 

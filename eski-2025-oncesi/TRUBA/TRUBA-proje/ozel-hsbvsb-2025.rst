.. _ozelkurum-hsbvsb-2025:

===============================================================================================================================
TRUBA Hizmetlerinden Özel Kurumlar için HSB ve VSB Hizmeti 2025
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
| Akya     [#note2]_    |    0,85 TL                 | Intel Xeon Gold 6148 2.40GHz, 2x20 çekirdek,       |
|                       |                            | çekirdek başına 9.6 GB bellek, EDR IB bağlantı,    |
|                       |                            | 4 x Tesla V100 16 GB GPU                           |
+-----------------------+----------------------------+----------------------------------------------------+
| Palamut               |    1,39 TL                 | AMD EPYC 7742 2.25GHz, 2x64 çekirdek,              |
|                       |                            | çekirdek başına 1.5 GB bellek, 4xHDR IB bağlantı,  |
|                       |                            | 8 x NVidia A100 80G GPU                            |
+-----------------------+----------------------------+----------------------------------------------------+
| Hamsi                 |    0,45 TL                 | Intel Xeon Gold 6258R 2.70GHz, 2x28 çekirdek,      |
|                       |                            | çekirdek başına 3.42 GB bellek, HDR100 IB bağlantı |
+-----------------------+----------------------------+----------------------------------------------------+
| Orfoz                 |    0,29 TL                 | Intel Xeon Platinum 8480+ 2.0GHz, 2x56 çekirdek,   |
|                       |                            | çekirdek başına 2.28 GB bellek, NDR200 IB bağlantı |
+-----------------------+----------------------------+----------------------------------------------------+
| Kolyoz                |    3,65 TL                 | Intel Xeon Gold 6548Y+ 2.50GHz, 2x32 çekirdek,     |
|                       |                            | çekirdek başına 16 GB bellek, 4xHDR200 IB bağlantı |
|                       |                            | 4 x NVidia H100 80 GB GPU                          |
+-----------------------+----------------------------+----------------------------------------------------+

.. [#note1] Saatlik hesaplama servis biriminin KDV hariç bedelidir.Herhangi bir hesaplama, veri depolama alanı olmadan kullanılamayacağı için ilgili bedele en az 1TB depolama alanı saatlik bedeli dahil edilmelidir.

.. [#note2] Akya kümesi için çekirdek/saat hesaplaması en az 10 çekirdek ve 10'un katları olarak, Palamut ve Kolyoz kümeleri için çekirdek/saat hesaplaması en az 16 çekirdek ve 16'ın katları olarak yapılmalıdır. 



+----------------------+---------------------------+---------------------------------------------+
|                              Veri Servis Birimi (VSB)                                          |
+======================+===========================+=============================================+
| Depolama Tipi        | Saatlik 1 TB              | Sunucu Özelliği                             |
|                      | Depoloma Bedeli [#note3]_ |                                             |
+----------------------+---------------------------+---------------------------------------------+
| YBH Depolama         |    0,51 TL                | Tüm hesaplama sunucuları tarafından         |
|                      |                           | görünen performans disk alanı               |
+----------------------+---------------------------+---------------------------------------------+
| YZ  Depolama         |    2,29 TL                | Tüm hesaplama sunucuları tarafından         |
|                      |                           | görünen performans disk alanı               |
+----------------------+---------------------------+---------------------------------------------+


.. [#note3] Saatlik 1 TB veri servis birimin KDV hariç bedelidir. Kullanımlarda yüksek performanslı hesaplama alanı olan YBH Depolama'dan alan tercih edilebilir. YZ teknolojilerinde çalışan işler için YZ Depolama'dan alan tercihi yapılabilir. YZ depolama alanının kısıtlı miktarda depolama alanına sahip olduğu göz önünde bulundurulmalıdır.  

.. note:: 

   Hesaplamalarda 1 ay 30 gün, 1 yıl ise 360 gün (12ay x 30 gün) olarak hesaplanmaktadır. 


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hizmet Almak İsteyen Özel Kurumlar İçin Yaklaşık Maaliyet Belirlenmesi 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TÜBİTAK ULAKBİM tarafından işletilen TRUBA kaynaklarından proje kapsamında destek almak isteyen kurumlar, proje önerisinde bulunmadan önce ihtiyaç duydukları kaynak miktarlarına göre, yukarıdaki tablodan projeleri için ihtiyaç duyulan bütçeyi hazırlayabilirler. Her türlü soru ve sorun ``trubaservis@ulakbim.gov.tr`` e-posta adresine yönlendirilebilir. 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Özel Kurumlar İçin Sözleşme Düzenlenmesi
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TÜBİTAK ULAKBİM'den hizmet alacak olan özel kurumlar için, yukarıdaki tabloda yer alan işlemci saat bedeli üzerinden istenilen kaynak miktarları belirlenebilir. Karşılıklı olarak ihtiyaç duyulan HSB ve VSB değerleri üzerinden hizmet süresi boyunca kullanılacak çekirdek saat miktarı belirlenerek, en son HSB ve VSB değerlerine göre yeni sözleşme oluşturularak, Kurum Yetkilisi [#note4]_ ve TÜBİTAK ULAKBİM Müdürlüğü arasında imzalanır. İmzalanan sözleşme tarihlerine göre alınan hizmet aylık/dönemsel olarak Kurum adına faturalandırılır. Her türlü soru ve sorun trubaservis@ulakbim.gov.tr e-posta adresine yönlendirilebilir.

.. [#note4] Kurum yetkilisi, özel kurum tarafından ilgili hizmeti almaya yetkili kişi olmalıdır. Bu konuda TÜBİTAK ULAKBİM Müdürlüğü ek bilgi isteme hakkına sahiptir. 


Örnek Hesaplama - I
--------------------

Kullanıcılar, sunucuların teknik özelliklerini göz önünde bulundurarak (çekirdek hızı, çekirdek sayısı, bellek miktarı, işlemci mimarisi vs) kullanmak isteyecekleri sunucu grubunu belirleyebilirler. Merkezi dosya sistemi kullanılmadan herhangi bir hesaplama yapmak mümkün olmadığı için hizmet bedeline verileri saklamak için de bir bedel eklenmelidir. Eklenebilecek en az veri alanı büyüklüğü 1 TB'dır. Herhangi bir hesaplama ve veri saklama talebi için hizmet bedeli aşağıdaki gibi hesaplanabilir: 

 .. code-block::

    Toplam HSB = Toplam çekirdek zamanı x Talep Edilen Çekirdek Sayısı x Seçilen İşlemci Çekirdeğinin  Saatlik Bedeli
    Toplam VSB = Öngörülen veri saklama zamanı x TB Miktarı x Seçilen Veri Depolama Alanının Saatlik Bedeli


Mesela, projesi süresince 138.240 çekirdek saat [#note5]_ hesaplama yapmayı ve bu çalışmalarının sonuçlarını başlangıcından itibaren 120 gün süre [#note6]_ ile sistemde saklamayı öngören bir kullanıcı, ilgili hizmet tutarını aşağıdaki gibi hesaplayabilir [#note7]_ .

Eğer kullanıcı hesaplarını, Hamsi sunucuları üzerinde gerçekleştirmek ve verilerini 1TB depolama alanında saklamak istiyorsa:

 .. code-block::

    Toplam HSB = 138.240 saat x 0,45 TL = 62.208,00 TL
    Toplam VSB = 120 gün x 24 saat  x 1 TB x 0,51 = 1.468,80 TL
    Toplam Tutar = 62.208,00 TL + 1.468,80 TL = 62.352,00 TL (KDV Hariç)

.. [#note5] Aynı anda kullanılabilecek çekirdek sayısı sınırlıdır. En fazla aynı anda kullanılacak çekirdek sayısını bildirmek gerekmektedir. İlgili sayı proje yürütücüsü ve TÜBİTAK ULAKBİM Müdürlüğü arasında imzalanacak olan sözleşmede yer alacaktır.

.. [#note6] Bu süre, yapılacak hesaplamanın bitiş zamanından daha uzun olması gerekmektedir. Hesaplamaların bu süreden daha uzun çıkması durumunda, fazla süre ile kullanılan disk alanı bedeli son faturaya yansıtılacaktır.

.. [#note7] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir.



Örnek Hesaplama - II
--------------------

Hizmet bedelinin, çekirdek sayısı ve proje süresi üzerinden hesaplamak istenmesi durumunda aşağıdaki yol izlenebilir.

Mesela, projesi kapsamında 120 gün boyunca 112 çekirdek ile hesaplama yapmak ve 1 TB'a kadar depolama alanı kullanmak isteyen bir kullanıcı, toplam hizmet bedelini aşağıdaki gibi hesaplayabilir.

Eğer kullanıcı hesaplarını Orfoz sunucuları üzerinde gerçekleştirmek istiyorsa [#note8]_ :

 .. code-block::

    Toplam Çalışma Süresi  = 120 gün x 24 saat = 2880 Saat
    Toplam Çekirdek Zamanı = 120 gün x 24 saat x 112 = 322560 Saat
    Toplam HSB = 2880 Saat x 112 x 0,29 TL = 93.542,40 TL 
    Toplam VSB = 2880 saat x 1 TB x 0,51 = 1.468,80 TL 
    Toplam Tutar = 93.542,40 + 1.468,80 TL = 95.011,20 TL (KDV Hariç)

.. [#note8] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir. 

**GPU** ile hesaplama yapmak isteyen kullanıcılar, GPU'ların takılı oldugu sunuculardaki tüm çekirdekleri de fiyatlandırmak durumundadır. Örneğin 120 Gün boyunca 8 GPU kullanarak hesaplama yapmak isteyen bir kullanıcı, her biri 4 adet GPU bulunduran Kolyoz sunucusunu kullanabilir. Kolyoz sunucularındaki çekirdek sayısı 64'dür. Toplam 8 adet GPU kullanımı icin 2 adet Kolyoz sunucusu ücretlendirilmelidir. Böyle bir hizmet talep edilmesi durumunda, hizmet tutarı aşağıdaki gibi hesaplanabilir [#note9]_ :

 .. code-block::

    Toplam Çalışma Süresi  = 120 gün x 24 saat = 2880 Saat
    Toplam Çekirdek Zamanı = 120 gün x 24 saat x 128 çekirdek = 368640 Saat
    Toplam HSB = 2880 Saat x 128 x 3,65 TL = 1.345.536,00 TL 
    Toplam VSB = 2880 saat x 1 TB x 0,51 =  1.468,80 TL 
    Toplam Tutar = 1.345.536,00 TL + 1.468,80 TL  = 1.347.004,80 TL (KDV Hariç)


.. [#note9] Hesaplanan miktarlar KDV hariç tutarlar olup, projenizin bütçesini belirlerken %20 KDV miktarının da dahil edilmesi gerekmektedir. 

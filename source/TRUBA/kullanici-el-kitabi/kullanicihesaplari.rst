====================
Kullanıcı Hesapları
====================

-------------------------------------
TRUBA Sistemini Kimler Kullanabilir?
-------------------------------------

Hesaplama kümesi üzerinde çalışabilir uygulamalara sahip Türkiye'deki tüm üniversite, araştırma kurumu ve enstitülerdeki araştırmacılar, öğretim üyeleri, öğrenciler TRUBA kaynaklarını kullanmak üzere TRUBA kullanıcısı olabilir. 

Ticari kullanıcılar ve endüstriyel işbirlikli akademik projeler TRUBA oluşumu tarafından değerlendirilerek kabul edilir. 

Altyapının kullanılması için çalışabilir uygulamaların (açık kaynak kodlu ve/veya lisanslı) aşağıdaki özelliklerden en az birini içermesi beklenmektedir: 

 * Birçok farklı bağımsız alt göreve bölünebilen yüksek geçişli hesaplamalar, 
 * Büyük miktarda verinin işlenmesini gerektiren yüksek performanslı hesaplamalar, 
 * Küçük bir zaman diliminde çok sayıda işlemin yapılmasını gerektiren işlemci merkezli hesaplamalar, 
 * Verilerin bir araya getirilmesi, saklanması ve çözümlenmesini de gerektirebilen veri merkezli hesaplamalar. 

----------------------------------
Başvuru ve Hesap Açılma Prosedürü
----------------------------------

Henüz öğrenci durumundaki araştırmacıların hesaplarının açılabilmesi için birlikte çalıştıkları akademik personelin ``grid-teknik@ulakbim.gov.tr`` e-posta adresine, başvuranın kendisi ile çalıştığına dair bilgi içeren bir onay e-postası göndermesi gerekmektedir. 

Yukarıdaki, ve başvuru sayfasındaki kullanım şartlarını sağlayan ve Linux işletim sistemi temel kullanım bilgisine sahip araştırmacı `portal.truba.gov.tr <http://portal.truba.gov.tr/>`_ adresinden yeni kullanıcı hesap açma başvurusunda bulunduktan kısa süre sonrasında portaldaki kayıtlı e-posta adresine bilgilendirme e-postaları gönderilecektir. 

Ön onaydan geçen araştırmacının kimlik bilgileri, e-Devlet ve YÖKSİS üzerinden onaylanmaktadır. Bu nedenle, araştırmacının herhangi bir kimlik bilgisini e-posta ve/veya başka yöntemlerle göndermesine gerek bulunmamaktadır. 

Kullanıcının kimlik doğrulamasının e-Devlet ve YÖKSİS üzerinden yapılmasının ardından, kullanıcının sistem üzerindeki kullanıcı hesabı (user account), ve kümeye iş gönderebilmesi için kaynak yöneticisi hesabı (bank account) kısa süre içerisinde açılarak, kullanıcıya e-posta ile kullanıcı adı ve şifresi hakkında geri bildirim yapılacaktır. TRUBA hesabı açılan araştırmacı, kullanıcı hesabı başvuru sayfasındaki kullanım politikasını kabul eder, ve bu şartlara göre çalışmalarını yürütür. 

.. note::

   TRUBA sistemini kullanan araştırmacılarımız bilimsel çalışmalar yürüttükleri için, yayınları ile eşleştirmek amacıyla, ORCID ID’lerine de ihtiyaç duymaktayız. Dolayısıyla, TRUBA sistemini kullanmak üzere başvuruda bulunacak araştırmacılarımızın `https://orcid.org/ <https://orcid.org/>`_ adresinden e-posta adresleri ile eşlesen bir ORCID ID alıp portaldaki (`portal.truba.gov.tr <http://portal.truba.gov.tr/>`_) profillerine eklemeleri gerekmektedir. 
   
Standart kullanıcı hesabı özellikleri
--------------------------------------

Güncel olarak tüm kullanıcı hesaplarının TRUBA'daki tüm kuyruklara iş gönderme yetkisi vardır. *Her bir kullanıcı sistemde yeterli kaynak miktarı olduğu sürece aynı anda en fazla 196 çekirdeğe kadar hesaplama kaynağı kullanabilir. Sistem üzerinde çalışmalara, yoğunluğa ve güncellemelere bağlı olarak bu miktar zaman içerisinde azaltılabilir ya da arttırılabilir.*

Tüm standart kullanıcı hesaplarının ev dizini kotaları 1 TB kadardır. Yine zaman içerisinde TRUBA bu miktarı değiştirme esnekliğine sahiptir. Herhangi bir proje kapsamında çalışan kullanıcıların projeleri için ayrıca proje disk kotası tanımlanmaktadır. TRUBA da hem kullanıcı hem de proje kotaları grup temelli hesaplanır. Herhangi bir kullanıcının ya da projenin kullandığı disk miktarı hesaplanırken, disk sistemi üzerinde grubu ilgili kullanıcıya ya da projeye ait olan dosyaların toplam büyüklüğü göz önüne alınır. 

Ev dizinlerinde oluşturulan dosya ve dizinlerin grupları, dosyayı oluşturan kullanıcının ki ile aynı olur, proje dizinlerinde oluşturulan dosya ve dizinlerin grupları ilgili projenin grubu ile aynı olur. Kullanıcılar varsayılan olarak kendi kullanıcı adı ile aynı grupta bulunurlar. Herhangi bir proje dolayısı ile birden fazla gruba dahil olan kullanıcılar dosya ya da dizinlerinin gruplarını dahil oldukları gruplardan herhangi birine ``chown, chgrp`` gibi komutlar yardımıyla değiştirebilirler.

Ayrıca herhangi bir projeye dahil olan kullanıcı, kendi ev dizininde projesi ile ilgili çalışırken oluşturdurduğu ve daha sonra oluşturacağı dosya veya dizinlerin gruplarının kendi kişisel grubu yerine otomatik olarak proje grubu olması sağlayabilir. 

.. note::

   Örneğin; /truba/home/sefa/test dizininde oluşturulacak dosya ve dizinlerin gruplarının "sefa" yerine otomatik "grid-teknik" olarak tanımlaması için aşağıdaki komut satırlarının uygulanması gerekmektedir:
  
.. code-block::

   mkdir /truba/home/sefa/test
   chown -R  grid-teknik /truba/home/sefa/test
   chmod g+s /truba/home/sefa/test

Bu aşamadan sonra test dizini içerisinde oluşturulacak dosya ve dizinlerin grubu ``grid-teknik`` olacaktır. 

TRUBA tarafından standard kullanıcılara verilen hizmet best-effort niteliğindedir (https://en.wikipedia.org/wiki/Best-effort_delivery). Bu nedenle kullanıcılara hizmetin devamlılığı, kalitesi, verilerin saklanması ve korunması, ve diğer TRUBA hizmetleri konusunda TRUBA'nın herhangi bir sorumluluğu yoktur, herhangi bir güvence ya da garanti sunmaz. 

Ayrıcalıklı Kullanım / ARDEB Projeleri
---------------------------------------

Standart kullanıcı hesaplarına tanınan hesaplama kaynaklarının yeterli olmadığı ya da, zaman kısıtlı projelerin yürütülmekte olduğu durumlarda, cüzi bir hizmet bedeli karşılığında kuyruk önceliği olan, ayrıcalıklı hizmet almak mümkündür. Talep edilen kaynak miktarı için verilecek hizmet bedeli, ilgili donanımın talep edilen kullanım süresinde harcayacağı elektrik enerjisi miktarı ve altyapı bakım-onarım maliyetleri göz önüne alınarak hesaplanmaktadır.

ARDEB'e proje başvurusunda bulunacak kullanıcılar proje başvurusu sırasında, yeni hesaplama donanımı alımı için fon talebinde bulunabilecekleri gibi, uygulamalarının TRUBA üzerinde çalışması mümkünse, hesaplarını TRUBA'da yürütmeyi tercih edebilirler.

----------------------------
TRUBA Kullanıcı Politikası
----------------------------

**TRUBA kullanıcısının aşağıdaki ilkelere uyması beklenmektedir.**

  * TRUBA kaynakları bu politika metninde belirtilen ilkeler doğrultusunda kullanılabilir. 
  
  * TRUBA kaynaklarını kullanarak elde edilmiş sonuçların doğrudan ya da dolaylı olarak kullanıldığı tüm makale, bildiri, tez (yüksek lisans, doktora) veya diğer (poster, vb) çalışmalarında, kullanıcının TRUBA oluşumuna teşekkür etmesi zorunludur. `Teşekkür örneklerine ulaşmak için tıklayınız <http://wiki.truba.gov.tr/index.php/Yap%C4%B1lan_%C3%87al%C4%B1%C5%9Fmalarda_TRUBA%27ya_T%C3%BCrk%C3%A7e_ve_%C4%B0ngilizce_Te%C5%9Fekk%C3%BCr_%C3%96rnekleri>`_ 
  
  * Kullanıcıların TRUBA'ya başvuru sırasında belirtilmiş uygulamalardan farklı bir iş çalıştırmaması beklenir. Böyle bir ihtiyaç durumunda kullanıcının ``grid-teknik@ulakbim.gov.tr`` adresine e-posta atarak yeni uygulamalar konusunda yeniden kullanıcı talebinde bulunması gerekmektedir. 
  
  * Arayüz makinası veya portal kullanıcı hesabı şifresinin güvenli bir şekilde saklanmasından kullanıcı sorumludur. 
  
  * Kullanıcılar tarafından TRUBA kullanıcı sertifikası güvenliğinin sağlanması gerekmektedir. 
  
  * Depolama elemanlarının uygulamalar dışında farklı amaçlar için kullanılmaması gerekmektedir. 
  
  * TRUBA kaynakları yasadışı herhangi bir amaçla, altyapının yönetimini ve güvenliğini tehdit edecek biçimde kullanılamaz. 
  
  * Sistemde bir güvenlik açığı gören yada böyle bir durumdan şüphelenen bir kullanıcının ivedilikle ``grid-teknik@ulakbim.gov.tr`` e-posta adresini kullanarak ya da 0 312 298 93 63 numaralı telefon numarasını arayarak altyapı işletenlerini uyarması gerekmektedir. 
  
  * Kullanıcının Grid kullanımında karşılaşabileceği sorunlardan TRUBA Oluşumu sorumlu değildir. Gridin sürekli çalışır durumda kalacağının, kullanıcının çalışma ortamına uygun olacağının ya da uygun hale getirileceğinin garantisi yoktur. 
  
  * Kayıtlı kullanıcı bilgisi, TRUBA tarafından sadece yönetsel, operasyonel, kaynakların kullanımında kimlik doğrulama ve yetkilendirme amaçlı kullanılabilir. Bu amaçlar dışında mevcut kimlik bilgilerinin gizli tutulması esastır. 
  
  * Kaynak sağlayıcılar, sanal organizasyonlar, Grid site yöneticileri yönetsel, operasyonel ya da güvenlik amaçlı olmak üzere Grid'e erişimi düzenlemede ya da sonlandırmada tam yetkilidir. Kullanıcılar bu düzenleme ya da değişiklikleri kabul etmek durumundadır. 
  
  * TRUBA altyapısı uygulama geliştirme amaçlı kullanılamaz. Kullanıcılar ancak geliştirilmiş uygulamalarını (arayüz makinasında ya da kendi makinalarında derlenmiş çalıştırılabilir iş ve veri dosyalarını) TRUBA altyapısına aktarabilirler. 
  
  * Kullanıcı arayüz makinasından konsol aracılığıyla gridi kullanan kullanıcılar programlarını arayüz makinasında derleyip derlenmiş çalıştırılabilir dosyalarını küme bilgisayara ya da Grid'e göndermek durumundadırlar. 
  
  * P-GRADE web portalından Grid'i kullanan kullanıcılar derlenmiş çalıştırılabilir programlarını gride göndermek durumundadırlar.   
  * TRUBA kullanıcılarının yürütmekte oldukları çalışma ve projeler yıllık olarak değerlendirilecektir. Bu değerlendirme sonucunda verimsiz ve yetersiz çalıştığı görülen kullanıcı/kullanıcı grubunun kullanım hakkı TRUBA Danışma Kurulu üyeleri tarafından değerlendirilerek gerek görülmesi halinde kapatılacaktır. 
  
  * Kullanıcı kabul edilebilir kullanım politikasında yer alan şartlardan herhangi birine uymamasından doğacak sonuçlardan sorumludur. 

Yeni Sertifika Başvurusu
------------------------

Yeni sertifika başvurusu sadece ve sadece Avrupa Araştırma Altyapıları'nda yer alan kaynaklara iş göndermek, ilgili AB projelerinde yetkilendirme servisleri için kullanılmaya başlanmıştır. Bu nedenle sadece ilgili alanlarda ihtiyaç duyanlar sertifika başvurusunda bulunabilir veya ca@grid.org.tr adresinden yardım isteyebilirler. 

https://portal.truba.gov.tr sayfasındaki Sertifika menüsünden yeni kullanıcı sertifikası başvurusunda bulunulabilinir. TRUBA sertifika otoritesi (CA) tarafından hazırlanıp imzalanarak size eposta ile gonderilecektir. 

*Sertifikamı Nerede Kullanabilirim?*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sertifika kullanım alanları aşağıdaki gibi özetlenebilir: 

* Uluslararası projelerde kişisel olarak yetkilendirme 
* Uluslararası araştırma projelerinin web sayfalarına erişim için 

Yeniden Sertifika Başvurusu Ne Zaman ve Nasıl Yapılır? 

Tüm araştırmacılara ve servislere verilen sertifika süresi 1(bir) yıldır. Bir yılın sonunda yeniden https://portal.truba.gov.tr adresinde yer alan Sertifika menüsünden başvuruda bulunabilirsiniz. 

Not: Sertifika başvuruları 5 iş günü içerisinde cevaplanmaktadır. 


=================
Dosya Sistemleri
=================

Hesaplama kümelerindeki sunucuların kendi üzerlerindeki yerel disklerden bağımsız olarak, sunucular kullanıcı verilerinin saklanması ve kullanıcı işlerinin çalıştırılması amacı ile *paylaştırılmış merkezi dosya sistemlerini* kullanırlar. Merkezi dosya sistemleri yüksek başarımlı LUSTRE paralel dosya sistemi kullanarak yapılandırılmıştır. 

Kullanım amacına göre dosya sistemleri farklı boyutlarda, ve farklı özellikteki donanımlarla hazırlanırlar. Örnegin, kullanıcı ev dizinleri performans dosya sistemine göre boyut olarak daha büyük olmasına rağmen, hız bakımından performans dosya sistemi daha başarılıdır. 

Ev dizinleri ve Ortak yazılımlar
---------------------------------

Kullanıcı ev dizinleri ve TRUBA tarafından sağlanan yazılımların (derleyici, uygulama ve kütüphaneler) kaydedildiği alan için “kullanıcı ev dizini” terimi kullanılmaktadır. Kullanıcı ev dizinleri için iki farklı dosya sistemi kullanılmaktadır. 

 * Lufer ve Mercan kümelerinde kullanıcı ev dizinleri (home_palamut1, home_palamut2 ve home_eymir) için /home_palamut dosya sistemi kullanılmaktadır. **Hesaplama kümesi kullanım dışı olduğu için bu dosya sistemi de kullanım dışıdır.** 

 * Levrek kümesinde kullanıcı dizinleri /truba/ dosya sistemi altında bulunmaktadır. Kısa zaman sonra, /home_palamut dosya sistemi kullanımdan kaldırılarak, tüm veri /truba dosya sistemine aktarılacaktır. **Bu nedenle kullanıcıların ivedilikle /truba dosya sistemi üzerinde çalışmaya başlamaları ve yeni uygulamalarını bu dosya sistemi üzerinde derlemeri gerekmektedir.**

Gerek home_palamut gerekse truba dosya sistemlerinde kullanıcılar için kota uygulaması söz konusudur. Tüm kullanıcıların disk kotaları eşit olarak ayarlanmıştır. ARDEB vasıtası ile hesap açılan ve projeleri kapsamında işlerini çalıştıran kullanıcılar için, standart kota miktarından farklı olarak, projelerinde öngörülen disk kotası miktarı uygulanmaktadır. 

Kullanıcı ev dizinlerinin yedekleri alınmamaktadır. Bu nedenle buradaki kullanıcı verilerinin düzenli olarak kullanıcılar tarafından kendi kişisel bilgisayarlarına aktarılması, önemsiz verilerin ise yine kullanıcının kendisi tarafından silinmesi beklenmektedir. **Kullanıcı ev dizinleri kesinlikle uzun vadeli bir depolama alanı olarak düşünülmemelidir.**

Kullanıcı dizinleri hesaplama sunucuları tarafında read-only erişilebilir durumdadır. Kulanıcılar hesaplamaları sırasında bu dizinlerden verilerini okuyabilirlerken, bu dizinlere herhangi bir çıktı yazamazlar. Bu nedenle işler ev dizinlerinde değil performans alanında (/truba_scratch) çalıştırılmalıdır. 

Kullanıcı ev dizinleri standart olarak sadece dizinin sahibi tarafından erişilebilecek şekilde oluşturulurlar. Ancak zamanla kullanıcılar dizin erişim haklarını bilerek ya da bilmeyerek değiştirebilirler. Kullanıcı ev dizinlerindeki verinin güvenliğinden yine kullanıcın kendisi sorumludur. 

Lüfer/Mercan kümelerinde ortak yazılımlar /home_palamut1/software dizininde tutulurlar. Bu dizine tüm kullanıcıların read-only erişimleri vardır. Bu dizindeki yazılımlar genel olarak ücretsiz lisanslı yazılımlardır ve tüm TRUBA kullanıcılarının -*yazılımın lisans haklarına uyulması şartı ile* kullanımına açıktır. 

Scratch dizini (/truba_scratch)
---------------------------------

Hem Mercan/Lüfer kümesinde hem de Levrek kümesinde hesaplama performans alanı okarak ``/truba_scratch`` dosya sistemi kullanılmaktadır. 

Yapısı gereği kullanıcı ev dizinlerine göre boyut olarak daha küçük ancak daha hızlı çalışacak şekilde yapılandırılmıştır. Kullanıcıların işlerini bu dosya sisteminde çalıştırması amaçlanmıştır. 

Hesap sırasında oluşacak dosyaların boyutları tam olarak kestirilemediğinden bu dosya sisteminde kota uygulanmamaktadır. Ancak bu dosya sistemindeki dosyalar düzenli olarak kullanıcı tarafından silinmelidir. Dosya sisteminde, 30 gün boyunca hiç erişilmemiş dosyalar düzenli olarak sistem yöneticisi tarafından silinmektedir. 

*Bu dosya sistemi kesinlikle kalıcı bir dosya depolama alanı olarak düşünülmemelidir. Dosya sistemindeki verilerin güvenliğinden kullanıcının kendisi sorumludur.*

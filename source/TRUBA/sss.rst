=======================
Sıkça Sorulan Sorular
=======================

Kullanıcılar tarafından sıklıkla sorulan bazı soruları ve cevaplarını aşağıda bulabilirsiniz. Aşağıda cevabını bulamadığınız sorularızı ``grid-teknik@ulakbim.gov.tr`` adresine iletebilirsiniz.

:ref:`1. Kullanıcı arayüzü sunucularına erişim kısıtlamaları var mı? <target to ss1>`

:ref:`2. Kullanıcı arayüzü sunucularına sabit IP'si olmayan bilgisayarlarla bağlanılabilir mi? <target to ss2>`

:ref:`3. Kullanıcı arayüzü sunucularına bağlanamıyorum, sorun nerede olabilir? <target to ss3>`

:ref:`4. OpenVPN'e bağlanabiliyorum, ancak kullanıcı arayüzü sunucusuna bağlanamıyorum, neden? <target to ss4>`

:ref:`5. OpenVPN'e bağlıyım, ancak bağlantım sürekli kesiliyor, yeniden bağlanmak zorunda kalıyorum <target to ss5>`

:ref:`6. OpenVPN bağlantısı yapamıyorum, her 5 saniyede program yeniden bağlanmaya çalışıyor <target to ss6>`

:ref:`7. Sertifikamın geçerlilik süresini nasıl öğrenebilirim? <target to ss7>`

:ref:`8. Sertifika başvurusunu nereden yapabilirim? <target to ss8>`

:ref:`9. Sertifikamı nerede kullanabilirim? <target to ss9>`

:ref:`10. Yeniden sertifika başvurusu ne zaman ve nasıl yapılır? <target to ss10>`

:ref:`11. Sertifikamı yüklemeye çalıştığımda şu hatayı alıyorum: "This personal certificate can't be installed because you do not own the corresponding private key which was created when the certificate was requested." <target to ss11>`

:ref:`12. Kullanıcı arayüzü sunucusundan diğer sunuculara geçiş yapamıyorum. <target to ss12>`

:ref:`13. Kullanıcı arayüzü sunucusunda çalıştırdığım işler sonlanıyor, neden? <target to ss13>`

:ref:`14. Kuyruğa gönderdiğim işlerin "err" dosyalarında "task/cgroup: plugin not compiled with hwloc support, skipping affinity." şeklinde hata mesajı alıyorum. <target to ss14>`

:ref:`15. Squeue ya da sbatch komutunu çalıştırdığımda, “squeue: error: slurm_receive_msg: Socket timed out on send/recv operation slurm_load_jobs error: Socket timed out on send/recv operation ” şeklinde bir mesaj alıyorum, neden? <target to ss15>`

:ref:`16. En fazla ne kadar kaynak kullanabilirim? <target to ss16>`

:ref:`17. Tanımlanan hesaplama çekirdeği miktarını nereden öğrenebilirim? <target to ss17>`

:ref:`18. Ev dizinime dosya kopyalayamıyorum, neden? <target to ss18>`

:ref:`19. Disk kotamı nasıl görürüm? <target to ss19>`

:ref:`20. Parolamı nasıl değiştiririm? <target to ss20>`

:ref:`21. Diğer kullanıcılar verilerime ulaşabiliyorlar, nasıl engellerim? <target to ss21>`

:ref:`22. İşlerim tekrar tekrar en baştan başlıyor neden? <target to ss22>`

:ref:`23. Bazı e-postalarım cevaplanmıyor, e-postaları okuyor musunuz? <target to ss23>`

:ref:`24. Bana aynı anda XX çekirdeğe kadar kullanabileceğim söylenmesine rağmen işlerim kuyrukta neden çok uzun süreler boyunca bekliyor? <target to ss24>`

:ref:`25. Derlediğim uygulamalar bazı kuyruklarda çok hızlı çalışıyorken bazılarında çok yavaş çalışıyor,  neden? <target to ss25>`

:ref:`26. Kullandığım parallel uygulamanın performansını arttırmak için ne yapabilirim? <target to ss26>`

:ref:`27. Hangi tür paralelleştirme daha başarılıdır: MPI mı OpenMP mi? <target to ss27>`

:ref:`28. Sistemde hazır bulunan uygulamalar benim derlediklerimden neden yavaş çalışıyor? <target to ss28>`

:ref:`29. Sunucu başına en fazla ne kadar GPU kullanabilirim? <target to ss29>`

:ref:`30. Tek çekirdekli işlerim çalışıyorken çok çekirdekli/çok nodlu işlerim çalışmıyor, neden? <target to ss30>`

:ref:`31. Sistemde "IDLE" node ve "IDLE" çekirdek olmasına rağmen kuyrukta bekleyen işim neden çalışmıyor? <target to ss31>`

:ref:`32. İşlerin daha çabuk başlaması için ne yapabilirim? <target to ss32>`

:ref:`33. Hesaplama kuyruklarındaki donanımların kullanım durumlarını nasıl görebilirim? <target to ss33>`

:ref:`34. İşlerim "AssociationJobLimit" veya "AssocGrpCPUMinutesLimit" uyarısı vererek başlamıyor, neden? <target to ss34>`

:ref:`35. Kullanıcı dizinlerinin başka kullanıcıların erişimine açılması (ACL) <target to ss35>`

:ref:`36. TRUBA kullanıcı hesabı şifremi nasıl değiştirebilirim? <target to ss36>`

:ref:`37. TRUBA kullanıcı şifremi hatırlamıyorum? Nasıl yeni şifre talep edebilirim? <target to ss37>`

:ref:`38. TRUBA kullanıcı hesabım askıya alındı. Ne yapmalıyım? <target to ss38>`

.. _target to ss1:

1. Kullanıcı arayüzü sunucularına erişim kısıtlamaları var mı?

    Evet. Sadece ULAKNET ağına bağlı bilgisayarlardan (tüm kamu üniversiteleri ve bazı vakıf üniversiteleri) levrek1.ulakbim.gov.tr sunucusuna SSH ile doğrudan bağlanabilir.
    
    Eğer internete ULAKNET üzerinden bağlanılmıyorsa, öncelikle OpenVPN ile TRUBA sanal ağına bağlanılmalı, sonrasında levrek1.ulakbim.gov.tr (ya da 172.16.7.1 adresine) ssh ile bağlanılmalıdır.  

.. _target to ss2:

2. Kullanıcı arayüzü sunucularına sabit IP'si olmayan bilgisayarlarla bağlanılabilir mi?

    Evet. Kişisel bilgisayarınıza OpenVPN programını kurup, programı https://docs.truba.gov.tr adresinde anlatıldığı şekilde yapılandırarak, herhangi bir IP kısıtlaması olmadan, dünyanın herhangi bir yerinden kullanıcı arayüzü sunucularına erişmek mümkündür. 

.. _target to ss3:

3. Kullanıcı arayüzü sunucularına bağlanamıyorum, sorun nerede olabilir?

    Sisteme bağlanamamanızın pek çok sebebi olabilir. Olası bazı sebepler:

    * Bağlanırken kullandığınız bilgisayarın IP adresini bize bildirmemiş olabilirsiniz.
    * Kullandığınız bilgisayardaki virus tarama ve firewall benzeri programlar bağlantınızı engelliyor olabilir. Bu programları yeniden yapılandırınız, ya da iptal ediniz.
    * Kullandığınız bilgisayarın IP'si değişmiş olabilir.
    * Bulunduğunuz networkte SSH veya OpenVPN bağlantılarına izin verilmiyor olabilir.
    * Bulunduğunuz networkte bir problem yaşanıyor olabilir.
    * TRUBA networkünde bir problem yaşanıyor olabilir. 

.. _target to ss4:

4. OpenVPN'e bağlanabiliyorum, ancak kullanıcı arayüzü sunucusuna bağlanamıyorum, neden?

    OpenVPN programını Windows bilgisayarlar üzerinde çalıştırırken yönetici hakları ile çalıştırmak, LINUX tabanlı bilgisayarlarda ise root hakları ile çalıştırmak gerekir. 

.. _target to ss5:

5. OpenVPN'e bağlıyım, ancak bağlantım sürekli kesiliyor, yeniden bağlanmak zorunda kalıyorum.

	Bu problem, bir başka OpenVPN bağlantınız varken, başka bir bilgisayardan aynı sertifika ile OpenVPN'e bağlanılmaya çalışıldığında ortaya çıkar. OpenVPN ile bağlanıldığında sunucu diğer bilgisayar üzerindeki bağlantıyı otomatik olarak koparır. Bağlantısı kesilen OpenVPN istemcisi otomatik olarak tekrar bağlanmaya çalışır, ve sisteme bağlanır. Bu durumda sunucu diğer istemcinin bağlantısını koparır. Bu böylece devam eder. Sorunu çözmek için diğer bilgisayardaki OpenVPN programının kapatılması gerekir.

.. _target to ss6:

6.  OpenVPN bağlantısı yapamıyorum, her 5 saniyede program yeniden bağlanmaya çalışıyor

	Büyük ihtimal sertifikanızın geçerlilik süresi dolmuştur. Kullandığınız sertifika yönetici programından, ya da sertifikanızı yedeklediğiniz web tarayıcısından sertifikanızın geçerlilik süresini kontrol ediniz. Sertifikanızın süresi dolmuş ise, daha önce sertifika başvurusu için size gönderilmiş olan e-postadaki sertifika başvuru linkine tıklayarak yeniden sertifika talebinde bulunabilirsiniz.

.. _target to ss7:

7. Sertifikamın geçerlilik süresini nasıl öğrenebilirim?

	Sertifika başvurusu sırasında kullandığınız web tarayıcının "Sertifikalar" kısmında sertifikanıza ait detaylı bilgilere ulaşabilirsiniz.

	Firefox için : Araçlar-Seçenekler -> Gelişmiş -> Sertifikalar -> Sertifikaları Göster -> Kişisel Sertifikalar 
	
	Chrome için  : Ayarlar -> Gelişmiş Ayarlar -> HTTPS/SSL (Sertifikaları Yönet)

.. _target to ss8:

8. Sertifika başvurusunu nereden yapabilirim?

	TRGrid CA tarafından onaylanmış sertifikaya ihtiyaç duyan araştırmacılarımız https://portal.truba.gov.tr/ bağlantısını kullanarak TRUBA üyelik portalından sertifika başvurusunda bulunabilirler.
	
.. _target to ss9:
	
9. Sertifikamı nerede kullanabilirim?

	Sertifika kullanım alanları aşağıdaki gibi özetlenebilir:

    * Uluslararası projelerde kişisel olarak yetkilendirme
    * Uluslararası araştırma projelerinin web sayfalarına erişim için 

.. _target to ss10:

10. Yeniden sertifika başvurusu ne zaman ve nasıl yapılır?

	Tüm araştırmacılara ve servislere verilen sertifika süresi 1(bir) yıldır. Önceki başvuruyu ne zaman yaptığınızı hatırlamıyorsanız, kullanıdığınız web tarayıcısının "sertifikalar" bölümünden, sertifikanızın geçerlilik süresini öğrenebilirsiniz.

	Eğer sertifikanızın süresi dolduysa, https://portal.truba.gov.tr web adresinde yer alan üyelik portalından sertifikanızın yenilenme sürecini başlatabilirsiniz.

.. _target to ss11:

11. Sertifikamı yüklemeye çalıştığımda şu hatayı alıyorum: "This personal certificate can't be installed because you do not own the corresponding private key which was created when the certificate was requested."

	Sertifika başvurusu yapıldığı sırada, sertifika başvurusunu yaptığınız bilgisayar ve kullandığınız tarayıcı program (browser: firefox, chrome vb. gibi) içerisinde gizli ve açık anahtar çifti oluşturulmaktadır. Gizli anahtar ilgili tarayıcı programı dolayısıyla kullandığınız bilgisayar içerisine kaydedilmektedir. Açık anahtar ise, TR-Grid CA tarafından imzalanmak üzere web arayüzünden bize gönderilmektedir.

	Sertifikanız imzalanarak tarafınıza gönderildiğinde, ilgili sertifikayı .p12 uzantılı kaydedebilmek için imzalanarak size gönderilen sertifika içerisindeki açık anahtar ile tarayıcı programınız tarafından saklanan gizli anahtarın eşleşmesi gerekmektedir. Bu sebeple size gönderilen bağlantıdaki sertifikanızı, ancak ve ancak başvuru yaptığınız bilgisayar ve üzerindeki başvuru sırasında kullandığınız tarayıcı program ile bağlantıya erişmek istediğinizde kaydedebilirsiniz.

	"This personal certificate can't be installed because you do not own the corresponding private key which was created when the certificate was requested." hatasını alıyorsanız, yukarıda belirtilen teknik sebepten dolayı, bağlantıyı açmak için kullandığınız tarayıcı tarafında gizli anahtarınıza erişim sağlanamamaktadır.

	Bu durumda, lütfen sertifika başvurusu sırasında kullandığınız bilgisayar ve tarayıcı programla size gönderilen bağlantıyı açtığınızdan emin olunuz.

	Eğer sertifikanız ile gizli anahtarınızı eşleştiremiyorsanız, lütfen konuyu ca@grid.org.tr e-posta adresine bildirerek, yeniden sertifika başvurusu yapınız.

.. _target to ss12:

12.  Kullanıcı arayüzü sunucusundan diğer sunuculara geçiş yapamıyorum.

	Sadece kullanıcı arayüzü sunucuları, kullanıcıların doğrudan erişimine açıktır. Kullanıcılar işlerini kuyruk sistemi aracılığı ile (slurm betik dosyaları hazırlayarak), kullanıcı arayüzü sunucuları üzerinden kuyruk sistemine göndermelidirler.

.. _target to ss13:

13. Kullanıcı arayüzü sunucusunda çalıştırdığım işler sonlanıyor, neden?

	Kullanıcı arayüzü sunucuları üzerinde sadece derleme, ve az kaynak isteyen kısa süreli işler çalıştırılmalıdır. Asıl işler, iş kuyruklarına gönderilmelidir.

	Tüm kullanıcılar kullanıcı arayüzleri üzerinden sisteme bağlı olduklarından, bu sunucuları yoracak veya uzun süreli veya çok kaynak gerektiren işlerin çalıştırılması kullanıcıların sunucuya bağanmasını ve kuyruk sistemine iş göndermesini zorlaştıracaktır.

	Kullanıcı arayüzü sunucusunda çalıştırılan, uzun süren ya da sistemin çalışmasını yavaşlatan işler sistem yöneticisi tarafından sonlandırılır. Bu şekilde çalışmakta ısrar eden kullanıcıların hesapları askıya alınır.

.. _target to ss14:

14. Kuyruğa gönderdiğim işlerin err dosyalarında “task/cgroup: plugin not compiled with hwloc support, skipping affinity.” şeklinde hata mesajı alıyorum.

	Bu bir uyarı mesajı niteliğinde olup, işin çalışmasına herhangi bir etkisi yoktur. Lütfen göz ardı ediniz.

.. _target to ss15:

15. Squeue ya da sbatch komutunu çalıştırdığımda, “squeue: error: slurm_receive_msg: Socket timed out on send/recv operation slurm_load_jobs error: Socket timed out on send/recv operation” şeklinde bir mesaj alıyorum, neden?

	Sistemin yoğun kullanıldığı zamanlarda geçici olarak network sıkıntıları yaşanabiliyor, böyle bir sıkıntının yaşandığı anda sbatch/squeue komutunu çalıştırırsanız bu uyarı ile karşılaşabilirsiniz. Bir süre daha bekleyip tekrar deneyiniz, herhangi bir düzelme olmazsa teknik birime e-posta gönderiniz.

.. _target to ss16:

16. En Fazla ne kadar kaynak kullanabilirim?

	Lisans öğrencileri için kendi hesaplarına denemeleri için aynı anda 4 çekirdek kullanımı tanımlanmaktadır. Lisan öğrencileri danışmanlarının sahip olduğu proje hesaplarından faydalanabilirler. Yüksek lisans öğrencileri için tanımlanan en fazla çekirdek sayısı 40'dır. Doktora öğrencisi ve akademik kullanıcılar için tanımlanan en fazla çekirdek sayısı 160'dır. 
	
	Standart kullanıcılar için tanımlanan en fazla çekirdek sayısı 160'dır. Bu sayı sistemin yoğunluğuna göre dönem dönem arttırılabilir ya da azaltılabilir. Bu sayı kaynak olduğu müddetçe kullanılabilecek rakamı belirtir. Kullanıcının her an bu miktardaki kaynağı kullanabileceği garanti değildir.

	ARDEB destekli bir proje kapsamında çalışmalarını yürüten bir kullanıcı, standart kullanıcı için tanımlanmış kaynak miktarının yanında, projesi kapsamında tanımlanmış miktar kadar kaynak kullanabilir.

.. _target to ss17:

17. Tanımlanan hesaplama çekirdeği miktarını nereden öğrenebilirim?

	Herhangi bir tanım değişikliği yapıldığı zaman portal.truba.gov.tr adresindeki duyurular kısmında paylaşılmaktadır.

.. _target to ss18:

18. Ev dizinime dosya kopyalayamıyorum, neden?

	Disk kotanızı doldurmuş olabilirsiniz. Standart kullanıcılar için disk kotası 1000GB kadardır. ARDEB destekli bir proje kapsamında çalışmalarını yürüten kullanıcılar için, farklı kota tanımları mevcuttur.

.. _target to ss19:

19. Disk kotamı nasıl görürüm?

	levrek1 (veya herhangi bir kullanıcı arayüzü sunucusunda) sunucusu üzerinde “quota” komutunu çalıştırarak ilgili dosya sistemlerindeki ev dizini kotalarınızı ve kullanım durumunuzu görebilirsiniz.

	Not: TRUBA'da her kullanıcı için bir kullanıcı grubu oluşturulmuştur. Kullanıcı adı ile kullanıcı grubunun adları (UID ve GID) aynıdır. Kotalar UID üzerinden değil GID üzerinden tanımlanmıştır.

.. _target to ss20:

20. Parolamı nasıl değiştiririm?

	Terminalden levrek arayüz sunucusuna bağlandıktan sonra "passwd" komutu ile parolanızı değiştirebilirsiniz.

.. _target to ss21:

21. Diğer kullanıcılar verilerime ulaşabiliyorlar, nasıl engellerim?

	Kullanıcı dizinleri oluşturulurken, sadece ilgili kullanıcının erişebileceği erişim hakları ile açılmaktadır. Ancak bazı kullanıcılar zamanla diğer kullanıcılarla veri paylaşmak vs. gibi sebeplerle ev dizinlerinin erişim izinlerini değiştirebiliyorlar. Dizin erişim hakkaları “chmod 700 $HOME” komutu ile eski haline getirilebilir.

.. _target to ss22:

22. İşlerim tekrar tekrar en baştan başlıyor neden?

	İşin çalıştığı esnada, işin çalıştığı sunucuda meydana gelen bir aksaklık nedeni ile işin durdurulması durumunda, iş sistem tarafından tekrar kuyruğa gönderilir. İşin tekrar kuyruğa gönderilmesi istenmiyorsa, betik dosyasına ==“#SBATCH –no-requeue”== satırı eklenmelidir.

.. _target to ss23:

23. Bazı e-postalarım cevaplanmıyor, e-postaları okuyor musunuz?

	``grid-teknik@ulakbim.gov.tr`` adresine gönderilen tüm e-postalar okunmaktadır. E-postada belirtilen şikayet konusu genel bir soruna işaret ediyor, ve üzerinde çalışılıyorsa, sorun düzeltildikten sonra, sorunun giderildiğine dair kullanıcıya herhangi bir geri dönüş yapmıyoruz. Kullanıcı sayısı ve aynı genel sorun için gönderilen e-posta sayısı göz önüne alındığında, her kullanıcıya geri dönüş yapılması mümkün görünmüyor.

	E-postada belirtilen sorun, sadece o kullanıcı ile ilgili ise, sorun ilgilenilmek üzere sıraya alınıyor. Ancak bazı durumlarda sıranın ilgili soruna gelmesi zaman alabiliyor. Dolayısıyla, geri dönüş e-postasının gönderilmesi zaman alabiliyor.

	Bazı durumlarda, e-posta gözümüzden kaçabiliyor. Sorunun e-posta ile bildirilmesine rağmen bir süre içinde sorun giderilmemiş olursa, bir hatırlatma e-postası daha gönderiniz.

.. _target to ss24:

24. Bana aynı anda XX çekirdeğe kadar kullanabileceğim söylenmesine rağmen işlerim kuyrukta neden çok uzun süreler boyunca bekliyor?

	İşlerin kuyrukta beklemesinin temelde iki nedeni olabilir. Ya size izin verilen işlemci sayısının tamamını kullanmaktasınız, Ya da gönderdiğiniz kuyrukta işinizin başlaması için yeterli kaynak yoktur. "sinfo" komutu ile boş kuyrukları kontrol ederek işlerinizi boş kuyruklara yeninden gönderebilir, ya da kuyrukta bekleyen işlerinizi "scontrol" komutu ile boş olan bir kuyruğa yönlendirebilirsiniz.

.. _target to ss25:

25. Derlediğim uygulamalar bazı neden kuyruklarda çok hızlı çalışıyorken bazılarında çok yavaş çalışıyor?

	Kuyruklarda kullanılan donanımlar arasında işlemci, bellek ve nesil farkı bulunmaktadır. Mercan/Lüfer sunucularında AMD işlemciler bulunurken Levrek sunucularında Intel işlemciler bulunmaktadır. Sunucuların performasları da aynı değildir. Dolayısı ile işlerin farklı hızlarda çalışması normaldir. Ancak donanım performansından ayrı olarak bir performans sıkıntısı yaşanıyor ise, yapılan derleme sisteme uygun olarak yapılmamış olabilir. Uygulamanın çalışacağı işlemci markasına göre, uygulamanızı o işlemci için TUNE edilmiş kütüphanelerle derlemekte fayda vardır. Özellikle blas,lapack,blacs,scalapack,fftw gibi kütüphanelerin kullanıldığı uygulamalarda tune edilmiş kütüphaneler büyük farklılıklar yaratabilir.

.. _target to ss26:

26. Kullandığım parallel uygulamanın performansını arttırmak için ne yapabilirim?

	Kullanmak istediğiniz çekirdek sayısı tek bir sunucu tarafından karşılanabiliyorsa, işlerinizi farklı sunuculara dagıtmak yerine tek bir sunucu üzerinde çalıştırmak genelde daha iyi sonuç verir.

.. _target to ss27:

27. Hangi tür paralelleştirme daha başarılıdır: MPI mı OpenMP mi?

	Bu uygulamanın yaptığı işe, kodun kalitesine ve daha pek çok paramereye bağlı olmakla birlikte, OpenMP (sunucu içi paralelleştirme) türü paralelleştirme, MPI (sunucular arası paralelleştirme -Message Passing Interface) türü paralellleştirmeye nazaran daha başarılıdır.

.. _target to ss28:

28. Sistemde hazır bulunan uygulamalar benim derlediklerimden neden yavaş çalışıyor?

	Sistemde bulunan uygulamalar, buradaki ekip tarafından standart özelliklerle ve mümkün olan en fazla kullanıcının işine yarayacak şekilde derlenilmeye çalışılmıştır. Hesaplarınızda kullanılan hesap türü için farklı derleme parametreleri, farklı optimizasyonlar gerekiyor olabilir. Bu nedenle aslında tüm kullanıcıların kendi derlemelerini kendilerinin yapmasını şiddetle tavsiye ediyoruz.

.. _target to ss29:

29. Sunucu başına en fazla ne kadar GPU kullanabilirim?

	Farklı nesil sunucular üzerinde farklı nesil kaynaklar bulunmaktadır. TRUBA'daki hesaplama kaynakları hakkında ayrıntılı bilgiye TRUBA Kaynakları sayfasından erişilebilir.

.. _target to ss30:

30. Tek çekirdekli işlerim çalışıyorken çok çekirdekli/çok nodlu işlerim çalışmıyor.

	Paralel işlerin çalışabilmesi için nodelar arasında kullanıcın şifresiz geçiş yapabiliyor olması gerekmektedir. Şifresiz geçiş için SSH anahtar mekanizması kullanılır. Bu geçiş için SSH anahtarlarının ve yapılandırmasının yapılmış olması gerekir. Ayrıntılı bilgi için "Kullanıcı Hesabının Kullanılır Duruma Getirilmesi" başlıklı maddeyi inceleyiniz.

.. _target to ss31:

31. Sistemde IDLE node ve IDLE çekirdek olmasına rağmen kuyrukta bekleyen işim neden çalışmıyor?

	Herhangi bir anda sistemde IDLE node ya da çekirdek bulunması, ilgili node ya da çekirdeğin o anda sizin işiniz tarafından kullanılabileceği anlamına gelmemektedir. IDLE node ya da çekirdekler, sizin işinizden önce gönderilen ya da önceliği sizin işinizden daha yüksek olan işlere yeterli kaynak oluşturmak için bekletiliyor olunabilir.

.. _target to ss32:

32. İşlerin daha çabuk başlaması için ne yapabilirim?

	İşleri kuyruğa gönderirken --time parameresi ile işin tahmini çalışma zamanını bildirmek zorunludur. Aksi halde işler 2 dakika içinde sistem tarafından sonlandırılmaktadır. Ancak kullanıcıların çoğu, zaman bilgisini verirken, iş çok daha kısa zamanda sonlanabilecekken bile, iş için verilebilecek en fazla zamanı vermektedirler. İşler planlanırken "backfill" algoritması kullanılmaktadır. Bu algoritmaya göre, önceliği düşük olan veya yeni gönderilmiş işler bile, önceliği yüksek olan ve çok çok önce gönderilmiş işlerden daha çabuk başlayabilir. Çünkü algoritma, sunucuların iş takvimlerini kullanıcıların vermiş oldukları --time bilgisine göre oluşturarak, arada kalan boş zamanlara, o zaman sığacak işleri planlamaktadır.

	Bu nedenle işler sıraya gönderilirlen işin çalışması için yeterli, mümkün olan en kısa zaman ile işin sıraya gönderilmesi işlerin çok daha hızlı bir şekilde başlamasını sağlamaktadır.

.. _target to ss33:

33. Hesaplama kuyruklarındaki donanımların kullanım durumlarını nasıl görebilirim?

	``sinfo`` komutu ile kümelerin anlık kullanım durumlarını görebilir, işinizi buna göre boş olan kümelere gönderebilir, ya da kuyrukta bekleyen işlerinizi bu boş kümelere yönlendirebilirsiniz. Aşağıdaki komutları da denemenizi öneririz:

    .. code-block::

        sinfo -o  ”%P %C ”
	    sinfo -o  ”%n %C “

.. _target to ss34:

34. İşlerim AssociationJobLimit veya AssocGrpCPUMinutesLimit uyarısı vererek başlamıyor.

	Hesabınız için tanımlanmış olan çekirdek-saat kotasının tamamını kullanmış olduğunuz için, işleriniz iş kuyruğuna alınmasına rağmen başlamaz. İşlerinizin başlayabilmesi için çekirdek-saat kotanızın arttırılması gerekir.

	https://portal.truba.gov.tr/ adresindeki profilinizi güncelleyerek şu ana kadar TRUBA kaynaklarını kullanarak yapmış olduğunuz, ve talep edeceğiniz ek kaynakla yapmak istediğiniz çalışmalar hakkında özet bilgi girmeniz ve yine portaldaki Yayınlar menüsünden çalışmalar sonunucunda hazırladğınız tez, bildiri, makale vs. yayınların listesini girmeniz durumunda yeni kaynak talebiniz değerlendirilerek bir uzatma sağlanabilir.

	Profil ve yayın bilgileri güncellendikten sonra ``grid-teknik@ulakbim.gov.tr`` adresine bildirimde bulunmayı unutmayınız.

.. _target to ss35:

35. Kullanıcı dizinlerinin başka kullanıcıların erişimine açılması (ACL)

    Güvenlik sebebi ile kullanıcı ev dizinleri ve dosyaları sadece ilgili kullanıcının erişimine açıktır. Ancak aynı projeler üzerinde çalışan kullanıcılar bazı durumlarda birbirlerinin verilerine erişmek isteyebilirler. Bu tip talepler sıklıkla teknik ekibimize ulaştırılmaktadır. Ancak bunun takibini ve düzenlenmesini yapmak tarafımızca mümkün değildir.

    Kullanıcılar bu ayarlamayı kendileri gerçekleştirebilirler. Örnek /truba/home/user1/ortak_dizin'ine user2 kullanıcısı için izin verilmesi

    user1 kullanıcısı tarafından verilecek komut:

    .. code-block::

	    setfacl -m u:user2:x  /truba/home/user1
	    setfacl -dm u:user2:rwx  /truba/home/user1/ortak_dizin

    Eğer birden fazla kullanıcıya ortak_dizin'e erişim hakkı verilmek isteniyorsa, diğer kullanıcılar için de bu komutlar çalıştırılmalıdır.

.. _target to ss36:

36. TRUBA kullanıcı hesabı şifresinin değiştirilmesi

	Levrek1 kullanıcı arayüzüne bağlandıktan sonra terminal üzerinden ``passwd`` komutunu yazarak mevcut şifrenizi değiştirebilirsiniz.

.. _target to ss37:

37. Yeni TRUBA kullanıcı şifresi talebi

	TRUBA kullanıcı portalı :ref:`<https://portal.truba.gov.tr/>` üzerinden e-devlet aracılıpıyla giriş yaparak ``Yeni Şifre``talebinde bulunabilirsiniz.

.. _target to ss38:

38. TRUBA kullanıcı hesabım askıya alındı. Ne yapmalıyım?

	Kullanıcı arayüzünde iş çalıştırıldığında ve de ilgili kullanıcı tarafından sisteme fazla yük bindirildiği durumlarda sistem kullanıcı hesabını otomatik olarak askıya almaktadır. Lütfen arayüz makinelerinde yoğunluğa sebep olacak işler çalıştırmayınız.

	Kullanıcı hesabınızın yeniden erişime açılabilmesi için TRUBA Dokümantasyon sayfamızda (docs.truba.gov.tr/) yer alan :ref:`Kullanıcı El Kitabı <kullanici-el-kitabi>` ve :ref:`Sıkça Sorulan Sorular <sss-TRUBA>` başlıkları altındaki içerikleri ayrıntılı bir şekilde inceleyip okuyarak hesaplama kümelerinin kullanım şekli ve kuralları konusunda bilgi edinmeniz gerekmektedir. 
	
	TRUBA kullanıcı hesabınızın tekrardan erişime açılabilmesi için ilgili dokümantasyon sayfalarını okuduktan sonra ``grid-teknik@ulakbim.gov.tr`` adresine bilgilendirme epostası göndermeniz gerekmektedir.
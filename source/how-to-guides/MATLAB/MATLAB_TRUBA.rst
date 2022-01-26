=================================
TRUBA'da MATLAB Kullanımı
=================================

TRUBA üzerinde MATLAB çalıştırmak isteyen kullanıcıların **kendilerine ait bir lisansa** sahip olması gerekmektedir. Bu lisans **kişisel, akademik ya da floating (kayar) lisans** olabilir.

Lisans türleri hakkında bilgiye `https://www.mathworks.com/pricing-licensing.html <https://www.mathworks.com/pricing-licensing.html>`_ adresinden erişebilirsiniz. Ayrıca üniversitelerin bilgi işlem merkezlerinden de lisansınız hakkında detaylı bilgi edinebilirsiniz.

MATLAB, sahip olunan lisans türüne göre TRUBA üzerinde farklı şekillerde çalıştırılabilir.

-------------------------------------------------------------------
Akademik (TAH: Total Academic Headcount) Lisansı Olan Kullanıcılar
-------------------------------------------------------------------

EGI ile MATHWORKS arasındaki anlaşma sayesinde kullanıcılar, **kişisel lisansları** ile EGI üyesi ülkelerin süperbilgisayar merkezlerinde MATLAB çalıştırabilmektedirler. Akademik lisansınızın Mathworks üzerinden doğrulanabilmesi için grafik ekrana ihtiyaç duyulmaktadır. Bu lisansa sahip olarak TRUBA üzerinde MATLAB çalıştıracaksanız birkaç metot bulunmaktadır.

- **Kişisel bilgisayarınızda MATLAB çalıştırarak**

- TRUBA üzerindeki kullanıcı arayüz sunucularından :ref:`grafik-ekran` alarak

Kişisel Bilgisayarınızda MATLAB Çalıştırırak TRUBA'ya İş Göndermek
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- MATLAB'ın güncel versiyonunu `Mathworks <https://www.mathworks.com/downloads/>`_ sitesinden indirebilirsiniz. Akademik lisansa sahipseniz, kullanıcı adı ve şifrenizle giriş yapıp MATLAB'ı indirebilir ve kişisel bilgisayarınıza kurulumu gerçekleştirebilirsiniz.

- Kişisel bilgisayarınızdan çalıştırdığınız MATLAB ile TRUBA’ya iş gönderebilmek için bir seferlik küme ayarının (“parallel cluster”) yapılması gerekmektedir.

- İlgili ayar dosyaları ``/truba/sw/scripts/matlab/matlabScripts/truba.nonshared.R2021b`` klasöründe yer almaktadır. Buradan ilgili klasörü kendi bilgisayarınıza indirebilirsiniz. 

  ::

    scp -r username@levrek1.ulakbim.gov.tr:/truba/sw/scripts/matlab/matlabScripts/truba.nonshared.R2021b ~/TRUBA_R2021b

İlgili dosyayı ayrıca  `bu web bağlantısından <source/how-to-guides/MATLAB/truba.nonshared.R2021b.zip>`_ indirebilirsiniz.

.. note::

    * TRUBA üzerinde MATLAB R2021b versiyonu yüklüdür. Bu yöntem ile çalışmak istiyorsanız siz de kendi bilgisayarınıza aynı versiyonu yüklemeniz gerekmektedir.
    
    * Aşağıdaki örnek ilgili klasörün ``'~/TRUBA_R2021b'`` altında olduğu varsayılarak düzenlenmiştir.)

- Kişisel bilgisayarınızda çalıştırdığınız **MATLAB komut penceresinden** indirmiş olduğunuz ayar dosyasına gidip, ``configCluster`` komutunu çalıştırınız. Sonrasında TRUBA kullanıcı adınızı giriniz.

::

    >> cd ~/TRUBA_R2021b/
    >> configCluster

.. image:: /assets/matlab-howto/matlab3.png
   :width: 400px
   
.. note::

    ``configCluster`` komutunu çalıştırdığınızda varsayılan kümeniz TRUBA olarak ayarlanacaktır. Eğer lokal makinenizde iş çalıştıracaksanız 
    ``c=parcluster('local');``
    şeklinde ilgili ayarı değiştirmeniz gerekecektir. 

Bu işlemi bir kez gerçekleştirmek yeterlidir. Bundan sonra iş gönderirken çalıştıracağınız işin ihtiyacına göre ilgili iş parametrelerinin belirtilmesi yeterli olacaktır. Aşağıda bir örnek verilmiştir.

.. _MATLAB-TRUBA_config:

Hesap ve kuyruk parametrelerinin yapılandırması
:::::::::::::::::::::::::::::::::::::::::::::::

MATLAB’ı çalıştıracağınız küme hakkındaki parametrelerinizi ayarlamanız gerekmektedir. "**truba.nonshared.R2021b**" dizini içerisindeki **truba.m** dosyası parametreleri otomatik olarak yapılandırmaktadır.  **MATLAB komut satırından** :code:`truba` komutunun çalıştırılması yeterlidir. 
 
   
.. warning::

    Eğer kampüs dışından (ULAKNET ağı dışından) bağlanıyorsanız öncelikle :ref:`open-vpn` ile bağlantı yapmanız gerekmektedir. 

::

    % kümeyi oluşturun
    c=parcluster;

    % bağlanacağınız arayüz makinesinin ip adresini 
    %VPN ile bağlanıyorsanız 172.16.7.1 , ULAKNET üzerinden bağlanıyorsanız  levrek1.ulakbim.gov.tr
    c.AdditionalProperties.ClusterHost='172.16.7.1';

    % ssh portunu ayarlayın
    c.AdditionalProperties.UseSshPort=22;

    % işinizi göndereceğiniz kuyruğun adını yazın
    c.AdditionalProperties.QueueName='hamsi';

    % işinizin süreceği maksimum zamanı girin. Aksilik yaşamamanız için tahmin ettiğiniz sürenin %20 fazlasını belirtin.
    c.AdditionalProperties.WallTime='3:00:00';

    % Node sayısını belirtin. (Genelde çalıştırılan işler için bir node yeterlidir)
    c.AdditionalProperties.Nodes=1

    % Thread sayısını giriniz. (--cpu-per-task)
    c.NumThreads=28;

    % işinizi kuyruğa göndermeden önce konfigürasyonunuzu tekrar gözden geçirebilirsiniz.
    c.AdditionalProperties

    % yapmış olduğunuz değişikliklerin farklı MATLAB oturumlarında kayıtlı kalmasını istiyorsanız yapmış olduğunuz değişiklikleri profilinize kaydedin.
    c.saveProfile


.. image:: /assets/matlab-howto/matlab4.png
    :width: 400px

Küme ayarlarınız başarıyla oluşturulmuş durumda. Ayrıca ``"Home->Parallel-> Create and Manage Clusters"`` sekmesi altından oluşturmuş olduğunuz kümenin özelliklerini görebilirsiniz. MATLAB'ı kapatıp açsanız da oluşturmuş olduğunuz küme ayarlarınız kayıtlı halde duracaktır. Buradan "default profile" seçimini de gerçekleştirebilirsiniz.

İşlerinizi gönderirken arayüz üzerinden de bu ayarları değiştirebilirsiniz.

.. warning::

    TRUBA üzerinde kurulu MATLAB, sadece  CentOS-7.9 işletim sistemi ile çalışmaktadır. Bu nedenle işler sadece **hamsi** kümesine gönderilebilir.


.. image:: /assets/matlab-howto/matlab6.png
    :width: 400px

.. note::

    Küme üzerinde İşlerinizin kayıt edildiği yer varsayılan olarak ``.matlab/3p_cluster_jobs/truba/TRUBA.R2021b/nonshared`` klasörüdür.  İşinizin durumunu ve sonuçlarını buradan kontrol edebilirsiniz.

    :code:`c.AdditionalProperties.RemoteJobStorageLocation=` komutu ile de ilgili klasörün yerini de değiştirebilirsiniz.

Herhangi bir parametreyi silmek istediğinizde (örneğin e-posta adresi) değişkeni boş bırakmanız yeterlidir.

::

    c.AdditionalProperties.EmailAddress = ''


.. table::

    +-----------------------------+--------------------------------------+------------------------------------------------------------------------------------------------------+
    | Slurm Parametresi           | MATLAB Karşılığı                     | Açıklama                                                                                             |
    +=============================+======================================+======================================================================================================+
    | :code:`--nodes, -N`         | :code:`c.AdditionalProperties.Nodes` | \                                                                                                    |
    +-----------------------------+--------------------------------------+------------------------------------------------------------------------------------------------------+
    | :code:`--ntasks, -n`        | :code:`pool=`                  | en fazla c.NumWorkers  kadar olabilir. Herhangi bir değer verilmezse c.NumWorkers değeri kullanılır. |
    +-----------------------------+--------------------------------------+------------------------------------------------------------------------------------------------------+
    | :code:`--cpus-per-task, -c` | :code:`c.NumThreads`                 | \                                                                                                    |
    +-----------------------------+--------------------------------------+------------------------------------------------------------------------------------------------------+

.. note::

**Hamsi** kuyruğunda sunucu başına minimum 28 çekirdek kullanılabilir. Hamsi kuyruğuna gönderilecek işler 28  ve katlarında çekirdek kullanmalıdır.

MATLAB komut satırından çalıştıracağınız tüm komutlar  kişisel bilgisayarınzda çalışacaktır. İşlem gücü gereken  fonksiyon ya da dosyaları TRUBA üzerinde çalıştırmak için ilgili kod parçasını :code:`batch` komutu ile kuyruğa göndermeniz gerekecektir. Aşağıdaki örnekleri inceleyebilirsiniz. Detaylı bilgi için `buradan <https://www.mathworks.com/help/parallel-computing/batch.html>`_ bilgi edinebilirsiniz. 


Örnek 1: Dahili komutlar ya da fonksiyonlar
::::::::::::::::::::::::::::::::::::::::::::::::

Bu örnekte dahili :code:`pwd` komutu/fonksiyonu kuyruk üzerinde çalıştırılacaktır.

::

    j=batch(c,@pwd,1,{},'CurrentFolder', '.','AutoAddClientPath',false)

İşinizi gönderdiğinizde, şekilde görüldüğü gibi TRUBA şifrenizin girilmesi istenecektir. Bu sorgu ekranı gelmiyorsa yukarıdaki küme ayarlarınızı kontrol ediniz. Ayrıca ``batch`` komutunun nasıl kullanılacağı ve ilgili parametrelerin ne olduğu hakkında bilgiye `MATLAB yardım merkezinden <https://www.mathworks.com/help/parallel-computing/batch.html#d123e38009>`_ erişim sağlayabilirsiniz. 

.. image:: /assets/matlab-howto/matlab7.png
    :width: 400px

İşinizi gönderdiğinizde bir "Slurm Jobid" si atanacaktır. Ayrica levrek1 arayüzünden :code:`squeue` komutu ile de işinizin durumunu öğrenebilirsiniz.

.. image:: /assets/matlab-howto/matlab8.png
    :width: 400px


.. image:: /assets/matlab-howto/matlab9.png
    :width: 400px

MATLAB komut penceresi üzerinden işinizin durumu hakkında bilgi edinebilirsiniz.

::

    % işinizin durumu hakkındaki bilgi için:
    j.State

    % işiniz sonucunu çağırmadan önce bitmesini beklemek için:
    j.wait

    % iş bittiğinde sonucu görmek için:
    j.fetchOutputs

    % işiniz artık gerekli değilse işinizi silmek için:
    j.delete

    % eğer var olan tüm işleri silmek isterseniz
    delete(c.Jobs)


İşinizin durumunu ayrıca "**MATLAB Job Monitor Tool**" ile de görebilirsiniz. İşinizle ilgili sonucu bu arayüz aracılığıyla da çekebilirsiniz.

.. image:: /assets/matlab-howto/matlab5.png
    :width: 400px

.. image:: /assets/matlab-howto/matlab10.png
    :width: 400px


.. note::

    İşinizi kuyruğa gönderdikten sonra oturumunuzu açık tutmanıza gerek yoktur. İşiniz tamamlandığında MATLAB'ı tekrar çalıştırıp biten işlerinizin durumunu görebilir ve sonuçlarınızı çağırabilirsiniz. Bu işlemi "MATLAB Job Monitor Tool" ile yapabileceğiniz gibi komut satırından da gerçekleştirebilirsiniz.


::

    c=parcluster;
    jobs=c.Jobs

    %% ID numarası 2 olan işi seç
     j2 = c.Jobs(2)
     j2.fetchOutputs

.. image:: /assets/matlab-howto/matlab11.png
    :width: 400px


Örnek 2: \*.m dosyaları
:::::::::::::::::::::::

Dahili komutlar ve fonksiyonların yanı sıra MATLAB betik dosyalarını da (\*.m) kuyrukta çalıştırmanız mümkündür. 

::

    %% test2.m içerigi
    pwd
	ls -al 
	a = 5; b = 7
	g = a + b
	d = g + sin(b)
	e = 5 * d
	f = exp(-d)



Bu dosyayı aşağıdaki komutla kuyruğa gönderebilirsiniz:

::

    j=batch('test2','CurrentFolder','/truba/home/kullanici_calisma_dizini/', 'AutoAddClientPath',false); 

Bu dosya kuyrukta çalışıp sonlandıktan sonra, ekran çıktılarını

::

    diary(j)

komutu ile alabilirsiniz. Ayrıca dosya içerisinde kullanılan değişkenlerin son değerlerini,

::
 
    load(j)

lokal arayüzünüze alabilirsiniz.

Örnek 3: Lokal dosyadan veri okumak ve sonuçları merkezi dizinde dosyaya yazmak
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Aşağıdaki örnekte kuyruğa göndereceğimiz betik, lokal dizinimizdeki veriyi okuyup işleyecek ve sonucu merkezi dizine yazacaktır.

::

    % test3.m içerigi
	pwd
	fileID = fopen('input.txt','r');
	formatSpec = '%d %f';
	sizeA = [2 Inf];
	A = fscanf(fileID,formatSpec,sizeA)
	A
	fclose(fileID);
	x = 1:1:5;
	y = [x;rand(1,5)];
	fileID = fopen('output.txt','w');
	fprintf(fileID,'%d %4.4f\n',y);
	fclose(fileID);

Bu dosya kuyruğa aşağıdaki komutla gönderilir.

::

    j=batch('test3','CurrentFolder','/truba/home/kullanici_calisma_dizini/', 'AutoAddClientPath',false); 

Bu dosya kuyrukta çalışıp sonlandıktan sonra, ekran çıktılarını

::

    diary(j)

komutu ile alabilirsiniz. Ayrıca dosya içerisinde kullanılan değişkenlerin son değerlerini,

::
 
    load(j)

lokal arayüzünüze alabilirsiniz.

Örnek 4: Paralel iş çalıştırma (paralel for, MPI) 
:::::::::::::::::::::::::::::::::::::::::::::::::::

MATLAB'ın neredeyse tüm fonksiyonları node için paralelleştirmeyi (OpenMP) hali hazırda desteklemektedir. Bu desteği kullanmak için kodda ekstra değişiklikler yapmaya gerek bulunmamaktadır. Herhangi bir MATLAB  fonksiyonu çalıştırıldığında, kod sunucuda izin verilen tüm çekirdekleri kullanacaktır.

MATLAB aynı zamanda nodelar arası paralelleştirmeyi (MPI) de desteklemektedir. Büyük :code:`for` döngüleri ya da destekeleyen diğer fonksiyonlar, birkaç basit  değişiklikle nodelar arası  paralel çalışır hale getirilebilir. Aşağıdaki kod parçasında paralel for döngüsü kullanılmıştır.

:: 

    %% test4.m dosyasinin icerigi
	function t = parallel_example(iter)
	if nargin==0, iter = 16; end
	disp('Start sim')

	t0 = tic;
	parfor idx = 1:iter
    		A(idx) = idx;
    		pause(2)
	end
	t = toc(t0);

	disp('Sim completed.')

Kodu kuyruğa göndermek için

::

    c.NumWorkers=4;
    c.NumThreads=7; 
    j = batch(c,@test4, 1, {}, 'pool',3,'CurrentFolder', '.','AutoAddClientPath',false)

.. warning::

    işinizi gönderdiğinizde config ayarlarınıza göre aşağıdaki gibi bir çıktı göreceksiniz. 
    ``additionalSubmitArgs = '--ntasks=4 --cpus-per-task=7 -p hamsi -t 3:00:00 -N 1 '``

    pool sayisi :code:`--ntask` parametresine karşılık gelmektedir. Bir çekirdek işi orkestra eden olarak ayrıldığından pool sayısı ``"ntasks-1"`` şeklinde girilmelidir.    


Barbun1 ya da Sardalya1 üzerinde MATLAB çalıştırarak TRUBA'ya iş göndermek
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Öncelikle kişisel lisansınızın TRUBA üzerinde aktif edilmesi gerekmektedir. Lisansınızı aktifleştirmek için **barbun1** ya da **sardalya1** bir sunucularından herhangi birine  grafik arayüzü desteği ile bağlanmak gereklidir. TRUBA kullanıcı arayüzlerine 3 farklı şekilde grafik arayüzü bağlantısı yapılabilir.

1. ``ssh -XY username@sunucu_adi`` komutu aracılığıyla :ref:`grafik arayüz <grafik-ekran>` alarak

2. :ref:`VNC ile (barbun1 ve sardalya1) üzerinde (Linux XFCE Desktop) masaüstü çalıştırarak <TRUBA-vnc>`

3. :ref:`OpenOnDemand <open_ondemand>` ile bağlanarak. “Interactive Apps” sekmesinden ``“TRUBA Desktop”`` **(Linux XFCE Desktop)** oturumu başlatılabilir. Linux Masaüstü üzerinde çalıştırılacak uygulamalar, küme üzerindeki hesaplama sunucularında çalıştırılmış olacaktır. Linux Masaüstünde **terminal** uygulamasından verilecek komutlarla sunucu üzerinde MATLAB da dahil olmak üzere herhangi bir görsel uygulama çalıştırılabilir.


.. warning::

    Not: VNC ile grafik arayüzü alarak MATLAB çalıştırmak sadece ``sardalya1`` ve ``barbun1`` sunucuları için geçerlidir.

:ref:`Buradan <grafik-ekran>` grafik arayüzüne nasıl bağlanılacağı hakkında detaylı bilgi edinebilirsiniz. 

Arayüz sunucusunda terminal ekranı aldıktan sonra MATLAB ile küme profili oluşturmaya başlayabiliriz.

::

    # Sistemde yüklü MATLAB versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab12.png

Sistem üzerinde farklı versiyonlar yüklü olabilir (R2018b ve R2021b vb).
Örnek olarak R2021b versiyonunu kullanacaksanız öncelikle bu yazılımı ``module load`` ile sisteminize yüklemeniz gerekecektir. Modül kullanımı ile ilgili bigiye :ref:`moduller-truba` sayfasından erişebilirsiniz.

::

    ## sisteminizde eskiden yüklü modüllerinizin çakışmamsi için öncelikle yüklü modülleri temizleyin
    module purge

    ## modülü yüklemek için
    module load centos7.9/app/matlab/r2021b

    ## modülün doğru şekilde yüklendiğini doğrulamak için
    module list

    ## MATLAB'i calistirmak icin
    matlab -nosplash

MATLAB'ı ilk kez çalıştırdığınızda aşağıdaki gibi bir sorgu ekranı açılacak ve lisansınızı aktive etmeniz istenecektir.

.. image:: /assets/matlab-howto/matlab2.png

Eğer ilgili sorgu ekran otomatik olarak açılmazsa ``matlab/bin`` dizinin altinda yer alan ``activate_matlab.sh`` betiğini çalıştırarak da aktivasyonu gerçekleştirebilirsiniz.

::

    ## matlab lisansını aktive etmek için
    /truba/sw/centos7.9/app/matlab/r2021b/bin/activate_matlab.sh


.. note::

    Not: Daha önce sunucu üzerinde lisansınızı kayıt ettirmişseniz kaydın yeniden yapılmasına gerek olmayabilir. Lisans uyarısı aldığınız taktirde ise
    ``activate`` betiğini yeniden çalıştırınız.

Lisans doğrulamasını gerçekleştirdikten sonra Matlab'ı yeniden çalıştırarak slurm küme ayarlarını gerçekleştirebilirsiniz.

::

    matlab -nosplash

Öncelikle ayar dosyasını (``/truba/sw/scripts/matlab/matlabScripts/truba.shared.R2021b``) arayüz sunucusunda kendi dizininize kopyalayın.

::

    ## bagli oldugunuz arayuz sunucusunda (ornegin levrek1)
    cp -r /truba/sw/scripts/matlab/matlabScripts/truba.shared.R2021b ~/TRUBA_2021b_shared

Daha sonra **MATLAB Komut Satırından** ilgili ayar dosyası çalıştırılır.

::

    matlab -nosplash
    cd ~/TRUBA_2021b_shared
    configCluster

Bu ayar dosyasını bir kez çalıştırmanız yeterlidir. Daha sonra :ref:`MATLAB-TRUBA_config` yönergelerini takip ederek hesaplama kümelerine iş gönderebilirsiniz.

.. warning::

    Kişisel bilgisayar üzerinden çalıştırdığınız MATLAB ile TRUBA kümesine iş göndermek için ``/truba/sw/scripts/matlab/matlabScripts/truba.nonshared.R2021b`` ayar dosyasını,

    TRUBA arayüz sunucularında grafik ekran alarak çalıştırdığınız MATLAB ile kümeye iş gönderecekseniz ise ``/truba/sw/scripts/matlab/matlabScripts/truba.shared.R2021b ~/TRUBA_2021b_shared`` ayar dosyasını kullanmanız gerekecektir. Aksi takdirde işlerinizde hata ile karşılaşacaksınız.

--------------------------------------------
Kayar (Floating) Lisansı Olan Kullanıcılar 
--------------------------------------------

Lisans doğrulaması, kullanıcının kendi kurumundaki lisans sunucusu tarafından yapılır. Bu nedenle kurumdaki lisans sunucusunun TRUBA sunucularına lisans doğrulaması için erişim izni vermesi gereklidir. TRUBA'nın çıkış IP adresi **193.140.99.241**'dir. Bu yetki ile ilgili kurumunuzun bilgi işlem daire başkanlığıyla iletişime geçiniz.

Kayar lisansına sahipseniz bir slurm betik dosyası hazırlayarak, işlerinizi ``sbatch`` komutu ile iş kuyruğuna gönderebilirsiniz. 

TRUBA üzerinde halihazırda bazı MATLAB versiyonları yüklü durumdadır. Bu yazılımlar zaman içerisinde yeni versiyonlar eklendikçe güncellenmektedir

Sistemde yüklü yazılımları ``module available`` komutu ile görebilirsiniz. Moduller hakkındaki ayrıntılı bilgiye :ref:`moduller-truba` sayfasından erişim sağlayabilirsiniz.

::

    # Sistemde yüklü matlab versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab1.png

.. warning::

    TRUBA üzerinde küme yönetimi ve iş zamanlayıcı olarak :ref:`SLURM <slurm-betik>` kullanılmaktadır. Kümede iş çalıştırmadan önce :ref:`SLURM betik özellikleri <slurm-betik>` hakkında bilgi edinmiş olmanız beklenmektedir. İş göndereceğiniz hesaplama kümeleri ile ilgili bilgiye :ref:`hesaplama-kumeleri` sayfasından erişebilirsiniz.

Lisans dosyanızı TRUBA arayüz sunucusuna transfer ediniz. Bunu terminal aracılığıyla ``scp`` komutu ile yapabileceğiniz gibi :ref:`winscp, filezilla <ssh-baglanti>` vb. gibi SFTP yazılımları aracılğıyla da gerçekleştirebilirsiniz.

::

    ## username kısmını TRUBA kullanıcı adınızla değiştirmeyi unutmayin
    scp -r "lisans_dosyanızın_bilgisayarınızdaki_yeri" username@levrek1.ulakbim.gov.tr:/truba/home/username/

- Kullanacağınız MATLAB versiyonuna karar verdiyseniz

- İş göndereceğiniz sunucuya karar verdiyseniz

- SLURM betik dosyası hazırlamakla ilgili bilgi edindiyseniz

- MATLAB lisans dosyanızı arayüz sunucusuna aktardıysanız

örnek bir betik dosyasını ``/truba/sw/scripts/matlab`` dizininin altında inceleyebilir ve işlerinizi kümeye gönderebilirsiniz.

::

    ### matlab.slurm dosyasinin icerigi

    $MATLAB_DIR/bin/matlab -nodisplay -nosplash < test.m > OUTPUTFILE.out
    exit

    #!/bin/bash
    #SBATCH -p hamsi #isi gondermek istediginiz kuyrugun adini yaziniz.
    #SBATCH -A kullanici_kuyruk_hesabi #kendi kuyruk hesabinizi yaziniz.
    #SBATCH -J matlab
    #SBATCH -N 1 
    #SBATCH -n 1 
    #SBATCH --cpus-per-task 28 
    #SBATCH --time=1:00:00

    echo "SLURM_NODELIST $SLURM_NODELIST"
    echo "NUMBER OF CORES $SLURM_NTASKS"

    #kendi lisans dosyanizin adi ve tam yolu..
    export MLM_LICENSE_FILE=$HOME/matlab_license.lic 

    ## onceden yuklu moduller varsa, kaldirin
    module purge

    #Cevre degiskenleri modul ile load edebilir
    module load centos7.9/app/matlab/r2021b

    ## MATLAB R2018b versiyonu icin
    ## module load centos7.3/app/matlab/R2018b

    #ya da kendiniz elle yapilandirabilirsiniz.
    #MATLAB_DIR=/truba/sw/centos7.3/app/matlab/R2018b
    #export LD_LIBRARY_PATH=$MATLAB_DIR/lib:$LD_LIBRARY_PATH
    #export PATH=$MATLAB_DIR/bin:$PATH


    ## test.m dosyasini calistirmak istediginiz matlab dosyasi ile degistirin
    $MATLAB_DIR/bin/matlab -nodisplay -nosplash < test.m > OUTPUTFILE.out

    exit


::

    ##  test.m dosyasinin icerigi
    A=rand(100,100);
    B=rand(100,100);
    C=A*B;
    size(C);
    quit


``sbatch`` ile işinizi kuyruğa gönderebilirsiniz. 

::

    ## isinizi kuyruga gondermek icin
    sbatch name_of_your_slurm_file

    ## isinizin durumu hakkinda bilgi edinmek icin
    squeue -u username

    ## isinizi iptal etmek isterseniz
    scancel "JOBID"

Çalıştırmış olduğunuz dosya ile ilgili çıktı dosyaları (``OUTPUTFILE.out``, ``slurm-"jobid".err``,  ``slurm-"jobid".out``)  işi göndermiş olduğunuz klasörde yer alacaktır. Ayrıca ``.matlab`` klasörü altında da göndermiş olduğunuz işle ilgili detaylara da erişebilirsiniz.


``batch`` ile işinizi gönderirken output dosyasını iki farklı şekilde yazdırabilirsiniz (dosyanızın adı "INPUTFILE"  olsun)

::

    # Bu metot ile iş gönderdiğinizde çıktı dosyanız MATLAB tarafından oluşturulan ">>" karakterlerini içerecektir.
    matlab -nodisplay -nosplash < INPUTFILE.m > OUTPUTFILE.out

    # Bu metot ile çalıştırdığınızda betiğinizin sonunda (INPUTFILE) "quit" komutu yer almalıdır. Aksi takdirde MATLAB, calıştırmak için komut bekleyeceğinden hesaplama kaynaklarını boş yere meşgul edecektir.

    matlab -nodisplay -nosplash -r INPUTFILE -logfile OUTPUTFILE.out 

2 Ek Notlar
-----------

- Örnek betik dosyalarına ``/truba/sw/scripts/matlab`` dizininden erişim sağlayabilirsiniz.


Dökümanla ilgili eksik ya da hata bulmanız durumunda bizlere grid-teknik@ulakbim.gov.tr adresinden erişebilirsiniz. Eklenmesini istediğiniz bilgiler için de bizlere aynı adresten ulaşabilirsiniz. 

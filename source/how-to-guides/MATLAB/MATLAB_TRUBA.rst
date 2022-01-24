

=================================
TRUBA'da MATLAB Nasıl Kullanılır?
=================================

TRUBA üzerinde MATLAB çalıştırmak isteyen kullanıcıların **kendilerine ait bir lisansa** sahip olması gerekmektedir. Bu lisans **kişisel, akademik ya da floating (kayar) lisans** olabilir.

Lisans türleri hakkında bilgiye `https://www.mathworks.com/pricing-licensing.html <https://www.mathworks.com/pricing-licensing.html>`_ adresinden erişebilirsiniz. Ayrıca üniversitelerin bilgi işlem merkezlerinden de lisansınız hakkında detaylı bilgi edinebilirsiniz.

MATLAB, sahip olunan lisans türüne göre TRUBA üzerinde farklı şekillerde çalıştırılabilir.

-------------------------------------------------------------------
Akademik (TAH: Total Academic Headcount) lisansı olan kullanıcılar:
-------------------------------------------------------------------

EGI ile MATHWORKS arasındaki anlaşma sayesinde kullanıcılar, **kişisel lisansları** ile EGI üyesi ülkelerin süperbilgisayar merkezlerinde MATLAB çalıştırabilmektedir. Akademik lisansınız Mathworks üzerinden doğrulanabilmesi için grafik ekrana ihtiyaç duyulmaktadır. Bu lisansa sahip olarak TRUBA üzerinde MATLAB çalıştıracaksanız birkaç metot mevcut.

- **Kişisel bilgisayarınızda MATLAB calıştırarak**

- TRUBA uzerindeki arayüz sunucularında `grafik ekran <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/grafikekran.html?highlight=grafik>`_ alarak

Kişisel Bilgisayarınızda MATLAB calıştırırak TRUBA'ya iş göndermek
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- MATLAB'ın güncel versiyonunu `mathworks <https://www.mathworks.com/downloads/>`_ sitesinden indirebilirsiniz. Akademik lisansa sahipseniz, kullanıcı adı ve şifrenizle giriş yapıp MATLAB'ı indirebilir ve kişisel bilgisayarınıza kurulumu gerçekleştirebilirsiniz.

- İlk kez çalıştırdığınızda aşağıdaki gibi lisans sorgu ekranıyla karşılaşacaksanız. Bilgilerinizi girip aktivasyonunuzu gerçekleştiriniz.

  .. image:: /assets/matlab-howto/matlab2.png

- Kişisel bilgisayarınızdan çalıştırdığınız MATLAB ile TRUBA'ya iş gönderebilmek için bir seferlik küme ayarının ("parallel cluster") yapılması gerekmektedir.

- İlgili ayar dosyaları ``/truba/sw/scripts/matlab/matlabScripts/truba.nonShared.R2021b`` klasöründe yer almaktadır. Buradan ilgili klasörü kendi bilgisayarınıza indiriniz. 

  ::

      scp -r username@levrek1.ulakbim.gov.tr:/truba/sw/scripts/matlab/matlabScripts/truba.nonShared.R2021b ~/TRUBA_2021b

(Aşağıdaki örnek ilgili klasörün ``'~/TRUBA_2021b'`` altında olduğu varsayılarak düzenlenmiştir.)

- Kişisel bilgisayarınızda çalıştırdığınız **MATLAB komut penceresinden** indirmiş olduğunuz ayar dosyasına gidip, ``configCluster`` komutunu çalıştırınız. Sonrasında TRUBA kullanıcı adınızı giriniz.

::

    >> cd ~/TRUBA_R2021b/
    >> configCluster

.. image:: /assets/matlab-howto/matlab3.png

.. note::

    ``configCluster`` komutunu çalıştırdığınızda varsayılan kümeniz TRUBA olarak ayarlanacaktır. Eğer lokal makinenizde iş çalıştıracaksanız 
    ``c=parcluster('local');``
    şeklinde ilgili ayarı değiştirmeniz gerekecektir. 

Bu işlemi bir kez gerçekleştirmek yeterlidir. Bundan sonra iş gönderirken çalıştıracağınız işin ihtiyacına göre ilgili iş parametrelerinin belirtilmesi yeterli olacaktır. Aşağıda bir örnek verilmiştir.

İşinizi TRUBA kümesine göre konfigure etmek
:::::::::::::::::::::::::::::::::::::::::::::::::::

MATLAB'ı çalıştıracağınız küme hakkındaki parametrelerinizi ayarlayın. Aşağıda belirtilen komutları yine MATLAB **komut penceresinden** çalıştırmanız gerekmektedir. 

::

    % kümeyi oluşturun
    c=parcluster;

    % şu anki konfigürasyonunuzu görün
    c.AdditionalProperties

.. warning::

    Eğer kampüs içinden bağlanıyorsanız doğrudan bağlanacağınız arayüz makinesinin ip adresini giriniz.

    - ``levrek1`` için ``172.16.7.1``

    - ``sardalya1`` için ``172.16.10.1``

    - ``barbun1`` için ``172.16.11.1``

    Eğer kampüs dışından (ULAKNET ağı dışından) bağlanıyorsanız öncelikle `openvpn <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/open-vpn/index.html>`_ ile bağlantı yapmanız gerekmektedir. 

İşinizle ilgili hesaplama kümesinin parametrelerini belirtin.

::

    % bağlanacağınız arayüz makinesinin ip adresini girin (levrek1 için)
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

    %% işiniz başladığında ve tamamlandığınızda e-posta ile bilgi almak istiyorsanız belirtin.
    c.AdditionalProperties.EmailAddress = 'xxx@metu.edu.tr'

    % işinizi kuyruğa göndermeden önce konfigürasyonunuzu tekrar gözden geçirebilirsiniz.
    c.AdditionalProperties

    % yapmış olduğunuz değişikliklerin farklı MATLAB oturumlarında kayıtlı kalmasını istiyorsanız yapmış olduğunuz değişiklikleri profilinize kaydedin.
    c.saveProfile

.. image:: /assets/matlab-howto/matlab4.png

Küme ayarlarınız başarıyla oluşturulmuş durumda. Ayrica ``"Home->Parallel-> Create and Manage Clusters"`` sekmesi altından oluşturmuş olduğunuz kümenin özelliklerini görebilirsiniz. MATLAB'ı kapatıp açsanız da oluşturmuş olduğunuz küme ayarlarınız kayıtlı halde duracaktır. Buradan "default profile" seçimini de gerçekleştirebilirsiniz.

.. image:: /assets/matlab-howto/matlab5.png


İşlerinizi gönderirken arayüz üzerinden de bu ayarları değiştirebilirsiniz.

.. warning::

    MATLAB CentOS-7.9 kümesi üzerinde kurulu olduğundan şu an için sadece hamsı kümesi üzerinde çalışmaktadır.


.. image:: /assets/matlab-howto/matlab6.png

.. note::

    İşlerinizin kayıt edildiği yer varsayılan olarak ``.matlab/3p_cluster_jobs/truba/TRUBA.R2021b/nonshared`` klasörü altında kayıtlı.
    ``c.AdditionalProperties.RemoteJobStorageLocation=''`` komutu ile de ilgili klasörün yerini de degistirebilirsiniz.

Herhangi bir parametreyi silmek istediğinizde (örneğin e-posta adresi) değişkeni boş bırakmanız yeterlidir.

::

    c.AdditionalProperties.EmailAddress = ''

TRUBA üzerinde interaktif olarak matlabı çalıştıramazsınız. Yani ``c=parpool(28)`` komutu ile kişisel bilgisayarınızda oluşturduğunuz gibi "pool job" oluşturmazsınız. Bunun için aşağıdaki örnekte gösterildiği gibi batch üzerinden işinizi göndermeniz gerekmektedir. Detaylı bilgi için `buradan <https://www.mathworks.com/help/parallel-computing/batch.html>`_ bilgi edinebilirsiniz. 

MATLAB arayüzü ile TRUBA'ya is gondermek
::::::::::::::::::::::::::::::::::::::::::::::::

::

    % kümeye erişim sağlayın 
    c = parcluster('truba R2021b');

    % varsayılan profil olarak TRUBA profiliniz seçiliyse ayrıca belirtmeye de gerek yok.  
    % c = parcluster;

    % işinizi küme üzerinde sıraya gönderin
    j=batch(c,@pwd,1,{},'CurrentFolder', '.','AutoAddClientPath',false)

İşinizi gönderdiğinizde şekilde görüldüğü gibi TRUBA şifrenizin girilmesi istenecektir. Bu sorgu ekranı gelmiyorsa yukarıdaki küme ayarlarınızı kontrol ediniz. Ayrıca ``batch`` komutunun nasıl kullanılacağı ve ilgili parametrelerin ne olduğu hakkında bilgiye `MATLAB yardım merkezinden <https://www.mathworks.com/help/parallel-computing/batch.html#d123e38009>`_ erişim sağlayabilirsiniz. 

.. image:: /assets/matlab-howto/matlab7.png

İşinizi gönderdiğinizde bir "Slurm Jobid" si atanacaktır. Ayrica levrek1 arayuzunden ``squeue`` komutu ile de işinizin durumunu öğrenebilirsiniz.

.. image:: /assets/matlab-howto/matlab8.png


.. image:: /assets/matlab-howto/matlab9.png

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

::

    % eğer var olan tüm işleri silmek isterseniz
    delete(c.Jobs)


İşinizin durumunu ayrıca "**MATLAB Job Monitor Tool**" ile de görebilirsiniz. İşinizle ilgili sonucu bu arayüz aracılığıyla da çekebilirsiniz.

.. image:: /assets/matlab-howto/matlab5.png

.. image:: /assets/matlab-howto/matlab10.png


.. note::

    İşinizi kuyruğa gönderdikten sonra oturumunuzu açık tutmanıza gerek yoktur. İşiniz tamamlandığında MATLABı tekrar çalıştırıp biten işlerinizin durumunu görebilir ve sonuçlarınızı çağırabilirsiniz. Bu işlemi "MATLAB Job Monitor Tool" ile yapabileceğiniz gibi komut satırından da gerçekleştirebilirsiniz.


::

    c=parcluster;
    jobs=c.Jobs

    %% ID numarası 2 olan işi seç
     j2 = c.Jobs(2)
     j2.fetchOutputs

.. image:: /assets/matlab-howto/matlab11.png

MATLAB ile TRUBA üzerinde Parallel İş Çalıştırma
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

TRUBA üzerinde "``batch``" komutu kullanarak paralel işler çalıştırmak da mümkün. Bunun için aşağıdaki ``"parallel_example.m"`` dosyası örnek olarak kullanılacaktır. Bu işi gönderirken .m dosyanızın örnekte olduğu gibi fonksiyon içermesi gerekecektir.

::

    % parallel_example.md osyasinin icerigi

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

::

    j = batch(c,@parallel_example, 1, {}, 'pool',3,'CurrentFolder', '.','AutoAddClientPath',false)
 
    %% additionalSubmitArgs =
        '--ntasks=4 --cpus-per-task=7 --ntasks-per-core=1 -p hamsi -t 3:00:00 -N 1 --mail-type=ALL --mail-user=sbilmis@metu.edu.tr'

.. warning::

    işinizi gönderdiğinizde config ayarlarınıza göre aşağıdaki gibi bir çıktı göreceksiniz. 
    ``additionalSubmitArgs = '--ntasks=4 --cpus-per-task=7 --ntasks-per-core=1 -p hamsi -t 3:00:00 -N 1 --mail-type=ALL --mail-user=sbilmis@metu.edu.tr'``

    pool sayisi ``--ntask`` parametresine karşılık gelmektedir. Bir çekirdek işi orkestra eden olarak ayrıldığından pool sayısı ``"ntasks-1"`` seklinde girilmelidir.    

TRUBA üzerindeki sunucularda grafik arayüz alarak MATLAB calıştırarak hesaplama kümelerine iş göndermek
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Lisansınızı aktive edebilmek için MATLAB yazılımını interaktif olarak çalıştırmanız gerekmektedir. Grafik arayüzü açabilmek için ise 3 farklı metot bulunmakta.

1. ``ssh -XY username@sunucu_adi`` komutu aracılığıyla `grafik arayüz <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/grafikekran.html>`_ alarak

2. VNC ile (barbun1 ve sardalya1) uzerinde (Linux XFCE Desktop) masaüstü çalıştırarak

3. `OpenOnDemand <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/openondemand/index.html>`_ ile bağlanarak. “Interactive Apps” sekmesinden ``“TRUBA Desktop”`` **(Linux XFCE Desktop)** oturumu başlatılabilir. Linux Masaüstü üzerinde çalıştırılacak uygulamalar, küme üzerindeki hesaplama sunucularında çalıştırılmış olacaktır. Linux Masaüstünde **terminal** uygulamasından verilecek komutlarla sunucu üzerinde MATLAB da dahil olmak üzere herhangi bir görsel uygulama çalıştırılabilir.

.. warning::

    Not: VNC ile grafik arayüzü alarak MATLAB çalıştırmak sadece ``sardalya1`` ve ``barbun1`` sunucuları için geçerlidir.

`Buradan <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/grafikekran.html?highlight=grafik>`_ grafik arayuzune nasil baglanilacagi hakkinda detayli bilgi edinebilirsiniz. 

Arayüz sunucusunda terminal ekranı aldıktan sonra MATLAB ile küme profili oluşturmaya başlayabiliriz.

::

    # Sistemde yüklü MATLAB versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab12.png

Sistem üzerinde farklı versiyonlar yüklü olabilir (R2018b ve R2021b vb).
Örnek olarak R2021b versiyonunu kullanacaksanız öncelikle bu yazılımı ``module load`` ile sisteminize yüklemeniz gerekecektir. Modul kullanimi ile ilgili bigiye `buradan <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/moduller.html>`_ erişebilirsiniz.

::

    ## sisteminizde eskiden yüklü modüllerinizin çakışmamsi için öncelikle yüklü modülleri temizleyin
    module purge

    ## modülü yüklemek için
    module load centos7.9/app/matlab/r2021b

    ## modülün doğru şekilde yüklendiğini doğrulamak için
    module list

    ## MATLAB'i calistirmak icin
    matlab -nosplash

MATLAB'i ilk kez çalıştırdığınızda aşağıdaki gibi bir sorgu ekranı açılacak ve lisansınızı aktive etmeniz istenecektir.

.. image:: /assets/matlab-howto/matlab2.png

Eger ilgili sorgu ekrani otomatik olarak açılmazsa ``matlab/bin`` dizinin altinda yer alan ``activate_matlab.sh``
betiğini çalıştırarak da aktivasyonu gerçekleştirebilirsiniz.

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

Daha sonra **MATLAB Komut Satirindan** ilgili ayar dosyası çalıştırılır.

::

    cd ~/TRUBA_2021b_shared
    configCluster

Bu ayar dosyasını bir kez çalıştırmanız yeterlidir. Daha sonra `İşinizi TRUBA kümesine göre konfigure etmek`_ yönergeleri takip ederek hesaplama kümelerine iş gönderebilirsiniz.

.. warning::

    Kişisel bilgisayar üzerinden çalıştırdığınız MATLAB ile TRUBA kümesine iş göndermek için ``/truba/sw/scripts/matlab/matlabScripts/truba.nonShared.R2021b`` ayar dosyasını,

    TRUBA arayüz sunucularında grafik ekran alarak çalıştırdığınız MATLAB ile kümeye iş gönderecekseniz ise ``/truba/sw/scripts/matlab/matlabScripts/truba.shared.R2021b ~/TRUBA_2021b_shared`` ayar dosyasını kullanmanız gerekecektir. Aksi takdirde işlerinizde hata ile karşılaşacaksınız.

--------------------------------------------
Kayar (Floating) lisansı olan kullanıcılar :
--------------------------------------------

Lisans doğrulaması, kullanıcının kendi kurumundaki lisans sunucusu tarafından yapılır. Bu nedenle kurumdaki lisans sunucusunun TRUBA sunucularına lisans doğrulaması için erişim izni vermesi gereklidir. TRUBA'nın çıkış IP adresi **193.140.99.241**'dir. Bu yetki ile ilgili kurumunuzun bilgi işlem daire başkanlığıyla iletişime geçiniz.

Kayar lisansına sahipseniz bir slurm betik dosyası hazırlayarak, işlerinizi ``sbatch`` komutu ile iş kuyruğuna gönderebilirsiniz. 

TRUBA üzerinde halihazırda bazı MATLAB versiyonları yüklü durumdadır. Bu yazılımlar zaman içerisinde yeni versiyonlar eklendikçe güncellenmektedir

Sistemde yüklü yazılımları `modul <https://docs.truba.gov.tr/TRUBA/kullan%C4%B1c%C4%B1-el-kitab%C4%B1/mod%C3%BCller.html>`_ komutu ile görebilirsiniz. 

::

    # Sistemde yüklü matlab versiyonlarını görmek için
    module avail -t 2>&1 | grep -i matlab

.. image:: /assets/matlab-howto/matlab1.png

.. warning::

    TRUBA üzerinde küme yönetimi ve iş zamanlayıcı olarak `Slurm <https://docs.truba.gov.tr/TRUBA/kullan%C4%B1c%C4%B1-el-kitab%C4%B1/kaynaky%C3%B6neticisi-isdongusu/slurm_file_properties.html>`_ kullanılmaktadır. Kümede iş çalıştırmadan önce `Slurm betik özellikleri <https://docs.truba.gov.tr/TRUBA/kullan%C4%B1c%C4%B1-el-kitab%C4%B1/kaynaky%C3%B6neticisi-isdongusu/slurm_file_properties.html>`_  hakkında bilgi edinmiş olmanız beklenmektedir.
    İş göndereceğiniz hesaplama kümeleri ile ilgili bilgiye `buradan <https://docs.truba.gov.tr/TRUBA/kullan%C4%B1c%C4%B1-el-kitab%C4%B1/hesaplamak%C3%BCmeleri.html>`_ erişebilirsiniz.

Lisans dosyanızı TRUBA arayüz sunucusuna transfer edin. Bunu terminal aracılığıyla ``scp`` komutu ile yapabileceğiniz gibi `winscp, filezilla vb. <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kullanici-ara-yuzu/ssh-ile-baglanti/index.html>`_ SFTP yazılımları aracılğıyla da gerçekleştirebilirsiniz.

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

Çalıştırmış olduğunuz dosya ile ilgili çıktı dosyalari (``OUTPUTFİLE.out``, ``slurm-"jobid".err``,  ``slurm-"jobid".out``)  işi göndermiş olduğunuz klasörde yer alacaktır. Ayrıca ``.matlab`` klasörü altında da göndermiş olduğunuz işle ilgili detaylara da erişebilirsiniz.


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

.. _cvmfs-kilavuzu:

CVMFS Kullanımı
--------------------------

`CernVM Dosya Sistemi <https://cvmfs.readthedocs.io/en/stable/index.html>`_ (CernVM-FS), bilimsel yazılımları sanal makinelere ve fiziksel iş düğümüne (working nodes) hızlı, ölçeklenebilir ve güvenilir bir şekilde sunmak için tasarlanmış salt okunur bir dosya sistemidir. Dosyalar ve dosya meta verileri talep üzerine indirilir ve agresif bir şekilde önbelleğe alınır.

CVMFS, Tier-2 olarak hizmet veren grid-makinelerinde halihazırda mevcuttur. Kullanıcıların bu alandaki hesaplama ihtiyaçlarını grid sistemine iş göndererek  karşılaması beklenmektedir. Fakat çeşitli nedenlerle grid üzerinde değil de TRUBA küme bilgisayarlari üzerinde CVMFS kullanmanız gerekiyorsa, "`cvmfsexec <https://github.com/cvmfs/cvmfsexec>`_" paketi ile bunu gerçekleştirmek mümkün.

Hesaplama kümelerine iş gönderirken ``cvmfsexec`` komutu sayesinde "root" yetkisi gerekmeden cvmfs modüllerini mount ederek ilgili paketleri yükleyip betiklerinizi çalıştırmanız mümkün. İşiniz tamamlandığında ise cvmfs ilgili node üzerinden otomatik olarak unmount edilmektedir. 

.. warning::

    hamsi kümelerinde CentOS 7.9 yüklü  olduğundan ``cvmfsexec`` kullanacağınız işlerinizi yalnızca hamsi kümelerine göndermeniz gerekmektedir. 

Aşağıda verilen örnek;  

- ATLAS deneyi için çevre elementlerinin kurulması (**setupATLAS**) `Daha fazla bilgi için buradan bilgi edinebilirsiniz <https://twiki.atlas-canada.ca/bin/view/AtlasCanada/ATLASLocalRootBase2#lcgenv_lsetup_lcgenv>`_

- ``lsetup`` komutu ile "root" paketinin yüklenmesi

- "psview.C" dosyasının "root" yazılımı ile çalıştırılarak "feynman.eps" ciktisinin üretilmesini gostermektedir.

.. warning::

    Asagida belirtilen örnek, ilgili dosyaların kullanıcının ev dizininde atlas\_test klasörü altında  olduğu  düşünülerek hazırlanmıştır. İlgili klasörü kullanıcı ``/truba/sw/scripts/hep/cvmfs`` konumundan kendi ev dizinine de kopyalayabilirsiniz. 

- psview.C dosyasının  içeriği  aşağıda  belirtilmistir. Dosya root yazılımıyla birlikte gelen tutorial klasörünün içerisinde yer alan tutorials/graphics/feynman.C dosyasını çalıştırarak Feynman diyagramı üretmektedir. Bu dosya kümede işin düzgün çalışıp çalışmadığını kontrol etmek için örnek olarak kullanılmıştır.

.. code:: c

    #include "TROOT.h"
    #include "TCanvas.h"
    #include "TImage.h"

    void psview()
    {
      // set to batch mode -> do not display graphics
      gROOT->SetBatch(1);

      // create a PostScript file
      TString dir = gROOT->GetTutorialDir();
      dir.Append("/graphics/feynman.C");
      gROOT->Macro(dir);
      gPad->Print("feynman.eps");
    }


- ATLAS çevre değişikliklerinin yüklenmesi ve çalıştırılacak betiğin hazırlanması

.. code:: bash


    ## "atlas_test.sh" dosya icerigi##

    #!/bin/bash

    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase

    ## bashkomutu takma adlarini kullanamadigindan betik icerisinde belirtilmesi gerekli
    shopt -s expand_aliases

    alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'

    setupATLAS

    ## cmake kurulumu gerekliyse eger (TRUBA uzerinde yuklu cmake versiyonlarini da kullanabilirsiniz) 
    lsetup cmake

    ## root 6.20 kurulumu
    lsetup "root 6.20.06-x86_64-centos7-gcc8-opt"


    # root batch modeda calistirmak icin (Not:dosyanin konumundan emin olunuz)
    root -b -q ~/atlas_test/psview.C

    ## feynman.eps dosyasi output olrak uretilir



- Çalıştıracağınız betikleri hazırladıktan sonra aşağıdaki örnekte gösterilen örnek slurm betiğini hazırlayabilirsiniz.

.. code:: bash

    ## "atlas_slurm.sh" dosya icerigi

    !/bin/bash
    #SBATCH -p hamsi  ## hesaplama kumesinin ismi (su an icin CentOS 7.9 yuklu olmasi nedeniyle hamsi kumeleri zorunlu)
    #SBATCH -A kullaniciadi ## kullanici adiniz
    #SBATCH -J atlas_test1 ## isinize vermis oldugunuz adi belirtin
    #SBATCH -N 1 ## node sayisi 
    #SBATCH --ntasks-per-node=28 ## hamsi kumelerinde 28 ve katlari seklinde girilmseli
    #SBATCH --time=00-01:00:00 ## isinizin maksimum suresi 
    #SBATCH --workdir=/truba/home/kullaniciadi/atlas_test  ### calisma klasorunuzu belirtebilirsiniz. Cikti dosylariniz da bunun icerisinde yer alacaktir.
    #SBATCH --output=/truba/home/kullaniciadi/atlas_test/slurm-%j.out  ## slurm cikti dosyasi ile ilgili bilgi
    #SBATCH --error=/truba/home/kullaniciadi/atlas_test/slurm-%j.err ## slurm ile ilgili aldiginiz hata dosyasinin yeri
    #SBATCH --mail-user=eposta@metu.edu.tr ## isinizin baslama ve bitisi durumunda e-posta bilgisi almak icin belirtin
    #SBATCH --mail-type=ALL

    ## Submit with the following option to prevent the local environment from being set on the batch job environment.
    ## Atlas cevre elementlerinin yuklenmesinde hata almamak icin 
    #SBATCH --export=NONE

    ## cvmfs paketini indirin
    git clone https://github.com/cvmfs/cvmfsexec

    ## default ayari ile dist klasorunu olusturun
    ./cvmfsexec/makedist default

    ## mount edeceginiz ekstra repositoryleri $CVMFSMOUNT ile ekleyebilirsiniz. root icin atlas repositorysinin disinda sft.cern.ch repositorysi de gerekmekte
    ./cvmfsexec/cvmfsexec atlas.cern.ch $CVMFSMOUNT sft.cern.ch -- bash /truba/home/kullaniciadi/atlas_test/atlas_test.sh


    # cvmfsexec klasorunu isiniz bittiginde silebilirsiniz

    rm -rf /truba/home/kullaniciadi/atlas_test/cvmfsexec


- slurm betiğiniz de hazir olduktan sonra isinizi ``sbatch`` komutu ile kumeye gonderebilirsiniz.

  .. code:: bash

      sbatch atlas_slurm.sh


- İşlerinizi göndermeden önce ``srun`` komutu ile hamsi kuyruğundaki bir nodu interaktif olarak ayırıp denemelerinizi gerçekleştirebilirsiniz.

.. code:: bash

    srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00 --job-name "cvmfs test" --pty bash -i



- Alternatif olarak docker ve singularity ile de ``cvmfsexec`` komutu ile ilgili repositoryleri mount etmek mümkün. Detaylı bilgi için `buradan <https://github.com/cvmfs/cvmfsexec>`_ faydalanabilirsiniz.


Sıklıkla kullandığınız spesifik yazılımları (cok fazla inode içermeyen) lxplus uzerinden scp komutu ile kendi ev dizininize de kopyalayabilirsiniz. Fakat, bu yöntemi inode sayısı  nedeniyle tercih etmemeniz önerilir.

.. code:: bash

    ## lxplus uzerinden root_numpy paketinin kendi ev dizininize kopyalayabilirsiniz.
    scp -r your_user_name@lxplus.cern.ch:/cvmfs/sft.cern.ch/lcg/releases/root_numpy/4.8.0-ff7a9 ./

- Dökümantasyona katkı yapmak isterseniz grid-teknik@ulakbim.gov.tr adresinden bize ulasabilirsiniz.

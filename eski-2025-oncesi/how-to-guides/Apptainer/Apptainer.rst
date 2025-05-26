.. _apptainer-kilavuzu:

=========
Apptainer
=========

Bu belge TRUBA altyapısında `Apptainer/Singularity <https://apptainer.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.
Bu kılavuz aşağıdakileri kapsamaktadır:


.. grid:: 5

    .. grid-item-card::  :ref:`konteyner_giris`
        :text-align: center
    .. grid-item-card:: :ref:`konteyner_kullanma`
        :text-align: center
    .. grid-item-card:: :ref:`konteyner_inşa_etme`
        :text-align: center
    .. grid-item-card:: :ref:`konteyner_anaconda`
        :text-align: center
    .. grid-item-card:: :ref:`konteyner_mpi`
        :text-align: center

.. _konteyner_giris:

Giriş
-----

Apptainer/Singularity, YBH sistemlerinde kullanılan popüler bir konteyner platformudur.  Apptainer kullanarak dizüstü bilgisayarınızda ya da sanal makinenizde oluşturacağınız, program ve yazılım parçalarını taşınabilir ve üretilebilir bir şekilde paketlenen konteynerlar istenilen başka bir makinede, ofis bilgisayarında, ya da dünyanın pek çok YBH merkezlerinde bile hiç bir kurulum gerçekleştirmeden işlerin çalıştıtırabilir olmasına imkan sağlar. Sistemlerimizde konteyner platformunu kullanmak için apptainer (önceki adı ile singularity) mevcuttur. Konteyner oluşturma işlemleri yerel ya da sanal bilgisayarınızda istenilen mimaride yapılabilir. Kurulum ve daha fazlası için `ilgili kılavuz <https://apptainer.org/docs/admin/main/installation.html>`_ ve konteyner kullanımı için `ilgili öğretici dokümantasyon <https://singularity-tutorial.github.io/>`_ takip edilebilir. Bu şekilde yerel bilgisayarınızda oluşturulan konteynerları TRUBA'da herhangi bir kuruluma ihtiyaç duymadan kullanabilir ve işlerinizi konteyner içerisinde koşturabilirsiniz.

.. _konteyner_kullanma:

Hazır Kullanım
--------------
Aşağıda popüler konteyner sağlayıcılarını bulabilirsiniz:

- `Sylabs.io Cloud Library <https://cloud.sylabs.io/>`_
- `Docker Hub <https://hub.docker.com/>`_
- `BioContainers.pro <https://biocontainers.pro/>`_
- `NVIDIA GPU Cloud (NGC) <https://catalog.ngc.nvidia.com/?filters=&orderBy=weightPopularASC&query=>`_


Temel apptainer kullanımı ``apptainer <COMMAND> ...`` şeklinde olmaktadır.

.. hint::
  
    COMMAND için popüler seçenekler:
        - ``build``: Konteyner oluşturmamızı sağlar.  
        - ``shell``: Konteyner içinde etkileşimli bir kabuk başlatmanıza olanak sağlar.
        - ``exec``: Konteyner çalıştırmanın varsayılan yoludur. Konteyner içinde ki terminale gönderilen komutları çalıştırır.
        - ``run``: Konteyner hazırlanırken ön tanımlı bir çalışma komut dosyasındaki adımları çalıştırır.

 

.. code-block:: bash

    apptainer build <Konteyner-ismi.sif> <Onceden-Insa-Edilmis-Konteyner-URL, Def or Sif files>

ile yukarıda bahsedilen konteyner sağlayıcılarından istenilen program için hazırlanmış olan konteyner elde edilebilir. Sonrasında 

.. code-block:: bash

    apptainer exec <Filename.sif> <Program> <Betik> <Arg1> ...

ile apptainer içerisinde  kurulu olan programı verilen betik ve *Arg1* parametresi ile konteyner içerisinde çalıştırabiliriz.

.. note::

    Örneğin, ubuntu 22.04 için bir konteyner oluşturmak ve içerisinde bulunan işletim sistemi bilgilerini yazdırmak aşağıdakini örnek alabiliriz: 

    .. tabs::

        .. tab:: Terminal

            .. code-block::  bash

                apptainer build ubuntu-22.04.sif docker://ubuntu:22.04
                apptainer exec ubuntu-22.04.sif cat /etc/os-release

        .. tab:: Çıktı

            .. code-block::  bash

                PRETTY_NAME="Ubuntu 22.04.2 LTS"
                NAME="Ubuntu"
                VERSION_ID="22.04"
                VERSION="22.04.2 LTS (Jammy Jellyfish)"
                VERSION_CODENAME=jammy
                ID=ubuntu
                ID_LIKE=debian
                HOME_URL="https://www.ubuntu.com/"
                SUPPORT_URL="https://help.ubuntu.com/"
                BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
                PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
                UBUNTU_CODENAME=jammy


.. warning:: 

    Yukarıdaki sağlayıcılardan indirme işlemleri yapmadan önce önbellek için bir dizin belirtmeniz 

    .. code-block:: bash

        export APPTAINER_CACHEDIR=/onbellek/icin/dizin
        export APPTAINER_TMPDIR=/tmp/icin/dizin

    ve gerektiğinde 

    .. code-block:: bash

        apptainer cache clean

    ile temizlemeniz gerekebilir. Daha fazla detay için `ilgili kılavuz <https://apptainer.org/docs/user/main/index.html>`_ ziyaret edilebilir.  Yukarıdaki adımlar yerine önbellekte tutulmasını istemiyorsak ``--disable-cache`` parametresini de kullanabiliriz.




**Konteyner dışından klasör bağlama veya dışarda bırakma**

İşlerinizi çalıştırırken konteyner içerisinde  ev dizinine erişimi engellemek istersek ``--no-home`` parametresi kullanabiliriz. Aksine, ev dizini olarak ``--home /path/on/host`` ile farklı bir yer de gösterilebilir.

Konteyneri ``apptainer shell image-name.sif`` ile çalıştırılırsa ``ls``  komutu konteynerin çalıştırıldığı dizin otomatik olarak bağlandığı görülmektedir. Varsayılan olarak, ``$HOME, $PWD, /tmp, /sys`` gibi klasörleri otomatik olarak konteyner içine bağlanır. Detay için `ilgili kılavuza <https://apptainer.org/docs/user/main/bind_paths_and_mounts.html>`_ bakılabilir. İstenilirse ``--bind kaynak_klasör:hedef_klasör`` ile dışarda bulunan ``kaynak_klasör`` içerde bulunan ``hedef_klasör`` isminde bir dizine bağlantı kurulabilir. Konteyner içinde ``hedef_klasör`` olmak zorunda değil, yok ise o isimde bir klasör oluşturur. Bunların aksine,  konteyner dışında bulunması istenilen dizin ise ``--no-mount /no/access/path`` parametresi ile yapılabilir.


.. _konteyner_inşa_etme:

Konteyner Açma, Ekleme ve Kapatma
----------------------------------

Yeni bir konteyner inşa etmek için bir konteyner servisi, tanım (def) ya da görüntü (image)  dosyalarına ihtiyaç bulunmaktadır. İstenilirse hazır bir konteyner elde edildikten sonra konteyneri bir klasör şeklinde açıp içerisinde bulunan terminal çalıştırılarak manuel olarak program kurabilir ya da kurulu olan bir programa paket eklenebilir. Bu konteyner klasörünü daha sonra kapatılıp kullanıma sunulabilir.

.. hint::
    
    Örneğin, Docker içerisinde servis edilen R programlama dili için r-base-4.3.0 konteyneri çekilecek ve içerisine ``remotes`` paketi kurulumu yapıldıktan sonra kullanıma özelleştirilmiş bir konteyner elde etmek için gerekli komutlar şu şekilde olabilmektedir:

    .. code-block:: bash

        # Klasör olarak konteyner çekilir.
        apptainer build --sandbox  r-base-4.3.0 docker://r-base:4.3.0

        # SEÇENEK 1
        # Konteyner yazılabilir şekilde içindeki R çalışır ve bir betik gönderilerek paket kurulur.
        apptainer exec --writable --no-home r-base-4.3.0/ R -e "install.packages('remotes')"

        # SEÇENEK 2
        # İstenilen paketler konteyner içindeki terminal vasıtasıyle R aktif edilerek de yapılabilinir.
        apptainer shell --writable --no-home r-base-4.3.0/
        Apptainer> R
        > install.packages('remotes')

        # Kurulum bittikten sonra klasör şeklinde olan konteynerdan bir görüntü dosyası oluşturulur.
        apptainer build r-base-4.3.0.sif r-base-4.3.0/
    

.. _konteyner_anaconda:

Konteyner içinde Anaconda
-------------------------

Conda platformunu konteyner içerisinde kullanmak için hazır anaconda ya da miniconda için servis edilen konteynerler kullanılabildiği gibi istenilen bir işletim sistemine ait bir konteyner içerisine de kurulum yapılabilir. Burada örnek olarak, hazır miniconda konteyneri oluşturulacak ve içerisine yeni bir conda ortamı oluşturma ve o ortam içerisinde python 3.9 versiyonu yükleme süreci gösterilecektir.

.. tabs:: 

    .. tab:: Miniconda3

        .. code-block:: bash

            # Konteyner indirme işlemi 
            apptainer build --sandbox miniconda3-container docker://continuumio/miniconda3
            # Konteyner içerisinde terminal açma
            apptainer shell --no-home --writable --fakeroot miniconda3-container
            apt update && apt install -y apt-utils vim
            # conda aktif edebilmek için yan sekmede sunulan bilgileri vi ile ekleme
            vi /.singularity.d/env/90-environment.sh
            # conda base ortamı aktif etme
            source /.singularity.d/env/90-environment.sh
    
    .. tab:: 90-environment.sh
        
        .. code-block:: bash

            # >>> conda initialize >>>
            # !! Contents within this block are managed by 'conda init' !!
            eval "$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
            if [ $? -eq 0 ]; then
                eval "$__conda_setup"
            else
                if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
                    . "/opt/conda/etc/profile.d/conda.sh"
                else
                    export PATH="/opt/conda/bin:$PATH"
                fi
            fi

            unset __conda_setup
            # <<< conda initialize <<<

Miniconda için ayarlamalar yapıldıktan sonra istenilirse ``test`` isminde ortam oluşturalım ve içinde python 3.9 versiyonu kurabiliriz.

.. tabs:: 

    .. tab:: Miniconda3

        .. code-block:: bash

            apptainer shell --no-home --writable --fakeroot miniconda3-container
            source /.singularity.d/env/90-environment.sh
            # test isminde bir conda ortamı oluşturma
            conda create --name test
            conda activate test
            # istenilen paket kurulumları gerçekleştirme
            conda install python=3.9
            # Konteyner kapatma
            apptainer build miniconda3-container.sif ./miniconda3-container

    .. tab:: conda-env-settings

        .. code-block:: bash

            MY_ENV_NAME=test
            CONDA_PREFIX="/opt/conda/envs/${MY_ENV_NAME}"
            CONDA_PROMPT_MODIFIER="(${MY_ENV_NAME})"
            CONDA_DEFAULT_ENV="${MY_ENV_NAME}"
            CONDA_PREFIX_1="/opt/conda"
            unset PROMPT_COMMAND
            PS1="(${MY_ENV_NAME}) "

Sonrasında konteyner içine girmeden ``test`` ortamı aktif edilmek ve ``python3.9`` versiyonu kullanmak için yukarıda belirtilen ``conda-env-settings`` dosyası içinde conda ortam ismi gibi gerekli değişiklikler yapıldıktan sonra aşağıdaki gibi apptainer terminal çağrılabilir.

.. code-block:: bash

    apptainer shell --env-file conda-env-settings miniconda3-container


.. _konteyner_mpi:

Konteyner, MPI ve GPU
---------------------

Konteyner içinde GPU kullanmasına olanak sağlamak için ``--nv`` parametresi kullanılarak yapılabilir. Daha fazla detay için `ilgili GPU kılavuzu <https://apptainer.org/docs/user/latest/gpu.html>`_ ziyaret edilebilir.

MPI işleri için konteyner içinde ve dışında aynı MPI programı ve versiyonu uyumlu olmalıdır. Program çalıştırırken 
``apptainer exec mpirun -n <mpi-is-sayisi> <Konteyner> <Program> <Betik>`` olarak değil,

.. code-block:: bash

    mpirun -n <mpi-is-sayisi> apptainer exec <Konteyner> <Program> <Betik>

şeklinde verilmelidir. Daha fazla detay için `ilgili MPI kılavuzu <https://apptainer.org/docs/user/latest/mpi.html>`_ ziyaret edilebilir.
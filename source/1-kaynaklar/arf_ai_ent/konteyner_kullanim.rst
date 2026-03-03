.. _arf_ai_ent_konteyner_kullanim:

======================
Konteyner Kullanımı
======================

ARF-AI kümesinde konteyner yönetimi `Enroot <https://github.com/NVIDIA/enroot>`_ ve `Pyxis <https://github.com/NVIDIA/pyxis>`_ altyapısı üzerinden sağlanmaktadır. Enroot, NVIDIA tarafından geliştirilen hafif bir konteyner çalışma zamanıdır; Pyxis ise SLURM ile entegrasyon sağlayarak ``--container-image`` gibi parametrelerle doğrudan iş betiklerinden konteyner kullanımına olanak tanır.

Sistemde önceden hazırlanmış konteynerler ``/arf/ai-ent/enroot/squashfs/ngc`` dizini altında Enroot squashfs (``.sqsh``) formatında sunulmaktadır. Bunların yanı sıra, ``--container-image`` parametresine çeşitli kaynaklardan konteyner URI'si vererek doğrudan çekip çalıştırabilirsiniz. Pyxis bu durumda imajı otomatik olarak çeker, Enroot aracılığıyla squashfs formatına dönüştürür ve iş içinde başlatır -- tüm bu adımlar tek komutla gerçekleşir.

Desteklenen imaj kaynakları:

.. list-table::
   :widths: 30 40 30
   :header-rows: 1

   * - Kaynak
     - Format
     - Örnek
   * - Yerel squashfs dosyası
     - ``/yol/dosya.sqsh``
     - ``/arf/ai-ent/.../pytorch_25.11-py3.sqsh``
   * - Docker Hub
     - ``IMAGE:TAG``
     - ``ubuntu:24.04``
   * - Docker Hub (açık protokol)
     - ``docker://IMAGE:TAG``
     - ``docker://ubuntu:24.04``
   * - NVIDIA NGC
     - ``nvcr.io#IMAGE:TAG``
     - ``nvcr.io#nvidia/pytorch:25.11-py3``
   * - Diğer depolar
     - ``REGISTRY/IMAGE:TAG``
     - ``ghcr.io/user/image:latest``

Ortam ve Modüller
==================

ARF-AI kümesine bağlandığınızda sistemde çeşitli modüller hazır olarak bulunmaktadır. Mevcut modülleri görmek için:

.. code-block:: bash

   module av

.. dropdown:: :octicon:`terminal;1.5em;secondary` Mevcut modül listesi (Tıklayınız)
    :color: info

    .. code-block:: text

       ------ /cm/local/modulefiles ------
       boost/1.81.0        cmd                gcc/14.2.0       luajit        module-info  openldap   sedutil/1.16.0
       cluster-tools/11.0  cuda-dcgm/4.3.0.1  gmp/6.3.0        mariadb       mpc/1.3.1    prs        shared
       cm-bios-tools       dot                ipmitool/1.8.19  mariadb-libs  mpfr/4.2.1   python3    slurm/ai-ent/24.11
       cm-nvfwupd/2.0.8    freeipmi/1.6.14    lua/5.4.7        module-git    null         python312

       ------ /cm/shared/modulefiles ------
       blas/gcc/64/3.11.0       default-environment              iozone/3.494                       netcdf/gcc/64/gcc/64/4.9.2
       bonnie++/2.00a           fftw3/openmpi/gcc/64/3.3.10      iperf/3.17.1                       netperf/2.7.0
       cm-pmix3/3.1.7           globalarrays/openmpi/gcc/64/5.8  jupyter-eg-kernel-wlm-py312/4.0.1  openblas/dynamic/(default)
       cm-pmix4/4.1.3           hdf5/1.14.0                      jupyter/16.0.8                     openblas/dynamic/0.3.28
       cuda12.8/blas/12.8.1     hdf5_18/1.8.21                   lapack/gcc/64/3.11.0               openmpi/gcc/64/4.1.8
       cuda12.8/fft/12.8.1      hwloc/1.11.13                    mpich/ge/gcc/64/4.1.1              openmpi4/gcc/4.1.8
       cuda12.8/toolkit/12.8.1  hwloc2/2.8.0                     mvapich2/gcc/64/2.3.7              ucx/1.18.0

.. admonition:: SLURM Modülü
   :class: important

   İş göndermeden önce SLURM modülünün yüklü olduğundan emin olunuz:

   .. code-block:: bash

      module load slurm/ai-ent/24.11

İnteraktif Kullanım (srun)
============================

Bir konteyneri interaktif olarak başlatmak için ``srun`` komutu kullanılır. ``--container-image`` parametresine yerel ``.sqsh`` dosyası veya ``docker://`` URI'si verilebilir:

.. tab-set::

    .. tab-item:: Yerel (.sqsh)

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh \
             --pty bash

    .. tab-item:: NGC

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=nvcr.io#nvidia/pytorch:25.11-py3 \
             --pty bash

    .. tab-item:: Docker Hub

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=ubuntu:24.04 \
             --pty bash

.. note::

   Harici depolardan çekilen imajlar ilk çalıştırmada otomatik olarak indirilir ve squashfs formatına dönüştürülür; bu nedenle ilk kullanımda ek bekleme süresi olabilir. Sık kullanılan imajlar için sistemde hazır bulunan ``.sqsh`` dosyalarını tercih etmeniz önerilir.

Parametrelerin açıklaması:

.. list-table::
   :widths: 20 80
   :header-rows: 1

   * - Parametre
     - Açıklama
   * - ``-n 1``
     - Çalıştırılacak görev sayısı
   * - ``-c 16``
     - Görev başına CPU çekirdek sayısı
   * - ``-N 1``
     - Kullanılacak düğüm sayısı
   * - ``--gres=gpu:1``
     - Tahsis edilecek GPU sayısı
   * - ``--container-image``
     - Kullanılacak konteyner imajı: yerel ``.sqsh`` dosya yolu veya ``docker://`` URI
   * - ``--pty bash``
     - İnteraktif kabuk oturumu başlatır

İş Gönderimi (sbatch)
========================

Uzun süreli veya toplu işler için ``sbatch`` ile iş betiği gönderilebilir. Aşağıda örnek bir SLURM iş betiği yer almaktadır:

.. code-block:: bash

   #!/bin/bash
   #SBATCH -J pytorch-job
   #SBATCH -A kullanici_adi
   #SBATCH -N 1
   #SBATCH -n 1
   #SBATCH -c 16
   #SBATCH --gres=gpu:1
   #SBATCH --time=0-01:00:00
   #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh

   python egitim_betigi.py

Betiği göndermek için:

.. code-block:: bash

   sbatch betik.sh

Çoklu GPU kullanımı için parametreleri buna göre ayarlayınız:

.. code-block:: bash

   #!/bin/bash
   #SBATCH -J multi-gpu-job
   #SBATCH -A kullanici_adi
   #SBATCH -N 2
   #SBATCH -n 8
   #SBATCH -c 16
   #SBATCH --gres=gpu:4
   #SBATCH --time=0-03:00:00
   #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh

   torchrun --nproc_per_node=4 --nnodes=2 egitim_betigi.py

Dizin Bağlama (Mount)
=======================

Konteyner içinden ana dosya sistemindeki dizinlere erişmek için ``--container-mounts`` parametresi kullanılır. Bu parametre ile ev dizininizi, veri depolarını veya çıktı dizinlerinizi konteynere bağlayabilirsiniz.

Sistemde ``/arf/repo`` dizini altında araştırmacıların ortak kullanımına sunulan veri kümeleri ve dosyalar bulunmaktadır.

.. code-block:: bash

   srun -n 1 -c 16 -N 1 --gres=gpu:1 \
     --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh \
     --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
     --pty bash

Birden fazla dizin bağlamak için virgülle ayırabilirsiniz:

.. code-block:: bash

   --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

sbatch betiğinde kullanımı:

.. code-block:: bash

   #!/bin/bash
   #SBATCH -J mount-job
   #SBATCH -A kullanici_adi
   #SBATCH -N 1
   #SBATCH -n 1
   #SBATCH -c 16
   #SBATCH --gres=gpu:1
   #SBATCH --time=0-01:00:00
   #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh
   #SBATCH --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

   cd /workspace
   python egitim_betigi.py --data-dir /repo

Konteyner Özelleştirme
========================

Mevcut konteynerlere ek paket veya kütüphane yüklemek istediğinizde, Enroot ile konteyneri yazılabilir hale getirip özelleştirebilirsiniz.

**Konteyneri içe aktarma ve başlatma:**

.. code-block:: bash

   enroot import /arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh
   enroot create --name pytorch-ozel pytorch_25.11-py3.sqsh
   enroot start --rw pytorch-ozel

Konteyner içinde ek paketlerinizi kurabilirsiniz (ör. ``pip install ...``). İşlem tamamlandıktan sonra özelleştirilmiş konteyneri dışa aktarabilirsiniz:

.. code-block:: bash

   enroot export --output pytorch-ozel.sqsh pytorch-ozel

Oluşturulan ``.sqsh`` dosyasını ``--container-image`` parametresiyle kullanabilirsiniz.

Örnek Kullanım Senaryoları
============================

.. tab-set::

    .. tab-item:: PyTorch

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh \
             --pty bash

    .. tab-item:: Llama 3.1 70B

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nim/meta_llama-3.1-70b-instruct.1.15.sqsh \
             --pty bash

    .. tab-item:: AlphaFold2

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/google/alphafold2_latest.sqsh \
             --pty bash

    .. tab-item:: Stable Diffusion

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/stabilityai/stable-diffusion-3.5-large_1.0.0.sqsh \
             --pty bash

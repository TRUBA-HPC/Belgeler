:orphan:

.. _ghz-benchmark:

====================
GHZ Benchmark Rehberi
====================

Bu doküman, TRUBA sisteminde NVIDIA cuQuantum, Qiskit Aer GPU backend ve MPI kullanılarak GHZ benchmark'ın SLURM ile çalıştırılması için temel adımları açıklamaktadır.

Amaç
=====

Bu rehberin amacı:

* Çalışma ortamının doğrulanması
* cuQuantum konteynerinin hazırlanması
* GPU erişiminin test edilmesi
* Tek node ve çoklu node çalıştırma örneklerinin sunulması
* Sık karşılaşılan hataların açıklanması

Ön Koşullar
===========

* TRUBA hesabına sahip olunmalıdır.
* GPU kaynaklarına erişim yetkisi bulunmalıdır.
* SLURM iş kuyruğu sistemi hakkında temel bilgi sahibi olunmalıdır.
* Apptainer tabanlı konteyner kullanımı bilinmelidir. (TRUBA altyapısında Apptainer platformunun kullanımı için :ref:`Apptainer` dokümantasyon sayfası incelenebilir.)

Çalışma Dizini
==============

Önerilen çalışma dizini yapısı aşağıdaki gibidir.

.. code-block:: bash

    mkdir -p /arf/scratch/$USER/qcomp/ghz/{jobs,logs,containers}
    cd /arf/scratch/$USER/qcomp/ghz

.. warning::

    Hesaplamalarınız için /arf/scratch/$USER dizininizi kullanmanız gerekmektedir.

    "HPC sistemlerinde scratch klasörü, yoğun okuma/yazma işlemleri gerektiren işler için geçici, yüksek hızlı bir depolama alanı olarak kullanılır ve hesaplamalar sırasında verimli bir G/Ç performansı sağlar. Bu dizindeki dosyalar genellikle iş tamamlandıktan sonra silinir, böylece diğer görevler için kaynaklar serbest kalır. “

    - /arf/home/$USER yalnızca program kurulumları ve küçük işlerin çalıştırılması içindir.
    - /arf/scratch/$USER dizini ise işlerin çalıştırılması için planlanmıştır. 

    :ref:`arf_depolama_kaynaklari`

Önerilen içerik:

* ``ghz_gpu_mpi.py`` : GHZ benchmark Python betiği
* ``jobs/`` : SLURM betikleri
* ``logs/`` : stdout ve stderr çıktıları
* ``containers/`` : Apptainer imajları

NVIDIA cuQuantum İmajının Hazırlanması
======================================

TRUBA üzerinde NVIDIA cuQuantum yazılım kiti Apptainer imajı olarak kullanılabilir. Eğer kullanıcı ev dizininize daha önceden indirdiğiniz hazır bir NVIDIA cuQuantum ``.sif`` imajı mevcutsa, doğrudan bu imaj kullanılabilir.  Hazır imaj bulunmuyorsa, NGC/Docker tabanlı cuQuantum imajı `NVIDIA GPU Cloud sayfasından <https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuquantum-appliance>`_ indirilerek Apptainer formatına dönüştürülebilir.


.. code-block:: bash

    mkdir -p $HOME/containers/cuquantum/
    cd $HOME/containers/cuquantum/
    apptainer pull cuquantum_25.11_cuda12.9.1.sif docker://nvcr.io/nvidia/cuquantum-appliance:25.11

    SIF="$HOME/containers/cuquantum/cuquantum_25.11_cuda12.9.1.sif"
    test -f "$SIF" && echo "cuQuantum imajı hazır."

.. note::

    İmaj etiketi yazılım kitinin sürüm ve CUDA uyumluluğuna göre uyarlanabilir.

GPU Erişiminin Doğrulanması
===========================

GHZ benchmark çalıştırılmadan önce konteynerin GPU cihazlarını görebildiği doğrulanmalıdır. Dolayısıyla çalışılmak istenen node üzerinden interaktif node rezervasyonu yapılarak GPU bilgisi listelenebilir.

.. code-block:: bash

    srun -p kolyoz-cuda -N 1 -n 1 -c 16 --gres=gpu:1 -A kullanici_adi -J test --time=0:10:00 --pty /usr/bin/bash -i
    hostname
    apptainer exec --nv "$SIF" nvidia-smi -L

Başarılı bir doğrulamada NVIDIA GPU'ların listelenmesi beklenir. Eğer sistem GPU cihazını göremiyorsa, konteyner çağrısında ``--nv`` seçeneğinin kullanıldığından ve çalışılan node üzerinde GPU bulunduğundan emin olunmalıdır.

GHZ Doğrulama Betiği (Tek Node İçin)
========================================

Aşağıdaki Python betiği, MPI rank bilgilerini okuyarak rank-GPU eşleşmesini yazdırır, Qiskit Aer GPU backend ile GHZ durumunu oluşturur ve fidelity değerini raporlar.

.. tab-set:: 

    .. tab-item:: ghz_gpu_mpi.py

      .. code-block:: bash

        #!/bin/bash

        import os
        import math
        import socket
        import numpy as np
        from mpi4py import MPI
        from qiskit import QuantumCircuit
        from qiskit_aer import AerSimulator

        comm = MPI.COMM_WORLD
        rank = comm.Get_rank()
        size = comm.Get_size()
        host = socket.gethostname()

        local_rank = os.environ.get("OMPI_COMM_WORLD_LOCAL_RANK")
        if local_rank is None:
            local_rank = os.environ.get("SLURM_LOCALID")
        if local_rank is None:
            local_rank = str(rank)

        localid = int(local_rank)

        if not os.environ.get("CUDA_VISIBLE_DEVICES"):
            os.environ["CUDA_VISIBLE_DEVICES"] = str(localid)

        print(
            f"[rank{rank}] host={host} localid={localid} "
            f"CVD={os.environ.get('CUDA_VISIBLE_DEVICES')} size={size}",
            flush=True,
        )

        NQ = int(os.environ.get("NQ", "24"))
        PREC = os.getenv("AER_PRECISION", "single")

        def build_ghz(n: int) -> QuantumCircuit:
            qc = QuantumCircuit(n)
            qc.h(0)
            for i in range(n - 1):
                qc.cx(i, i + 1)
            qc.save_statevector()
            return qc


        def ghz_metrics(statevector: np.ndarray):
            amp0 = statevector[0]
            amp1 = statevector[-1]
            p0 = float(np.abs(amp0) ** 2)
            p1 = float(np.abs(amp1) ** 2)
            overlap = (np.conjugate(amp0) + np.conjugate(amp1)) / math.sqrt(2.0)
            fid = float(np.abs(overlap) ** 2)
            return p0, p1, fid

        backend = AerSimulator(method="statevector", device="GPU")
        backend.set_options(precision=PREC)

        opts = backend.options
        set_kwargs = {}

        for k in ("cusvaer_enable", "enable_cusvaer", "cusvaer"):
              if hasattr(opts, k):
                set_kwargs[k] = True
                break

        if hasattr(opts, "cusvaer_comm_plugin_type"):
            set_kwargs["cusvaer_comm_plugin_type"] = 0

        mpi_soname = os.getenv("MPI_SONAME", "libmpi.so.40")
        if hasattr(opts, "cusvaer_comm_plugin_soname"):
            set_kwargs["cusvaer_comm_plugin_soname"] = mpi_soname

        if set_kwargs:
            backend.set_options(**set_kwargs)

        if rank == 0:
            print(f"[rank0] AER_PRECISION={PREC}", flush=True)
            print(f"[rank0] host={host} size={size} NQ={NQ}", flush=True)
            print(f"[rank0] CUDA_VISIBLE_DEVICES={os.environ.get('CUDA_VISIBLE_DEVICES')}", flush=True)
            print(f"[rank0] set_options={set_kwargs}", flush=True)

        qc = build_ghz(NQ)
        result = backend.run(qc).result()
        sv = np.asarray(result.get_statevector(qc))
        p0, p1, fid = ghz_metrics(sv)

        if rank == 0:
            print(f"[GHZ] P(0..0)={p0:.12f} P(1..1)={p1:.12f} fidelity={fid:.12f}", flush=True)


    .. tab-item:: job_ghz_singlenode.slurm

      .. code-block:: bash

        #!/bin/bash
        #SBATCH -p kolyoz-cuda
        #SBATCH -A [USERNAME]
        #SBATCH -J ghz_ucx_2node_8r
        #SBATCH -N 1
        #SBATCH --ntasks-per-node=4
        #SBATCH -n 4
        #SBATCH -c 16
        #SBATCH --gres=gpu:4
        #SBATCH --time=0-00:30:00
        #SBATCH -o logs/%x_%j.out
        #SBATCH -e logs/%x_%j.err

        set -euo pipefail
        mkdir -p logs

        module purge
        module load lib/openmpi/5.0.4-cuda-12.4

        export OMPI_MCA_pml=ucx
        export UCX_TLS=rc,tcp
        export UCX_NET_DEVICES=all
        export OMPI_MCA_opal_cuda_support=true
        export UCX_LOG_LEVEL=warn
        export UCX_MEMTYPE_CACHE=n
        export PRRTE_MCA_hwloc_base_disable_io=1
        export PRRTE_MCA_hwloc_base_use_hwloc=1
        export HWLOC_COMPONENTS=-nvml

        SIF="$HOME/containers/cuquantum/cuquantum_25.11_cuda12.9.1.sif"

        srun --mpi=pmix -n 4 apptainer exec --nv -B "${SLURM_SUBMIT_DIR}:/work" "$SIF" bash -lc '
          export PYTHONUNBUFFERED=1
          export CUDA_DEVICE_ORDER=PCI_BUS_ID
          export CUDA_VISIBLE_DEVICES=${SLURM_LOCALID:-0}
          cd /work
          python3 -u ghz_gpu_mpi.py
        '

    .. tab-item:: İş Gönderme
        .. code-block:: bash
    
          sbatch job_ghz_singlenode.slurm





Slurm Betiği: İki Node Doğrulama Örneği
=======================================

Aşağıdaki örnek, 2 node / 8 rank / node başına 4 GPU kullanarak GHZ betiğini çalıştırmak üzere hazırlanmış olan SLURM betik dosyasıdır.

.. tab-set:: 

    .. tab-item:: job_multinode.slurm

      .. code-block:: bash

        #!/bin/bash
        #SBATCH -p kolyoz-cuda
        #SBATCH -A [USERNAME]
        #SBATCH -J ghz_ucx_2node_8r
        #SBATCH -N 2
        #SBATCH --ntasks-per-node=4
        #SBATCH -n 8
        #SBATCH -c 16
        #SBATCH --gres=gpu:4
        #SBATCH --time=0-00:30:00
        #SBATCH -o logs/%x_%j.out
        #SBATCH -e logs/%x_%j.err

        set -euo pipefail
        mkdir -p logs

        module purge
        module load lib/openmpi/5.0.4-cuda-12.4

        export OMPI_MCA_pml=ucx
        export UCX_TLS=rc,tcp
        export UCX_NET_DEVICES=all
        export OMPI_MCA_opal_cuda_support=true
        export UCX_LOG_LEVEL=warn
        export UCX_MEMTYPE_CACHE=n
        export PRRTE_MCA_hwloc_base_disable_io=1
        export PRRTE_MCA_hwloc_base_use_hwloc=1
        export HWLOC_COMPONENTS=-nvml

        SIF="$HOME/containers/cuquantum/cuquantum_25.11_cuda12.9.1.sif"

        srun --mpi=pmix -n 8 apptainer exec --nv -B "${SLURM_SUBMIT_DIR}:/work" "$SIF" bash -lc '
        export PYTHONUNBUFFERED=1
        export CUDA_DEVICE_ORDER=PCI_BUS_ID
        export CUDA_VISIBLE_DEVICES=${SLURM_LOCALID:-0}
        cd /work
        python3 -u ghz_gpu_mpi.py
        '

    .. tab-item:: İş Gönderme
        
        Hazırlanan SLURM dosyası kuyruğa aşağıdaki şekilde gönderilebilir.

        .. code-block:: bash
    
          NQ=34 AER_PRECISION=single sbatch --exclude=kolyoz17,kolyoz31 job_ghz_multinode.slurm

 


Beklenen Çıktı
==============

Qiskit Aer GPU backend ve rank-GPU eşlemesi doğru çalışıyorsa çıktı aşağıdaki yapıya benzer olmalıdır.

.. code-block:: console

    [rank0] host=kolyoz5 localid=0 CVD=0 size=8
    [rank1] host=kolyoz5 localid=1 CVD=1 size=8
    [rank2] host=kolyoz5 localid=2 CVD=2 size=8
    [rank3] host=kolyoz5 localid=3 CVD=3 size=8
    [rank4] host=kolyoz21 localid=0 CVD=0 size=8
    [rank5] host=kolyoz21 localid=1 CVD=1 size=8
    [rank6] host=kolyoz21 localid=2 CVD=2 size=8
    [rank7] host=kolyoz21 localid=3 CVD=3 size=8
    [rank0] AER_PRECISION=single
    [GHZ] P(0..0)=0.499999982886 P(1..1)=0.499999982886 fidelity=0.999999965771

Bu örnekte her node üzerinde ``localid`` değerlerinin ``CUDA_VISIBLE_DEVICES`` ile eşleştiği görülmektedir. Bu durum, her MPI rank'in ilgili node üzerinde farklı bir GPU'ya yerleştirildiğini gösterir.

Sık Karşılaşılan Hatalar
========================

CUDA cihazı görülmüyor
----------------------

.. code-block:: console

    ERROR: Failed to load qobj: No CUDA device available!

Bu durumda konteynerin GPU cihazlarını göremediği anlaşılır. Konteyner çağrısında ``--nv`` seçeneğinin kullanıldığından ve çalışılan node üzerinde GPU bulunduğundan emin olunmalıdır.

Node üzerinde GPU handle problemi
---------------------------------

.. code-block:: console

    Unable to determine the device handle for gpu 0000:55:00.0: Unknown Error

Bu hata belirli bir node üzerindeki GPU/NVML durumunun sorunlu olduğunu gösterir. İlgili node Slurm betiğinde ``--exclude=`` ile dışlanabilir.

Bellek yetersizliği
-------------------

.. code-block:: console

    slurmstepd: error: Detected 1 oom_kill event in StepId=...
    srun: error: ... Out Of Memory

Bu hata, ilgili qubit sayısının mevcut GPU belleğini aştığını gösterir. Bu durumda node/GPU sayısı artırılmalı veya daha düşük qubit sayısı tercih edilmelidir.

Uygulama Notları
================

* Çoklu node koşullarında MPI başlatıcısı olarak doğrudan Slurm'un ``srun --mpi=pmix`` çağrısı kullanılmalıdır.
* Aynı betik içinde tekrar tekrar ``srun`` çağrısı yapılmamalı; ana çalışma tek ``srun`` adımı içerisinde yürütülmelidir.
* GPU envanteri kontrolü amacıyla çalıştırılan ``nvidia-smi`` çağrılarında ``|| true`` kullanılabilir.
* H100/H200 türündeki farklı node'lar üzerinde çalışılabileceği için kullanıcılar gerekli gördüklerinde SLURM constraint eklemelidir.
* Düzenli deney takibi için her koşunun Job ID, node listesi, qubit sayısı, precision ve runtime bilgileri kaydedilmelidir.

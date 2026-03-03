.. _arf_ai_ent_ornekler:

===========================
Örnek Kullanım Senaryoları
===========================

Bu sayfada, ARF-AI kümesindeki konteynerlerin farklı kullanım senaryolarına göre örnekleri yer almaktadır. Temel ``srun``, ``sbatch`` ve ``--container-*`` parametrelerinin detaylı açıklaması için :ref:`arf_ai_ent_konteyner_kullanim` sayfasına bakınız.

Framework ve Bilimsel Konteynerler
====================================

Framework ve bilimsel hesaplama konteynerleri hem interaktif (``srun --pty bash``) hem de iş betiği (``sbatch``) ile kullanılabilir.

.. tab-set::

    .. tab-item:: PyTorch -- İnteraktif

        Keşif, hata ayıklama veya kısa denemeler için:

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             --pty bash

    .. tab-item:: PyTorch -- Eğitim (sbatch)

        Uzun süreli model eğitimi için:

        .. code-block:: bash

           #!/bin/bash
           #SBATCH -J pytorch-train
           #SBATCH -A kullanici_adi
           #SBATCH -N 1  -n 1  -c 16  --gres=gpu:1
           #SBATCH --time=0-12:00:00
           #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh
           #SBATCH --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

           cd /workspace
           python train.py --data-dir /repo/dataset --epochs 50

    .. tab-item:: PyTorch -- Dağıtık Eğitim

        Çoklu GPU ve çoklu düğüm ile dağıtık eğitim:

        .. code-block:: bash

           #!/bin/bash
           #SBATCH -J pytorch-dist
           #SBATCH -A kullanici_adi
           #SBATCH -N 2  -n 8  -c 16  --gres=gpu:4
           #SBATCH --time=1-00:00:00
           #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh
           #SBATCH --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

           cd /workspace
           torchrun --nproc_per_node=4 --nnodes=2 train.py

    .. tab-item:: AlphaFold2

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/google/alphafold2_latest.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             python run_alphafold.py --fasta_paths=/workspace/input.fasta --output_dir=/workspace/output

    .. tab-item:: Stable Diffusion

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/stabilityai/stable-diffusion-3.5-large_1.0.0.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace \
             --pty bash

    .. tab-item:: NeMo

        .. code-block:: bash

           srun -n 1 -c 64 -N 1 --gres=gpu:4 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nemo_25.11.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             --pty bash

Dil Modeli Servise Alma (NIM)
===============================

NIM dil modeli konteynerleri (Llama, GPT-OSS vb.) interaktif bir kabuk yerine **OpenAI uyumlu bir API sunucusu** başlatır. Sunucu varsayılan olarak ``8000`` portunda çalışır. Konteynerin kendi başlangıç betiğini çalıştırması için ``--container-entrypoint`` parametresi kullanılır.

Sunucuyu Başlatma
------------------

.. tab-set::

    .. tab-item:: Llama 3.1 70B (4 GPU)

        70B parametreli bir model tek GPU belleğine sığmadığından çoklu GPU gereklidir:

        .. code-block:: bash

           srun -n 1 -c 64 -N 1 --gres=gpu:4 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nim/meta_llama-3.1-70b-instruct.1.15.sqsh \
             --container-entrypoint

    .. tab-item:: GPT-OSS 120B (8 GPU, 2 Düğüm)

        120B gibi çok büyük modeller birden fazla düğüme dağıtılabilir:

        .. code-block:: bash

           srun -n 2 -c 64 -N 2 --gres=gpu:4 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/openai/gpt-oss-120b_1.5.2-variant.sqsh \
             --container-entrypoint

    .. tab-item:: sbatch ile

        Uzun süreli model sunumu için sbatch betiği tercih edilebilir:

        .. code-block:: bash

           #!/bin/bash
           #SBATCH -J llama-server
           #SBATCH -A kullanici_adi
           #SBATCH -N 1  -n 1  -c 64  --gres=gpu:4
           #SBATCH --time=0-06:00:00
           #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nim/meta_llama-3.1-70b-instruct.1.15.sqsh
           #SBATCH --container-entrypoint

Sunucu hazır olduktan sonra (başlatma süreci model boyutuna göre birkaç dakika sürebilir), aynı düğümden sorgu gönderebilirsiniz.

API ile Sorgu Gönderme
-----------------------

.. tab-set::

    .. tab-item:: curl

        .. code-block:: bash

           curl -X POST http://localhost:8000/v1/chat/completions \
             -H "Content-Type: application/json" \
             -d '{
               "model": "meta/llama-3.1-70b-instruct",
               "messages": [{"role": "user", "content": "Merhaba, nasılsın?"}]
             }'

    .. tab-item:: Python (OpenAI istemcisi)

        .. code-block:: python

           from openai import OpenAI

           client = OpenAI(base_url="http://localhost:8000/v1", api_key="not-used")

           response = client.chat.completions.create(
               model="meta/llama-3.1-70b-instruct",
               messages=[{"role": "user", "content": "Kuantum hesaplama nedir?"}]
           )

           print(response.choices[0].message.content)

.. note::

   NIM sunucusu OpenAI API formatıyla uyumludur. Mevcut OpenAI istemci kütüphanelerini ``base_url`` parametresini değiştirerek doğrudan kullanabilirsiniz.

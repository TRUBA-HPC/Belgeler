.. _arf_ai_ent_ornekler:

===========================
Örnek Kullanım Senaryoları
===========================

Bu sayfada, ARF-AI kümesindeki konteynerlerin farklı kullanım senaryolarına göre örnekleri yer almaktadır. Temel ``srun``, ``sbatch`` ve ``--container-*`` parametrelerinin detaylı açıklaması için :ref:`arf_ai_ent_konteyner_kullanim` sayfasına bakınız.

.. grid:: 2 3 5 5

    .. grid-item-card:: :ref:`ornekler_pytorch`
        :text-align: center
    .. grid-item-card:: :ref:`ornekler_nemo`
        :text-align: center
    .. grid-item-card:: :ref:`ornekler_bilimsel`
        :text-align: center
    .. grid-item-card:: :ref:`ornekler_nim`
        :text-align: center
    .. grid-item-card:: :ref:`ornekler_benchmark`
        :text-align: center

.. _ornekler_pytorch:

PyTorch ile Model Eğitimi
===========================

PyTorch konteyneri, derin öğrenme modellerinin geliştirilmesi ve eğitimi için kullanılır. İnteraktif keşiften çoklu düğümlü dağıtık eğitime kadar geniş bir kullanım aralığı sunar.

.. tab-set::

    .. tab-item:: İnteraktif

        Keşif, hata ayıklama veya kısa denemeler için:

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/pytorch_25.11-py3.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             --pty bash

    .. tab-item:: Eğitim (sbatch)

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

    .. tab-item:: Dağıtık Eğitim

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

.. _ornekler_nemo:

NeMo Framework ile LLM Eğitimi
=================================

`NeMo Framework <https://docs.nvidia.com/nemo-framework/user-guide/latest/index.html>`_, büyük dil modeli (LLM) ön eğitimi ve ince ayar (fine-tuning) için tasarlanmış NVIDIA'nın uçtan uca eğitim platformudur. Konteyner içinde ``/opt/NeMo-Framework-Launcher/`` dizini altında yapılandırma dosyaları ve başlatıcı betikler yer alır; eğitim parametreleri Hydra tabanlı YAML yapılandırmaları ile yönetilir.

.. tab-set::

    .. tab-item:: İnteraktif

        Keşif, ortam kontrolü veya veri ön işleme için interaktif kabuk:

        .. code-block:: bash

           srun -n 1 -c 64 -N 1 --gres=gpu:4 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nemo_25.11.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             --pty bash

    .. tab-item:: Ön Eğitim (Pretraining)

        NeMo Framework Launcher ile LLM ön eğitimi. Aşağıdaki örnekte GPT-3 5B modeli 4 GPU üzerinde eğitilmektedir:

        .. code-block:: bash

           #!/bin/bash
           #SBATCH -J nemo-pretrain
           #SBATCH -A kullanici_adi
           #SBATCH -N 1  -n 1  -c 64  --gres=gpu:4
           #SBATCH --time=2-00:00:00
           #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nemo_25.11.sqsh
           #SBATCH --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

           cd /opt/NeMo-Framework-Launcher/launcher_scripts
           python main.py \
             training=gpt3/5b \
             training.model.data.data_prefix=/repo/dataset \
             training.trainer.devices=4 \
             training.trainer.max_steps=5000 \
             training.exp_manager.explicit_log_dir=/workspace/results

        Dağıtık ön eğitim için düğüm ve GPU sayılarını artırın (``-N 2 --gres=gpu:4`` gibi) ve ``training.trainer.num_nodes=2`` parametresini ekleyin.

    .. tab-item:: İnce Ayar (Fine-tuning)

        Önceden eğitilmiş bir modeli (ör. Llama 3) kendi veri kümenizle ince ayar (SFT/LoRA) yapmak için:

        .. code-block:: bash

           #!/bin/bash
           #SBATCH -J nemo-sft
           #SBATCH -A kullanici_adi
           #SBATCH -N 1  -n 1  -c 64  --gres=gpu:4
           #SBATCH --time=1-00:00:00
           #SBATCH --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/nemo_25.11.sqsh
           #SBATCH --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo

           cd /opt/NeMo-Framework-Launcher/launcher_scripts
           python main.py \
             peft=llama/sft \
             peft.model.restore_from_path=/repo/checkpoints/llama3-8b.nemo \
             peft.model.data.train_ds.file_path=/workspace/data/train.jsonl \
             peft.trainer.devices=4 \
             peft.trainer.max_epochs=3 \
             peft.exp_manager.explicit_log_dir=/workspace/results/sft

        Checkpoint ``.nemo`` formatında olmalıdır. `NGC Catalog <https://catalog.ngc.nvidia.com/models>`_ üzerinden uyumlu modeller indirilebilir. LoRA için ``peft=llama/lora`` yapılandırması kullanılabilir.

.. _ornekler_bilimsel:

Bilimsel Konteynerler
=======================

.. tab-set::

    .. tab-item:: AlphaFold2

        Protein yapı tahmini için:

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/google/alphafold2_latest.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace,/arf/repo:/repo \
             python run_alphafold.py --fasta_paths=/workspace/input.fasta --output_dir=/workspace/output

    .. tab-item:: Stable Diffusion

        Görüntü üretimi için:

        .. code-block:: bash

           srun -n 1 -c 16 -N 1 --gres=gpu:1 \
             --container-image=/arf/ai-ent/enroot/squashfs/ngc/stabilityai/stable-diffusion-3.5-large_1.0.0.sqsh \
             --container-mounts=/arf/home/kullanici_adi:/workspace \
             --pty bash

.. _ornekler_nim:

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

.. _ornekler_benchmark:

Performans Testi (AIPerf)
===========================

`AIPerf <https://github.com/ai-dynamo/aiperf>`_, çıkarım sunucularının performansını ölçmek için NVIDIA tarafından geliştirilen kapsamlı bir benchmark aracıdır. NIM, Triton, vLLM ve SGLang gibi çıkarım çözümlerini destekler. Ölçülen temel metrikler:

- **TTFT (Time to First Token):** İlk token üretim süresi
- **ITL (Inter-Token Latency):** Tokenlar arası gecikme
- **Throughput:** Saniyedeki toplam token üretim hızı (tokens/s)
- **Eşzamanlılık:** Farklı yük seviyelerinde performans davranışı

Kurulum ve Kullanım
---------------------

AIPerf, NIM sunucusunun çalıştığı düğümden veya aynı ağdaki başka bir düğümden çalıştırılabilir. Sistemde hazır konteyner mevcuttur:

.. code-block:: bash

   srun -n 1 -c 16 -N 1 --gres=gpu:1 \
     --container-image=/arf/ai-ent/enroot/squashfs/ngc/nvidia/ai-dynamo/aiperf_0.5.0.sqsh \
     --container-mounts=/arf/home/kullanici_adi:/workspace \
     --pty bash

Çalışan bir NIM sunucusuna yönelik benchmark testi:

.. tab-set::

    .. tab-item:: Temel Benchmark

        .. code-block:: bash

           aiperf profile \
             --model meta/llama-3.1-70b-instruct \
             --url http://SUNUCU_IP:8000 \
             --endpoint-type chat \
             --concurrency 10 \
             --request-count 100 \
             --streaming

    .. tab-item:: Yük Testi

        Farklı eşzamanlılık seviyelerinde performans karşılaştırması:

        .. code-block:: bash

           for C in 1 5 10 20 50; do
             echo "=== Concurrency: $C ==="
             aiperf profile \
               --model meta/llama-3.1-70b-instruct \
               --url http://SUNUCU_IP:8000 \
               --endpoint-type chat \
               --concurrency $C \
               --request-count 200 \
               --streaming
           done

.. tip::

   Benchmark testi öncesinde NIM sunucusunun tamamen hazır olduğundan emin olun. Sunucunun hazır olup olmadığını ``curl http://SUNUCU_IP:8000/v1/models`` komutuyla kontrol edebilirsiniz. AIPerf'in detaylı kullanım seçenekleri ve ileri düzey yapılandırmaları için `AIPerf dokümantasyonu <https://github.com/ai-dynamo/aiperf>`_ sayfasına bakınız.

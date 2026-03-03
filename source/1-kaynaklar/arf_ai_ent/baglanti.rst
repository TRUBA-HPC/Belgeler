.. _arf_ai_ent_baglanti:

========
Bağlantı
========

ARF-AI kümesine erişim ve iş gönderimi ``arf-ai`` kullanıcı arayüzü üzerinden gerçekleştirilmektedir. Aşağıda bağlantı yöntemleri ve erişim adresleri özetlenmiştir.

.. list-table:: Bağlantı Adresleri
   :widths: 20 40 20
   :header-rows: 1
   :align: center

   * - Tür
     - Adres
     - IP
   * - SSH (Terminal)
     - ``ssh -l <kullanici-adiniz> 172.16.35.249``
     - 172.16.35.249
   * - JupyterHub
     - https://172.16.35.249:8000/
     - 172.16.35.249
   * - User Portal
     - https://172.16.35.251:8081/userportal/#/login
     - 172.16.35.251

.. note::

   ARF-AI kümesine erişim sağlayabilmek için öncelikle **OpenVPN** bağlantınızın aktif olması gerekmektedir. OpenVPN bağlantısı :ref:`open-vpn` sayfasından sağlanabilir.

   Bağlantı sağlandıktan sonra aşağıdaki komut ile ``arf-ai`` arayüzüne SSH ile bağlanabilirsiniz:

   .. code-block:: bash

      ssh -l <kullanici-adiniz> 172.16.35.249

Herhangi bir sorun yaşarsanız, yardım ve destek almak için lütfen :ref:`truba_iletisim` sayfasındaki teknik destek iletişim bilgilerini kullanarak bizimle iletişime geçiniz.

Mevcut AI Konteynerleri
========================

ARF-AI kümesinde, NGC kataloğundan sağlanan optimize edilmiş AI konteynerleri ``/arf/ai-ent/enroot/squashfs/ngc`` dizini altında Enroot squashfs formatında sunulmaktadır. Konteynerler; NVIDIA, Google, OpenAI ve Stability AI gibi sağlayıcılardan gelmekte olup büyük dil modelleri, bilimsel hesaplama, görüntü üretimi ve daha pek çok alanda kullanıma hazırdır.

.. dropdown:: :octicon:`package;1.5em;secondary` Mevcut konteyner listesini görüntüle (Tıklayınız)
    :color: info

    .. code-block:: text

       /arf/ai-ent/enroot/squashfs/ngc
       ├── google
       │   ├── alphafold2_latest.sqsh
       │   └── tensorflow_25.02-tf2-py3.sqsh
       ├── nvidia
       │   ├── blueprint
       │   │   ├── ingestor-server_2.4.0.sqsh
       │   │   ├── rag-playground_2.2.0.sqsh
       │   │   └── rag-server_2.4.0.sqsh
       │   ├── nim
       │   │   ├── cosmos-predict2-container_1.2.sqsh
       │   │   ├── cosmos-reason1-7b_1.sqsh
       │   │   ├── genmol_1.0.sqsh
       │   │   ├── meta_llama-3.1-70b-instruct.1.15.sqsh
       │   │   └── vista3d_latest.sqsh
       │   ├── omniverse
       │   │   └── ov-base-ubuntu-22_2025.2.0.sqsh
       │   ├── quantum
       │   │   ├── cuda-quantum_cu13-0.13.0.sqsh
       │   │   └── uquantum-appliance:25.11-cuda12.9.1-devel-ubuntu24.04-x86_64.sqsh
       │   ├── rapidsai
       │   ├── hpc-benchmarks_25.09.sqsh
       │   ├── isaac-sim_5.1.0.sqsh
       │   ├── nemo_25.07.sqsh
       │   ├── nemo_25.11.sqsh
       │   ├── physicsnemo_25.11.sqsh
       │   ├── pytorch_25.11-py3.sqsh
       │   ├── sglang_25.11-py3.sqsh
       │   ├── tensorrt_25.11-py3.sqsh
       │   └── tritonserver_25.11-vllm-python-py3.sqsh
       ├── openai
       │   ├── gpt-oss-120b_1.5.2-variant.sqsh
       │   └── gpt-oss-20b_1.sqsh
       └── stabilityai
           └── stable-diffusion-3.5-large_1.0.0.sqsh

.. note::

   Konteyner listesi zamanla güncellenebilir. Güncel listeyi görmek için ``arf-ai`` arayüzünde aşağıdaki komutları kullanabilirsiniz:

   .. code-block:: bash

      ls /arf/ai-ent/enroot/squashfs/ngc/

   Alt dizinler dahil tüm konteynerleri listelemek için:

   .. code-block:: bash

      find /arf/ai-ent/enroot/squashfs/ngc/ -name "*.sqsh"

Harici Konteyner Kullanımı
---------------------------

Yukarıda listelenen önceden yüklenmiş konteynerlerin yanı sıra, açık erişimli konteyner depolarından (Docker Hub, NGC Catalog, GitHub Container Registry vb.) ihtiyaç duyduğunuz konteynerleri doğrudan çekip kullanabilirsiniz.

.. admonition:: Lisanslı Konteyner Talebi
   :class: tip

   NVIDIA AI Enterprise lisansı gerektiren bir konteynere ihtiyaç duymanız halinde, aşağıdaki bilgileri içeren bir e-posta ile ``grid-teknik@ulakbim.gov.tr`` adresine başvurabilirsiniz:

   .. dropdown:: :octicon:`mail;1.5em;secondary` E-posta taslağı (Tıklayınız)
       :color: info

       | **Konu:** ARF-AI Lisanslı Konteyner Talebi
       |
       | Sayın TRUBA Teknik Ekibi,
       |
       | ARF-AI kümesinde kullanmak üzere aşağıdaki lisanslı konteynerin sisteme eklenmesini talep ediyorum.
       |
       | **Konteyner Adı:** [NGC kataloğundaki tam adı, ör: nvcr.io/nvidia/nemo:25.11]
       | **Kullanım Amacı:** [Kısa açıklama]
       | **Kullanıcı Adı:** [TRUBA kullanıcı adınız]
       |
       | Saygılarımla,
       | [Adınız Soyadınız]

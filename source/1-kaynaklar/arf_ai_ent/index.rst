.. _arf-ai-ent:

====================================
ARF-AI
====================================

.. grid:: 2

    .. grid-item-card:: :ref:`arf_ai_ent_baglanti`
        :text-align: center
    .. grid-item-card:: :ref:`arf_ai_ent_konteyner_kullanim`
        :text-align: center

ARF-AI, yapay zeka alanında çalışan araştırmacılara hizmet etmek amacıyla kurulan özel bir hesaplama kümesidir. Bu küme için TRUBA tarafından `NVIDIA AI Enterprise ürün sayfası <https://www.nvidia.com/en-us/data-center/products/ai-enterprise/>`_ kapsamı kullanıma alınmıştır.

NVIDIA AI Enterprise Nedir?
============================

`NVIDIA AI Enterprise <https://docs.nvidia.com/ai-enterprise/>`_, yapay zeka modellerinin gelistirilmesi, optimize edilmesi ve dagitilmasi icin tasarlanmis kapsamli bir yazilim platformudur. Bu platform, arastirmacilara ve gelistiricilere GPU-hizlandirilmis araclar, onceden optimize edilmis konteynerler ve hazir AI mikroservisleri sunarak yapay zeka projelerini onemli olcude hizlandirir.

Platformun Sağladığı Temel Bileşenler
=======================================

**NVIDIA NIM (Inference Microservices)**

Onceden optimize edilmis, dagitima hazir AI model mikroservisleridir. Her NIM konteyneri; Triton Inference Server, TensorRT, TensorRT-LLM ve PyTorch gibi bilesenleri icerir. Buyuk dil modelleri (LLM), goruntu uretimi ve bilimsel modeller gibi pek cok alanda kullanima hazir konteynerler sunar. (`NIM Dokumantasyonu <https://docs.nvidia.com/nim/index.html>`_ | `API Deneme Platformu <https://build.nvidia.com/explore/discover>`_)

**NVIDIA AI Blueprint**

Yapay zeka uygulamalarinin hizla gelistirilmesi icin sunulan hazir referans is akislaridir. Blueprint'ler; onceden egitilmis modelleri, NIM mikroservislerini ve altyapi bilesenlerini bir araya getirerek RAG (Retrieval-Augmented Generation) tabanli soru-cevap sistemleri, dijital asistanlar ve cok modlu veri isleme gibi uctan uca cozumler olusturmayi kolaylastirir. (`AI Blueprint Dokumantasyonu <https://docs.nvidia.com/nim/agent-blueprints/overview/latest/index.html>`_ | `GitHub <https://github.com/NVIDIA-AI-Blueprints>`_)

**NGC Katalogu Erisimi**

NVIDIA GPU Cloud (NGC) katalogu uzerinden 100'den fazla AI framework'une ve onceden egitilmis modele erisim saglanir. NGC, yapay zeka ve HPC uygulamalari icin optimize edilmis konteyner imajlarinin merkezi deposudur. (`NGC Katalogu <https://catalog.ngc.nvidia.com/>`_)

**NVIDIA RAPIDS**

GPU-hizlandirilmis veri bilimi kutuphaneleri ailesidir. cuDF (veri cerceveleri), cuML (makine ogrenmesi) ve cuGraph (graf analitigi) gibi bilesenlerle veri bilimi sureclerini 70 kata kadar hizlandirabilir. (`RAPIDS Dokumantasyonu <https://docs.rapids.ai/>`_)

**NVIDIA Triton Inference Server**

Birden fazla framework'ten (PyTorch, TensorFlow, TensorRT, ONNX vb.) gelen modelleri yuksek performansla sunmak icin tasarlanmis acik kaynakli bir cikarim sunucusudur. Dinamik gruplama ve model birlestirme gibi ozelliklerle 100 kata kadar dusuk gecikme saglayabilir. (`Triton Dokumantasyonu <https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/index.html>`_)

**NVIDIA TensorRT**

Derin ogrenme modellerini GPU uzerinde en yuksek verimlilikle calistirmak icin optimize eden bir cikarim motorudur. Egitilmis modelleri otomatik olarak optimize ederek cikarim hizini onemli olcude artirir. (`TensorRT Dokumantasyonu <https://docs.nvidia.com/deeplearning/tensorrt/index.html>`_)

**NVIDIA TAO Toolkit**

Transfer ogrenme tabanli bir model gelistirme aracidir. Onceden egitilmis modelleri kendi veri kumenizle ince ayar yaparak, sifirdan egitime kiyasla AI model gelistirme surecini 10 kata kadar hizlandirir. (`TAO Toolkit Dokumantasyonu <https://docs.nvidia.com/tao/tao-toolkit/index.html>`_)

**NeMo Framework**

Buyuk dil modelleri (LLM), konusma tanima (ASR) ve metin-konusma (TTS) modelleri icin kapsamli bir egitim ve ince ayar cercevesidir. Coklu GPU ve coklu dugum egitimi icin optimize edilmistir. (`NeMo Dokumantasyonu <https://docs.nvidia.com/nemo-framework/user-guide/latest/index.html>`_)

**NVIDIA Dynamo**

Buyuk dil modellerinin cok dugumlu dagitik ortamlarda sunulmasi icin tasarlanmis moduler bir cikarim framework'udur. Prefill ve decode asamalarini ayiran ayristirilmis servis mimarisi, onek tabanli akilli yonlendirme ve dagitik KV Cache yonetimi ile GPU kaynaklarini dinamik olarak tahsis ederek cikarim performansini optimize eder. (`Dynamo GitHub <https://github.com/ai-dynamo/dynamo>`_ | `Gelistirici Sayfasi <https://developer.nvidia.com/dynamo>`_)

**AIPerf**

Cikarim sunucularinin performansini olcmek icin tasarlanmis kapsamli bir benchmark aracidir (GenAI-Perf'in devami niteligindedir). NIM, Triton, vLLM ve SGLang gibi cikarim cozumlerini destekler; token uretim hizi, ilk token suresi (TTFT), gecikme ve eszamanli istek kapasitesi gibi metrikleri raporlar. (`AIPerf GitHub <https://github.com/ai-dynamo/aiperf>`_)

**Desteklenen Framework'ler**

NVIDIA AI Enterprise; PyTorch, TensorFlow, TensorRT, RAPIDS, JAX ve daha pek cok populer yapay zeka framework'unu destekler. Tum bu framework'ler NGC uzerinden optimize edilmis konteynerler olarak sunulur.

.. admonition:: Erişim Politikası
   :class: important

   NVIDIA AI Enterprise lisansi kapsamindaki kaynaklar, yapay zeka alaninda aktif arastirma yurutten kullanicilara tahsis edilmistir. Erisim talepleri ve kullanim kosullari hakkinda detayli bilgi icin sistem yoneticinizle iletisime geciniz.

Daha fazla bilgi için aşağıdaki başlıklara göz atabilirsiniz:

- :ref:`arf_ai_ent_baglanti` - Erişim bilgileri, mevcut AI konteynerleri ve konteyner talebi
- :ref:`arf_ai_ent_konteyner_kullanim` - Slurm ile konteyner çalıştırma, mount ve özelleştirme

.. toctree::
   :hidden:

   baglanti.rst
   konteyner_kullanim.rst

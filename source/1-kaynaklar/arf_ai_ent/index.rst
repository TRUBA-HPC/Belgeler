.. _arf-ai-ent:

====================================
ARF-AI
====================================

.. grid:: 3

    .. grid-item-card:: :ref:`arf_ai_ent_baglanti`
        :text-align: center
    .. grid-item-card:: :ref:`arf_ai_ent_konteyner_kullanim`
        :text-align: center
    .. grid-item-card:: :ref:`arf_ai_ent_ornekler`
        :text-align: center

ARF-AI, yapay zeka alanında çalışan araştırmacılara hizmet etmek amacıyla kurulan özel bir hesaplama kümesidir. Bu küme için TRUBA tarafından  `NVIDIA AI Enterprise <https://www.nvidia.com/en-us/data-center/products/ai-enterprise/>`_ lisansı satın alınmıştır.

NVIDIA AI Enterprise Nedir?
============================

`NVIDIA AI Enterprise <https://docs.nvidia.com/ai-enterprise/>`_, yapay zeka modellerinin geliştirilmesi, optimize edilmesi ve dağıtılması için tasarlanmış kapsamlı bir yazılım platformudur. Bu platform, araştırmacılara ve geliştiricilere GPU-hızlandırılmış araçlar, önceden optimize edilmiş konteynerler ve hazır AI mikroservisleri sunarak yapay zeka projelerini önemli ölçüde hızlandırır.

Platformun Sağladığı Temel Bileşenler
=======================================

**NVIDIA NIM (Inference Microservices)**

Önceden optimize edilmiş, dağıtıma hazır AI model mikroservisleridir. Her NIM konteyneri; Triton Inference Server, TensorRT, TensorRT-LLM ve PyTorch gibi bileşenleri içerir. Büyük dil modelleri (LLM), görüntü üretimi ve bilimsel modeller gibi pek çok alanda kullanıma hazır konteynerler sunar. (`NIM Dokümantasyonu <https://docs.nvidia.com/nim/index.html>`_ | `API Deneme Platformu <https://build.nvidia.com/explore/discover>`_)

**NVIDIA AI Blueprint**

Yapay zeka uygulamalarının hızla geliştirilmesi için sunulan hazır referans iş akışlarıdır. Blueprint'ler; önceden eğitilmiş modelleri, NIM mikroservislerini ve altyapı bileşenlerini bir araya getirerek RAG (Retrieval-Augmented Generation) tabanlı soru-cevap sistemleri, dijital asistanlar ve çok modlu veri işleme gibi uçtan uca çözümler oluşturmayı kolaylaştırır. (`AI Blueprint Dokümantasyonu <https://docs.nvidia.com/nim/agent-blueprints/overview/latest/index.html>`_ | `GitHub <https://github.com/NVIDIA-AI-Blueprints>`_)

**NGC Kataloğu Erişimi**

NVIDIA GPU Cloud (NGC) kataloğu üzerinden 100'den fazla AI framework'üne ve önceden eğitilmiş modele erişim sağlanır. NGC, yapay zeka ve HPC uygulamaları için optimize edilmiş konteyner imajlarının merkezi deposudur. (`NGC Kataloğu <https://catalog.ngc.nvidia.com/>`_)

**NVIDIA RAPIDS**

GPU-hızlandırılmış veri bilimi kütüphaneleri ailesidir. cuDF (veri çerçeveleri), cuML (makine öğrenmesi) ve cuGraph (graf analitiği) gibi bileşenlerle veri bilimi süreçlerini 70 kata kadar hızlandırabilir. (`RAPIDS Dokümantasyonu <https://docs.rapids.ai/>`_)

**NVIDIA Triton Inference Server**

Birden fazla framework'ten (PyTorch, TensorFlow, TensorRT, ONNX vb.) gelen modelleri yüksek performansla sunmak için tasarlanmış açık kaynaklı bir çıkarım sunucusudur. Dinamik gruplama ve model birleştirme gibi özelliklerle 100 kata kadar düşük gecikme sağlayabilir. (`Triton Dokümantasyonu <https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/index.html>`_)

**NVIDIA TensorRT**

Derin öğrenme modellerini GPU üzerinde en yüksek verimlilikle çalıştırmak için optimize eden bir çıkarım motorudur. Eğitilmiş modelleri otomatik olarak optimize ederek çıkarım hızını önemli ölçüde artırır. (`TensorRT Dokümantasyonu <https://docs.nvidia.com/deeplearning/tensorrt/index.html>`_)

**NVIDIA TAO Toolkit**

Transfer öğrenme tabanlı bir model geliştirme aracıdır. Önceden eğitilmiş modelleri kendi veri kümenizle ince ayar yaparak, sıfırdan eğitime kıyasla AI model geliştirme sürecini 10 kata kadar hızlandırır. (`TAO Toolkit Dokümantasyonu <https://docs.nvidia.com/tao/tao-toolkit/index.html>`_)

**NeMo Framework**

Büyük dil modelleri (LLM), konuşma tanıma (ASR) ve metin-konuşma (TTS) modelleri için kapsamlı bir eğitim ve ince ayar çerçevesidir. Çoklu GPU ve çoklu düğüm eğitimi için optimize edilmiştir. (`NeMo Dokümantasyonu <https://docs.nvidia.com/nemo-framework/user-guide/latest/index.html>`_)

**NVIDIA Dynamo**

Büyük dil modellerinin çok düğümlü dağıtık ortamlarda sunulması için tasarlanmış modüler bir çıkarım framework'üdür. Prefill ve decode aşamalarını ayıran ayrıştırılmış servis mimarisi, önek tabanlı akıllı yönlendirme ve dağıtık KV Cache yönetimi ile GPU kaynaklarını dinamik olarak tahsis ederek çıkarım performansını optimize eder. (`Dynamo GitHub <https://github.com/ai-dynamo/dynamo>`_ | `Geliştirici Sayfası <https://developer.nvidia.com/dynamo>`_)

**AIPerf**

Çıkarım sunucularının performansını ölçmek için tasarlanmış kapsamlı bir benchmark aracıdır (GenAI-Perf'in devamı niteliğindedir). NIM, Triton, vLLM ve SGLang gibi çıkarım çözümlerini destekler; token üretim hızı, ilk token süresi (TTFT), gecikme ve eşzamanlı istek kapasitesi gibi metrikleri raporlar. (`AIPerf GitHub <https://github.com/ai-dynamo/aiperf>`_)

**Desteklenen Framework'ler**

NVIDIA AI Enterprise; PyTorch, TensorFlow, TensorRT, RAPIDS, JAX ve daha pek çok popüler yapay zeka framework'ünü destekler. Tüm bu framework'ler NGC üzerinden optimize edilmiş konteynerler olarak sunulur.

.. admonition:: Erişim Politikası
   :class: important

   NVIDIA AI Enterprise lisansı kapsamındaki kaynaklar, yapay zeka alanında aktif araştırma yürüten kullanıcılara tahsis edilmiştir. Erişim talepleri ve kullanım koşulları hakkında detaylı bilgi için sistem yöneticinizle iletişime geçiniz.

Daha fazla bilgi için aşağıdaki başlıklara göz atabilirsiniz:

- :ref:`arf_ai_ent_baglanti` — Erişim bilgileri, mevcut AI konteynerleri ve konteyner talebi
- :ref:`arf_ai_ent_konteyner_kullanim` — SLURM ile konteyner çalıştırma, mount ve özelleştirme
- :ref:`arf_ai_ent_ornekler` — Framework, bilimsel hesaplama ve dil modeli servise alma örnekleri
- :download:`NVIDIA Base Command Manager Kullanım Kılavuzu (PDF) </_static/pdf/nvidia/bcm-user-manual.pdf>` — Küme kullanımı, Slurm, MPI, GPU ve konteyner yönetimi hakkında kapsamlı referans doküman

.. toctree::
   :hidden:

   baglanti.rst
   konteyner_kullanim.rst
   ornekler.rst

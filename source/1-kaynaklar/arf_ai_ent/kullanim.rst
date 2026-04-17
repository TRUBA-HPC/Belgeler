.. _arf_ai_ent_kullanim:

==============================
NVIDIA AI Enterprise Kullanımı
==============================

Bu bölüm, ARF-AI üzerinde merkezi olarak sunulan NVIDIA AI Enterprise SIF imajlarının Apptainer ile nasıl çalıştırılacağını açıklar.

Lisanslı NVIDIA AI Enterprise SIF Konteynerleri
-----------------------------------------------

ARF-AI platformunda çeşitli NVIDIA AI Enterprise konteynerleri lisanslı olarak aşağıdaki dizinde sunulmaktadır:

.. code-block:: bash

   /arf/ai-ent/apptainer/sif/nvidia

Sık kullanılan bazı örnek konteynerler:

- ``nemo-26.02.sif``
- ``pytorch-26.03-py3.sif``
- ``sglang-26.03-py3.sif``
- ``tensorflow-25.02-tf2-py3.sif``
- ``tensorrt-26.03-py3.sif``
- ``vllm-26.03-py3.sif``
- ``ai-dynamo/sglang-runtime-1.1.0-dev.2.sif``

Daha güncel veya tam listeyi görmek için doğrudan ilgili dizinde aşağıdaki gibi komutları kullanabilirsiniz:

.. code-block:: bash

   ls -lh /arf/ai-ent/apptainer/sif/nvidia
   ls -lh /arf/ai-ent/apptainer/sif/nvidia/ai-dynamo

.. seealso::

   Apptainer temel kavramları için :ref:`Apptainer` sayfasını inceleyiniz.


İhtiyaç Duyulan Konteyner Bildirimi
-----------------------------------

Listede bulunmayan bir NVIDIA AI Enterprise konteynerine ihtiyaç duyuyorsanız, aşağıdaki bilgilerle talep iletebilirsiniz:

- Talep edilen konteyner adı ve sürümü (`NGC Kataloğu <https://catalog.ngc.nvidia.com/>`_ üzerinden öğrenilebilir)
- Kullanım amacı (eğitim, çıkarım, servis vb.)
- Gerekli ek paketler veya bağımlılıklar
- Hedef kuyruk/GPU gereksinimi

Talep ve destek için :ref:`truba_iletisim` sayfasındaki iletişim kanallarını kullanınız.

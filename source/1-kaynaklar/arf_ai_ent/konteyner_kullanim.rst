.. _arf_ai_ent_konteyner_kullanim:

=============================
Konteyner Kullanımı
=============================

Bu bölüm, ARF-AI üzerinde merkezi olarak sunulan NVIDIA AI Enterprise SIF imajlarının Apptainer ile nasıl çalıştırılacağını açıklar.

Temel Kullanım
--------------

GPU erişimi için ``--nv`` parametresi kullanılır:

.. code-block:: bash

   apptainer exec --nv /yol/imaj.sif python -c "import torch; print(torch.cuda.is_available())"

Host dizini bağlamak için:

.. code-block:: bash

   apptainer exec --nv --bind /project:/workspace /yol/imaj.sif bash

Slurm ile Çalıştırma
--------------------

Örnek iş betiği:

.. code-block:: bash

   #!/bin/bash
   #SBATCH -p barbun-cuda
   #SBATCH -A <proje>
   #SBATCH -N 1
   #SBATCH --gres=gpu:1
   #SBATCH -t 01:00:00

   module load apptainer
   apptainer exec --nv /yol/imaj.sif python /workspace/train.py

.. warning::

   I/O yoğun işlerde veri yolu olarak ``/arf`` veya ilgili proje/scratch alanlarını kullanınız.

.. seealso::

   Apptainer temel kavramları için :ref:`Apptainer` sayfasını inceleyiniz.

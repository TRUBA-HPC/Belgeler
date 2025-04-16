==========================================
İşlerin Kuyruk Sisteminde İzlenmesi
==========================================

Bir önceki bölümde (:ref:`basic_slurm_commands`) temel slurm komutlarının özellikleri genel olarak anlatıldı. Bu bölümde komutları kullanarak terminal üzerinde işlerinizi nasıl yönetebileceğiniz örnekler üzerinden gösterilmektedir.

1. İşleri kuyruk sistemine göndermek için **sbatch** komutu kullanılır. Kullanacağız uygulama için gerekli girdi dosyalarıyla beraber hazırladığınız **SLURM Betik** dosyasını hazırladıktan sonra terminale aşağıdaki komut satırı yazılır.

.. code-block:: bash

  sbatch slurm_betiginin_adi


2. Kuyruğa gönderdiğiniz işlerinizin sistemde durumlarını görmek için aşağıdaki komut satırını terminale yazdıktan sonra ekranda işlerinizle ilgili ayrıntıları görebilirsiniz.

.. code-block:: bash

   squeue -u hesap_isminiz

.. image:: /assets/kaynakyoneticisi-isdongusu/images/squeue.png   
   :width: 500

Ekrandaki bilgiye göre kuyrukta iki tane hesabımızın olduğunu bunlardan **7043266** numaralı işimizin beklemede (pending),  **7043267** numaralı işin ise sistemde çalıştığını (Run) anlamaktayız. Dolayısıyla sisteme verdiğimiz işlerin ID numaraları ilk sütunda yazmaktadır. Bu numaralar kullanılarak işlerimizi sonlandırabiliriz.

3. Sistemde işlerin sonlandırılması için 

.. code-block:: bash

   scancel JOBID

Dolayısıyla **7043266** id numaralı işi sonlandırmak için terminale aşağıdaki komut satırı yazılmalıdır. 

.. code-block:: bash

   scancel 7043266




   











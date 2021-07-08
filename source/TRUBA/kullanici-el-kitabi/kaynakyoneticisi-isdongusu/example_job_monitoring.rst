==========================================
İşlerin Kuyruk Sisteminde İzlenmesi
==========================================

Bir önceki bölümde temel slurm komutlarının özellikleri genel olarak anlatıldı. Bu bölümde komutların terminal
üzerinde işlerimizi nasıl yönetebileceğimizi örnekler üzerinden gösterelim.

1. İşleri kuyruk sistemine göndermek için **sbatch** komutunu kullanılır. Kullanacağız uygulama için gerekli dosyalarla beraber 
hazırladığınız **Slurm Betik** dosyasını hazırladıktan sonra terminale aşağıdaki komut satırı yazılır.

.. code-block:: bash

  sbatch slurm_betiğinin_adı


2. Kuyruğa gönderdiğiniz işlerinizi sistemde durumlarını görmek için aşağıdaki komut satırını terminale yazdıktan sonra ekranda işlerinizle ilgili ayrıntıları görebilirsiniz.

.. code-block:: bash

   squeue -u hesap_isminiz

.. image:: /assets/kaynakyoneticisi-isdongusu/images/squeue.png   
   :width: 500

Ekrandaki bilgiye göre kuyrukta iki tane hesabımızın olduğunu bunlardan **7043266** numaralı işimizin beklemede (pending),  **7043267** numaralı işin ise sistemde çalıştığını (Run) anlamaktayız.
Dolayısıyla sisteme verdiğimiz işlerin ID numaraları ilk sütunda yazmaktadır. Bu numaralar kullanılarak işlerimizi öldürebiliriz.
3. Sistemde işlerin öldürülmesi için 

.. code-block:: bash

   scancel JOBID

Dolayısıyla **7043266** id numaralı işi öldürmek için terminale aşağıdaki komut satırı yazılmalıdır. 

.. code-block:: bash

   scancel 7043266




   











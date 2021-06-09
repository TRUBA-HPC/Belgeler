==========================================
İşlerin Önceliklendirilmesi ve Başlatılması
==========================================

Herhangi bir iş kuyruğa gönderildiğinde, kaynak yöneticisi belli parametrelere göre işin öncelik değerini (priority) hesaplar, ve işi kuyruğa alır. İşin öncelik değeri ne kadar yüksek ise, iş kuyruğunun o kadar önünde yer alır. Bu işin daha önce başlatılması anlamına gelir ( kullandığımız **backfill** algoritması, daha düşük öncelikli işlerin de başlatılmasına olanak sağlar).

Kullanıcılar işlerinin öncelik değerini **squeue --format=%Q** yada **sprio** komutları ile ögrenebilirler. TRUBA' daki kuyruk sisteminde **SLURM** tarafından sağlanan **multifactor** algoritması kullanılmaktadır. Bu algoritmaya göre, herhangi bir işin önceliği hesaplanırken iş gönderilirken tanımlanmış parametrelere ve sistem yöneticisi tarafından belirlenmiş parametre ağırlıklarına bakılır.
**PriorityWeightAge, PriorityWeightJobSize, PriorityWeightPartition,PriorityWeightQOS değerleri**, sistem yöneticisi tarafından belirlenmiş, her parametrenin öncelik hesaplamasında ne kadar ağırlığı olduğunu belirleyen değerlerdir. TRUBA'da bu değerler aşağıdaki notta verildiği gibidir. 

.. code-block:: bash

  PriorityWeightAge =1000 
  PriorityWeightJobSize =10000 
  PriorityWeightPartition =10000
  PriorityWeightQOS =10000
  
Herhangi bir kullanıcı arayüzünde, kullanıcılar **sprio -w** komutu ile güncel değerleri görebilirler.

İş önceliği için aşağıda verilen formül kullanılmaktadır.

.. code-block:: bash

   Job_priority =
                       (PriorityWeightAge) * (age_factor) +
                       (PriorityWeightFairshare) * (fair-share_factor) +
                       (PriorityWeightJobSize) * (job_size_factor) +
                       (PriorityWeightPartition) * (partition_factor) +
                       (PriorityWeightQOS) * (QOS_factor) +
                       SUM(TRES_weight_cpu * TRES_factor_cpu,TRES_weight_<type> * TRES_factor_<type>,...)

TRUBA'daki öncelik hesaplamasında **TRES** ve **Fairshare** parametreleri hesaba katılmamaktadır. Dolayısı ile formülümüz aşağıdaki gibidir:

.. code-block:: bash

   Job_priority =
                       (PriorityWeightAge) * (age_factor) +
                       (PriorityWeightJobSize) * (job_size_factor) +
                       (PriorityWeightPartition) * (partition_factor) +
                       (PriorityWeightQOS) * (QOS_factor) 

**Job_size_factor**  hesabı şu şekilde bulunur:

.. code-block:: bash

   Job_node_number_factor=(node_number_in_job/total_node_number_in_cluster)
   Job_cpu_number_factor = (cpu_number_in_job/total_cpu_number_in_cluster)
   job_size_factor= (Job_node_number_factor+ job_cpu_number_factor)

Eğer büyük işler öncelikliyse:

.. code-block:: bash
   
   JOBSIZE_priority= (PriorityWeightJobSize/2) * job_size_factor

Eğer küçük işler öncelikliyse:

.. code-block:: bash

   JOBSIZE_priority= PriorityWeightJobSize - (PriorityWeightJobSize/2) * job_size_factor

Örneğin 100 nodedan oluşmuş 1000 çekirdekli bir kümede, -n20 -N4 ile gönderilecek bir işin **JOBSIZE_priority değeri** şu şekilde hesaplanır:

.. code-block:: bash
   
   jOBSIZE_priority=(10000/2) * ( 4/100 + 20/1000)
                   = 300
   

Küçük işlerin önceliğini  için yukarıdaki formüle göre şu şekilde hesaplanır:

.. code-block:: bash

   jOBSIZE_priority=10000 -300 =9700

**age_factor** değerini hesaplamak için 

.. code-block:: bash
    
    age_factor=job_age/MaxAge

Yukarıda tanımlanan **MaxAge** herhangi bir işin kuyrukta en fazla bekleme süresidir. Bu değer sistem yöneticisi tarafından belirlenir.    

Böylelikle **AGE_Priority**


.. code-block:: bash
   
   AGE_priority=PriorityWeightAge*job_age/MaxAge

Yukarıdaki formülleri  en faza bekleme süresi 15 gün ve PriorityWeightAge değeri 1000 olan TRUBA'da herhangi bir 
kuyrukta 10 gün bekleyen bir iş için  AGE_priority değeri aşağıdaki gibi olacaktır.

.. code-block:: bash
  
   AGE_priority=(10/15)*1000 = 667 

Eğer iş kuyrukta 15 gün ya da daha fazla bekleyecek olursa, işin **AGE_priority değeri** en fazla 1000 olacaktır.
**QOS_factor** değeri şu şeklde hesaplanır:
İşin gönderildiği anda, tüm hesaplar arasında, QOS tanımlarında priority değeri en yüksek olan hesabın priority değeri tavan limit olarak kabul edilir. 
İşi gönderen kullanıcının QOS tanımındaki priority degeri bu tavan limitle normalize edilir.
QOS_factor=QOS_priority_of_user/max_qos_priorty_in_cluster 

.. code-block:: bash

   QOS_priority=PriorityWeightQOS*QOS_factor  

**QOS** öncelik değeri 1500 olan bir kullanıcı için, tavan limiti 5000 ve **PriorityWeightQOS** değeri 10000 olan bir kümeye iş gönderecek olursa, ilgili işin aşağıdaki gibi olacaktır.

.. code-block:: bash

   QOS_priority=1500/5000 * 10000 = 3333

**partition_factor değeri**, öncelik değeri en yüksek olan kuyruğun değeri tavan kabul edilerek, işin gönderildiği kuyruğun değerinin bu tavan değere bölünmesi ile hesaplanır.

..code-block:: bash

  partition_factor = priority_value_of_partition_of_job/max_priortity_value_of_partitions
  Partition_priority=PriorityWeightPartition*partition_factor

Kuyrukların öncelik değerleri **scontrol show partition** komutu ile görülebilir.  


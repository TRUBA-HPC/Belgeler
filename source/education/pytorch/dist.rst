=============================================================================================
Dağıtılmış, çok düğümlü ve çok GPU'lu eğitim
=============================================================================================

.. PyTorch enables training models using multiple GPUs on a single device, and multiple GPUs on multiple devices. In this example, we will explore data-parallelism which is when a model is copied to multiple GPUs, and each GPU trains the model on a portion of the training samples. The gradients of the model are synchronized between all the participating GPUs and averaged during the backward pass of training, which keeps the model identical on all the GPUs. In this example, we will use two nodes with three GPUs on each node to carry out classification on the MNIST digit dataset. 

PyTorch, tek bir aygıtta birden çok GPU ve birden çok aygıtta birden çok GPU kullanan eğitim modellerine olanak tanır. Bu örnekte, bir modelin birden fazla GPU'ya kopyalanması ve her bir GPU'nun modeli, eğitim örneklerinin bir kısmı üzerinde, eğitmesi işlemlerinin nasıl gerçekleştirildiğini keşfedeceğiz. Modelin gradyanları, katılan tüm GPU'lar arasında senkronize edilir ve eğitimin geriye doğru geçişi sırasında ortalaması alınır, bu da modeli tüm GPU'larda aynı tutar. Bu örnekte, MNIST basamaklı veri kümesinde sınıflandırma yapmak için her bir düğümde üç GPU bulunan iki düğüm kullanacağız.

Yürütme modeli
================================

.. In every node that will take part in the training, we will execute an instance of the training script. And in each training script, a single process will be forked for each GPU that will participate in training on the node running the script. For example, if two nodes are going to take part in training, and three GPUs were used in each node, then we will execute two scripts, one on each node, and each script will fork three training processes, and each process will use a single GPU on its node. In total, there will be six processes carrying out the training, and two parent processes on each node. The six processes running the training on the GPUs will be part of the same communication group running MPI, gloo, or NCCL backends. The following figure demonstrates this scenario.

Eğitimde yer alacak her düğümde, eğitim komut dosyasının bir örneğini yürüteceğiz. Ve her eğitim komut dosyasında, komut dosyasını çalıştıran düğümde eğitime katılacak her GPU için tek bir işlem çatallanacak. Örneğin, eğitimde iki düğüm yer alacaksa ve her düğümde üç GPU kullanılmışsa, her düğümde bir tane olmak üzere iki komut dosyası çalıştıracağız ve her komut dosyası üç eğitim sürecini çatallayacak ve her işlem bir tane GPU kullanacak. Toplamda, eğitimi gerçekleştiren altı süreç ve her düğümde iki ana süreç olacaktır. GPU'larda eğitimi çalıştıran altı süreç, MPI, gloo veya NCCL arka uçlarını çalıştıran aynı iletişim grubunun parçası olacaktır. Aşağıdaki şekil bu senaryoyu göstermektedir.


.. image:: res/dist.png
   :target: res/dist.png
   :alt: res/dist.png


Sinir ağı modeli (Neural network model)
=======================================

.. We will use the same neural network model used in the Deep Neural Network example:

Derin Sinir Ağı örneğinde kullanılan sinir ağı modelini kullanacağız:

.. code-block:: python


   import torch

   class DeepNeuralNetwork(torch.nn.Module):
       def __init__(self, num_layers, input_features, num_hidden_features, num_classes):
           super(DeepNeuralNetwork, self).__init__()
           self.hidden_layers = torch.nn.ModuleList()
           self.hidden_layers.append(torch.nn.Linear(input_features, num_hidden_features))

           for _ in range(num_layers-2):
               self.hidden_layers.append(torch.nn.Linear(num_hidden_features, num_hidden_features))
           self.hidden_layers.append(torch.nn.Linear(num_hidden_features, num_classes))
           self.relu_activation = torch.nn.ReLU()

       def forward(self, samples):
           out = samples
           for layer in self.hidden_layers[:-1]:
               out = layer(out)
               out = self.relu_activation(out)
           out = self.hidden_layers[-1](out)
           return out

Üst süreç - ana komut dosyası
============================================================

.. The script which will be run on each node will download the dataset used in training on its node and will read some environment variables to determine the number of nodes participating in training. Most importantly, it will fork the children processes that will carry out the training, and it will for one process for each GPU on its node.

.. In this example, we assume that SLURM was used to execute the training job. When SLURM is used to execute a parallel job, it writes some of the metadata of the job to the environment in the form of environment variables. We can read the number of tasks that are taking part in the training job using the ``"SLURM_NPROCS"`` environment variable. This value will be equal to the value of the SLURM parameter ``-n/--ntasks`` that was used when running this job step. In addition, we will read the number of the *current* task between all participating tasks using the ``"SLURM_PROCID"`` environment variable. Both of the above variables are set automatically by SLURM. 

.. For each GPU on the device, we fork a process to run the function ``train_process_on_gpu`` which we define later on. This function is responsible for training using a single GPU. We fork processes using the ``torch.multiprocessing.spawn`` function as it is specialized for forking processes for training on PyTorch. Each parent process will fork as many ``train_process_on_gpu`` processes as there are GPUs on its node.

Her düğümde çalıştırılacak komut dosyası, eğitimde kullanılan veri kümesini düğümüne indirecek ve eğitime katılan düğüm sayısını belirlemek için bazı ortam değişkenlerini okuyacaktır. En önemlisi, eğitimi gerçekleştirecek alt süreçleri çatallayacak ve düğümündeki her GPU için bir işlem başlatacaktır.

Bu örnekte, eğitim işini yürütmek için SLURM'un kullanıldığını varsayıyoruz. Paralel bir işi yürütmek için SLURM kullanıldığında, işin meta verilerinin bir kısmı ortam değişkenleri olarak saklanır. ``"SLURM_NPROCS"`` ortam değişkenini kullanarak eğitim işinde yer alan görevlerin sayısını okuyabiliriz. Bu değer, bu iş adımını çalıştırırken kullanılan SLURM parametresi ``-n/--ntasks`` değerine eşit olacaktır. Ayrıca, ``"SLURM_PROCID"`` ortam değişkenini kullanarak tüm katılan görevler arasındaki *geçerli* görevin sayısını okuyacağız. Yukarıdaki değişkenlerin her ikisi de SLURM tarafından otomatik olarak ayarlanır.

Cihaz üzerindeki her bir GPU için daha sonra tanımlayacağımız ``train_process_on_gpu`` fonksiyonunu çalıştırmak için bir işlem çatallıyoruz. Bu işlem, tek bir GPU kullanarak eğitim yapacaktır. ``torch.multiprocessing.spawn`` işlemini kullanarak süreçleri çatallıyoruz. Her ana işlem, düğümünde GPU sayısı kadar çok ``train_process_on_gpu`` işlemini çatallayacaktır.

.. code-block:: python

   if __name__=="__main__":
       # "group_size", eğitime katılan SLURM görevlerinin sayısıdır. Bizim durumumuzda, aynı zamanda eğitime katılan düğüm sayısıdır. 
       group_size = int(os.environ["SLURM_NPROCS"])
       # 'id_in_group', yürütülen tüm görevler arasındaki mevcut görevin kimliğidir. Yani düğüm numarasıdır. 
       id_in_group = int(os.environ["SLURM_PROCID"])
       # Bu düğümde eğitim için kullanılabilen GPU sayısı 
       gpus_per_device = torch.cuda.device_count()
       # Eğitime katılacak toplam GPU sayısı. İletişim grubunun parçası olacak süreçlerin sayısıdır. 
       world_size = gpus_per_device * group_size
       print(f"Bu, eğitim için kullanılacak {id_in_group} düğümden {group_size} düğüm numarasıdır. Toplamda, eğitim için kullanılacak toplam {world_size} GPU vardır. ")
       # torch.multiprocessing, yerel Python multiprocessing kitaplığı üzerindeki bir sarmalayıcıdır. PyTorch eğitiminde kullanılan süreçleri oluşturmak için kullanılır. 
       import torch.multiprocessing as mp
       args = (world_size, id_in_group, gpus_per_device)
       # Her train_process_on_gpu işlevi, eğitimi tek bir GPU üzerinde çalıştıran bir süreç olacaktır. Mevcut düğümde ne kadar GPU varsa o kadar süreç yaratıyoruz. 
       mp.spawn(train_process_on_gpu, args=args, nprocs=gpus_per_device, join=True)

Alt süreç - GPU'da eğitim fonksiyonu
===============================================================================

.. The train function is responsible for the entirety of training, and it will be executing on all the nodes, with one instance for every GPU. The function must establish the communication group, load the dataset, create the data samplers, and execute the training loop. One of the nodes will need to run testing.

Train işlemi, eğitimin tamamından sorumludur ve her GPU için bir örnekle tüm düğümlerde yürütülecektir. İşlem, iletişim grubunu oluşturmalı, veri kümesini yüklemeli, veri örnekleyicileri oluşturmalı ve eğitim döngüsünü yürütmelidir. Bu durumda düğümlerden birinin test yapması gerekir.

İletişim grupları oluşturma
---------------------------------------------------------------

.. Once the function is forked, its first argument will be its index between all the forked processes by the same parent process. We can use that number as the ID of the GPU that this process will use. The remaining arguments are passed to it from the ``args`` named paramter used while forking the processes in the ``spawn`` function. 

.. The first thing we do in this function is that we calculate the rank of this process between *all* the processes running training. Afterward, we create the communication group that will be used for training using the ``init_process_group`` function and use ``gloo`` as the communication backend. It's important to note that, in order for the communication group to be created, the IP address of the main node and a port for communication must be specified. We will specify those in the SLURM script used to run the job and we show the script at the end of this tutorial.

İşlem çatallandığında, ilk argümanı aynı ana süreç tarafından tüm çatallı süreçler arasındaki indeksi olacaktır. Bu sayıyı bu işlemin kullanacağı GPU'nun kimliği olarak kullanabiliriz. Kalan argümanlar, ``spawn`` işlevindeki süreçleri çatallarken kullanılan ``args`` adlı parametreden iletilir.

Bu fonksiyonda yaptığımız ilk şey, bu işlemin eğitim çalıştıran *tüm* süreçler arasındaki sırasını hesaplamamızdır. Daha sonra ``init_process_group`` fonksiyonunu kullanarak eğitim için kullanılacak iletişim grubunu oluşturuyoruz ve iletişim arka ucu olarak ``gloo``\ yu kullanıyoruz. Unutulmamalıyız ki, iletişim grubunun oluşturulabilmesi için ana düğümün IP adresi ve iletişim için bir bağlantı noktası belirtilmelidir. İşi çalıştırmak için kullanılanları SLURM betiğinde belirteceğiz ve betiği bu eğitimin sonunda göstereceğiz.

.. code-block:: python

   def train_process_on_gpu(gpu_id_in_node, world_size, id_in_group, gpus_per_device):
       # Eğitim için kullanılan tüm 'train_process_on_gpu' süreçleri arasında bu sürecin sıralaması
       rank = gpu_id_in_node + id_in_group*gpus_per_device
       print(f"rank {rank}, gpu_id_in_node {gpu_id_in_node}")
       dist.init_process_group('gloo', rank=rank, world_size=world_size)
       ...

Veri kümesi ve veri örnekleyici
----------------------------------------------------------

.. All the processes participating in the training procedure will have copies of the same model. However, each of them will be training using a different set of samples. We establish this distributed sampling using the ``DistributedDataSampler`` object. This object takes a dataset that will be used by multiple processes and establishes a sampling pattern in such a way that every process will receive a different set of samples to train with. After creating the sampler and telling it how many processes are going to be used, and the rank of the current process, we pass the sampler to the data loader which we will use to get the training batches during the training phase.

Eğitim prosedürüne katılan tüm süreçlerde aynı modelin kopyaları olacaktır. Ancak, her biri farklı bir örnek seti kullanarak eğitim işlemini gerçekleştirecektir. Bu dağıtılmış örneklemeyi ``DistributedDataSampler`` nesnesini kullanarak oluşturuyoruz. Bu nesne, birden fazla işlem tarafından kullanılacak bir veri kümesini alır ve her işlemin eğitmek için farklı bir örnek kümesi alacağı şekilde bir örnekleme modeli oluşturur. Sampler'ı oluşturup kaç işlemin kullanılacağını ve mevcut işlemin sırasını söyledikten sonra, eğitim aşamasında eğitim partilerini almak için kullanacağımız sampler'ı data loader'a aktarıyoruz.

.. code-block:: python

   def train_process_on_gpu(gpu_id_in_node, world_size, id_in_group, gpus_per_device):
       ....
       from torch.utils.data.distributed import DistributedSampler
       train_dataset = MNIST(root='../data', train = True, download = True, 
           transform=transforms.ToTensor())
       
       # Örnekleyiciyi oluşturuyoruz ve eğitimde kullanılan toplam süreç sayısı ve mevcut sürecin sıralaması ile birlikte veri kümesini iletiyoruz. Bu iş için bir örnekleme yöntemi oluşturacaktır. 
       data_sampler = DistributedSampler(train_dataset, num_replicas=world_size, rank=rank)
       
       # Verileri, eğitim gruplarını döndürürken kullanması gereken örnekleme şeması hakkında bilgilendirmek için örnekleyicinin yanı sıra DataLoader'a da iletiyoruz. 
       dataloader = DataLoader(train_dataset, batch_size=128, sampler=data_sampler)
       num_features = 28*28
       num_classes = len(train_dataset.classes)
       ....

Dağıtılmış model
------------------------------------

.. We create an identical neural network model on all the processes, but we wrap it with a ``DistributedDataParallel`` object, and we use that object for training. We also inform it of which GPU on the current device it is going to use for training. This wrapped model will synchronize the trainable parameters of the models on all the GPUs participating in training. More specifically, it will synchronize the backward pass, and will guarantee that all copies of the model have the same gradients at the end of a backward pass by averaging all the sets of gradients.

Tüm süreçlerde özdeş bir sinir ağı modeli oluşturuyoruz, ancak bunu bir ``DistributedDataParallel`` nesnesi ile sarıyoruz ve o nesneyi eğitim için kullanıyoruz. Ayrıca mevcut cihazda hangi GPU'nun eğitim için kullanacağını da bildiriyoruz. Bu sarılmış model, eğitime katılan tüm GPU'lardaki modellerin eğitilebilir parametrelerini senkronize edecektir. Daha spesifik olarak, geriye doğru geçişi senkronize edecek ve tüm gradyan kümelerinin ortalamasını alarak, geriye doğru geçişin sonunda modelin tüm kopyalarının aynı gradyanlara sahip olmasını garanti edecektir.

.. code-block:: python

   def train_process_on_gpu(gpu_id_in_node, world_size, id_in_group, gpus_per_device):
       ....
       model = DeepNeuralNetwork(4, num_features, 128, num_classes=num_classes).to(gpu_id_in_node)
       parallel_model = DistributedDataParallel(model, device_ids=[gpu_id_in_node])
       ....

Eğitim döngüsü
=========================

.. The train loop used for distributed training looks identical to the one used for single-node, single-GPU training. We will use the ``DataLoader`` to fetch training samples, we will pass them to the training model, we will calculate a loss, do a backward pass through the model, and update the gradients. All of the communcationa and synchronization is done automatically by the ``DistributedDataParallel`` model. In fact, it only needs to synchronize at the backwards pass through the model. At that point, the gradients from all the participating processes are synchronized and averaged such that all the processes will have the same set of gradients at the end of the backwards pass. 

Dağıtılmış eğitim için kullanılan eğitim döngüsü, tek düğümlü, tek GPU eğitimi için kullanılanla aynı görünüyor. Eğitim örneklerini getirmek için ``DataLoader``\ 'ı kullanacağız, onları eğitim modeline geçireceğiz, bir kayıp hesaplayacağız, modelden geriye doğru bir geçiş yapacağız ve gradyanları güncelleyeceğiz. Tüm iletişim ve senkronizasyon ``DistributedDataParallel`` modeli tarafından otomatik olarak yapılır. Aslında, sadece modelden geriye doğru geçişte senkronize olması gerekiyor. Bu noktada, tüm katılan süreçlerden gelen gradyanlar senkronize edilir ve geriye doğru geçişin sonunda tüm süreçlerin aynı gradyan kümesine sahip olacağı şekilde ortalaması alınır.

.. code-block:: python

   def train_process_on_gpu(gpu_id_in_node, world_size, id_in_group, gpus_per_device):
       ....
       optimizer = torch.optim.Adam(parallel_model.parameters(), lr=0.001)
       criterion = torch.nn.CrossEntropyLoss()
       epochs = 2
       for epoch in range(epochs):
           total_loss = 0
           for data, labels in dataloader:
               data = data.reshape(-1, 28*28)
               data = data.to(gpu_id_in_node) 
               labels = labels.to(gpu_id_in_node)
               optimizer.zero_grad()
               y_score = parallel_model(data)
               loss = criterion(y_score, labels)
               # Geriye geçiş sırasında, tüm işlemler gradyanlarını senkronize edecek ve tüm GPU'lar sonunda aynı gradyanlara sahip olacaktır. 
               loss.backward()
               optimizer.step()
               total_loss+=loss
           print(f"loss at rank {rank} is {total_loss}")

Modeli test etmek
---------------------

.. We only carry out testing on a single node since it is not a time-sensitive operation. It is done in exactly the same way as testing is done in a single-node, single-GPU example. Only difference is that we specify that only the process with rank == 0 executes testing.

Zamana duyarlı bir işlem olmadığı için yalnızca tek bir düğüm üzerinde test yapıyoruz. Tek düğümlü, tek GPU örneğinde yapılan testle tamamen aynı şekilde yapılır. Tek fark, yalnızca rank == 0 olan işlemin testi yürüteceğini belirtmemizdir.

.. code-block:: python

   def train_process_on_gpu(gpu_id_in_node, world_size, id_in_group, gpus_per_device):
       ....
       if rank == 0:
           test_dataset = MNIST(root='../data', train = False, download = True, 
               transform=transforms.ToTensor())
           test_dataloader = DataLoader(test_dataset, batch_size=128)
           n_samples = 0
           n_correct = 0
           for data, labels, in test_dataloader:
               data = data.reshape(-1, 28*28)
               data = data.to(gpu_id_in_node)
               labels = labels.to(gpu_id_in_node)
               y_score = parallel_model(data)
               _, predicted = torch.max(y_score.data, 1)
               n_samples += labels.size(0)
               n_correct += (predicted == labels).sum().item()
           acc = 100.0 * n_correct / n_samples
           print(f'10000 test görüntüsünde ağın doğruluğu : {acc} %')

SLURM komut dosyası
==================================

.. Finally, we will show the SLURM script we used on TRUBA to execute the multi-GPU, multi-node job.

.. In the script, we specify the number of nodes we wish to use, as well as the number of tasks taking part in the training. Each task is going to run a parent process (training script.) In addition, we set two environment variables in the script, ``"MASTER_ADDR"`` which is the IP address of the main process in the communication group, and ``"MASTER_PORT"`` which is the port that the communication group will communicate on. Please make sure that the port is empty before using it. Finally, we run the training script using the nodes we reserved using the ``srun`` command. We use a conda environment that has PyTorch installed.

Son olarak, çoklu GPU, çok düğümlü işi yürütmek için TRUBA'da kullandığımız SLURM betiğini göstereceğiz.

Komut dosyasında, kullanmak istediğimiz düğüm sayısını ve eğitimde yer alan görev sayısını belirtiyoruz. Ayrıca komut dosyası içerisinde iletişim grubundaki ana işlemin IP adresi olan ``"MASTER_ADDR"`` ve ``"MASTER_PORT"`` olmak üzere iki ortam değişkeni belirledik, bunlar iletişim grubunun iletişim kuracağı bağlantı noktasıdır. Lütfen kullanmadan önce bağlantı noktasının boş olduğundan emin olun. Son olarak, ``srun`` komutunu ve ayırdığımız düğümleri kullanarak eğitim komut dosyasını çalıştırıyoruz. Bunun için PyTorch'un kurulu olduğu bir conda ortamı kullanıyoruz.

.. code-block:: bash

   #!/bin/bash
   #SBATCH --account=<account> #your_user_account
   #SBATCH --job-name=pytorch
   #SBATCH --partition=<partition>
   #SBATCH --nodes=2 
   #SBATCH --ntasks=2 # Number of parent processes that will be used
              # Kullanılacak üst işlem sayısı
   #SBACTH --ntasks-per-node=1 # We specify that we want a single parent process to run on each node
                   # Her düğümde tek bir üst sürecin çalışmasını istediğimizi belirtiyoruz.
   #SBATCH --gres=gpu:3 # number of GPUs used in each node
                # her düğümde kullanılan GPU sayısı

   #SBATCH --cpus-per-task=8
   #SBATCH --time=02:00:00 

   # Setup
   module purge 
   module add centos7.3/lib/cuda/10.1

   hostname
   source /truba/home/<account>/anaconda3/bin/activate
   conda init
   # PyTorch'un kurulu olduğu conda ortamının adı 
   conda activate <conda_env>

   export MASTER_PORT=12900 # portun boş olduğundan emin olun
   export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
   # -N ve -n, bu iş adımında kullanılan düğüm sayısını ve görev sayısını belirtir 
   srun -N 2 -n 2 python 01_distributed.p

.. admonition:: Çıktı
      :class: dropdown, information

                After dispatching the SLURM script on the Palamut-cuda partition, we receive the following output:

                Palamut-cuda bölümünde SLURM betiğini gönderdikten sonra aşağıdaki çıktıyı alıyoruz:

                .. code-block:: bash

                   Bu, eğitim için kullanılacak 1 düğümden 2 düğüm numarasıdır. Toplamda, eğitim için kullanılacak toplam 6 GPU vardır. 
                   Bu, eğitim için kullanılacak 0 düğümden 2 düğüm numarasıdır. Toplamda, eğitim için kullanılacak toplam 6 GPU vardır. 
                   bu düğümün sıralaması  5. Bu işlemin bu cihazda kullanacağı GPU numarası 2 
                   loss at rank 5 is 72.71366119384766
                   loss at rank 5 is 22.71541976928711
                   bu düğümün sıralaması  4. Bu işlemin bu cihazda kullanacağı GPU numarası 1 
                   loss at rank 4 is 73.31228637695312
                   loss at rank 4 is 23.012968063354492
                   bu düğümün sıralaması  1. Bu işlemin bu cihazda kullanacağı GPU numarası 1 
                   loss at rank 1 is 72.8398208618164
                   loss at rank 1 is 21.87244415283203
                   bu düğümün sıralaması  3. Bu işlemin bu cihazda kullanacağı GPU numarası 0 
                   loss at rank 3 is 71.55941009521484
                   loss at rank 3 is 21.87774085998535
                   bu düğümün sıralaması  2. Bu işlemin bu cihazda kullanacağı GPU numarası 2 
                   loss at rank 2 is 72.82304382324219
                   loss at rank 2 is 21.772422790527344
                   bu düğümün sıralaması  0. Bu işlemin bu cihazda kullanacağı GPU numarası 0 
                   loss at rank 0 is 73.36946105957031
                   loss at rank 0 is 23.250808715820312
                   10000 test görüntüsünde ağın doğruluğu : 92.79 %

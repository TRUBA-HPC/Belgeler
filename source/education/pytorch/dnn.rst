=========================================
Derin sinir ağları (Deep neural networks) 
=========================================

.. We will create a deep neural network consisting of multiple neural network layers. We will train it to do image classification on the famous MNIST digit dataset. This example shows how PyTorch datasets can be used along with DataLoader objects to process a dataset in mini-batches.

Çoklu sinir ağı katmanlarından oluşan derin bir sinir ağı oluşturacağız. Ünlü MNIST basamak veri setinde görüntü sınıflandırması yapmak için onu eğiteceğiz. Bu örnekte, ek olarak, bir veri kümesini mini partiler halinde işlemek için DataLoader nesneleriyle birlikte PyTorch veri kümelerinin nasıl kullanılabileceğini gösterceğiz.

Cihazı belirtme
===================================

.. We specify the device we wish the training to be carried out on. We will use the GPU if it is available, and if it isn't we will use the CPU. 

Eğitimin yapılmasını istediğimiz cihazı belirtiyoruz. Varsa GPU'yu, yoksa CPU'yu kullanacağız.

.. code-block:: python

   device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

Veri kümesi
=====================

.. We begin by downloading the dataset from the ``torchvision`` package that comes with PyTorch. The dataset is composed of image data, so we convert these images to tensors by passing the ``ToTensor()`` function as a ``transformer`` argument to the constructor of the datasets.

.. In each of these datasets, an element corresponds to a sample. Each sample is a tuple, made up of the features of the sample and its class label. 

PyTorch ile birlikte gelen ``torchvision`` paketinden veri setini indirerek başlıyoruz. Veri kümesi görüntü verilerinden oluşmakta, dolayısıyla bu görüntüleri ``ToTensor()`` işlemine, veri kümelerinin yapıcısına bir ``transformer`` argümanı olarak ileterek, tensörlere dönüştürüyoruz.

Bu veri kümelerinin her birinde, bir öğe bir örneğe karşılık gelir. Her örnek, örneğin özelliklerinden ve sınıf etiketinden oluşan bir gruptur.

.. code-block:: python

   import torch
   from torchvision import datasets
   import torchvision.transforms as transforms

   # verilerin indirileceği sunucudaki konumu 'data_storage' olarak belirtiyoruz. Eğitim veri setini seçiyoruz ve indirilmemişse Torchvision'dan indirmesini istiyoruz. Veri kümesi görüntü verilerinden oluşur, bu nedenle `ToTensor()` dönüşümünü geçirerek onu tensörlere dönüştürürüz.  
   train_dataset = datasets.MNIST(root='data', train = True, download = True, 
       transform=transforms.ToTensor())
   test_dataset = datasets.MNIST(root='data', train = False, download = True, 
       transform=transforms.ToTensor())
   
   # Her özellik bir tensör şeklindedir (1*28*28), bu da 28*28 toplam özelliğe sahip olduğu anlamına gelir. 
   num_features = 28*28
   num_classes = len(train_dataset.classes)

   zeroth_sample = train_dataset[0]
   print(f"Eğitim örneğindeki 0. örnek, {zeroth_sample[0].shape} boyutunda özellik tensörünü içerir ve sınıfı {zeroth_sample[1]}'dir. ")

.. admonition:: Çıktı
   :class: dropdown, information

        .. code-block:: python

            Eğitim örneğindeki 0. örnek, torch.Size([1, 28, 28]) boyutunda özellik tensörünü içerir ve sınıfı 5'dir.

Model Oluşturma
================================

.. We create our deep neural network by making a class that inherits from the ``torch.nn.Module`` class. We add the required neural network layers to the model in the ``__init__`` function, and we add the activation function we will use. We then define the forward propagation process in the ``forward`` function.

.. Our model will contain a variable number of hidden layers. We must store these layers in a ``torch.nn.ModuleList`` object so that they can be updated later using the optimizer object. We also store the non-linear activation function that we will use during forward propagation. 

.. During forward propagation, we apply the ReLU non-linear activation function after all the layers, except the last one. This is because the loss that we will use, cross-entropy loss, will apply the softmax activation.

.. We create the mode and send the model to the GPU.

``Torch.nn.Module`` sınıfından miras alan bir sınıf yaratarak derin sinir ağımızı oluşturuyoruz. ``__init__`` fonksiyonunda modele gerekli sinir ağı katmanlarını ekliyoruz ve kullanacağımız aktivasyon fonksiyonunu ekliyoruz. Daha sonra ileriye doğru yayılma sürecini ``forward`` fonksiyonunda tanımlayacağız.

Modelimiz değişken sayıda gizli katman içerecektir. Bu katmanları bir ``torch.nn.ModuleList`` nesnesinde saklamalıyız, böylece daha sonra optimizer nesnesi kullanılarak güncellenebilirler. Ayrıca ileriye doğru yayılma sırasında kullanacağımız doğrusal olmayan aktivasyon fonksiyonunu da saklıyoruz.

İleri yayılım sırasında, sonuncusu hariç tüm katmanlardan sonra ReLU doğrusal olmayan aktivasyon fonksiyonunu uygularız. Bunun nedeni, kullanacağımız kaybın yani çapraz entropi kaybının softmax aktivasyonunu uygulayacak olmasıdır.

Son olarak, modu oluşturup modeli GPU'ya gönderiyoruz.

.. code-block:: python

   class DeepNeuralNetwork(torch.nn.Module):
       def __init__(self, num_layers, input_features, num_hidden_features, num_classes):
           super(DeepNeuralNetwork, self).__init__()
           # Ağın katmanlarını depolamak için `torch.nn.ModuleList()` türünde bir nesne oluşturuyoruz. Bunu, optimize edicinin sinir ağı katmanlarının parametrelerini güncelleyebilmesi için yapmalıyız. 
           self.hidden_layers = torch.nn.ModuleList()
           # İlk katman, her girdi örneği için input_features özelliklerini alır ve num_hidden_feautrue özelliklerini çıkarır.
           self.hidden_layers.append(torch.nn.Linear(input_features, num_hidden_features))

           for _ in range(num_layers-2):
               self.hidden_layers.append(torch.nn.Linear(num_hidden_features, num_hidden_features))
           
           # Son katman, her örnek için sınıf sayısı kadar çıktı üretir.
           self.hidden_layers.append(torch.nn.Linear(num_hidden_features, num_classes))
           # Katmanlar arasında kullanılacak aktivasyon fonksiyonu olarak ReLU'yu ekliyoruz
           self.relu_activation = torch.nn.ReLU()

       def forward(self, samples):
           # Girdiyi katmanlardan geçiriyoruz ve ardından sonuncusu hariç tüm katmanlar için aktivasyon işlemini uyguluyoruz. 
           for layer in self.hidden_layers[:-1]:
               out = layer(samples)
               out = self.relu_activation(out)
           # son katman için aktivasyonu uygulamıyoruz çünkü kullanacağımız kayıp fonksiyonu softmax aktivasyonunu uyguluyor 
           out = self.hidden_layers[-1](out)
           return out

   num_layers = 4
   num_hidden_features = 128
   model = DeepNeuralNetwork(num_layers, num_features, num_hidden_features, num_classes).to(device)
   print(model)

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        DeepNeuralNetwork(
            (hidden_layers): ModuleList(
            (0): Linear(in_features=784, out_features=128, bias=True)
            (1): Linear(in_features=128, out_features=128, bias=True)
            (2): Linear(in_features=128, out_features=128, bias=True)
            (3): Linear(in_features=128, out_features=10, bias=True)
            )
            (relu_activation): ReLU()
        )

Optimize edici ve kayıp
============================================

.. We define an Adam optimizer for our model and we give it the learning rate and pass to it the model parameters. The optimizer will update these parameters according to its strategy. We also define the loss function as the cross-entropy loss.

Modelimiz için bir Adam optimizer tanımlıyoruz, ona öğrenme oranını ve model parametrelerini iletiyoruz. Optimize edici, bu parametreleri stratejisine göre güncelleyecektir. Kayıp fonksiyonunu ayrıca çapraz entropi kaybı olarak tanımlıyoruz.

.. code-block:: python

   learning_rate = 0.01
   # "model.parameters()", "model" içindeki tüm eğitilebilir parametreleri döndürür. Bizim durumumuzda, bunlar "model"deki doğrusal katmanın parametreleridir.
   optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)  
   loss_function = nn.CrossEntropyLoss()

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Adam (
        Parameter Group 0
            amsgrad: False
            betas: (0.9, 0.999)
            eps: 1e-08
            lr: 0.01
            weight_decay: 0
        )

Veri yükleyiciler (Dataloaders)
================================

.. Since the dataset is large, we will use a ``DataLoader`` object that will handle splitting the data into batches of samples. These mini-batches will be smaller and more manageable than the full dataset by the GPU memory.

.. We pass the datasets to the ``DataLoader`` constructor and specify the batch size (number of samples at each mini-batch.) We also specify that we want to shuffle the samples. 

Veri kümesi büyük olduğundan, verileri numune yığınlarına bölecek bir ``DataLoader`` nesnesi kullanacağız. Bu mini yığınlar, GPU belleğinin tam veri kümesinden daha küçük ve daha yönetilebilir olacaktır.

Veri kümelerini ``DataLoader`` yapıcısına iletiyoruz ve parti boyutunu (her mini partideki numune sayısı) belirliyoruz. Ayrıca numuneleri karıştırmak istediğimizi de belirtiyoruz.

.. code-block:: python

   batch_size = 100
   train_loader = torch.utils.data.DataLoader(dataset=train_dataset, 
                                              batch_size=batch_size, 
                                              shuffle=True)

   test_loader = torch.utils.data.DataLoader(dataset=test_dataset, 
                                             batch_size=batch_size, 
                                             shuffle=False)

Eğitim döngüsü
==============================

.. We create the training loop that will run for a certain number of epochs. Inside the training loop, we make another loop where the ``train_loader`` will supply us all the sample batches inside it in a shuffled order. In other words, at every epoch, we will process all the mini-batches inside ``train_loader``.

Belirli sayıda çağ boyunca çalışacak eğitim döngüsünü oluşturuyoruz. Eğitim döngüsünün içinde, ``train_loader``\ ın içindeki tüm numune gruplarını karışık bir sırayla bize sağlayacağı başka bir döngü yapıyoruz. Başka bir deyişle, her adımda, tüm mini partileri ``train_loader`` içinde işleyeceğiz.

.. code-block:: python

   num_epochs = 2
   for epoch in range(num_epochs):
       # Aşağıdaki döngünün her yinelemesi, train_loader'dan "batch_size" boyutunda bir mini toplu iş alacaktır. Her parti bir dizi tensörden oluşur. Birincisi partinin özellik vektörleri, ikincisi ise partinin etiketleridir.
       # "X_train_batch", toplu işin özellik vektörleridir ve "y_train_batch", toplu işin etiketleridir
       for i, (X_train_batch, y_train_batch) in enumerate(train_loader):  
           
           # X_train_batch, model için uygun şekilde şekillendirilmemiş. Şeklini [batch_size, 1, 28, 28] yerine [batch_size, 748] olarak değiştirmeliyiz
           X_train_batch = X_train_batch.reshape(X_train_batch.shape[0], 28*28)
           # Verileri cihaza gönderiyoruz
           X_train_batch = X_train_batch.to(device)
           y_train_batch = y_train_batch.to(device)

           # Batch'i tanımladığımız `forward` fonksiyonunu çağıracak modele geçiriyoruz ve son katmanın çıktısını döndürüyoruz. 
           outputs = model(X_train_batch)
       
           # Kaybı hesaplamak için modelin çıktısını ve partinin etiketlerini kullanıyoruz. 
           loss = loss_function(outputs, y_train_batch)

           # Modelin tüm eğitilebilir parametrelerine göre kaybın gradyanını hesaplayacak olan kayıp üzerinde 'backward' işlevini çağırarak geri yayılımı gerçekleştiriyoruz. 
           loss.backward()

           # Optimize edici, eğitilebilir parametreleri güncellemek için önceki adımda hesaplanan gradyanları kullanır. 
           optimizer.step()
       
           # Bir sonraki eğitim adımına hazırlanırken tüm parametrelerin gradyanlarını sıfıra ayarlamalıyız. 
           optimizer.zero_grad()
           if i%100 == 0:
               print(f"Epoch {epoch}: batch {i}/{len(train_loader)} with loss {loss}")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Epoch 0: batch 0/600 with loss 2.2971487045288086
        Epoch 0: batch 100/600 with loss 0.4326843023300171
        Epoch 0: batch 200/600 with loss 0.2942448556423187
        Epoch 0: batch 300/600 with loss 0.2156781703233719
        Epoch 0: batch 400/600 with loss 0.227325901389122
        Epoch 0: batch 500/600 with loss 0.12324336916208267
        Epoch 1: batch 0/600 with loss 0.19837243854999542
        Epoch 1: batch 100/600 with loss 0.19496408104896545
        Epoch 1: batch 200/600 with loss 0.15394555032253265
        Epoch 1: batch 300/600 with loss 0.3124085068702698
        Epoch 1: batch 400/600 with loss 0.164706289768219
        Epoch 1: batch 500/600 with loss 0.05262318626046181

Değerlendirme
==========================

Son olarak, modelin doğruluğunu değerlendiririz. Test verilerini mini partiler halinde işlemek için ``test_loader`` kullanıyoruz. Hesaplamalarımızın gradyan hesaplaması için kullanılmasını önlemek için değerlendirme kodunu ``torch.no_grad()`` kod bloğu ile çevreliyoruz. Bu ayrıca, ileriye doğru yayılma sırasında oluşturulan hesaplama grafiğinin kaydedilmesi gerekmediğinden, bellek tüketimimizi de azaltacaktır.

.. code-block:: python

   # Değerlendirme kodu bloğunu bir `torch.no_grad()` çağrısı ile çevreliyoruz, böylece hesaplamalarımız gradyan hesaplaması için kullanılmaz ve bu nedenle bellek açısından daha verimli olur 
   with torch.no_grad():
       n_correct = 0
       n_samples = 0
       for images, labels in test_loader:
           images = images.reshape(images.shape[0], 28*28).to(device)
           labels = labels.to(device)
           outputs = model(images)

           # "predicted" tensörü, her örnek için en yüksek puanların endekslerini içerecektir. Başka bir deyişle, her örneğin tahmin edilen sınıfını içerecektir. 
           _, predicted = torch.max(outputs.data, 1)
           n_samples += labels.size(0)
           n_correct += (predicted == labels).sum().item()

       acc = 100.0 * n_correct / n_samples
       print(f'10000 test örneğinde ağın doğruluğu : {acc} %')

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        10000 test örneğinde ağın doğruluğu : 96.23 %

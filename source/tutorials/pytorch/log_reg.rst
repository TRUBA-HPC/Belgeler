
=====================================================
Logistic regression model - Lojistik regresyon modeli 
=====================================================

In this tutorial, we will create a logistic regression model using PyTorch tensors. The model will perform a multi-label classification task. We will introduce an optimizer, a loss function, a linear neural network layer, and construct the training loop and the testing operation.

You can find the full code at the end of the page.

Bu derste, PyTorch tensörlerini kullanarak bir lojistik regresyon modeli oluşturacağız. Model, çok etiketli bir sınıflandırma görevi gerçekleştirecektir. Bir optimize edici, bir kayıp fonksiyonu, doğrusal bir sinir ağı katmanı tanıtacağız ve eğitim döngüsünü ve test işlemini oluşturacağız.

Kodun tamamını sayfanın sonunda bulabilirsiniz.

Dataset - veri kümesi
=====================

Defining dataset - veri kümesini tanımlama
------------------------------------------

We will use a real-world dataset for training. We get this dataset from the ``sklearn`` library. We then split it into train and test sets, and we normalize the features of the train and test sets.

Note: to install ``sklearn``\ , run the following command:

Eğitim için gerçek dünya veri setini kullanacağız. Bu veri setini ``sklearn`` kütüphanesinden alıyoruz. Daha sonra tren ve test setlerine ayırıyoruz ve tren ve test setlerinin özelliklerini normalleştiriyoruz.

Not: ``sklearn``\ 'i kurmak için aşağıdaki komutu çalıştırın:

.. code-block:: bash

   pip install sklearn

.. code-block:: python

   from sklearn import datasets
   from sklearn.preprocessing import StandardScaler
   from sklearn.model_selection import train_test_split

   breast_cancer_data = datasets.load_breast_cancer()

   # X is a matrix with every row containing the features of a data sample
   # X, her satırı bir veri örneğinin özelliklerini içeren bir matristir 
   # y is an array of integers, with every integer being the class of a sample of thecorresponding row in X
   # y, bir tamsayı dizisidir ve her tamsayı, X'te karşılık gelen satırın bir örneğinin sınıfıdır. 
   X, y = breast_cancer_data.data, breast_cancer_data.target 
   print(f"{X.shape[0]} örnek var.Her örnek {X.shape[1]} özellik içerir.")

   # Split the dataset into a train and test the datasets
   # Veri kümesini bir trene bölün ve veri kümelerini test edin 
   X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.3, random_state=1337)
   print(f"{X_train.shape[0]} eğitim örneği ve {X_test.shape[0]} test örneği var ")
   num_features = X.shape[1] # her örnekteki özellik sayısı # number of features in each sample

   # Standardize features by removing the mean and scaling to unit variance
   # Ortalamayı kaldırarak ve birim varyansına ölçeklendirerek özellikleri standartlaştırın 
   sc = StandardScaler()
   X_train = sc.fit_transform(X_train)

   # Use the same standardization on the test set
   # Test setinde aynı standardizasyonu kullanın 
   X_test = sc.transform(X_test)

Output

.. code-block:: python

   569 örnek var.Her örnek 30 özellik içerir.
   398 eğitim örneği ve 171 test örneği var

Converting to Tensors and moving to GPU
---------------------------------------

The datasets are currently of type ``numpy.ndarray``. We will convert them to Torch tensors so that we can use them with our PyTorch model. We will then send them to the GPU so that we can run our model on the GPU. Notice that we change the shape of the labels sets from a rank-1 tensor (array of elements) to a rank-2 tensor (an array of arrays, each of length 1.) This is useful when we are calculating the loss later.

Veri kümeleri şu anda ``numpy.ndarray`` türündedir. PyTorch modelimiz ile kullanabilmemiz için onları Torch tensörlerine dönüştüreceğiz. Daha sonra modelimizi GPU üzerinde çalıştırabilmemiz için onları GPU'ya göndereceğiz. Etiket kümelerinin şeklini rank-1 tensörden (eleman dizisi) rank-2 tensöre (her biri 1 uzunluğunda bir dizi dizisi) değiştirdiğimize dikkat edin. Bu, daha sonra kaybı hesaplarken kullanışlıdır.

.. code-block:: python

   import torch
   # Select the GPU to work on
   # üzerinde çalışmak için GPU'yu seçin Select the GPU
   gpu_device = torch.device("cuda:0")

   # Convert it to a tensor, then move the tensor to the GPU convert it to the type torch.float32
   # Bir tensöre dönüştürün, ardından tensörü GPU'ya taşıyın ve bunu bir tür fener 
   # olarak torch.float32 
   X_train = torch.from_numpy(X_train)
   X_train = X_train.to(gpu_device, dtype=torch.float32)

   # Do both operations in one line
   # Her iki işlemi de tek satırda yapın 
   X_test = torch.from_numpy(X_test).to(gpu_device, dtype=torch.float32)

   y_train = torch.from_numpy(y_train).to(gpu_device, dtype=torch.float32)

   # We change the shape of the label dataset from an array of elements to an array of arrays of length 1. This is useful later when calculating the loss.
   # Etiket kümesinin şeklini bir eleman dizisinden 1 uzunluğunda bir dizi dizisine değiştiriyoruz. Bu, daha sonra kaybı hesaplarken kullanışlıdır. 
   print(f"Şekil değiştirmeden önce etiketlerin şekli {y_train.shape}")
   y_train = y_train.reshape(y_train.shape[0], 1)
   print(f"Şekil değiştirmeden sonra etiketlerin şekli {y_train.shape}")
   # Do all previous operations in one line
   # Önceki tüm işlemleri tek satırda yapın 
   y_test = torch.from_numpy(y_test).to(gpu_device, dtype=torch.float32).reshape(y_test.shape[0],1)

Output:

.. code-block:: python

   Şekil değiştirmeden önce etiketlerin şekli torch.Size([398])
   Şekil değiştirmeden sonra etiketlerin şekli torch.Size([398, 1])

Creating Model - Model Oluşturma
================================

We can create machine learning models using PyTorch by creating a class that inherits from the ``torch.nn.Module`` class. Inside this class, we specify all the inner layers in our model (CNN, FFNN, etc.), and the process of forward propagation through the model. PyTorch will handle backpropagation automatically.

The first function we need to define is the ``__init__`` function, in which we will set the inner layers of the model. We only need a single layer for a logistic regression model: the ``torch.nn.Linear`` layer. It takes the input vector ``x`` and produces ``y = xA^T + B`` where ``A`` and ``B`` are the trainable parameters of the layer. 

After defining the class, we create an instance of our model and send it to the GPU.

``Torch.nn.Module`` sınıfından miras alan bir sınıf oluşturarak PyTorch kullanarak makine öğrenme modelleri oluşturabiliriz. Bu sınıf içerisinde, modelimizin tüm iç katmanlarını (CNN, FFNN vb.) ve model üzerinden ileriye doğru yayılma sürecini belirtiyoruz. PyTorch geri yayılımı otomatik olarak gerçekleştirir.

Tanımlamamız gereken ilk fonksiyon, modelin iç katmanlarını ayarlayacağımız ``__init__`` fonksiyonudur. Lojistik regresyon modeli için yalnızca tek bir katmana ihtiyacımız var: ``torch.nn.Linear`` katmanı. ``x`` girdi vektörünü alır ve ``y = xA^T + B`` üretir; burada ``A`` ve ``B`` katmanın eğitilebilir parametreleridir.

Sınıfı tanımladıktan sonra modelimizin bir örneğini oluşturup GPU'ya gönderiyoruz.

.. code-block:: python

   class LogisticRegression(torch.nn.Module):
       def __init__(self, num_features):
           super(LogisticRegression, self).__init__()
       # Add the linear layer as a member of our model. 
       # Lineer katmanı modelimizin bir üyesi olarak ekleyin.
       # When a batch of samples (matrix, where each row is a sample) is passed to the model, there should be num_features features in each row. It will generate a single output value for each row in the input.
           # Modele bir grup numune (her satırın bir numune olduğu matris) iletildiğinde, her satırda num_features özellikleri olmalıdır. Girdideki her satır için tek bir çıktı değeri üretecektir. 
           self.linear_layer = torch.nn.Linear(num_features, 1)

       # When a batch of samples is passed through the model, this function will be called
       # Modelden bir grup numune geçirildiğinde, bu fonksiyon çağrılacaktır.
       def forward(self, samples):
       # Forward propagation starts with passing the sample matrix through the linear layer. Each row in `samples` has num_features values, and the output will contain 1 value in each row.
           # İleri yayılma, numune matrisinin doğrusal katmandan geçirilmesiyle başlar. "örnekler"deki her satırın num_features değerleri vardır ve çıktı her satırda 1 değer içerecektir.
           output = self.linear_layer(samples)
           # We apply the sigmoid function on every element in `output`
       # 'output' içindeki her öğeye sigmoid işlevini uygularız
           y_score = torch.sigmoid(output)
           return y_score

   model = LogisticRegression(num_features).to(gpu_device)
   print(model)

Output

.. code-block:: python

   LogisticRegression(
     (linear_layer): Linear(in_features=30, out_features=1, bias=True)
   )

Defining the optimizer - Optimize ediciyi tanımlama
===================================================

After we create the model, we create the optimizer object and the loss function we will use for training. The optimizer is going to handle updating the model. There are many strategies for optimization like Stochastic Gradient Descent (SGD) and  Adamic Adar. We will use SGD for our example. We tell the optimizer the learning rate we want and we pass it the parameters of the model that we wish to update.

We also define the loss function. This function will take the scores that the model gives every input sample and calculate the loss of the system compared to the real labels. Also, we will use it to calculate the gradients of the system.

Modeli oluşturduktan sonra optimizer nesnesini ve eğitim için kullanacağımız kayıp fonksiyonunu oluşturuyoruz. Optimize edici, modelin güncellenmesiyle ilgilenecektir. Optimizasyon için Stokastik Gradyan İniş (SGD) ve Adamic Adar gibi birçok strateji vardır. Örneğimiz için SGD kullanacağız. Optimize ediciye istediğimiz öğrenme oranını söylüyoruz ve güncellemek istediğimiz modelin parametrelerini ona iletiyoruz.

Kayıp fonksiyonunu da tanımlıyoruz. Bu fonksiyon, modelin her girdi örneğine verdiği puanları alacak ve gerçek etiketlere kıyasla sistemin kaybını hesaplayacaktır. Ayrıca, sistemin gradyanlarını hesaplamak için kullanacağız.

.. code-block:: python

   learning_rate = 0.01
   # `model.parameters()` returns all the trainable paramters in `model`. In our case, these are the parameters of the linear layer in `model`
   # "model.parameters()", "model" içindeki tüm eğitilebilir parametreleri döndürür. Bizim durumumuzda, bunlar "model"deki doğrusal katmanın parametreleridir. 
   optimizer = torch.optim.SGD(model.parameters(), lr=learning_rate)
   loss_function = torch.nn.BCELoss()

   print(optimizer)

Output:

.. code-block:: python

   SGD (
   Parameter Group 0
       dampening: 0
       lr: 0.01
       momentum: 0
       nesterov: False
       weight_decay: 0
   )

Training loop and evaluation step - Eğitim döngüsü ve değerlendirme adımı
=========================================================================

We define the training loop to carry out the training of the model. It will run for a certain number of steps (epochs) and in each step, it will carry out a forward propagation through the system, calculate the loss of the system, use the loss to calculate the gradients of the trainable parameters, and update the trainable parameters using the optimizer.

Also, every 25 epochs, we will evaluate the model using the testing set.

Modelin eğitimini gerçekleştirmek için eğitim döngüsünü tanımlarız. Belirli sayıda adım (dönem) için çalışacak ve her adımda sistem üzerinden ileriye doğru bir yayılım gerçekleştirecek, sistem kaybını hesaplayacak, kaybı, eğitilebilir parametrelerin gradyanlarını hesaplamak için kullanacak ve optimize edici kullanılarak eğitilebilir parametreler.

Ayrıca her 25 çağda bir test setini kullanarak modeli değerlendireceğiz.

.. code-block:: python

   epochs = 50
   for epoch in range(epochs+1):
       # 
       # Pass the entire training set through the forward propagation of the model.
       # Tüm eğitim setini modelin ileri yayılımından geçirin. 
       y_score = model(X_train)
       # We calculate the loss
       # Kaybı hesaplıyoruz 
       loss = loss_function(y_score, y_train)
       # This call will calculate the gradient of loss with respect to each trainable parameter in our model.
       # Bu çağrı, modelimizdeki her eğitilebilir parametreye göre kaybın gradyanını hesaplayacaktır. 
       loss.backward()

       # The optimizer will use the gradients calculated in the previous line to update the trainable parameters according to its strategy (in this case, SGD)
       # Optimize edici, eğitilebilir parametreleri stratejisine göre güncellemek için önceki satırda hesaplanan gradyanları kullanacaktır (bu durumda, SGD) 
       optimizer.step()

       # This step will remove the gradients calculated in this step to prepare for the next training step.
       # Bu adım, bir sonraki eğitim adımına hazırlanmak için bu adımda hesaplanan gradyanları 
       # kaldıracaktır. 
       optimizer.zero_grad()
       # Evaluation step
       # Değerlendirme adımı 
       if epoch % 25 == 0:
           # The call to "torch.no_grad()" tells PyTorch not to include calculations in this code block in the gradient calculation
           # "torch.no_grad()" çağrısı, PyTorch'a bu kod bloğundaki hesaplamaları degrade hesaplamasına dahil etmemesini söyler. 
           with torch.no_grad():
               y_score = model(X_test)
               # if y_score[i] > 0.5, then y_pred[i] = 1. else y_pred[i] = 0
               y_pred = y_score.round()
               num_correct = y_pred.eq(y_test).sum()
               accuracy = num_correct/y_test.shape[0]
               print(f"Epoch {epoch}: loss {loss} model accuracy = {accuracy.item()}")

Output:

.. code-block:: python

   Epoch 0: loss 0.6590105891227722 model accuracy = 0.6198830604553223
   Epoch 25: loss 0.41418391466140747 model accuracy = 0.8771929740905762
   Epoch 50: loss 0.32267412543296814 model accuracy = 0.9298245906829834

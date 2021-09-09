
===========================================================================================================
PyTorch Geometric (PyG) ile çizgesel sinir ağları
===========================================================================================================

.. Neural networks were designed for structured data like text, images, and audio files. However, there is a big range of unstructured data that classic neural networks can't process. For such data, we can use PyTorch Geometric. It is a framework that allows running graph neural networks, which can process unstructured data like graphs and meshes.

Sinir ağları, metin, resim ve ses dosyaları gibi yapılandırılmış veriler için tasarlanmıştır. Ancak, klasik sinir ağlarının işleyemeyeceği çok sayıda düzensiz yapıda veri vardır. Bu tür veriler için PyTorch Geometric'i kullanabiliriz. PyTorch Geometric çizgeler ve örgüler gibi yapılandırılmamış verileri işleyebilen çizgesel sinir ağlarının çalıştırılması için geliştirilmiş bir kütüphanedir.

Kurulum
======================

.. Note: PyTorch must be installed before you can install PyTorch Geometric. You can refer to the guide on installing PyTorch for instructions on how to install PyTorch. To install PyTorch Geometric, please follow these steps:

Not: PyTorch Geometric'i kurabilmeniz için önce PyTorch yüklenmelidir. PyTorch'un nasıl kurulacağına ilişkin talimatlar için PyTorch'u yükleme kılavuzuna başvurabilirsiniz. PyTorch Geometric'i yüklemek için lütfen şu adımları izleyin:


#. 
   Şu anda yüklü olan PyTorch sürümünü kontrol edin ve bir ortam değişkeninde saklayın. Bunu yapmak için aşağıdaki komutu çağırmanız yeterlidir:

   .. code-block:: bash

       export TORCH=$(python -c "import torch; print(torch.__version__)")

#. 
   Şu anda yüklü olan ``cudatoolkit`` sürümünü kontrol edin ve bunu bir ortam değişkeninde saklayın.


   #. 
      İlk önce kurduğunuz CUDA sürümünü kontrol edin:

      .. code-block:: python

          python -c "import torch; print(torch.version.cuda)"
          >> 11.1

   #. 
      Yukarıda gösterilen sürüme bağlı olarak aşağıdaki ortam değişkenini ayarlayın

      .. code-block:: python

          export CUDA=cu111 # for cuda 11.1

       Bu öğreticinin yazıldığı sırada cuda sürümü için olası değerler cpu (eğer cudatoolkit kurulu değilse), cu92, cu101, cu102, cu110 veya cu111 şeklindedir.

#. 
   Gerekli kütüphaneleri aşağıdaki çağrılarla kurun:

   .. code-block:: bash

       pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
       pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
       pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
       pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
       pip install torch-geometric

Veri - çizge veri yapısı
===========================================================

PyG tanımları, çizge veri kümelerini tanımlamak için ``torch_geometric.data.Data`` sınıfını kullanır. Bu türdeki her nesne bir çizgeyi temsil eder. Bir ``Data`` nesnesi birçok veri üyesi içerebilir. İşte içerebileceği bazı önemli veri üyeleri:

.. ``edge_index``\ : Graph connectivity information Torch tensor in the COO format. It's of the dimension [2, number_of_edges]. Each column represents an edge.

*  ``edge_index``\ : COO formatında çige bağlantı bilgisini tutan Torch tensörü. Bu, [2, number_of_edges] boyutunda olacak. Her sütun bir bağlantıyı temsil eder. 

.. ``x``\ : the feature vectors of all the nodes in the graph. It's a tensor of shape [num_nodes, num_node_features]

*  ``x``\ : çizgedeki tüm düğümlerin özellik vektörleri. [num_nodes, num_node_features] şeklinde bir tensör

.. ``edge_attr``\ : Edge feature matrix with shape [num_edges, num_edge_features]

*  ``edge_attr``\ : [num_edges, num_edge_features] şeklinde bağlantı özelliklerinin saklandığı matris

.. ``y``\ : labels to train against (may have arbitrary shape), e.g., node-level targets of shape [num_nodes, \*] or graph-level targets of shape [1, \* ] 

*  ``y``\ : eğitmek için etiketler (isteğe bağlı şekle sahip olabilir), ör. düğüm düzeyindeki şekil [num_nodes, \*] hedefleri veya şekili [1, \* ] olacak şekilde çizge düzeyindeki hedefler

.. The above attributes are not all required to create a ``Data`` object. In addition, we can extend the object with our own attributes if needed, e.g., edge weights.

.. In the following example, we define an undirected graph with four nodes and three edges. We also add feature vectors for all the nodes in the graph:

Yukarıdaki niteliklerin tümü bir ``Data`` nesnesi oluşturmak için gerekli değildir. Ek olarak, gerekirse nesneyi, örneğin bağlantı ağırlıkları gibi kendi yarattığımız özelliklerimizle genişletebiliriz.

Aşağıdaki örnekte, dört düğümü ve üç bağlantısı olan yönsüz bir çizge tanımlıyoruz. Ayrıca çizgedeki tüm düğümler için özellik vektörleri ekliyoruz:

.. code-block:: python

   import torch
   from torch_geometric import Data

   edge_index = torch.tensor([[1, 2, 0, 1, 2, 0],
                  [2, 1, 1, 0, 0, 0]])
   graph = Data(edge_index = edge_index)
   print(f"Çizge: {graph}")

   graph.x = torch.randn((4,5))
   print(f"Düğüm özellikleri ekledikten sonraki çizge: {graph}")
   print(f"çizgenin {graph.num_nodes} düğümü ve {graph.num_edges} bağlantısı vardır")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Çizge: Data(edge_index=[2, 6])
        Düğüm özellikleri ekledikten sonraki çizge: Data(edge_index=[2, 6], x=[4, 5])
        çizgenin 4 düğümü ve 6 bağlantısı vardır

.. Data objects have many useful utility functions. Here are some examples:

Veri objelerinin birçok faydalı yardımcı fonksiyonu vardır:

.. code-block:: python

   print(f"`Data` nesnesinde hangi verilerin olduğunu kontrol edin: {data.keys}")

   print(f"düğüm özelliği vektörleri\n {data['x']}")

   print(f"edge_attr verilerde mi? {'edge_attr' in data}")

   print(f"düğüm özellikleri sayısı {data.num_node_features}")

   print(f"Çizge izole düğümler içeriyor mu? {data.contains_isolated_nodes()}")

   print(f"Çizge kendi kendine döngüler içeriyor mu? {data.contains_self_loops()}")

   print(f"Çizge yönlendirilmiş mi? {data.is_directed()}")

.. admonition:: Çıktı
   :class: dropdown, information
   
    .. code-block:: 

        `Data` nesnesinde hangi verilerin olduğunu kontrol edin: ['x', 'edge_index']
        tensor([[ 1.7464,  0.0523, -0.1089,  0.3255, -0.3031],
        [-0.8393,  2.7257,  0.7538,  0.0997, -0.3187],
        [-0.6025, -0.8008, -0.3081,  1.0320, -0.2903],
        [ 2.2594,  0.0473, -0.7182,  0.1754, -0.8136]])
        edge_attr verilerde mi? False
        düğüm özellikleri sayısı 5
        Çizge izole düğümler içeriyor mu? True
        Çizge kendi kendine döngüler içeriyor mu? True
        Çizge yönlü mü? True

Mevcut GNN katmanlarını kullanarak bir model oluşturma
===================================================================================================

.. PyG comes with an extensive collection of existing GNN layers. We can use these layers to construct our own models. In the following example, we create a neural network model using some famous GNNs to carry out the task of node classification - classifying nodes (vertices) in the graph. Our model will take a graph, along with a feature vector for every node, and will classify these nodes into one of 7 possible classes. 

PyG, mevcut GNN katmanlarının kapsamlı bir koleksiyonuyla birlikte gelir. Bu katmanları kendi modellerimizi oluşturmak için kullanabiliriz. Aşağıdaki örnekte, düğüm sınıflandırma - çizgedeki düğümleri (köşeler) sınıflandırma görevini yerine getirmek için bazı bilinen GNN'leri kullanarak bir sinir ağı modeli oluşturuyoruz. Modelimiz, her düğüm için bir özellik vektörü ile birlikte bir çizge alacak ve bu düğümleri 7 olası sınıftan birine sınıflandıracaktır.

Veri kümesi
---------------------

.. We will use one of the datasets that PyG provides. We use the famous Cora dataset used for evaluating classification tasks. 

.. When loading this dataset, we specify the location we wish to download the dataset to in the ``root`` parameter. In this case, we also need to specify the name of the dataset we want in the ``name`` parameter. Not all datasets require this parameter. You can check the requirements of each dataset in the `documentation <https://pytorch-geometric.readthedocs.io/en/latest/notes/introduction.html>`_ of PyG.

.. The object ``dataset`` contains a list of all the graphs inside the dataset. In our case, the ``Cora`` dataset contains a single graph.

PyG'nin sağladığı veri kümelerinden birini kullanacağız. Sınıflandırma görevlerini değerlendirmek için bu tür eğitimlerde sıklıkla kullanılan Cora veri setini kullanıyoruz.

Bu veri kümesini yüklerken, ``root`` parametresinde veri kümesini indirmek istediğimiz konumu belirtiyoruz. Bu durumda da ``name`` parametresinde istediğimiz veri setinin adını belirtmemiz gerekiyor. Tüm veri kümeleri bu parametreyi gerektirmez. Veri kümelerinin gereksinimlerini PyG'nin `belgelerinde <https://pytorch-geometric.readthedocs.io/en/latest/notes/introduction.html>`_ kontrol edebilirsiniz.

``dataset`` nesnesi, veri kümesi içindeki tüm çizgelerin bir listesini içerir. Bizim durumumuzda, ``Cora`` veri seti tek bir çizge içerir.

.. code-block:: python

   from torch_geometric.data import DataLoader
   from torch_geometric.datasets import Planetoid

   dataset = Planetoid(root='data', name='Cora') # dataset bir çizge listesi içerir 

   print(f"dataset'de {len(dataset)} çizge var") 

   print(dataset[0])
   cora = dataset[0]

   num_node_features =  cora.num_features
   # Çizgedeki düğüm sınıflarının sayısı 
   num_classes = cora.y.max().item()+1

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        dataset'de 1 çizge var
        Data(edge_index=[2, 10556], test_mask=[2708], train_mask=[2708], val_mask=[2708], x=[2708, 1433], y=[2708])
        Düğümlerin özellik vektörleri 1433 özelliğe sahiptir. Düğümler için toplam 7 sınıf var

Model oluşturma
--------------------------------

.. We now create a neural network model that includes both, graph neural network layers, and a regular neural network layer. This model will be a class that inherits from the class ``torch.nn.Module`` and will work in exactly the same way as a normal neural network,i.e., it will take features of nodes (which are represented by the tensor ``x`` inside the graph), and will make classifications using these feature. The only difference between our model and a normal neural network model is that we will add graph neural network layers to it. These layers will use the connectivity information of the graph as well as the feature vectors of nodes while training.

.. In the ``__init__`` function, we add two GNN layers and one linear layer, as well as two activation functions. The GNN layers are going to take the features of the nodes, as well as the graph connectivity information, while, the linear layer will only take the feature vectors of the nodes. In other words, the linear layer will process the feature vectors without any information about the graph structure.

.. We pass the forward function a ``Data`` object, and we extract from it the node features (\ ``data.x``\ ) and the edge information of the graph (\ ``data.edge_index``\ ). It's important to note that when we pass the node features to the GNN layers, we also pass the edge information. This is because these layers use the edge information during their processing.

.. After passing the graph through the GNNs, we pass the node features through a linear layer. Notice that we don't pass the connectivity information of the graph. Finally, we use a log-softmax activation and return the results, which will be a row of 7 elements for each node.

Şimdi hem çizge sinir ağı katmanlarını hem de normal bir sinir ağı katmanını içeren bir sinir ağı modeli oluşturuyoruz. Bu model, ``torch.nn.Module`` sınıfından miras alan bir sınıf olacak ve normal bir sinir ağı ile tamamen aynı şekilde çalışacak, yani, düğümlerin (\ ``x`` tensörü ile temsil edilen) özelliklerini alacak ve bu özellikleri kullanarak sınıflandırmalar yapacaktır. Bizim modelimiz ile normal bir sinir ağı modeli arasındaki tek fark, bizim modelimize çizge sinir ağı katmanları ekleyeceğiz. Bu katmanlar, eğitim sırasında düğümlerin özellik vektörlerinin yanı sıra çizgenin bağlantı bilgilerini de kullanacak.

``__init__`` fonksiyonunda iki GNN katmanı ve bir lineer katmanın yanı sıra iki aktivasyon fonksiyonu ekliyoruz. GNN katmanları, çizge bağlantı bilgilerinin yanı sıra düğümlerin özelliklerini alırken, doğrusal katman yalnızca düğümlerin özellik vektörlerini alacaktır. Başka bir deyişle, doğrusal katman, özellik vektörlerini çizge yapısı hakkında herhangi bir bilgi kullanmadan işleyecektir.

İleri fonksiyonuna bir ``Data`` nesnesi iletiriz ve ondan düğüm özelliklerini (\ ``data.x``\ ) ve çizgenin bağlantı bilgilerini (\ ``data.edge_index``\ ) çıkarırız. Unutulmamalıdır ki düğüm özelliklerini GNN katmanlarına geçirdiğimizde bağlantı bilgisini de iletmiş oluyoruz. Bunun nedeni, bu katmanların işlemleri sırasında bağlantı bilgilerini kullanmasıdır.

Grafiği GNN'lerden geçirdikten sonra, düğüm özelliklerini doğrusal bir katmandan geçiriyoruz. Grafiğin bağlantı bilgilerini geçmediğimize dikkat edin. Son olarak, bir log-softmax aktivasyonu kullanarak her düğüm için 7 elemanlık bir satır olacak olan sonuçları döndürüyoruz.

.. code-block:: python

   import torch_geometric.nn as pyg_nn
   import torch.nn as nn

   class GNN(nn.Module):
       def __init__(self, in_features, num_hidden_feats, num_classes):
           super(GNN, self).__init__()
           # ModuleList, sinir ağı katmanlarının bir listesini tutar 
           self.gnn_layers = nn.ModuleList()
           # Bu "Graph Convolutional Network" katmanı, in_feature uzunluğundaki özellik vektörlerini alacak ve her düğüm için num_hidden_feats uzunluğunda özellik vektörleri üretecektir.
           self.gnn_layers.append(pyg_nn.GCNConv(in_features, num_hidden_feats))
           # Bu "Çizge Dikkat Ağı" katmanı, hidden_layer_features uzunluğundaki özellikleri alacak ve her düğüm için hidden_layer_features uzunluğunda vektörler üretecektir.
           self.gnn_layers.append(pyg_nn.GATConv(num_hidden_feats, num_hidden_feats))
           # Bu, sıradan bir doğrusal sinir ağı katmanıdır. 
           self.lin = nn.Linear(num_hidden_feats, num_classes)
           self.relu = nn.ReLU()

       # Bir çizge yapısı içeren `Data` nesnesini ileri işlevine ileteceğiz. 
       def forward(self, data):
           # Düğüm özelliklerini ve bağlantı bilgisi tensörlerini "data" nesnesinden çıkarıyoruz 
           node_features, edge_index = data.x, data.edge_index
           # Özellik vektörlerini ve bağlantı bilgilerini GNN katmanına aktarıyoruz. GNN katmanı, işlem sırasında bağlantı bilgilerini kullanacaktır. 
           out_node_features = self.gnn_layers[0](node_features, edge_index)
           # GNN katmanı, güncellenmiş düğüm özelliği vektörlerini döndürür 
           out_node_features = self.relu(out_node_features)
           out_node_features = self.gnn_layers[1](out_node_features, edge_index)
           out_node_features = self.relu(out_node_features)
           # Düğüm özellik vektörlerini doğrusal katmana geçiriyoruz. `self.lin` bir GNN katmanı olmadığı için bağlantı bilgisini iletmemize gerek olmadığına dikkat edin. 
           out_node_features = self.lin(out_node_features)
           return out_node_features

   num_hidden_feats = 128

   device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

   model = GNN(num_node_features, num_hidden_feats, num_classes).to(device)
   print(model)

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        (gnn_layers): ModuleList(
            (0): GCNConv(1433, 128)
            (1): GATConv(128, 128, heads=1)
            )
            (lin): Linear(in_features=128, out_features=7, bias=True)
            (relu): ReLU()
        )

Optimize edici ve kayıp
--------------------------------------------

.. We use an Adam optimizer and a negative log-likelihood loss function. The optimizer will handle updating the parameters according to the Adam strategy, and the loss function will be used to calculate the loss and the gradients of the trainable parameters in the model.

Bir Adam optimize edici ve bir negatif log-olasılık kaybı fonksiyonu kullanıyoruz. Optimize edici, parametreleri Adam stratejisine göre güncellemeyi yönetecek ve kayıp fonksiyonu, modeldeki eğitilebilir parametrelerin kayıplarını ve gradyanlarını hesaplamak için kullanılacaktır.

.. code-block:: python

   optimizer = torch.optim.Adam(model.parameters(), lr = 0.01)
   loss_function = nn.functional.nll_loss

Eğitim döngüsü
-------------------------

.. The train loop looks exactly like the train loop of a normal neural network built with PyTorch. In each training step, we pass the dataset through the model and it will return a score vector for each node. Then, we calculate the loss of these scores and use the loss to calculate the gradients of the model parameters. Finally, we use the optimizer to update the parameters of the model using the calculated gradients.

.. While training, we would like to use a part of our data for training, and another part for testing. In other words, we only wish to use the classes of some of the nodes for training while keeping the classes of the remaining nodes hidden. However, we need to pass the entire graph to the model since the entire graph is required to calculate the outputs of the training samples. We get the training portion of the data using the ``train_mask`` property in the Cora graph. It should be noted that not all the graphs provided by PyG have training masks.c

Eğitim döngüsü, PyTorch ile oluşturulmuş normal bir sinir ağının eğitim döngüsüne tam olarak benziyor. Her eğitim adımında, veri kümesini modelden geçiririz ve model her düğüm için bir puan vektörü döndürür. Ardından, bu puanların kaybını hesaplıyoruz ve kaybı, model parametrelerinin gradyanlarını hesaplamak için kullanıyoruz. Son olarak, hesaplanan gradyanları kullanarak modelin parametrelerini güncellemek için optimize ediciyi kullanıyoruz.

Eğitim sırasında, verilerimizin bir kısmını eğitim için, bir kısmını da test için kullanmak istiyoruz. Diğer bir deyişle, kalan düğümlerin sınıflarını gizli tutarken sadece bazı düğümlerin sınıflarını eğitim için kullanmak istiyoruz. Ancak eğitim örneklerinin çıktılarını hesaplamak için çizgenin tamamı gerektiğinden, çizgenin tamamını modele aktarmamız gerekiyor. Cora çizgesindeki ``train_mask`` özelliğini kullanarak verinin eğitim kısmını alıyoruz. PyG tarafından sağlanan tüm çizgelerin eğitim maskelerine sahip olmadığına dikkat edilmelidir.

.. code-block:: python

   epochs = 100
   for epoch in range(epochs):
       # `Data` nesnesini modele geçiriyoruz. Model, güncelleme işleminden sonra düğümlerin özellik vektörlerini döndürür. 
       y_score = model(cora)
       # Kaybı hesaplamak için eğitim kümesindeki düğümlerin yalnızca özellik vektörlerini seçmek için `train_mask` kullanıyoruz.
       y_score_train = y_score[cora.train_mask]
       # Ayrıca, yalnızca eğitim kümesindeki düğümlerin etiketlerini seçmek için `train_mask` kullanırız. 
       y_train = cora.y[cora.train_mask]
       # Kaybı hesaplıyoruz, model parametrelerine göre kaybın gradyanlarını hesaplıyoruz ve bunları güncellemek için optimize ediciyi kullanıyoruz. 
       loss = loss_function(y_score_train, y_train)
       loss.backward()
       optimizer.step()
       optimizer.zero_grad()
       if epoch % 20 == 0:
           print(f"Epoch {epoch}: loss {loss}")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Epoch 0: loss 1.9444819688796997
        Epoch 20: loss 0.0636444166302681
        Epoch 40: loss 0.007010670844465494
        Epoch 60: loss 0.00019191707542631775
        Epoch 80: loss 3.740669853868894e-05

Test döngüsü
---------------------------

.. We testing procedure of learning on graphs is similar to the one using structured datasets. We will pass the testing data through the model, make predictions, and count the number of correct predictions. To get the testing data, we use the ``test_mask`` property that is supplied with the Cora dataset.

Çizgeler üzerinde öğrenme prosedürünü test ediyoruz, bu düzenli veri kümelerini kullanmaya benzer. Test verilerini modelden geçireceğiz, tahminler yapacağız ve doğru tahminlerin sayısını sayacağız. Test verilerini elde etmek için Cora veri seti ile sağlanan ``test_mask`` özelliğini kullanıyoruz.

.. code-block:: python

   with torch.no_grad():
       y_score = model(cora)[cora.test_mask]
       prediction = y_score.argmax(dim=1)
       score =  prediction.eq(cora.y[cora.test_mask]).sum().item()
       print(f"Final accuracy = {100*score/cora.test_mask.sum()}")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Final accuracy = 71.8000%

GNN katmanı oluşturma - mesaj geçiş arayüzü (message passing interface)
==================================================================================================

Teori
--------------

.. In the previous example, we constructed a machine learning model that can process graphs and carry out node classification. However, we used already existing graph neural network layers. In the following example, we will create our own GNN layer and use it in a model that will do graph classification. 

.. Generalizing convolutions to unstructured data (e.g., graphs) is often referred to as *message passing.* The message passing schema can be expressed as follows, given that :math:`\mathbf{x} *i^{k}` is the feature vector of node :math:`i` at layer :math:`k`, and :math:`\mathbf{e}_{i,j}` is an optional feature vector associated with the edge :math:`(i,j)`:

Önceki örnekte, çizgeleri işleyebilen ve düğüm sınıflandırmasını gerçekleştirebilen bir makine öğrenimi modeli oluşturduk. Ancak, zaten var olan çizge sinir ağı katmanlarını kullandık. Aşağıdaki örnekte kendi GNN katmanımızı oluşturacağız ve bunu çizge sınıflandırması yapacak bir modelde kullanacağız.

Konvolüsyonları düzensiz verilere (örneğin çizgeler) genelleştirmeye *mesaj geçişi (message passing) denir.* Mesaj geçiş şeması, :math:`\mathbf{x} *i^{k}` ifadesinin i düğümünün k katmanındaki özellik vektörü olduğu göz önüne alındığında aşağıdaki gibi ifade edilebilir. :math:`\mathbf{e}_{i,j}`, :math:`(i,j)` bağlantıyla ilişkili isteğe bağlı bir özellik vektörüdür.

.. math::

    \mathbf{x}_i^{(k)} = \gamma^{(k)} \left( \mathbf{x}\ *i^{(k-1)}, \square*\ {j \in \mathcal{N}(i)} \, \phi^{(k)}\left(\mathbf{x}_i^{(k-1)}, \mathbf{x}\ *j^{(k-1)},\mathbf{e}*\ {j,i}\right) \right)

.. Where :math:`\square` is a permutation invariable function (order of operands does not matter) called the *aggregation* function like the summation, max, or mean functions, and :math:`\gamma` and :masth:`\phi` are differentiable functions (such as linear neural network layers.)

:math:`\square` permütasyon değişmez bir fonksiyon olduğunda (işlenenlerin sırası önemli değildir), toplam, maksimum veya ortalama gibi fonksiyonlar *toplaşma* fonksiyonu olarak adlandırılır. :math:`\gamma` ve  :math:`\phi` türevlenebilir fonksiyonlardır. (örneğin doğrusal sinir ağı katmanları.)

.. In other words, to calculate the feature vector of a node :math:`i` after message passing layer :math:`k`, we do the following steps:
Başka bir deyişle, :math:`k` katmanından mesaj geçtikten sonra bir :math:`i` düğümünün özellik vektörünü hesaplamak için aşağıdaki adımları yaparız:

.. #. For every incoming neighbor :math:`j` of node :math:`i`, we apply the function :math:`\phi` to generate a "message" from these neighbors. The function :math:`\phi` uses the feature vectors of :math:`i`, :math:`j`, and optionally the feature vector of the edge :math:`(i,j)`.
.. #. We aggregate all the messages coming to node :math:`i` using the function :math:`\square` into a single vector. The function :math:`\square` can be a summation over all messages, mean of all messages, or the max message. This will generate a single representation of all the messages to node :math:`i`.
.. #. Finally, we apply the transformation :math:`\gamma` to the aggregated representation of the messages and the embedding of the node itself. The final output would be the new feature vector of the node.

#. :math:`i` düğümünün gelen her :math:`j` komşusu için bir "mesaj" üretirken :math:`\phi` fonksiyonunu uygularız. :math:`\phi` fonksiyonu, :math:`i, j`'nin özellik vektörlerini ve isteğe bağlı olarak :math:`(i,j)` bağlantısının özellik vektörünü kullanır.
#. :math:`\square` fonksiyonunu kullanarak :math:`i` düğümüne gelen tüm mesajları tek bir vektörde topluyoruz. :math:`\square` fonksiyonu, tüm mesajların toplamı, tüm mesajların ortalaması veya maksimum mesaj olabilir. Bu, :math:`i` düğümüne gönderilen tüm mesajların tek bir temsilini oluşturacaktır.
#. Son olarak, :math:`\gamma` dönüşümünü mesajların toplu gösterimi ve düğümün kendisinin gömülmesi için uygularız. Nihai çıktı, düğümün yeni özellik vektörü olacaktır.

.. The ``torch_geometric.nn.MessagePassing`` is an interface that allows classes that inherit it to implement the procedure described above with ease. The following functions provide this functionality:
``Torch_geometric.nn.MessagePassing``\ , kendisini miras alan sınıfların yukarıda açıklanan prosedürü kolaylıkla uygulamasına izin veren bir arayüzdür. Aşağıdaki fonksiyonlar bu özelliği sağlar:


.. ``MessagePassing(aggr="add", flow="source_to_target", node_dim=-2)``\ : The ``aggr`` parameter defines the aggregation schema(:math:`\square`) (\ ``"add"``\ , ``"sum"``\ , or ``"max"``\ ), and ``flow`` describes the flow of messages - whether they are from an edge's source to target or vice versa. 
*  ``MessagePassing(aggr="add", flow="source_to_target", node_dim=-2)``\ : ``aggr`` parametresi, toplaşma şemasını(:math:`\square`) (\ ``"add"``\ , ``"sum"`` veya ``"max"``\ ) tanımlar ve ``flow``\ , mesaj akışının bir uç kaynağın kaynağından hedefe mi yoksa tam tersi mi olduğunu belirler.
.. ``MessagePassing.propagate(edge_index, **kwargs)``: this function will carry out the message passing procedure. It takes the edge connectivity information (``edge_index``), as well as any other data  (e.g. node feature vectors ``x``, edge feature vectors ``edge_attr``, etc.) that is needed for constructing messages and updating embeddings, and returns a matrix containing a vector for each node in the input graph. ``propogate()`` will call the following three functions:
*  ``MessagePassing.propagate(edge_index, **kwargs)``: bu fonksiyon mesaj geçirme prosedürünü gerçekleştirecektir. İletileri oluşturmak ve yerleştirmeleri güncellemek için gerekli olan uç bağlantı bilgilerini (``edge_index``) ve diğer tüm verileri (ör. düğüm özellik vektörleri ``x``, bağlantı özellik vektörleri ``edge_attr``, vb.) alır ve her biri için bir vektör içeren bir matris döndürür. ``propogate()`` aşağıdaki üç işlevi çağırır:

  #. ``MessagePassing.message(...)`` : Bu fonksiyon, yukarıdaki formüldeki :math:`\phi` fonksiyonunu temsil eder. ``propagate()`` fonksiyonuna iletilen tüm parametreleri alır ve isteğe bağlı olarak, grafiğin bağlantılarının kaynağına ve hedefine eşlenen özellik vektörlerinden de geçirelebilir. Detaylandırmak gerekirse, ``propagate()`` fonksiyonuna köşe özellikleri, çizgedeki her düğüm için bir satır, içeren bir matristen geçilmişse, örnek olarak ``node_feats => tensor([num_nodes, num_feats])`` matrisi,  ve ``message()`` fonksiyonuna yapılan çağrı ``node_feats_i`` parametresini içeriyorsa, o zaman ``node_feats_i``, ``[sayı_edgeleri, sayı_feats]`` boyutunda bir matris olur ve ``node_feats_i[a]`` ve ``node_feats[edge_index[1][a]`` eşdeğer olur. Başka bir deyişle, bu a bağlantısının hedef düğümüne ait ``node_feats`` satırıdır. Öte yandan, yapılan çağrıya, bir ``node_feats_j`` parametresi iletilirse, o zaman ``node_feats`` matrisinin eşlemelerini içerecek, ancak bağlantıların kaynaklarına dayalı olacaktır. Programcı, mesajları oluşturmak için ``propagate()`` fonksiyonuna iletilen diğer parametrelerin yanı sıra bu fonksiyonları kullanabilir. Bu fonksiyon, her bağlantı için bir satır içeren bir matris, msj, döndürmelidir, burada ``msgs[a]`` satırı, bağlantı a'nın hedef düğümüne gönderilen bir mesaj, yani ``edge_index[1][a]`` düğümüne gönderilen bir mesaj olacaktır. 
  #. ``MessagePassing.aggregate(msgs, ...)``: bu fonksiyon, ``message()`` fonksiyonu tarafından döndürülen tüm mesajları alacak ve yukarıdaki formüldeki :math:`\square` fonksiyonunu uygulayacaktır. Yani, mesajları her köşe için tek bir vektörde toplar (toplar, maksimumlarını bulur veya ortalamalarını bulur) ve düğüm başına bir son vektör içeren matrisi döndürür.
  #. ``MessagePassing.update(aggr_out, ...)``\ : Bu fonksiyon, ``propagate()`` öğesine iletilen tüm parametrelerin yanı sıra her bir köşe için ileti toplaşmasının sonucunu içeren ``propagate()`` öğesinin döndürdüğü matrisi alır ve yukarıdaki formülasyondaki :math:`\gamma` dönüşümü ve yayılma sürecinin son çıktısını döndürür.

..  #. ``MessagePassing.message(...)``: This function represents the :math:`\phi` function in the formulation above. It will take as parameters all the parameters that are passed to ``propagate()``, and optionally, it can also be passed *feature vectors mapped to the source and destination of the edges of the graph.* To elaborate, if the ``propagate()`` function was passed a matrix containing feature vertices, say a matrix ``node_feats: tensor([num_nodes, num_feats])\``, with a row for each node in the graph, and the call to the ``message()`` function contained a parameter ``node_feats_i``, then ``node_feats_i`` would be a matrix of size ``[num_edges, num_feats]`` with ``node_feats_i[a]`` being ``node_feats[edge_index[1][a]`` , i.e., the row of ``node_feats`` pertaining to the target node of edge ``a`` . On the other hand, if it is passed a parameter ``node_feats_j``, then it will contain mappings of the ``node_feats`` matrix but based on the sources of edges. The programmer can use these functions, as well as any other parameters passed to the ``propagate()`` function to generate messages. This function must return a matrix ``msgs`` with a row for each edge, where row ``msgs[a]`` will be a message sent to the target node of edge ``a`` , i.e., a message sent to node ``edge_index[1][a]`` (and vice versa for the opposite flow.) 

..  #. ``MessagePassing.aggregate(msgs, ...)``: this function will take all the messages returned by the ``message()`` function, and apply the :math:`\square` function in the formulation above. i.e., it will aggregate them (sum them up, find their max, or find their mean) into a single vector for each vertex and return the matrix containing one final vector per node. 

..  #. ``MessagePassing.update(aggr_out, ...)``\ : This function will take the matrix that ``aggregate()`` returns that contains the result of message aggregation for each vertex, as well as any parameters that were passed to ``propagate()``\ , and apply the :math:`\gamma` transformation in the formulation above and return the final output of the propagation process.

.. The following figure demonstrates an example of a call to the ``propagate()`` function that takes as parameters the connectivity information of the graph (\ ``edge_index``\ ) as well as a matrix containing feature vectors for each node (\ ``node_features``\ ).

Aşağıdaki şekil, parametre olarak grafiğin bağlantı bilgilerini (\ ``edge_index``\ ) ve ayrıca her düğüm için özellik vektörlerini içeren bir matrisi (\ ``node_features``\ ) alan ``propagate()`` fonksiyonuna yapılan bir çağrıyı gösterir.


.. image:: /assets/pytorch-education/mp.png
   :target: /assets/pytorch-education/mp.png
   :alt: /assets/pytorch-education/mp.png


Dataset - veri kümesi
---------------------

.. We will use a dataset with multiple graphs, and will carry out graph classification. 

Çoklu çizgelere sahip bir veri seti kullanacağız ve çizge sınıflandırması yapacağız.

.. code-block:: python

   from torch_geometric.datasets import TUDataset

   dataset = TUDataset(root='data', name='ENZYMES')

   print(f"Bu veri kümesinde {len(dataset)} çizge var ")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Bu veri kümesinde 600 çizge var

Veri yükleyiciler (Dataloaders)
--------------------------------

.. Since this dataset is large, we will use the DataLoader mechanism provided by PyG. It behaves similarly to the PyTorch DataLoader class, but it is specifically modified for the ``torch_geometric.data.Dataset`` class, and handles partitioning datasets with multiple graphs. We will create a data loader for the training data, and one for the testing data. The ``batch_size`` parameter determines how many samples per batch to load.

Bu veri seti büyük olduğu için PyG tarafından sağlanan DataLoader mekanizmasını kullanacağız. PyTorch DataLoader sınıfına benzer şekilde davranır, ancak özellikle ``torch_geometric.data.Dataset`` sınıfı için modifiye edilmiştir ve veri kümelerini çoklu çizgelere bölümlemeyi işler. Eğitim verileri için bir veri yükleyici ve test verileri için bir tane oluşturacağız. ``batch_size`` parametresi, parti başına kaç numunenin yükleneceğini belirler.

.. code-block:: python

   from torch_geometric.data import DataLoader

   # Train_loader eğitmek için çizgelerin %80'ini kullanacak ve test_loader kalan %20'yi test için kullanacak 
   # batch_size, puanları hesaplarken sınıfları kullanılacak düğüm sayısını belirler 
   train_loader = DataLoader(dataset[:int(data_size * 0.8)], batch_size=64, shuffle=True)
   test_loader = DataLoader(dataset[int(data_size * 0.8):], batch_size=64, shuffle=True)

   train_iter = iter(train_loader)
   batch = train_iter.next()
   print(batch)
   print(f"Toplu iş {batch.x.shape[0]} düğümü içermesine rağmen, yalnızca {batch.y.shape[0]} etiketi vardır (çizge sayısı).")

.. code-block:: python

   Batch(batch=[2083], edge_index=[2, 7694], ptr=[65], x=[2083, 3], y=[64])
   Toplu iş 2083 düğümü içermesine rağmen, yalnızca 64 etiketi vardır (çizge sayısı).

GNN katmanı tanımlama
--------------------------------------------

.. We now define a GNN layer that is mathematically equivalent to the `GCN layer <https://arxiv.org/abs/1609.02907>`_ we used in the previous example. We will use the message passing interface to define the layer.

.. In the constructor, we specify that we want the aggregation to be "add", and that messages should flow from the source of an edge to its target. We also add a single linear layer. 

.. In the forward function, we pass the node features through the linear layer, then we call the ``propagate()`` function with the transformed node features (\ ``node_feats: tensor([num_nodes, in_channels])``\ ) and the connectivity information. The propagate function will first call the ``message()`` function, and because the message function has the parameter ``node_feats_j``\ , the ``node_feats`` matrix will be mapped onto the sources of all the edges in the graph to produce ``node_feats_j``. This means that ``node_feats_j[a] == node_feats[edge_index[0][a]]`` .

.. For each element ``node_feats_j[a]`` corresponding to the ``a``\ th edge between nodes ``i`` and ``j``\ , the ``message()`` function will return ``node_feats_j[a] * 1/( sqrt(degree(i)) * sqrt(degree(j))))``. 

.. Afterwards, the ``aggregate()`` function will be called automatically, and it will do ``add`` aggregation on the matrix that ``message()`` returns. Finally, the ``update()`` function will be called, and it will be passed the tensor that the ``aggregate()`` function returns. The tensor that ``update()`` returns will be returned by the ``propagate()`` function.

Şimdi, önceki örnekte kullandığımız `GCN katmanına <https://arxiv.org/abs/1609.02907>`_ matematiksel olarak eşdeğer bir GNN katmanı tanımlıyoruz. Katmanı tanımlamak için mesaj geçiş arayüzünü kullanacağız.

Yapıcıda, toplaşma fonksiyonunun "toplam" olarak istediğimizi ve mesajların bir bağlantının kaynağından hedefine akması gerektiğini belirtiriz. Ayrıca tek bir doğrusal katman ekliyoruz.

İleri fonksiyonunda , düğüm özelliklerini doğrusal katmandan geçiririz, sonra dönüştürülmüş düğüm özellikleri (\ ``node_feats: tensor([num_nodes, in_channels])``\ ) ve bağlantı bilgileri ile ``propagate()`` fonksiyonunu çağırırız. Yayma fonksiyonu önce ``message()`` fonksiyonunu çağırır ve mesaj fonksiyonu ``node_feats_j`` parametresine sahip olduğundan, ``node_feats`` matrisi, ``node_feats_j`` üretmek için çizgedeki tüm bağlantıların kaynaklarıyla eşleştirilir. Bu, ``node_feats_j[a] == node_feats[edge_index[0][a]]`` anlamına gelir.

``i`` ve ``j`` düğümleri arasındaki ``a`` bağlantısına karşılık gelen her ``node_feats_j[a]`` öğesi için, ``message()`` fonksiyonu ``node_feats_j[a] * 1/( sqrt(degree(i) değerini döndürür. )) * sqrt(derece(j))))`` olarak ifade edilir.

Daha sonra, ``aggregate()`` fonksiyonu otomatik olarak çağrılır ve ``message()`` döndürdüğü matris üzerinde toplaşma işlemi olarak ``add`` yapar. Son olarak, ``update()`` fonksiyonu çağrılacak ve ``aggregate()`` fonksiyonunun döndürdüğü tensörden geçirilecektir. ``update()`` döndürdüğü tensör, ``propagate()`` fonksiyonu tarafından döndürülecektir.

.. code-block:: python

   import torch_geometric.utils as pyg_utils
   class GCN(pyg_nn.MessagePassing):
       def __init__(self, in_channels, out_channels):
           
            # Bu katmanın toplaşma fonksiyonu olarak toplama kullanacağını ve mesajların bir bağlantnın kaynağından ucun hedefine gideceğini belirtiyoruz. 
           super(GCN, self).__init__(aggr='add', flow='source_to_target')  
           # Katmanda kullanacağımız doğrusal bir sinir ağı ekliyoruz. 
           self.lin = nn.Linear(in_channels, out_channels)

       def forward(self, x, edge_index):
           # Katmanımızdan bir girdi geçtiğinde "forward" fonksiyonunu çağrılır. "x" düğüm özelliklerini ve "edge_index" bağlantı bilgilerini alacağız 

           # bitişiklik matrisine kendi kendine döngüler ekleyin.
           edge_index, _ = pyg_utils.add_self_loops(edge_index)

           # Düğüm özelliği matrisini dönüştür 
           node_feats = self.lin(x)

           # Yayılma çağrısı mesaj geçişini yürütecek 
           # Önce 'message()' çağrılır, ardından 'aggregate()', ardından 'update()' ve 'update()' çıktılanır
           # 'propagate()' öğesine iletilen tüm parametreler, çağırdığı diğer üç fonksiyonlara iletilecektir. 
           return self.propagate(edge_index, node_feats=node_feats)

       def message(self, node_feats_j, edge_index, size):
           # Fonksiyon argümanlarına `node_feats_j` parametresini eklediğimizde, `node_feats`in çizgenin tüm bağlantılarının kaynakları üzerindeki eşlemesi hesaplanacak ve `node_feats_j` içine yerleştirilecektir.
           # node_feats_j şekili =>[num_edges, out_channels]
           row, col = edge_index

           # GCN belgesine göre normları hesaplayın 
           deg = pyg_utils.degree(row, size[0], dtype=node_feats_j.dtype)
           deg_inv_sqrt = deg.pow(-0.5)
           norm = deg_inv_sqrt[row] * deg_inv_sqrt[col]
           # Döndürülen matris, çizgedeki her bağlantı için bir mesaj içerir. 
           return norm.view(node_feats_j.shape[0], 1)*node_feats_j

       def update(self, aggr_out):
           # "message()" fonksiyonu tarafından döndürülen matristeki mesajlar toplanır ve her düğüm için tek bir kümelenmiş vektör oluşturmak üzere "aggr_out" içine yerleştirilir. 
           # aggr_out şekili => [N, out_channels]
           return aggr_out

Model oluşturma
--------------------------------

.. We will use the GNN layer we built in a complete model. We will use a similar model to the one we used in the previous example, but we will add an additional pooling function that will pool all the feature vectors of nodes in a graph into a single feature vector. This is because we wish to use this model for graph classification.

.. In the pooling function, we use the member ``batch`` inside the ``data`` object. This member is only added when we a DataLoader is used to get samples. The ``batch`` tensor contains the graph ID of every node in the ``data`` object. 

Oluşturduğumuz GNN katmanını eksiksiz bir modelde kullanacağız. Önceki örnekte kullandığımıza benzer bir model kullanacağız, ancak bir çizgideki düğümlerin tüm özellik vektörlerini tek bir özellik vektöründe toplayacak ek bir havuz fonksiyonu ekleyeceğiz. Bunun nedeni, bu modeli çizge sınıflandırması için kullanmak istememizdir.

Havuzlama fonksiyonunda
, ``data`` nesnesinin içindeki ``batch`` üyesini kullanırız. Bu üye yalnızca, örnekleri almak için bir DataLoader kullandığımızda eklenir. ``batch`` tensörü, ``data`` nesnesindeki her düğümün çizge kimliğini içerir.

.. code-block:: python

   import torch
   class GNN(nn.Module):
       def __init__(self, in_features, num_hidden_feats, num_classes):
           super(GNN, self).__init__()
           self.gnn_layers = nn.ModuleList()
           self.gnn_layers.append(GCN(in_features, num_hidden_feats))

           self.gnn_layers.append(pyg_nn.GATConv(num_hidden_feats, num_hidden_feats))
           self.lin = nn.Linear(num_hidden_feats, num_classes)
           self.relu = nn.ReLU()
           self.log_softmax = nn.LogSoftmax(dim=1)

       def forward(self, data):
           # Bağlantı bilgilerine ('edge_index') ve düğüm özelliklerine ('x') ek olarak, 'batch' tensörünü de çıkarıyoruz. Bu tensör, partideki her düğümü ait olduğu çizgeye eşler. 
           node_features, edge_index, batch = data.x, data.edge_index, data.batch
           # Bu katmanı, GCNConv katmanını kullandığımız şekilde kullanıyoruz. 
           out_node_features = self.gnn_layers[0](node_features, edge_index)
           out_node_features = self.relu(out_node_features)
           out_node_features = self.gnn_layers[1](out_node_features, edge_index)
           out_node_features = self.relu(out_node_features)
           # Bu bir çizge sınıflandırma problemi olduğundan, havuzlama fonksiyonunu kullanarak her bir çizgeye ait düğümlerin tüm özellik vektörlerini tek bir vektörde toplayacağız. Havuzlama fonksiyonu, her düğümün çizge kimliklerini içeren "batch" tensörünü kullanır. 
           out_graph_features = pyg_nn.global_mean_pool(out_node_features, batch)
           out_graph_features = self.lin(out_graph_features)
           return self.log_softmax(out_graph_features)

   num_hidden_feats = 128
   num_node_features = dataset.num_node_features
   num_classes = dataset.num_classes

   device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

   model = GNN(num_node_features, num_hidden_feats, num_classes).to(device)
   print(model)

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        GNN(
            (gnn_layers): ModuleList(
            (0): GCN(
                (lin): Linear(in_features=3, out_features=128, bias=True)
            )
            (1): GATConv(128, 128, heads=1)
            )
            (lin): Linear(in_features=128, out_features=2, bias=True)
            (relu): ReLU()
            (log_softmax): LogSoftmax(dim=1)
        )

Eğitim döngüsü
=========================

.. The train loop we will use is similar to the one we used in the last example, with a few key differences. First, in each training epoch, we will iterate through multiple batches and train on those batches. We will use the ``train_loader`` to do this iteration. Second, we don't need to use a mask to select training data. This is because the ``train_loader`` contains only training data.

Kullanacağımız eğitim döngüsü, birkaç temel fark dışında son örnekte kullandığımıza benzer. İlk olarak, her eğitim döneminde, birden fazla grup arasında yineleme yapacağız ve bu gruplar üzerinde eğiteceğiz. Bu yinelemeyi yapmak için ``train_loader``\ ı kullanacağız. İkincisi, eğitim verilerini seçmek için maske kullanmamıza gerek yok. Bunun nedeni, ``train_loader``\ ın yalnızca eğitim verilerini içermesidir.

.. code-block:: python

   epochs = 10
   for epoch in range(epochs):
       epoch_loss = 0
       for batch_num, batch in enumerate(train_loader):
           y_score = model(batch)
           loss = loss_function(y_score, batch.y)
           loss.backward()
           optimizer.step()
           optimizer.zero_grad()
           epoch_loss+=loss
       if epoch % 2 == 0:
           print(f"Loss {epoch_loss}")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Loss 8.446746826171875
        Loss 7.77716588973999
        Loss 7.491060733795166
        Loss 7.148349285125732
        Loss 7.039545059204102

Test etmek
---------------------

.. Similarly, for testing, we are going to use the ``test_loader`` to fetch the testing data, and we will pass batches from the ``test_loader`` into the model and use them for prediction.

Benzer bir şekilde, test için, test verilerini yüklemek için ``test_loader``\ ı kullanacağız ve ``test_loader``\ dan partileri modele geçirecek ve bunları tahmin için kullanacağız.

.. code-block:: python

   with torch.no_grad():
       num_correct = 0
       total_samples = 0
       for batch in test_loader:
           y_score = model(batch)
           y_pred = y_score.argmax(dim=1)
           num_correct += y_pred.eq(batch.y).sum().item()
           total_samples +=len(batch.batch.unique())
       print(f"Accuracy {num_correct/total_samples*100}")

.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: python

        Accuracy 31.838565022421523

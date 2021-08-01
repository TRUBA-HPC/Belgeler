
==========================================================
PyTorch C++ Frontend Interface - PyTorch C++ Ön Uç Arayüzü
==========================================================

PyTorch provides a C++ interface that allows developing deep learning models directly on C++. All of the essential functionality of PyTorch is available, including tensors, autograd, neural network modules, optimizers, and data loaders. The programming interface is very similar to that of Python and converting a model from Python to C++ is very easy. The PyTorch C++ frontend is referred to as ``LibTorch`` and we will use this name in the remainder of this document.

PyTorch, doğrudan C++ üzerinde derin öğrenme modelleri geliştirmeye olanak tanıyan bir C++ arabirimi sağlar. Tensörler, otomatik geçiş, sinir ağı modülleri, optimize ediciler ve veri yükleyiciler dahil olmak üzere PyTorch'un tüm temel işlevleri mevcuttur. Programlama arayüzü Python'a çok benzer ve bir modeli Python'dan C++'a dönüştürmek çok kolaydır. PyTorch C++ ön ucu ``LibTorch`` olarak anılır ve bu adı bu belgenin geri kalanında kullanacağız.

Installation and Compilation -  Kurulum ve Derleme
==================================================

Important: on TRUBA, this tutorial works only if PyTorch was installed using pip. It does not work when PyTorch is installed using ``conda``.

We will show the steps taken to compile a ``LibTorch`` program. These steps can be followed to compile more complex programs. 

Önemli: TRUBA'da bu öğretici yalnızca PyTorch pip kullanılarak yüklendiyse çalışır. PyTorch ``conda`` kullanılarak kurulduğunda çalışmaz.

Bir ``LibTorch`` programını derlemek için atılan adımları göstereceğiz. Daha karmaşık programları derlemek için bu adımlar izlenebilir.

Installing cuDNN
----------------


#. Download cuDNN Linux (x64) version from the official Nvidia website `https://developer.nvidia.com/cudnn <https://developer.nvidia.com/cudnn>`_

   Resmi Nvidia web sitesinden cuDNN Linux (x64) sürümünü indirin
#. 
   After moving the downloaded file to TRUBA, extract it:

   İndirilen dosyayı TRUBA'ya taşıdıktan sonra çıkartın:

   .. code-block:: python

       tar -xvf cudnn-10.2-linux-x64-v8.2.2.26.tgz

#. 
   This will create the folder ``cuda``\ , we will refer to the path of the ``cuda`` folder as ``<cudnn_root>``

   Bu, ``cuda`` klasörünü oluşturacak, ``cuda`` klasörünün yolunu ``<cudnn_root>`` olarak belirteceğiz.

Creating the project directory - Proje dizini oluşturma
-------------------------------------------------------


#. 
   Create a folder for your project

   Projeniz için bir klasör oluşturun

   .. code-block:: python

       mkdir libt_project
       cd libt_project

#. 
   Let's create a simple C++ program to compile:

   Derlemek için basit bir C++ programı oluşturalım:

   .. code-block:: bash

       vim libt_project.cpp

#. 
   In the file ``libt_project.cpp``\ , let's create a simple ``LibTorch`` program. This program will create a rank-2 tensor of dimensions 2x2 and fill it with random values:

   ``libt_project.cpp`` dosyasında basit bir ``LibTorch`` programı oluşturalım. Bu program, 2x2 boyutlarında bir rank-2 tensörü oluşturacak ve onu rastgele değerlerle dolduracaktır:

   .. code-block:: bash

       #include <torch/torch.h>
       #include <iostream>

       int main() {
         torch::Tensor tensor = torch::rand({2, 3});
         std::cout << tensor << std::endl;
       }

Compilation - Derleme
---------------------


#. 
   For compilation, we will use ``CMake``. To do so, we create a ``CMakeLists.txt`` file. It is not necessary to use ``CMake`` to build ``LibTorch`` programs but that's the recommended build system by the developers.

   Derleme için ``CMake`` kullanacağız. Bunu yapmak için bir ``CMakeLists.txt`` dosyası oluşturuyoruz. ``LibTorch`` programları oluşturmak için ``CMake`` kullanmak gerekli değildir, ancak geliştiriciler tarafından önerilen derleme sistemi budur.

   .. code-block:: bash

       cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
       project(libt_project)

       find_package(Torch REQUIRED)
       set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS}")

       add_executable(libt_project libt_project.cpp)

#. 
   We will create a build directory, navigate to it, and start the making procedure. We will use whatever PyTorch version is already installed in our environment. Note: on TRUBA, this only works with a PyTorch that is installed using ``pip``\ :

   Bir derleme dizini oluşturacağız, ona gideceğiz ve yapım prosedürüne başlayacağız. Ortamımızda halihazırda kurulu olan PyTorch sürümünü kullanacağız. Not: TRUBA'da bu yalnızca ``pip`` kullanılarak kurulan bir PyTorch ile çalışır:

   .. code-block:: bash

       mkdir build
       cd build
       cmake -DCMAKE_PREFIX_PATH=`python -c 'import torch;print(torch.utils.cmake_prefix_path)'` ..

#. 
   The build process does not complete successfully. We open the file ``CMakeCache.txt`` and edit the ``CUDNN_ROOT`` variable and set it to the location of the ``cuda`` folder we got when we extracted ``CUDNN`` in the ``cuDNN`` installation step:

   Oluşturma işlemi başarıyla tamamlanmıyor. ``CMakeCache.txt`` dosyasını açıp ``CUDNN_ROOT`` değişkenini düzenleyerek ``cuDNN`` kurulum adımında ``CUDNN``\ 'yi ayıkladığımızda aldığımız cuda klasörünün konumuna ayarlıyoruz:

   .. code-block:: bash

       vim CMakeCache.txt
       ...
       //Folder containing NVIDIA cuDNN
       CUDNN_ROOT:PATH=<cudnn_root>

#. 
   Finally, we create the make files and compile the program.

   Son olarak make dosyalarını oluşturuyoruz ve programı derliyoruz.

   .. code-block:: bash

       cmake -DCMAKE_PREFIX_PATH=`python -c 'import torch;print(torch.utils.cmake_prefix_path)'` ..
       cmake --build . --config Release

#. 
   The executable will be in our current directory with the name ``libt_project``. We execute it to see the results:

   Yürütülebilir dosya mevcut dizinimizde libt_project adıyla olacaktır. Sonuçları görmek için çalıştırıyoruz:

   .. code-block:: bash

       ./libt_project

    Output:

   .. code-block:: bash

       0.9432  0.2726  0.5261
       0.4113  0.0114  0.8928
       [ CPUFloatType{2,3} ]

Future compilation - Gelecek derleme
------------------------------------

After following these steps, the next time we want to compile our program, we only need to use a single command: 

Bu adımları izledikten sonra bir dahaki sefere programımızı derlemek istediğimizde sadece tek bir komut kullanmamız yeterli:

.. code-block:: bash

   cmake --build . --config Release

Building the deep neural network module - Derin sinir ağı modülünü oluşturma
============================================================================

We will create a deep neural network that will preform multi-class classification on the ``MNIST`` image dataset. This network will be comprised of two linear layers. We create modules in ``LibTorch`` by creating a C++ struct that inherits from the ``torch::nn::Module`` class. There are two methods of declaring modules in ``LibTorch``. The first uses *value semantics* and it is not fully supported by ``LibTorch``\ while the second, which uses *reference semantics* (shared pointers) is fully supported by ``LibTorch``. For more information on the exact difference between the two, please check the following `link <https://pytorch.org/tutorials/advanced/cpp_frontend.html#module-ownership>`_. In this tutorial, we will use the reference semantics method.

``MNIST`` görüntü veri setinde çok sınıflı sınıflandırmayı önceden oluşturacak derin bir sinir ağı oluşturacağız. Bu ağ iki lineer katmandan oluşacaktır. ``torch::nn::Module`` sınıfından miras alan bir C++ yapısı oluşturarak ``LibTorch``\ 'ta modüller oluşturuyoruz. ``LibTorch``\ 'ta modül bildirmenin iki yöntemi vardır. İlki değer semantiğini kullanır ve ``LibTorch`` tarafından tam olarak desteklenmezken, referans semantiğini (paylaşılan işaretçiler) kullanan ikincisi ``LibTorch`` tarafından tam olarak desteklenir. İkisi arasındaki kesin fark hakkında daha fazla bilgi için lütfen aşağıdaki bağlantıyı kontrol edin. Bu derste referans anlambilim yöntemini kullanacağız.

Module declaration
------------------

When declaring a neural network module, we create a struct that inherits from ``torch::nn::Module`` and we must give it a name of the format ``MODULE_NAMEImpl``. In addition, we follow the class declaration with the macro ``TORCH_MODULE(MODULE_NAME)``. This will create a new class, ``MODULE_NAME``\ , which is a wrapper around a ``shared_ptr`` of our ``MODULE_NAMEImpl`` class. This means that anytime we create an instance of ``MODULE_NAME``\ , we will use it like we'd use pointers, and use ``->`` instead of ``.`` when calling its functions. The following is the declaration of the deep neural network we will use for this example:

Bir sinir ağı modülü bildirirken, ``torch::nn::Module``\ 'den miras alan bir yapı oluşturuyoruz ve buna ``MODULE_NAMEImpl`` biçiminde bir ad vermeliyiz. Ayrıca sınıf bildirimini ``TORCH_MODULE(MODULE_NAME)`` makrosu ile takip ediyoruz. Bu, ``MODULE_NAMEImpl`` sınıfımızın bir paylaşılan_ptr'sinin etrafındaki sarmalayıcı olan ``MODULE_NAME`` adlı yeni bir sınıf oluşturacaktır. Bu, bir ``MODULE_NAME`` örneği oluşturduğumuzda, onu işaretçiler kullanır gibi kullanacağımız ve yerine ``->`` kullanacağımız anlamına gelir. işlevlerini çağırırken. Bu örnek için kullanacağımız derin sinir ağının bildirimi aşağıdadır:

.. code-block:: cpp

   struct DNNImpl : torch::nn::Module{
   };
   TORCH_MODULE(DNN);

   ...

   int main(){
     DNN model();
     model->forward(); // we use the model as a shared_ptr - modeli bir paylaşılan_ptr olarak kullanıyoruz
   }

Module content - Modül içeriği
------------------------------

Each module must have inside it: 


#. D\ **ata members:** the parameters of the module, as well as its and inner layers such as linear layers and convolutional layers.
#. **Constructor:** the function where the module and its parameters and layers are initialized.
#. **Forward function:** this function will carry out the forward propagation of the module.


Her modülün içinde şunlar olmalıdır:


#. **Veri üyeleri**\ : modülün parametrelerinin yanı sıra doğrusal katmanlar ve evrişim katmanları gibi onun ve iç katmanları.
#. **Yapıcı**\ : modülün ve parametrelerinin ve katmanlarının başlatıldığı işlev.
#. **İleri işlevi**\ : bu işlev, modülün ileriye doğru yayılmasını gerçekleştirecektir.

Data members - Veri üyeleri
^^^^^^^^^^^^^^^^^^^^^^^^^^^

For our example, we add to our module two fully connected linear layers.

Örneğimiz için modülümüze tam bağlantılı iki lineer katman ekliyoruz.

.. code-block:: cpp

   struct DNNImpl : torch::nn::Module{
     // linear1 and linear2 are the two layers that will be in our neural network
     // linear1 ve linear2, sinir ağımızda olacak iki katmandır
     torch::nn::Linear linear1, linear2; 
     ...
   };

Constructor - yapıcı
^^^^^^^^^^^^^^^^^^^^

In our constructor, we will initialize our linear layers with the appropriate input and output sizes, and we will register them. This will allow optimizers to see these parameters when carrying out optimization steps. 

Yapıcımızda, lineer katmanlarımızı uygun giriş ve çıkış boyutlarıyla başlatacağız ve onları kaydedeceğiz. Bu, optimize edicilerin optimizasyon adımlarını gerçekleştirirken bu parametreleri görmelerini sağlar.

.. code-block:: cpp

   struct DNNImpl : torch::nn::Module{
   ...
     // Our constructor takes the number of input features, output features, and hidden layer features
     // In the initializer list, we initialize both our linear layers and register them
     // Yapıcımız girdi özelliklerinin, çıktı özelliklerinin ve gizli katman özelliklerinin sayısını alır.
      // Başlatıcı listesinde hem lineer katmanlarımızı başlatıyoruz hem de kaydediyoruz
     DNNImpl(int in_channels, int hidden_channels, int out_channels): 
       linear1(register_module("linear1", torch::nn::Linear(in_channels, hidden_channels))),
       linear2(register_module("linear2", torch::nn::Linear(hidden_channels, out_channels))) {}
   };

Forward function -  ileri işlevi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Finally, we define the forward function in our module. This function will take a batch of data and propagate it forward to produce scores for each input. 

Son olarak modülümüzde forward fonksiyonunu tanımlıyoruz. Bu işlev, bir grup veriyi alır ve her girdi için puanlar üretmek üzere ileriye doğru yayar.

.. code-block:: cpp

   struct DNNImpl : torch::nn::Module{

     ...
     // Takes a mini-batch of samples containing `batch_size` samples
     // "batch_size" örnekleri içeren bir mini toplu numune alır
     torch::Tensor forward(torch::Tensor x){
       // The input tensor will be of the shape [batch_size, 1, 28, 28] since each example is an image of 28x28 pixels.
       // We first reshape it into a tensor of size [batch_size, 28*28]
       // .size(i) returns the size of the tensor along dimension i, so, x.size(0) returns batch_size
       // Her örnek 28x28 piksellik bir görüntü olduğundan giriş tensörü [batch_size, 1, 28, 28] şeklinde olacaktır.
        // Önce onu [batch_size, 28*28] boyutunda bir tensöre yeniden şekillendiriyoruz
        // .size(i), i boyutu boyunca tensörün boyutunu döndürür, dolayısıyla x.size(0), batch_size değerini döndürür
       x = x.view({x.size(0), -1});
       // We pass the input through the first linear layer and apply the relu activation function
      // Girdiyi ilk lineer katmandan geçiriyoruz ve relu aktivasyon fonksiyonunu uyguluyoruz
       x = torch::relu(linear1(x));
       // We apply the second linear layer
      // İkinci lineer katmanı uyguluyoruz
       x = linear2(x);
       // We do not apply a non-linearity after the second layer because the loss function
       // will apply the soft-max non-linearity
       // Kayıp fonksiyonu soft-max lineer olmayanlığı uygulayacağı için ikinci katmandan sonra doğrusallık uygulamıyoruz
       return x;
     }

   };
   TORCH_MODULE(DNN);

Dataset - veri kümesi
=====================

Download dataset - Veri kümesini indir
--------------------------------------

``LibTorch`` contains functionality to use the ``MNIST`` dataset. However, it does not automatically download the dataset. For this reason, we must download the dataset manually. `This script <https://www.notion.so/6dd52a5e01ed73a642c1e772084bcd03>`_ will download the data to the current directory. Before running the example, make sure you download the dataset. In our example, we download the datasets to the directory ``mnist/``.

``LibTorch``\ , ``MNIST`` veri kümesini kullanmak için işlevsellik içerir. Ancak, veri kümesini otomatik olarak indirmez. Bu nedenle veri setini manuel olarak indirmeliyiz. Bu komut dosyası, verileri geçerli dizine indirecektir. Örneği çalıştırmadan önce veri setini indirdiğinizden emin olun. Örneğimizde, veri setlerini ``mnist/`` dizinine indiriyoruz.

Dataset objects - Veri kümesi nesneleri
---------------------------------------

We start our main program by creating the dataset objects for the training and test sets. 

Eğitim ve test setleri için veri seti nesneleri oluşturarak ana programımıza başlıyoruz.

.. code-block:: cpp

   int main(){

      auto train_data = torch::data::datasets::MNIST("./mnist", torch::data::datasets::MNIST::Mode::kTrain)
       .map(torch::data::transforms::Normalize<>(0.5, 0.5))
       .map(torch::data::transforms::Stack<>());
      auto test_data = torch::data::datasets::MNIST("./mnist", torch::data::datasets::MNIST::Mode::kTest)
       .map(torch::data::transforms::Normalize<>(0.5, 0.5))
       .map(torch::data::transforms::Stack<>());
   ...
   }

When we load the datasets, we specify two transformations to be applied on them. The first, ``Normalize``\ , will shift the range of values form [0,1] to [-1,1]. The second, ``Stack``\ , will stack the tensors of an entire mini-batch into a single tensor.
Veri setlerini yüklediğimizde üzerlerine uygulanacak iki dönüşümü belirtiyoruz. Birincisi, ``Normalize``\ , değer aralığını [0,1] biçiminden [-1,1]'e kaydırır. İkincisi, ``Stack``\ , tüm bir mini grubun tensörlerini tek bir tensörde toplayacaktır.

Dataset loader - Veri kümesi yükleyici
--------------------------------------

Then, we create for each dataset a loader object that we will use to fetch mini-batches during training. Unlike python, we cannot pass named parameters to function calls. So, to give the dataset loaders options like the batch size and the number of parallel workers, we must create a ``DataLoaderOptions`` object and pass it to the DataSetLoader creator functions.
Ardından, her bir veri kümesi için eğitim sırasında mini yığınları getirmek için kullanacağımız bir yükleyici nesnesi oluştururuz. Python'dan farklı olarak, işlev çağrılarına adlandırılmış parametreleri iletemeyiz. Bu nedenle, veri kümesi yükleyicilerine toplu iş boyutu ve paralel çalışan sayısı gibi seçenekler vermek için bir ``DataLoaderOptions`` nesnesi oluşturmalı ve bunu DataSetLoader oluşturucu işlevlerine iletmeliyiz.

.. code-block:: cpp

   int main(){
   ...
       // We create the options object, which will tell the data loaders of the batch size and number of workers it needs to use
       // Veri yükleyicilere parti boyutunu ve kullanması gereken işçi sayısını söyleyecek options nesnesini oluşturuyoruz
       auto data_loader_options = torch::data::DataLoaderOptions().batch_size(batch_size).workers(2);
       // We create both data loaders using thier respective datasets and pass them the DataLoaderOptions object
       // Her iki veri yükleyiciyi de ilgili veri kümelerini kullanarak oluşturuyoruz ve onlara DataLoader Options nesnesini iletiyoruz
       auto train_data_loader = torch::data::make_data_loader(std::move(train_data), data_loader_options);
       auto test_data_loader = torch::data::make_data_loader(std::move(test_data), data_loader_options);
   ...
   }

Specifying device - cihazı belirtme
-----------------------------------

Similar to the Python interface, we will create a ``Device`` object that we will use to specify where we wish the tensors and model to be. This can be the CPU or it can be a GPU.
Python arayüzüne benzer şekilde, tensörlerin ve modelin nerede olmasını istediğimizi belirtmek için kullanacağımız bir Device nesnesi oluşturacağız. Bu CPU olabilir veya bir GPU olabilir.

.. code-block:: cpp

   int main(){
   ...
       torch::Device device = torch::kCPU;
       if (torch::cuda::is_available()) {
           std::cout << "CUDA is available! Training on GPU." << std::endl;
             device = torch::kCUDA;
       }
   ...
   }

Creating module - Modül oluşturma
---------------------------------

We will create the module and move it to the device we created. 
Modülü oluşturup oluşturduğumuz cihaza taşıyacağız.

.. code-block:: cpp

   int main(){
   ...
       // The number of input channels is the number of pixels in each image, and the number of output channels is the number of classes we wish to predict
       // Giriş kanallarının sayısı, her görüntüdeki piksellerin sayısıdır ve çıkış kanallarının sayısı, tahmin etmek istediğimiz sınıfların sayısıdır.
       DNN model(28*28, 15, 10);
       model->to(device);
   ...
   }

Optimizer - Optimize Edici
==========================

We create an Adam optimizer and pass it the parameters of our model. When we create the optimizer, we use an ``AdamOptions`` object to pass the options that we want our optimizer to have. In this case, we tell the optimizer to use a learning rate of 2e-1.

Bir Adam optimizer yaratıyoruz ve ona modelimizin parametrelerini iletiyoruz. Optimize ediciyi oluşturduğumuzda, optimize edicimizin sahip olmasını istediğimiz seçenekleri iletmek için bir ``AdamOptions`` nesnesi kullanırız. Bu durumda, optimize ediciye 2e-1'lik bir öğrenme oranı kullanmasını söyleriz.

.. code-block:: cpp

   int main(){
   ...
       torch::optim::Adam optim(
             model->parameters(), torch::optim::AdamOptions(2e-4));
   ...
   }

Training loop - Eğitim döngüsü
==============================

In our training loop, we will iterate for 2 epochs. In each epoch, we will go over all the batches inside the ``train_data_loader`` object. Note that the data loader will generate objects of type ``torch::data:Example<>``. Each object of this type has two members, ``data`` and ``target``. ``data`` is the input tensor of this batch, and ``target`` is the labels tensor of this batch. 

Eğitim döngümüzde 2 dönem için yineleyeceğiz. Her çağda, ``train_data_loader`` nesnesinin içindeki tüm yığınları gözden geçireceğiz. Veri yükleyicinin ``torch::data:Example<>`` türünde nesneler oluşturacağını unutmayın. Bu türdeki her nesnenin ``data`` ve ``target`` olmak üzere iki üyesi vardır. ``data``\ , bu grubun girdi tensörüdür ve ``target``\ , bu grubun etiket tensörüdür.

.. code-block:: cpp

   int main(){
   ...
     int epochs = 2;
     for (int i =0; i< epochs; ++i){
       int batch_count = 0;
       // Each batch contains the tensor batch.data containing the input values, and batch.target containing the batch labels
       // Her toplu iş, giriş değerlerini içeren tensör toplu.verilerini ve toplu iş etiketlerini içeren toplu.target'ı içerir
       for (torch::data::Example<> & batch : *train_data_loader){
         // remove the old gradients from our model
         // eski degradeleri modelimizden kaldır
         model->zero_grad();
         // send the input data to the device
         // giriş verilerini cihaza gönder
         torch::Tensor inputs = batch.data.to(device);
         // send the labels to the device
         // etiketleri cihaza gönder
         torch::Tensor labels = batch.target.to(device);
         // propogate the input batch forward through the model
         // girdi grubunu model üzerinden ileriye doğru yay
         torch::Tensor output = model->forward(inputs);
         // calculate the loss of the system
         // sistem kaybını hesapla
         torch::Tensor loss = torch::cross_entropy_loss(output, labels);
         // calculate the gradients 
         // gradyanları hesapla
         loss.backward();
         // Use the optimizer to update the parameters
         // Parametreleri güncellemek için optimize ediciyi kullanın
         optim.step();
         if (batch_count %100 == 0){
           std::cout <<"Epoch " << i <<" batch: " << batch_count << " - loss: " << loss.item<float>() << std::endl;
         }
         batch_count++;
       }
     }
   ...
   }

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: cpp

      CUDA is available! Training on GPU.
      Epoch 0 batch: 0 - loss: 2.3642
      Epoch 0 batch: 100 - loss: 1.81446
      Epoch 0 batch: 200 - loss: 1.41634
      Epoch 0 batch: 300 - loss: 0.982396
      Epoch 0 batch: 400 - loss: 0.762961
      Epoch 0 batch: 500 - loss: 0.688441
      Epoch 0 batch: 600 - loss: 0.764025
      Epoch 0 batch: 700 - loss: 0.462873
      Epoch 0 batch: 800 - loss: 0.364896
      Epoch 0 batch: 900 - loss: 0.427254
      Epoch 1 batch: 0 - loss: 0.398513
      Epoch 1 batch: 100 - loss: 0.538056
      Epoch 1 batch: 200 - loss: 0.350546
      Epoch 1 batch: 300 - loss: 0.462508
      Epoch 1 batch: 400 - loss: 0.337015
      Epoch 1 batch: 500 - loss: 0.450874
      Epoch 1 batch: 600 - loss: 0.386576
      Epoch 1 batch: 700 - loss: 0.497509
      Epoch 1 batch: 800 - loss: 0.391332
      Epoch 1 batch: 900 - loss: 0.16951

Evaluation - Değerlendirme
==========================

Finally, we evaluate the quality of the system using the test set we created previously. As usual, we don't want the calculation done for evaluation to be recorded and used for gradient calculation. For this reason, we place the evaluation calculation inside a code block and we create a ``torch::NoGradGuard`` object. This guarantees that all the calculations that will take place in the same code block will not be recorded and used for gradient calculation.

Son olarak daha önce oluşturduğumuz test setini kullanarak sistemin kalitesini değerlendiriyoruz. Her zamanki gibi, değerlendirme için yapılan hesaplamanın kaydedilmesini ve gradyan hesaplaması için kullanılmasını istemiyoruz. Bu nedenle değerlendirme hesaplamasını bir kod bloğunun içine yerleştiriyoruz ve bir ``torch::NoGradGuard`` nesnesi oluşturuyoruz. Bu, aynı kod bloğunda yer alacak tüm hesaplamaların kaydedilmeyeceğini ve gradyan hesaplaması için kullanılmayacağını garanti eder.

.. code-block:: cpp

   int main(){
   ...
     int correct_predictions = 0;
     int total_predictions = 0;
     {
       // As long as this object exists, calculations will be be recorded for 
       // gradient calculation
       // Bu nesne var olduğu sürece, gradyan hesaplaması için hesaplamalar kaydedilecektir.
       torch::NoGradGuard no_grad;
       for (torch::data::Example<> & batch : *test_data_loader){
         torch::Tensor output = model->forward(batch.data.to(device));
         // The max function will return a tuple of tensors, the first tensor contains the 
         // top scores in each row, and the second tensor contains the index of the highest
         // score
         // max işlevi bir dizi tensör döndürür, ilk tensör her satırdaki en yüksek puanları içerir ve ikinci tensör en yüksek puanın dizinini içerir
         auto score_predicted = at::max(output, 1);
         auto predicted = std::get<1>(score_predicted);
         // We count the number of correct predictions and use it 
         // Doğru tahminlerin sayısını sayar ve kullanırız
         correct_predictions+= (predicted == batch.target.to(device)).sum().item<int>();
         total_predictions+= output.size(0);

       }
     }
     std::cout << "Final score: " << correct_predictions << "/" << total_predictions << " - accuracy: " << float(correct_predictions)/total_predictions*100 << std::endl;
   }

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: 

      Final score: 9007/10000 - accuracy: 90.07

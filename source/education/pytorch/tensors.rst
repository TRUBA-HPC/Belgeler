
=========================
Tensörler
=========================

.. The main building block of PyTorch is its tensors. They can represent anything from scaler values to n-dimensional arrays. In addition to including over 100 tensor operations, PyTorch provides the ability to calculate gradients for tensors after applying arbitrarily many mathematical operations on them. This tutorial will cover the basics of tensors as well as gradient calculations on tensors.

PyTorch'un ana yapı taşı tensörleridir. Ölçekleyici değerlerinden n boyutlu dizilere kadar her şeyi temsil edebilirler. 100'den fazla tensör işleminin dahil edilmesine ek olarak, PyTorch tensörler için gradyanları rastgele birçok matematiksel işlemi uyguladıktan sonra hesaplama yeteneği sağlar. Bu eğitim, tensörlerin temellerini ve tensörler üzerindeki gradyan hesaplamalarını kapsayacaktır. 

.. Creating tensors

Tensörler oluşturma
--------------------

.. From existing data

Mevcut verilerden 
^^^^^^^^^^^^^^^^^^

.. One can create Python nested arrays and use them to create tensors. You can specify the data type of the numbers in the tensor using the ``dtype`` attribute or let PyTorch automatically infer them.

Python iç içe diziler oluşturabilir ve bunları tensörler oluşturmak için kullanabilir. ``dtype`` özelliğini kullanarak tensördeki sayıların veri türünü belirtebilir veya PyTorch'un bunları otomatik olarak çıkarmasına izin verebilirsiniz. 


.. code-block:: python

   import torch

   scaler = 10
   array = [1,2]
   matrix = [[3.1,4.0,5.0],[6.5,-71,8.02]]

   s_tensor = torch.tensor(scaler, dtype=torch.int32)
   a_tensor = torch.tensor(array, dtype=torch.float32)
   m_tensor = torch.tensor(matrix)

   print(f"Ölçekleyiciler  \n{s_tensor}\n")
   print(f"1D dizisi \n{a_tensor}\n")
   print(f"2D matris \n{m_tensor}\n")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      Ölçekleyiciler
      10

      1D dizisi
      tensor([1., 2.])

      2D matris
      tensor([[  3.1000,   4.0000,   5.0000],
            [  6.5000, -71.0000,   8.0200]])

.. Using constant values

Sabit değerler kullanma 
^^^^^^^^^^^^^^^^^^^^^^^

.. Tensors can be created by specifying the required tensor shape. In this case, the tensor will be populated with constant values which can be random or user-specified. The shape is specified as multiple arguments, a tuple, or a list. The following are some examples:

Tensörler, gerekli tensör şekli belirtilerek oluşturulabilir. Bu durumda tensör, rastgele veya kullanıcı tanımlı olabilen sabit değerlerle doldurulacaktır. Şekil, birden çok bağımsız değişken, bir demet veya bir liste olarak belirtilir. Aşağıda bazı örnekler verilmiştir: 

.. code-block:: python

   import torch

   rand_uni = torch.rand((2,3)) # tekdüze rastgele değerlere sahip matris 
   rand_nor = torch.randn(2,3) # normal dağılımdan rastgele değerlere 
                               # sahip matris 
   all_ones = torch.ones(4) # Bir ile dolu 1D dizisi 
   all_zeros = torch.zeros([2,3,2]) # 3 sıralı sıfır tensörü 
   all_six = torch.full((2,2), 6) # tüm değerleri 6'ya eşit olan matris 
   regular = torch.arange(1,2,0.2) # 0,2 aralıklı [1,2) aralığında 1B değer 
                                   # dizisi

   print(f"Tekdüze dağılımdan rastgele \n{rand_uni}\n")
   print(f"Normal dağılımdan rastgele  \n{rand_nor}\n")
   print(f"Birler  \n{all_ones}\n")
   print(f"Sıfırlar  \n{all_zeros}\n")
   print(f"Sabit  \n{all_six}\n")
   print(f"Bir dizi değer  \n{regular}\n")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information


   .. code-block::

      Tekdüze dağılımdan rastgele
      tensor([[0.5713, 0.6914, 0.8229],
            [0.6467, 0.3670, 0.2972]])

      Normal dağılımdan rastgele
      tensor([[-0.2732, -1.3975,  0.3833],
            [-0.3211,  0.2996,  0.0519]])

      Birler
      tensor([1., 1., 1., 1.])

      Sıfırlar
      tensor([[[0., 0.],
               [0., 0.],
               [0., 0.]],

            [[0., 0.],
               [0., 0.],
               [0., 0.]]])

      Sabit
      tensor([[6, 6],
            [6, 6]])

      Bir dizi değer
      tensor([1.0000, 1.2000, 1.4000, 1.6000, 1.8000])
.. Using other tensors

Diğer tensörleri kullanma 
^^^^^^^^^^^^^^^^^^^^^^^^^

.. One can create tensors that are like existing tensors. This allows using the other tensor's attributes including its values, shape, and data types.

Mevcut tensörler gibi tensörler yaratılabilir. Bu, değerleri, şekli ve veri türleri dahil olmak üzere diğer tensör niteliklerinin kullanılmasına izin verir. 

.. code-block:: python

   import torch

   rand_nor = torch.randn(2,3, dtype=torch.float32) # rastgele tensör 
   all_sevens = torch.zeros_like(rand_nor) # aynı şekil ve veri türü 
   all_ones = torch.ones_like(rand_nor, dtype=torch.float64) # aynı şekil, farklı  
                                                               # veri türü
   exact_copy = rand_nor.clone().detach() # aynı tensör

   print(f"Orijinal tensör \n{rand_nor}\n")
   print(f"Aynı şekil ve veri türü \n{all_sevens}\n")
   print(f"Aynı şekil, farklı veri türü \n{all_ones}\n")
   print(f"Tam kopya \n{exact_copy}\n")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information


   .. code-block::

      Orijinal tensör
      tensor([[ 0.5975,  1.1559,  0.5189],
            [-1.1280, -0.0791,  1.2801]])

      Aynı şekil ve veri türü
      tensor([[0., 0., 0.],
            [0., 0., 0.]])

      Aynı şekil, farklı veri türü
      tensor([[1., 1., 1.],
            [1., 1., 1.]], dtype=torch.float64)

      Tam kopya
      tensor([[ 0.5975,  1.1559,  0.5189],
            [-1.1280, -0.0791,  1.2801]])

.. Tensor manipulation

Tensör manipülasyonu 
--------------------

.. Accessing tensors (slicing)

Tensörlere erişme (dilimleme)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. A tensor can be accessed and sliced easily with numpy-like syntax.

Bir tensöre, numpy benzeri sözdizimi ile kolayca erişilebilir ve dilimlenebilir. 

.. code-block:: python

   import torch

   const_ten = torch.tensor([[1,2,3], [4,5,6]], dtype=torch.float32)

   single_element = const_ten[1,2]
   first_row = const_ten[0,:]
   second_column = const_ten[:, 1]
   sub_matrix = const_ten[0:2,1:3]

   print(f"Tek eleman  \n{single_element}\n")
   print(f"İlk sıra \n{first_row}\n")
   print(f"İkinci sütun  \n{second_column}\n")
   print(f"Alt matris  \n{sub_matrix}\n")

.. Output:


.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      Tek eleman
      6.0

      İlk sıra
      tensor([1., 2., 3.])

      İkinci sütun
      tensor([2., 5.])

      Alt matris
      tensor([[2., 3.],
            [5., 6.]])


.. Reshaping tensors

Tensörleri yeniden şekillendirmek 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Tensors can be reshaped easily using the ``reshape`` and ``reshape_as`` functions. Important: these functions will return a new tensor, but the new tensor might use the same data as the original tensor. You can use the ``clone`` function to make sure the data of the original tensor is copied to the new one.

Tensörler, ``reshape`` ve ``reshape_as`` işlevleri kullanılarak kolayca yeniden şekillendirilebilir. Önemli: bu işlevler yeni bir tensör döndürür, ancak yeni tensör orijinal tensörle aynı verileri kullanabilir. Orijinal tensörün verilerinin yenisine kopyalandığından emin olmak için 'klon' işlevini kullanabilirsiniz. 

.. code-block:: python

   import torch

   all_ones = torch.zeros(2,4)

   diff_shape = all_ones.reshape((2,4)) # Şekli bir demet ile belirtin 

   diff_shape_1 = all_ones.reshape((1,2,4))

   diff_shape_2 = all_ones.reshape(-1, 2) # Putting -1 at a dimension tells PyTorch to infer the value automatically
                     # Bir boyuta -1 koymak, PyTorch'a değeri otomatik olarak çıkarmasını söyler

   rand_t = torch.empty((2, 2, 2)) 
   diff_shape_3 = all_ones.reshape_as(rand_t) #Başka bir tensörün şekliyle
                                             # eşleşmeyi kullanabilirsiniz 


   new_tensor = all_ones.clone().detach().reshape((2,4)) 
                                       #Başka bir tensörün şekliyle
                                       # eşleşmeyi kullanabilirsiniz 

   print("Şekil: (2,3)")
   print(all_ones)
   print("\nŞekil: (3,2)")
   print(diff_shape)
   print("\nŞekil: (1,2,3)")
   print(diff_shape_1)
   print("\nŞekil: (4,2)")
   print(diff_shape_2)
   print("\nŞekil: (2,2,2)")
   print(diff_shape_3)
   print("\nYeni tensör:")
   print(new_tensor)

   
.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: 
   
      Şekil: (2,3)
      tensor([[0., 0., 0., 0.],
            [0., 0., 0., 0.]])

      Şekil: (3,2)
      tensor([[0., 0., 0., 0.],
            [0., 0., 0., 0.]])

      Şekil: (1,2,3)
      tensor([[[0., 0., 0., 0.],
               [0., 0., 0., 0.]]])

      Şekil: (4,2)
      tensor([[0., 0.],
            [0., 0.],
            [0., 0.],
            [0., 0.]])

      Şekil: (2,2,2)
      tensor([[[0., 0.],
               [0., 0.]],

            [[0., 0.],
               [0., 0.]]])

      Yeni tensör:
      tensor([[0., 0., 0., 0.],
            [0., 0., 0., 0.]])

.. Concatenating tensors

Tensörleri birleştirme 
^^^^^^^^^^^^^^^^^^^^^^

.. Tensors can be joined together on any axis. The concatenated tensor is returned as a new tensor.

Tensörler herhangi bir eksende birleştirilebilir. Birleştirilmiş tensör, yeni bir tensör olarak döndürülür. 

.. code-block:: python

   import torch

   all_ones = torch.ones(2,3)
   all_zeros = torch.zeros_like(all_ones) # all_ones ile aynı şekil 

   con_hor = torch.cat([all_ones, all_zeros], dim=1) # yatay  
   con_ver = torch.cat([all_ones, all_zeros], dim=0) # dikey

   print(f"Yatay birleştirme  \n{con_hor}\n")
   print(f"Dikey birleştirme  \n{con_ver}\n")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      Yatay birleştirme
      tensor([[1., 1., 1., 0., 0., 0.],
            [1., 1., 1., 0., 0., 0.]])

      Dikey birleştirme
      tensor([[1., 1., 1.],
            [1., 1., 1.],
            [0., 0., 0.],
            [0., 0., 0.]])

.. Mathematical operations

Matematiksel işlemler 
^^^^^^^^^^^^^^^^^^^^^

.. There are many mathematical operations that can be done on tensors. A full list can be found `here <https://pytorch.org/docs/stable/torch.html#math-operations>`_.

Tensörler üzerinde yapılabilecek birçok matematiksel işlem vardır. Tam bir liste şu şekilde `bulunabilir <https://pytorch.org/docs/stable/torch.html#math-operations>`_ 

.. code-block:: python

   import torch

   all_ones = torch.ones(3,2, dtype=torch.float32)
   all_twos = torch.full((2,3),2, dtype=torch.float32)
   all_threes = torch.full((3,2),3, dtype=torch.float32)

   scaler_arith = all_ones + 4
   tensor_arith = all_ones - all_threes

   scaler_mul = all_ones * 2
   elem_mul = all_ones * all_threes
   mat_mul = all_ones.matmul(all_twos)

   print(f"Bir tensöre ölçekleyici ekleme \n{scaler_arith}\n")
   print(f"İki tensör eklemek  \n{tensor_arith}\n")
   print(f"Bir tensörün bir ölçekleyici ile çarpılması  \n{scaler_mul}\n")
   print(f"Element-bilge çarpma  \n{elem_mul}\n")
   print(f"Matris çarpımı  \n{mat_mul}\n")

.. Output:


.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      Bir tensöre ölçekleyici ekleme
      tensor([[5., 5.],
            [5., 5.],
            [5., 5.]])

      İki tensör eklemek
      tensor([[-2., -2.],
            [-2., -2.],
            [-2., -2.]])

      Bir tensörün bir ölçekleyici ile çarpılması
      tensor([[2., 2.],
            [2., 2.],
            [2., 2.]])

      Element-bilge çarpma
      tensor([[3., 3.],
            [3., 3.],
            [3., 3.]])

      Matris çarpımı
      tensor([[4., 4., 4.],
            [4., 4., 4.],
            [4., 4., 4.]])


GPU üzerindeki tensörler 
^^^^^^^^^^^^^^^^^^^^^^^^

Tensors can be moved to the GPU from the CPU and back easily. They can also be created directly on the GPU. Operations cannot happen between tensors on different devices.

.. code-block:: python

   import torch

   gpu_0_also = torch.device('cuda:0') # 
   gpu_0 = torch.device('cuda') #
   gpu_1 = torch.device('cuda:1')
   cpu_device = torch.device('cpu')

   t1 = torch.tensor([1,2,3], device=gpu_0)
   print(f"t1 on GPU 0: \n{t1}\n")
   t2 = torch.tensor([1,2,3])
   print(f"t2 on CPU: \n{t2}\n")
   t2 = t2.to(gpu_0)
   print(f"t2 on GPU 0: \n{t2}\n")
   t3 = t2 + t1
   t3 = t3.to(cpu_device)
   print(f"t3 on GPU 0: \n{t3}\n")


.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: 

      t1 on GPU 0:
      tensor([1, 2, 3], device='cuda:0')

      t2 on CPU:
      tensor([1, 2, 3])

      t2 on GPU 0:
      tensor([1, 2, 3], device='cuda:0')

      t3 on CPU:
      tensor([2, 4, 6])
   

.. In-place and out-of-place operations

Yerinde ve yerinde olmayan operasyonlar 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Generally, all functions are out-of-place meaning that a call to an operation will not modify the operands and will return a new data structure. However, functions that end with the ``_`` character are in-place. For example, ``t3 = t1.mul(t2)`` will element-wise multiply the tensors ``t1`` and ``t2`` and store the result in ``t3``. However, ``t1.mul_(t2)`` will element-wise multiply ``t1`` and ``t2`` them and store the result in ``t1``.

Genel olarak, tüm işlevler yerinde değildir, yani bir işleme yapılan bir çağrının işlenenleri değiştirmeyeceği ve yeni bir veri yapısı döndüreceği anlamına gelir. Bununla birlikte, ``_`` karakteriyle biten işlevler yerindedir. Örneğin, ``t3 = t1.mul (t2)``, eleman bazında ``t1`` ve ``t2`` tensörlerini çarpacak ve sonucu ``t3`` içinde saklayacaktır. Ancak, ``t1.mul_(t2)``, ``t1`` ve ``t2`` yi eleman bazında çarpacak ve sonucu ``t1`` de saklayacaktır. 

.. Gradient calculation

Gradyan hesaplama 
--------------------

.. One of the most important features of PyTorch is its ``torch.autograd`` package. It enables gradients of tensors and scalers alike to be calculated with ease. This is very useful for building machine learning pipelines as it drives the process of back-propagation.

PyTorch'un en önemli özelliklerinden biri, ``torch.autograd`` paketidir. Tensörlerin ve ölçekleyicilerin gradyanlarının kolaylıkla hesaplanmasını sağlar. Bu, geri yayılma sürecini yönlendirdiği için makine öğrenimi ardışık düzenleri oluşturmak için çok kullanışlıdır. 


.. Requiring gradient

Gradyan gerektiriyor 
^^^^^^^^^^^^^^^^^^^^

.. For a tensor's gradient to be calculatable, we must specify that we require the tensor for a specific tensor, either at creation time or by calling a function.

Bir tensör gradyanının hesaplanabilir olması için, tensöre belirli bir tensöre ihtiyaç duyduğumuzu, yaratma sırasında veya bir fonksiyon çağırarak belirtmemiz gerekir. 

.. code-block:: python

   import torch

   t0 = torch.ones(3, requires_grad=True)
   t1 = torch.zeros(3)

   print(f"t0 \n{t0}")
   print(f"t1 \n{t1}\n")

   t1.requires_grad_(True)
   print(f"t1 \n{t1}")
   print("t1'de manuel olarak etkinleştirilen gradyan hesaplaması \n")
   t1.requires_grad_(False)
   print(f"t1 \n{t1}")
   print("Manuel olarak devre dışı bıraktı ")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      t0
      tensor([1., 1., 1.], requires_grad=True)
      t1
      tensor([0., 0., 0.])

      t1
      tensor([0., 0., 0.], requires_grad=True)
      t1'de manuel olarak etkinleştirilen gradyan hesaplaması

      t1
      tensor([0., 0., 0.])
      Manuel olarak devre dışı bıraktı

.. Calculating gradient

Gradyan hesaplanıyor 
^^^^^^^^^^^^^^^^^^^^

.. When a tensor ``t`` has the option ``requires_grad`` set to ``True``\ , we can calculate the gradient of any other tensor ``other`` with respect to ``t``. We do so by calling the ``backward()`` function on ``other``.

Bir tensör ``t``, ``required_grad`` seçeneğini ``True`` olarak ayarladığında, ``other`` tensörünün ``t`` ye göre gradyanını hesaplayabiliriz. Bunu, ``other`` üzerinde ``backward ()`` işlevini çağırarak yapıyoruz. 

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)
   t2 = t1*t1 # t2, t1 cinsinden bir fonksiyondur 
              # dt2/dt1 = 2*t1
   t2.backward()

   print(f"t1 = {t1}")
   print(f"t1'e göre t2'nin gradyanı  = {t1.grad}")

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      t1 = 1.0
      t1'e göre t2'nin gradyanı  = 2.0

.. Deeper functions

Daha derin işlevler 
^^^^^^^^^^^^^^^^^^^

.. Gradients of tensors are calculated using the chain rule which means that they are calculated for arbitrarily deep functions. They can also be calculated for any of the intermediary steps of the function. However, if we want to calculate more than a single gradient, we must add the option ``retain_graph`` to the ``backward()`` function.

Tensörlerin gradyanları zincir kuralı kullanılarak hesaplanır, bu da onların keyfi derinlikteki fonksiyonlar için hesaplandığı anlamına gelir. İşlevin herhangi bir ara adımı için de hesaplanabilirler. Bununla birlikte, tek bir gradyandan daha fazlasını hesaplamak istiyorsak, ``backward()`` fonksiyonuna ``retain_graph`` seçeneğini eklemeliyiz. 

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)

   t2 = t1*t1-5 # dt2/dt1 = 2*t1

   t3 = t2*2+3 # dt3/dt2 = 2

   t4 = t3**4 # dt4/g3 = 4*t3^3

   print(f"t1 = {t1}, t2 = {t2}, t3 = {t3}, t4 = {t4}")

   t2.backward(retain_graph=True) # gradyanı tekrar hesaplayabilmek
                                  #  için "retain_graph = True" belirtiriz 
   print(f"t1'ye göre t2'nin gradyanı  = {t1.grad}")
   # dt2/dt1 = 2 * t1
   t1.grad.data.zero_() # bu degradeyi 0'a sıfırlayacak 

   t3.backward(retain_graph=True)
   print(f"t1'e göre t3'ün gradyanı  = {t1.grad}")
   # dt3/dt1 = dt3/dt2 * dt2/dt1 = 2 * 2 * t1
   t1.grad.data.zero_() # bu degradeyi 0'a sıfırlayacak

   t4.backward()
   print(f"t1'e göre t4 gradyanı  = {t1.grad}")
   # dt4/dt1 = dt4/dt3 * dt3/dt2 * dt2/dt1 = 4 * t3^3 * 2 * 2 * t1
   t1.grad.data.zero_() # bu degradeyi 0'a sıfırlayacak

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block::

      t1 = 1.0, t2 = -4.0, t3 = -5.0, t4 = 625.0
      t1'ye göre t2'nin gradyanı  = 2.0
      t1'e göre t3'ün gradyanı  = 4.0
      t1'e göre t4 gradyanı  = -2000.0

.. Updating tensors using gradients

Degradeleri kullanarak tensörleri güncelleme 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Generally, in machine learning pipelines, the gradient of a tensor is used to update that tensor's value. When updating the tensor using its gradient, we must make sure that the update procedure is not *tracked* by the ``autograd`` package. In other words, we need to mark the update operation as not part of the forward propagation of pipeline. We do so using the ``torch.no_grad()`` function which halts all gradient tracking.

Genel olarak, makine öğrenimi ardışık düzenlerinde, bir tensörün gradyanı, bu tensörün değerini güncellemek için kullanılır. Tensörü gradyanını kullanarak güncellerken, güncelleme prosedürünün ``autograd`` paketi tarafından *izlenmediğinden* emin olmalıyız. Başka bir deyişle, güncelleme işlemini boru hattının ileriye doğru yayılmasının bir parçası olarak işaretlememeliyiz. Bunu, tüm gradyan izlemeyi durduran ``torch.no_grad()`` işlevini kullanarak yapıyoruz. 

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)

   t2 = t1*t1-5 # dt2/dt1 = 2*t1
   t2.backward() # t1'ye göre t3'ün gradyanını hesaplayın 
   print(f"t1 = {t1}")
   print(f"t1'e göre t2'nin gradyanı  = {t1.grad.data}\n")
   with torch.no_grad(): # gradyanlar hesaplanırken bu bloktaki 
       t1-=t1.grad.data  # tensör işlemleri izlenmez 
   print(f"güncellemeden sonra t1  = {t1}")
   t1.grad.data.zero_() # bu degradeyi 0'a sıfırlayacak

.. Output:

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: python

      t1 = 1.0
      t1'e göre t2'nin gradyanı  = 2.0

      güncellemeden sonra t1  = -1.0

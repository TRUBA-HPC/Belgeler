
=========================
Tensors
=========================

The main building block of PyTorch is its tensors. They can represent anything from scaler values to n-dimensional arrays. In addition to including over 100 tensor operations, PyTorch provides the ability to calculate gradients for tensors after applying arbitrarily many mathematical operations on them. This tutorial will cover the basics of tensors as well as gradient calculations on tensors.

Creating tensors
----------------

From existing data
^^^^^^^^^^^^^^^^^^

One can create Python nested arrays and use them to create tensors. You can specify the data type of the numbers in the tensor using the ``dtype`` attribute or let PyTorch automatically infer them.

.. code-block:: python

   import torch

   scaler = 10
   array = [1,2]
   matrix = [[3.1,4.0,5.0],[6.5,-71,8.02]]

   s_tensor = torch.tensor(scaler, dtype=torch.int32)
   a_tensor = torch.tensor(array, dtype=torch.float32)
   m_tensor = torch.tensor(matrix)

   print(f"Scalers \n{s_tensor}\n")
   print(f"1D array \n{a_tensor}\n")
   print(f"2D matrix \n{m_tensor}\n")

Output:

.. code-block::

   Scalers 
   10

   1D array
   tensor([1., 2.])

   2D matrix
   tensor([[  3.1000,   4.0000,   5.0000],
           [  6.5000, -71.0000,   8.0200]])

Using constant values
^^^^^^^^^^^^^^^^^^^^^

Tensors can be created by specifying the required tensor shape. In this case, the tensor will be populated with constant values which can be random or user-specified. The shape is specified as multiple arguments, a tuple, or a list. The following are some examples:

.. code-block:: python

   import torch

   rand_uni = torch.rand((2,3)) # matrix with uniformally random values 
   rand_nor = torch.randn(2,3) # matrix with random values from a
                               # normal distirbution
   all_ones = torch.ones(4) # 1D array with filled with ones
   all_zeros = torch.zeros([2,3,2]) # 3-rank tensor of zeros 
   all_six = torch.full((2,2), 6) # matrix with all its values == 6
   regular = torch.arange(1,2,0.2) # 1D array of values in the range [1,2) 
                                   # spaced by 0.2

   print(f"Random from uniform distribution \n{rand_uni}\n")
   print(f"Random from normal distribution \n{rand_nor}\n")
   print(f"Ones \n{all_ones}\n")
   print(f"Zeros \n{all_zeros}\n")
   print(f"Constant \n{all_six}\n")
   print(f"A range of values \n{regular}\n")

Output:

.. code-block::

   Random from uniform distribution 
   tensor([[0.9696, 0.0413, 0.6204],
           [0.3546, 0.1855, 0.8386]])

   Random from normal distribution
   tensor([[-0.0132, -1.3348,  0.7555],
           [-2.4719,  1.9691,  2.2053]])

   Ones
   tensor([1., 1., 1., 1.])

   Zeros
   tensor([[[0., 0.],
            [0., 0.],
            [0., 0.]],

           [[0., 0.],
            [0., 0.],
            [0., 0.]]])

   Constant
   tensor([[6, 6],
           [6, 6]])

   A range of values
   tensor([1.0000, 1.2000, 1.4000, 1.6000, 1.8000])

Using other tensors
^^^^^^^^^^^^^^^^^^^

One can create tensors that are like existing tensors. This allows using the other tensor's attributes including its values, shape, and data types.

.. code-block:: python

   import torch

   rand_nor = torch.randn(2,3, dtype=torch.float32) # random tensor
   all_sevens = torch.zeros_like(rand_nor) # same shape and datatype
   all_ones = torch.ones_like(rand_nor, dtype=torch.float64) # same shape,
                                                             # different datatype
   exact_copy = rand_nor.clone().detach() # same shape, different datatype

   print(f"Original tensor \n{rand_nor}\n")
   print(f"Same shape and datatype \n{all_sevens}\n")
   print(f"Same shape, different datatype \n{all_ones}\n")
   print(f"Exact copy \n{exact_copy}\n")

Output:

.. code-block::

   Original tensor 
   tensor([[1.0669, 1.1981, 0.2314],
           [0.1303, 1.3123, 0.7025]])

   Same shape and datatype
   tensor([[0., 0., 0.],
           [0., 0., 0.]])

   Same shape, different datatype
   tensor([[1., 1., 1.],
           [1., 1., 1.]], dtype=torch.float64)

   Exact copy
   tensor([[1.0669, 1.1981, 0.2314],
           [0.1303, 1.3123, 0.7025]])

Tensor manipulation
-------------------

In-place and out-of-place operations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note: generally, all functions are out-of-place meaning that a call to an operation will not modify the operands and will return a new data structure. However, functions that end with the ``_`` character are in-place. For example, ``t3 = t1.mul(t2)`` will element-wise multiply the tensors ``t1`` and ``t2`` and store the result in ``t3``. However, ``t1.mul_(t2)`` will element-wise multiply ``t1`` and ``t2`` them and store the result in ``t1``.

Accessing tensors (slicing)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

A tensor can be accessed and sliced easily with numpy-like syntax.

.. code-block:: python

   import torch

   const_ten = torch.tensor([[1,2,3], [4,5,6]], dtype=torch.float32)

   single_element = const_ten[1,2]
   first_row = const_ten[0,:]
   second_column = const_ten[:, 1]
   sub_matrix = const_ten[0:2,1:3]

   print(f"single_element \n{single_element}\n")
   print(f"First row \n{first_row}\n")
   print(f"Second column \n{second_column}\n")
   print(f"Sub-matrix \n{sub_matrix}\n")

Output:

.. code-block::

   single_element 
   6.0

   First row 
   tensor([1., 2., 3.])

   Second column
   tensor([2., 5.])

   Sub-matrix
   tensor([[2., 3.],
           [5., 6.]]

Concatenating tensors
^^^^^^^^^^^^^^^^^^^^^

Tensors can be joined together on any axis. The concatenated tensor is returned as a new tensor.

.. code-block:: python

   import torch

   all_ones = torch.zeros(2,3)
   all_zeros = torch.ones_like(all_ones) # same shape as all_ones

   con_hor = torch.cat([all_ones, all_zeros], dim=1) # horizontal 
   con_ver = torch.cat([all_ones, all_zeros], dim=0) # vertical

   print(f"Horizontal concatenation \n{con_hor}\n")
   print(f"Vertical concatenation \n{con_ver}\n")

Output:

.. code-block::

   Horizontal concatenation 
   tensor([[0., 0., 0., 1., 1., 1.],
           [0., 0., 0., 1., 1., 1.]])

   Vertical concatenation 
   tensor([[0., 0., 0.],
           [0., 0., 0.],
           [1., 1., 1.],
           [1., 1., 1.]])

Mathematical operations
~~~~~~~~~~~~~~~~~~~~~~~

There are many mathematical operations that can be done on tensors. A full list can be found `here <https://pytorch.org/docs/stable/torch.html#math-operations>`_.

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

   print(f"Adding a scaler to a tensor \n{scaler_arith}\n")
   print(f"Adding two tensors \n{tensor_arith}\n")
   print(f"Multiplying a tensor by a scaler \n{scaler_mul}\n")
   print(f"Element-wise multiplication \n{elem_mul}\n")
   print(f"Matrix multiplication \n{mat_mul}\n")

Output:

.. code-block::

   Adding a scaler to a tensor 
   tensor([[5., 5.],
           [5., 5.],
           [5., 5.]])

   Adding two tensors
   tensor([[-2., -2.],
           [-2., -2.],
           [-2., -2.]])

   Multiplying a tensor by a scaler
   tensor([[2., 2.],
           [2., 2.],
           [2., 2.]])

   Element-wise multiplication
   tensor([[3., 3.],
           [3., 3.],
           [3., 3.]])

   Matrix multiplication
   tensor([[4., 4., 4.],
           [4., 4., 4.],
           [4., 4., 4.]])

Gradient calculation
--------------------

One of the most important features of PyTorch is its ``torch.autograd`` package. It enables gradients of tensors and scalers alike to be calculated with ease. This is very useful for building machine learning pipelines as it drives the process of back-propagation.

Requiring gradient
^^^^^^^^^^^^^^^^^^

For a tensor's gradient to be calculatable, we must specify that we require the tensor for a specific tensor, either at creation time or by calling a function.

.. code-block:: python

   import torch

   t0 = torch.ones(3, requires_grad=True)
   t1 = torch.zeros(3)

   print(f"t0 \n{t0}")
   print(f"t1 \n{t1}\n")

   t1.requires_grad_(True)
   print(f"t1 \n{t1}")
   print("Manually enabled gradient calculation on t1\n")
   t1.requires_grad_(False)
   print(f"t1 \n{t1}")
   print("Manually disabled it")

Output:

.. code-block::

   t0 
   tensor([1., 1., 1.], requires_grad=True)
   t1
   tensor([0., 0., 0.])

   t1
   tensor([0., 0., 0.], requires_grad=True)
   Manually enabled gradient calculation on t1

   t1
   tensor([0., 0., 0.])
   Manually disabled it

Calculating gradient
^^^^^^^^^^^^^^^^^^^^

When a tensor ``t`` has the option ``requires_grad`` set to ``True``\ , we can calculate the gradient of any other tensor ``other`` with respect to ``t``. We do so by calling the ``backward()`` function on ``other``.

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)
   t2 = t1*t1 # t2 is a function in terms of t1
              # dt2/dt1 = 2*t1
   t2.backward()

   print(f"t1 = {t1}")
   print(f"Gradient of t2 with respect to t1 = {t1.grad}")

Output:

.. code-block::

   t1 = 1.0
   Gradient of t2 with respect to t1 = 2.0

Deeper functions
^^^^^^^^^^^^^^^^

Gradients of tensors are calculated using the chain rule which means that they are calculated for arbitrarily deep functions. They can also be calculated for any of the intermediary steps of the function. However, if we want to calculate more than a single gradient, we must add the option ``retain_graph`` to the ``backward()`` function.

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)

   t2 = t1*t1-5 # dt2/dt1 = 2*t1

   t3 = t2*2+3 # dt3/dt2 = 2

   t4 = t3**4 # dt4/g3 = 4*t3^3

   print(f"t1 = {t1}, t2 = {t2}, t3 = {t3}, t4 = {t4}")

   t2.backward(retain_graph=True) # we specify `retain_graph=True` to be able
                                  # to calculate the gradient again
   print(f"Gradient of t2 with respect to t1 = {t1.grad}")
   # dt2/dt1 = 2 * t1
   t1.grad.data.zero_() # this will reset the gradient to 0

   t3.backward(retain_graph=True)
   print(f"Gradient of t3 with respect to t1 = {t1.grad}")
   # dt3/dt1 = dt3/dt2 * dt2/dt1 = 2 * 2 * t1
   t1.grad.data.zero_() # this will reset the gradient to 0

   t4.backward()
   print(f"Gradient of t4 with respect to t1 = {t1.grad}")
   # dt4/dt1 = dt4/dt3 * dt3/dt2 * dt2/dt1 = 4 * t3^3 * 2 * 2 * t1
   t1.grad.data.zero_() # this will reset the gradient to 0

Output:

.. code-block::

   t1 = 1.0, t2 = -4.0, t3 = -5.0, t4 = 625.0
   Gradient of t2 with respect to t1 = 2.0
   Gradient of t3 with respect to t1 = 4.0
   Gradient of t4 with respect to t1 = -2000.0

Updating tensors using gradients
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Generally, in machine learning pipelines, the gradient of a tensor is used to update that tensor's value. When updating the tensor using its gradient, we must make sure that the update procedure is not *tracked* by the ``autograd`` package. In other words, we need to mark the update operation as not part of the forward propagation of pipeline. We do so using the ``torch.no_grad()`` function which halts all gradient tracking.

.. code-block:: python

   import torch

   t1 = torch.tensor(1, dtype=torch.float32, requires_grad=True)

   t2 = t1*t1-5 # dt2/dt1 = 2*t1
   t2.backward() # calculate the gradient of t3 with respect to t1
   print(f"t1 = {t1}")
   print(f"Gradient of t2 w.r.t t1 = {t1.grad.data}\n")
   with torch.no_grad(): # tensor operations in this block are not
       t1-=t1.grad.data  # tracked when calculating gradients
   print(f"t1 after the update {t1}")
   t1.grad.data.zero_() # this will reset the gradient to 0

Output:

.. code-block:: python

   t1 = 1.0
   Gradient of t2 w.r.t t1 = 2.0

   t1 after the update -1.

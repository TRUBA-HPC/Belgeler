.. _thrust-vector-addition:

==============================
Thrust : Vektör Toplama İşlemi
==============================

.. code-block:: C++

    #include <thrust/device_vector.h>
    #include <thrust/copy.h>
    #include <iostream>
    int main(void)
    {
            size_t inputLength= 500;
            thrust::host_vector<float> hostInput1(inputLength);
            thrust::host_vector<float> hostInput2(inputLength);

            for(int i = 0; i<inputLength; i++)
            {
                    hostInput1[i] = 1;
                    hostInput2[i] = 1;
            }

            thrust::device_vector<float> deviceInput1(inputLength);
            thrust::device_vector<float> deviceInput2(inputLength);
            thrust::device_vector<float> deviceOutput(inputLength);

            thrust::copy(hostInput1.begin(), hostInput1.end(), deviceInput1.begin());
            thrust::copy(hostInput2.begin(), hostInput2.end(), deviceInput2.begin());
            thrust::transform(deviceInput1.begin(), deviceInput1.end(),
            deviceInput2.begin(), deviceOutput.begin(),thrust::plus<float>());

            thrust::copy(deviceOutput.begin(), deviceOutput.end(),
            std::ostream_iterator<int>(std::cout, "\n"));

            return 0;
    }

.. note:: 

    Yukarda görmüş olduğunuz örnek thrust kütüphanesi ile 500 elemanlı iki adet vektör toplama işlemi gerçekleşmektedir.


.. admonition:: Çıktı
   :class: dropdown, information

    .. code-block:: C++

        2
        2
        2
        2
        2
        .
        .
        .
        2


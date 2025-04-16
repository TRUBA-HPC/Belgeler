.. _openacc-vector-addition:


===============================
OpenACC : Vektör Toplama İşlemi
===============================

.. code-block:: C++

    #include <iostream>
    #include <string.h>

    int main(void)
    {
            int inputLength= 500;
                    
                    int* input1 = (int*)malloc(500*sizeof(int));
                    int* input2 = (int*)malloc(500*sizeof(int));
                    
                    int* output = (int*)malloc(500*sizeof(int));
                    memset(output, 0, sizeof(output));
                    
                    for(int i = 0; i<inputLength; i++)
            {
                input1[i] = 1;
                input2[i] = 1;
            }
                    
                    #pragma acc parallel loop 
                    copyin(input1[0:inputLength],input2[0:inputLength]),  
                    copyout(output[0:inputLength])
            for(i = 0; i < inputLength; ++i) 
                    {
                        output[i] = input1[i] + input2[i];
                    }
                    for(int i = 0; i<inputLength; i++)
                    {
                                    std::cout<<output<<std::endl;
                    }
            
            return 0;
    }

.. note:: 

    Yukarda görmüş olduğunuz örnek OpenACC kullanılarak gcc derleyici ile derlenmiştir. OpenACC ile 500 elemanlı iki adet vektör toplama işlemi gerçekleşmektedir.


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

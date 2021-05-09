.. _cuda-vector-addition:


===========================
CUDA: Vektör Toplama İşlemi
===========================

.. code-block:: C++

    #include <stdio.h>

    __global__ void sumVector(int *vec1, int* vec2, int* outVec, int size)
    {
        int index = threadIdx.x + blockIdx.x * blockDim.x;
        if(index < size)
        {
            outVec[index] = vec1[index] + vec2[index];
        }
    }


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
                    
        int *d_input1;
        int *d_input2;
        int *d_output;
            
        cudaMalloc(&d_input1, inputLength * sizeof(int));
        cudaMalloc(&d_input2, inputLength * sizeof(int));
        cudaMalloc(&d_output, inputLength * sizeof(int));
        
    
        cudaMemcpy(d_input1, input1,inputLength * sizeof(int), cudaMemcpyHostToDevice); 
            
        cudaMemcpy(d_input2, input2,inputLength *  sizeof(int), cudaMemcpyHostToDevice); 	
        sumVector<<<32,512>>>(d_input1,d_input2,d_output,inputLength); 
        cudaDeviceSynchronize();
        cudaMemcpy(output, d_output, inputLength * sizeof(int), cudaMemcpyDeviceToHost); 
        for(int i = 0; i<inputLength; i++)
        {
            printf("%d\n",output[i]);
        }
        cudaFree(d_input1);
        cudaFree(d_input2);
        cudaFree(d_output);
        return 0;
    }

.. note:: 

    Yukarda görmüş olduğunuz örnek CUDA kullanılarak nvcc derleyici ile derlenmiştir. CUDA ile 500 elemanlı iki adet vektör toplama işlemi gerçekleşmektedir.


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

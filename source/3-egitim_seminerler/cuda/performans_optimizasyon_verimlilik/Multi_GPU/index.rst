:orphan:

=====================
Multi-GPU Programlama
=====================

Bu bölümde birden fazla GPU kullanarak hesaplama kapasitesini artırma yöntemleri ele alınmaktadır.

Doküman
-------

Detaylı açıklamalar için aşağıdaki dökümanı inceleyebilirsiniz:

.. raw:: html

   <object data="../../../../cuda/pdf/Multi_GPU_Metin.pdf" type="application/pdf" width="100%" height="600px">
       <p>PDF görüntülenemiyor. <a href="../../../../cuda/pdf/Multi_GPU_Metin.pdf">Buradan indirebilirsiniz.</a></p>
   </object>

Örnek Kodlar
------------

Bu konuyla ilgili örnek kodlar:

* :download:`Multi-GPU Vektör Toplama (Basit) <Kod1_Vector_Addition_MultiGPU.cu>` - Temel multi-GPU vektör toplama
* :download:`Multi-GPU Vektör Toplama (Streams) <Kod2_Vector_Addition_MultiGPU_Streams.cu>` - CUDA Streams ile multi-GPU
* :download:`Multi-GPU Vektör Toplama (OpenMP) <Kod3_Vector_Addition_MultiGPU_OpenMP.cu>` - OpenMP ile multi-GPU

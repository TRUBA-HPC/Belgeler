:orphan:

============
CUDA Streams
============

Bu bölümde CUDA Streams konusu ele alınmaktadır. CUDA Streams, GPU üzerinde görev düzeyinde paralellik sağlayarak 
birden fazla işlemin eş zamanlı çalışmasını mümkün kılar.

Doküman
-------

CUDA Streams konusundaki detaylı açıklamalar için aşağıdaki dökümanı inceleyebilirsiniz:

.. raw:: html

   <object data="../../../../cuda/pdf/CUDA_Streams_Metin.pdf" type="application/pdf" width="100%" height="600px">
       <p>PDF görüntülenemiyor. <a href="../../../../cuda/pdf/CUDA_Streams_Metin.pdf">Buradan indirebilirsiniz.</a></p>
   </object>

Örnek Kodlar
------------

Bu konuyla ilgili örnek kodlar:

* :download:`Vektör Toplama (Basit) <Kod1_Vector_Addition.cu>` - Tek stream ile vektör toplama örneği
* :download:`Vektör Toplama (Streams) <Kod2_Vector_Addition_Streams.cu>` - Çoklu stream ile vektör toplama örneği

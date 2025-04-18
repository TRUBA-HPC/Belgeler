
.. _jupyter-araclari:

--------------------------
Jupyter Araçları 
--------------------------

Bu belgede sunulan bilgiler yalnızca web arayüzü sunucularında yürütülebilen interaktif çalışmalar içindir. Bu doğrultuda, yüksek performanslı hesaplama merkezinde interaktif işlemlerinizi gerçekleştirebilmeniz için :ref:`open_ondemand` web arayüzü hizmete sunulmuştur. İnteraktif arayüz ile ilgili bağlantı bilgilerine :ref:`arf-baglanti` sayfasından erişebilirsiniz. Web arayüzünde yer alan notebook kullanım özet bilgileri ise aşağıdaki gibidir:

1. Jupyter Notebook - XXX:   
    Buradan açılan jupyter notebook, yapay zeka alanında kullanılan temel olarak, ``XGBoost, TensorFlow, Keras, PyTorch, Scikit-learn, accelerate, deepspeed, transformers, ...`` paketlerin kurulumlarını içermektedir. Buradan açılmış bir jupyter notebook içerisinde açılan python ortamları aşağıdaki gibi olacaktır.

        .. tabs::

            .. tab:: Jupyter Notebook - CPU

                .. code-block:: bash

                    module purge
                    module load apps/truba-ai/cpu-2024.0
                    

            .. tab:: Jupyter Notebook - GPU

                .. code-block:: bash
            
                    module purge
                    module load apps/truba-ai/gpu-2024.0


2. Jupyter Notebook - Custom:   
    Bu araç, jupyter notebook isteğinizi, kullanıcı ev dizininde tanımlı özel jupyter ortamlarında başlatır. Kullanıcının ev dizinindeki ``.bashrc`` dosyasında, gerekli ortam yapılandırmaları :ref:`bashrc_ekleme` bölümünde belirtildiği şekilde yapılmış olmalıdır.

    Örneğin, miniconda3 modülü içinde bulunan jupyter kullanmak isteniyorsa, ``.bashrc`` dosyasına

    .. code-block::

        module load miniconda3

    komutunun eklenmesi durumunda jupyter notebook ilgili ortamda başlatılacaktır.


4. Jupyter Notebook - Container:   
    Bu araç, temel paketlerin bulunduğu ve Python, Julia ile R programlarının entegre edildiği bir konteyner ortamında jupyter notebook'unuzu başlatır.



5. Jupyter ile R kernel kullanma:
    Jupyter araçları sistemimizde var olan R modüllerini kullanarak kernel oluşturabilirsiniz. Bu sayede farklı kernel'lara bir notebook üzerinden geçiş yapabilirsiniz. 

    Öncelikle kullanilmak istenen sanal ortami aktif edelim:

    .. code-block:: bash

        module load miniconda3

    Sonra, istenilen R modülü çağrılır.

    .. code-block:: bash

        module load apps/R/4.3.0-gcc-11.3.1
        R

    R çalıştıktan sonra

    .. code-block:: r

        chooseCRANmirror(ind=69)
        install.packages('remotes')
        remotes::install_github('IRkernel/IRkernel')
        library(IRkernel)
        IRkernel::installspec()

    yazılarak Jupyter araçlarının R kernel'ı görmesi sağlanır. Jupyter Notebook - Custom kullanilarak OnDemand uzerinden jupyter araçlarına bağlandıktan sonra Kernel menüsünden geçiş yapabilirsiniz.
.. _arf-python:

===============================
ARF Kümesinde Python Kullanımı
===============================

Bu belge ARF kumelerinde `Python <https://www.python.org/>`_ platformunun kullanımını kolaylaştırmak için oluşturulmuştur.

Sistemde kullanılabilecek conda ve standart ortam olmak iki farklı python platformu bulunmaktadır. Conda platfomu içerisinde ise standart ve intel optimize edilmiş python olmak üzere iki farklı kullanım mevcuttur.

- Standart Python

    .. code-block:: 

        module load comp/python/3.12.2
    ile yuklemeler yapilabiblir. Bu python kullanılarak bir sanal ortam oluşturulması ve o ortam içerisine ihtiyaç duyulan paketlerin oluşturulan sanal ortama kurulması önerilmektedir. Bu süreç şu şekilde tamamlanabilir:

    - Sanal ortam oluşturma : ``virtualenv /arf/home/$USER/python-3.12``
    - Sanal ortamı aktif etme : ``source /arf/home/$USER/python3.12/bin/activate``
    - Python ve pip kontrol etme: ``which python && which pip``
    - pip güncelleme: ``pip install --upgrade pip``
    - Paket yükleme ``python -m pip install paket-ismi`` 

- Conda ortamında bulunan Python

    - Standart python için

        .. code-block:: bash

            module load miniconda3

    - Intel optimize python için

        .. code-block:: bash

            module load miniconda-intelpython3

    ile yüklemeler yapılabiblir ve ``conda info`` ile conda platformunu ayarlamalarını  ve ``conda list`` ile içerisinde varsayılan olarak sunulan paketleri görüntüleyebilirsiniz. İhtiyaç halinde 

    - Ortam oluşturma: ``conda create -n custom-env``
    - Ortamı aktif etme: ``conda activate custom-env``
    - İstenilen python versiyonu kurma: ``conda install python=<version>``




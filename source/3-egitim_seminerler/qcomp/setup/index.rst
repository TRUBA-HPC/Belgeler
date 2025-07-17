.. _qcomp_setup:


===============================
Qiskit ve PennyLane Kurulumları
===============================

.. warning::
    Belgenin geri kalanında ev dizinine Miniconda kurulumunun yapılmış olduğu kabul edilmektedir. Ev dizininizde Miniconda kurulu değilse kurulumu :ref:`Python Kılavuzu'nu <python-kilavuzu>` takip ederek yapabilirsiniz.


--------------------------
Qiskit Kurulumu
--------------------------

Mevcut shell oturumunuzda conda’nın temel ortamını etkinleştirin:

.. code-block:: bash
    
    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"

Conda kullanarak sanal ortam yaratın ve yarattığınız ortamı aktifleştirin.

.. code-block:: bash
    
    conda create --name qcomp-env
    conda activate qcomp-env
    conda list

.. note::
    İstediğiniz zaman sanal ortamı kaldırıp baştan başlayabilirsiniz:

    .. code-block:: bash

        conda deactivate
        conda remove -n qcomp --all
        conda create --name qcomp-env
        conda activate qcomp-env

Python ve GPU'da çalıştırmak için gereken paketleri kurun.

.. code-block:: bash

    conda install python=3.8
    conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0


Qiskit paketlerini kurun.

.. code-block:: bash

    pip install qiskit
    pip install qiskit-aer-gpu

.. note::
    ``Qiskit machine learning`` gibi ekstra Qiskit kütüphanelerini kurmak için `Qiskit'in Dokümantasyonuna <https://qiskit.org/documentation/>`_ bakabilirsiniz.


----------------------------------------------
PennyLane Kurulumu
----------------------------------------------

Aynı virtual environment aktifken yine benzer şekilde PennyLane paketini kurun.

.. code-block:: bash

     pip install pennylane --upgrade

PennyLane'e Qiskit eklentisini kurarak Qiskit içinde bulunan cihazları PennyLane içinde de kullanabilirsiniz. Bunun için aşağıdaki paketini kurun.

.. code-block:: bash

    pip install pennylane-qiskit


.. note::

    Kurulum ve kullanım hakkında daha fazla bilgi için dokümantasyon `dokümantasyon <https://pennylane.ai/>`_ sayfasına bakabilirsiniz.




----------------------------------------------
SLURM Betik Dosyası ile Kuyruğa İş Gönderme
----------------------------------------------

Örnek kod hazırlayın: ``install_debug.py``

.. code-block:: python

    import qiskit
    import pennylane as qml

    print("Qiskit version:", qiskit.__version__)
    dev = qml.device('qiskit.aer', wires=2)
    print(dev)

    # Kuantum devresini oluşturma
    circ = qiskit.QuantumCircuit(2)
    circ.h(0)
    circ.cx(0, 1)
    circ.measure_all()

    # GPU'da çalışacak simülatorü ayarlama
    simulator = qiskit.Aer.get_backend('aer_simulator')
    simulator.set_options(device='GPU')
    circ = qiskit.transpile(circ, simulator)

    # Simulasyonu çalıştırma    
    result = simulator.run(circ).result()
    print(result)

Qiskit ve PennyLane'in doğru çalıştığından emin olmak için çıktının aşağıdaki gibi olduğundan emin olun.

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: python

        Qiskit version: 0.21.0
        Qiskit PennyLane plugin
        Short name: qiskit.aer
        Package: pennylane_qiskit
        Plugin version: 0.24.0
        Author: Xanadu
        Wires: 2
        Shots: 1024
   
Eğer bir CUDA cihazı göremiyorsa yukarıdaki çıktıya ek olarak sistem aşağıdaki gibi hata verecektir. GPU'da çalıştırmak istediğiniz kodlarda bu hatanın olmadığından emin olun. 

.. admonition:: Çıktı
   :class: dropdown, information

   .. code-block:: console

        WARNING:qiskit.providers.aer.backends.aerbackend:Simulation failed and returned the following error message:
        ERROR: Failed to load qobj: No CUDA device available!


Kuyruğa iş göndermek için bir `slurm betiği <https://slurm.schedmd.com/sbatch.html>`_ hazırlayın: ``submit-install_debug-job.sh``

.. code-block:: bash

    #!/bin/bash
    #SBATCH -p debug              # Kuyruk adi: Bu gibi deneme kodlari için debug kuyrugunu kullaniyoruz 
    #SBATCH -C akya-cuda          # Kisitlama: GPU bulunan bir sunucuyu  verdiğinizden emin olun.
    #SBATCH -A [USERNAME]         # Kullanici adi
    #SBATCH -J install_debug      # Gonderilen isin ismi
    #SBATCH -o install_debug.out  # Ciktinin yazilacagi dosya adi
    #SBATCH --gres=gpu:1          # Her bir sunucuda kac GPU istiyorsunuz? Kumeleri kontrol edin.
    #SBATCH -N 1                  # Gorev kac node'da calisacak?
    #SBATCH -n 1                  # Ayni gorevden kac adet calistirilacak?
    #SBATCH --cpus-per-task 10    # Her bir gorev kac cekirdek kullanacak? Kumeleri kontrol edin.
    #SBATCH --time=0:15 :00       # Sure siniri koyun.
    #SBATCH --error=slurm-%j.err  # Hata dosyası

    eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
    conda activate qcomp-env
    python install_debug.py

.. note::
    Betikteki ``[USERNAME]`` yertutucusunu kullanıcı adınızla değiştirmeyi unutmayın.

İşi kuyruğa gönderin.

.. code-block:: bash

    sbatch submit-install_debug-job.sh

Gönderdiğiniz işin durumunu kontrol edin.

.. code-block:: bash

    squeue

İş bittikten sonra terminal çıktısını görüntüleyin.

.. code-block:: bash

    cat install_debug.out
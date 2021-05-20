
=============================
Installation
=============================

Local installation
------------------

PyTorch is available for Windows, Linux, and macOS. It can be installed using package managers like ``Conda`` and ``Pip`` or it can be compiled directly from the source. The appropriate installation steps depend on the system, preferred installation method, available CUDA version, and programming language. The steps for each combination can be accessed on the website under the following link: `https://pytorch.org/get-started/locally/ <https://pytorch.org/get-started/locally/>`_

On this link, the following options can be found:


.. image:: res/installation_options.png
   :target: res/installation_options.png
   :alt: res/installation_options.png


The first five columns are for the user to select the installation configuration, and the final column shows the command to be called to install the package. In this example above, we are installing PyTorch on a Linux system with no GPU support. We are using Conda and we want to install the Python interface. To do so, we open a terminal and execute the following command

.. code-block:: bash

   conda install pytorch torchvision torchaudio cpuonly -c pytorch

TRUBA installation
------------------

We recommend installing PyTorch on TRUBA through the Conda virtual environment interface. It allows creating very customizable and easily modifiable Python environments.

Installing Conda
^^^^^^^^^^^^^^^^


#. On the following webpage: `https://www.anaconda.com/products/individual <https://www.anaconda.com/products/individual>`_ go to the bottom of the page to the "Anaconda Installers" section and copy the link for the "64-Bit (x86) Installer".
#. On TRUBA, download the installer script using the ``wget`` command using the link copied above

   .. code-block:: bash

       wget https://repo.anaconda.com/archive/Anaconda3-<your_version>

#. After the script is downloaded successfully, run it using the ``bash`` command:

   .. code-block:: bash

       bash Anaconda3-<your_version>

#. Follow the instructions of the script to complete the installation.

#. You will need to disconnect and reconnect for the installation to take effect.

Installing PyTorch
^^^^^^^^^^^^^^^^^^


#. 
   (optional) create a new Conda environment


   #. 
      Execute the following command to create the environment

      .. code-block:: bash

          conda create --name pyt_env

   #. 
      Once the environment is created, activate it with the following command

      .. code-block:: bash

          conda activate pyt_env

#. 
   From the website, use the appropriate command for installing PyTorch using Conda. At the time of writing this tutorial, this was the command to install the CPU version:

   .. code-block:: bash

       conda install pytorch torchvision torchaudio cpuonly -c pytorch

Using PyTorch
^^^^^^^^^^^^^

If you installed PyTorch on TRUBA using Conda, then you must initialize Conda and load the environment on which PyTorch is installed at the beginning of your SLURM scripts. For example, this SLURM script will run the python script ``pyt_example.py`` that uses PyTorch:

.. code-block:: bash

   #!/bin/bash
   #SBATCH --account=<account>
   #SBATCH --job-name=pyt_ex
   #SBATCH --ntasks=1
   #SBATCH --time=1-00:00:00
                                                                                                                                                                                                                                                                                                                                                                   # Setup environment
   module purge
   bash
   source /truba/home/<user_name>/anaconda3/bin/activate
   conda init
   conda activate pyt_env

   python pyt_example.py

This assumes that Conda was installed in the default location, and that the environment on which PyTorch is installed is named ``pyt_env``.

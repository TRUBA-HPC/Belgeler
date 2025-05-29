Quantum ESPRESSO Kurulumu
================================


## Barbun Hesaplama Kümesi'nde Kurulum

Quantum Espresso programını derlemek için bir klasör oluşturup ilgili klasöre gidiniz. Kullanmak istediğiniz versiyon için kurulum dosyalarını `QE GitHub sayfasından <https://github.com/QEF/q-e/releases>`\_ edinebilirsiniz ve bulunduğunuz dizine `wget` komutu ile indirebilirsiniz. Aşağıdaki komut bloğundan QE6.7 versiyonu için olan link belirtilmiştir.

.. code-block:: bash

```
mkdir espresso
cd espresso
wget https://github.com/QEF/q-e/archive/refs/tags/qe-6.7.0.tar.gz
```

Sıkıştırılmış arşiv dosyalarını açınız ve kurulum dosyalarının olduğu ilgili klasöre gidiniz.

.. code-block:: bash

```
tar -xzvf qe-6.7.0.tar.gz
cd q-e-qe-6.7.0
```

Kurulumu `barbun` kuyruğu için optimize bir şekilde kurmak istiyorsanız öncelikle `srun` komutu ile `barbun` kuyruğundaki 1 tane makineden 4 tane CPU'yu interaktif olarak ayırabilirsiniz:

.. code-block:: bash

srun -N 1 -A kullaniciadi -p barbun --ntasks-per-node=4 --time=01:00:00 --job-name "qe-install" --pty bash -i

.. note::

   Kurulum süre sini \:ref:`partitions` sayfasından değiştirebilirsiniz.

Kurulu modül bilgilerine

.. code-block:: bash

   module available

komutu ile ulaşabilirsiniz. Tanımlı modülleri

.. code-block:: bash

   module list

ile görebilir, çakışma olmaması için öncelikle

.. code-block:: bash

   module purge

komutunu kullanabilirsiniz.


.. code-block:: bash

   make all
   make install

.. note ::

   Belirli executable'lar için `make pw` gibi komutlar kullanabilirsiniz.

.. code-block:: bash

   mv bin bin-barbun-impi-oneapi21

## Open MPI ile Kurulum

.. code-block:: bash

   module purge
   module load lib/openmpi/4.1.7

.. code-block:: bash

   FLAGS="-xHost"; CFLAGS=\$FLAGS CXXFLAGS=\$FLAGS MPIF90=mpif90 CC=mpicc CXX=mpic++&#x20;
   ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

.. code-block:: bash

   make all
   make install

.. code-block:: bash

   mv bin bin-barbun-openmpi4-oneapi21

---

## Hamsi Hesaplama Kümesi'nde Kurulum

.. code-block:: bash

   ```
   mkdir espresso
   cd espresso
   wget https://github.com/QEF/q-e/archive/refs/tags/qe-6.7.0.tar.gz
   ```

.. code-block:: bash

   ```
   tar -xzvf qe-6.7.0.tar.gz
   cd q-e-qe-6.7.0
   ```

.. code-block:: bash

   srun -N 1 -A kullaniciadi -p hamsi --ntasks-per-node=28 --time=01:00:00 --job-name "qe-install" --pty bash -i

.. code-block:: bash

   module available
   module list

.. code-block:: bash

   FLAGS="-xHost"; CFLAGS=\$FLAGS CXXFLAGS=\$FLAGS MPIF90=mpif90 CC=mpicc CXX=mpic++&#x20;
   ./configure --prefix=/truba/home/username/espresso/q-e-qe-6.7.0 --enable-shared=no

.. code-block:: bash

   make all
   make install


   



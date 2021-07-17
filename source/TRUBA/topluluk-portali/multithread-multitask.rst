.. _multithread-multitask:

==========================================================
Multithread/multitask Uygulamaların Çalıştırılması
==========================================================


OpenMP yad pthread tarzı sadece node içi paralelleştirme kullanan uygulamaları sbatch yada srun ile çalıştırırken dikkat edilmesi gereken bazı husular bulunmaktadır.

Sbatch ile çalışırken:
-----------------------

**-N 1 :** en fazla 1 node kullanılmalı

**-n 5 (yada -c 5) :** iş tanımı için en az - en fazla 5 çekirdek ayrılır.. Sbatch herhangi bir görev çalıştırmadığı için -n paramerresi de sorun oluşturmayacaktır. Ancak doğru olan -c 'yi kullanmaktır...

**export OMP_NUM_THREADS=5 :** uygulama kendisi için 5 çekirdeğe kadar izin verildiğinden haberdar edilir. Bazı uygulamalar izin verilen çekirdek sayısını otomatik olarak farkedebilir. Ancak genel olarak bunu yazmaya ihtiyaç vardır.

`SLURM Betik Özellikleri hakkında ayrıntılı bilgiye ulaşmak için tıklayınız <slurm-betik>`_.

srun ile çalışırken:
-------------------------

**-N 1 :** en fazla 1 node kullanılmalıdır.

**-n 1 :** 1 task/görev başlatılacaktır.

**-c 5:** görev başına 5 çekirdeğe izin verilecektir.

Uygulama kaç çekirdek kullanabilecegini otomatik alğılayabilmeli ya da, ``export OMP_NUM_THREADS=5`` komutu, ``srun`` komutundan önce çalıştırılmalıdır.

.. note::

    -n değeri 1 den fazla olursa, örneğin 2, komutun iki kopyası birbirinden bağımsız olarak çalıştırılacaktır.




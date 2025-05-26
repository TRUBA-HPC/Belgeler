.. _slurm-betik:

==========================================
Örnek SLURM Betik Dosyaları
==========================================

Her kullanıcının  kullandığı uygulamanın yeri, özellikleri, versiyonu, ihtiyaç duyduğu kaynak türü ve miktarı, derlendiği ortam ve kütüphanelere göre, kullanılabilecek betik dosyaları farklılıklar gösterebilir. TRUBA ekibi tarafından, tüm kullanıcıların kullanımı için standart özelliklerle derlenen uygulamaların pek çoğu için örnek betik dosyaları hazırlanarak, kullanıcıların kullanımına sunulmuştur. Örnek betik dosyalarına ``/truba/sw/scripts`` dizininden ulaşılabilir. Kullanıcıların buradaki betik dosyalarını kullanabilmeleri için, onları scratch'deki kendi dizinlerine kopyalamaları ve betik dosyalarında verilmiş tanımları kendi hesaplarının özelliklerine göre  değiştirmesi gerekmektedir.


İlgili dizinde uygulamanın test amaçlı çalıştırılan örnek input dosyaları bulunduğu için,
betik dosyaları içinde bulundukları dizinle birlikte kopyalamak daha faydalı olabilir.

Aşağıda Quantum Espresso programı için hazırlanan örnek betik dosyası komutların yanlarında açıklamaları ile birlikte örnek olarak verilmiştir.

.. code-block:: bash

   #!/bin/bash
   #SBATCH -p orfoz
   #SBATCH -J qe_test
   #SBATCH -N 1
   #SBATCH -n 110
   #SBATCH -c 1
   #SBATCH -C weka
   #SBATCH --time=3-00:00:00

   export OMP_NUM_THREADS=1


   echo "SLURM_NODELIST $SLURM_NODELIST"
   echo "NUMBER OF CORES $SLURM_NTASKS"

   module purge

   #source /arf/sw/comp/oneapi/2023.0/setvars.sh
   module load comp/oneapi/2023  
   module load lib/hdf5/1.14.3-oneapi-2023.0

   module load apps/espresso/7.2-oneapi-2023.0

   mpirun pw.x < in.Si > Si.out

   exit

Farklı disiplinler için gereken birçok kütüphanenin örnek SLURM scriptlerine `/arf/sw/scripts` dizininden erişebilirsiniz.

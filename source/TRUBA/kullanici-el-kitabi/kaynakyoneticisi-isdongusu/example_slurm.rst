.. _example_slurm:

==========================================
Örnek SLURM Betik Dosyaları
==========================================

Her kullanıcının  kullandığı uygulamanın yeri, özellikleri, versiyonu, ihtiyaç duyduğu kaynak türü ve miktarı, derlendiği ortam ve kütüphanelere göre, kullanılabilecek betik dosyaları farklılıklar gösterebilir. TRUBA ekibi tarafından, tüm kullanıcıların kullanımı için standart özelliklerle derlenen uygulamaların pek çoğu için örnek betik dosyaları hazırlanarak, kullanıcıların kullanımına sunulmuştur. Örnek betik dosyalarına ``/truba/sw/scripts`` dizininden ulaşılabilir. Kullanıcıların buradaki betik dosyalarını kullanabilmeleri için, onları scratch'deki kendi dizinlerine kopyalamaları ve betik dosyalarında verilmiş tanımları kendi hesaplarının özelliklerine göre  değiştirmesi gerekmektedir.


İlgili dizinde uygulamanın test amaçlı çalıştırılan örnek input dosyaları bulunduğu için,
betik dosyaları içinde bulundukları dizinle birlikte kopyalamak daha faydalı olabilir.

Aşağıda Quantum Espresso programı için hazırlanan örnek betik dosyası komutların yanlarında açıklamaları ile birlikte örnek olarak verilmiştir.

.. code-block:: bash

   #!/bin/bash
   #SBATCH -p barbun # isin gönderileceği node grubu
   #SBATCH -A mdemirtas #kullanilacak kredi hesabının adı. Siz de kendi hesabınızın ismini yazmalısınız.
   #SBATCH -J silicon_surf # işin kurukta gösterilecek adı. 
   #SBATCH -N 1  #Hesaplama sırasında, kullanılacak çekirdeklerin kaç farklı node tarafından sağlanacağını belirler. 
   #SBATCH -n 20 #Görev sayısı (mpi işleri için, uygulamanın çalıştırılacağı kopya sayısı). 
   #SBATCH --time=02-00:00 #Hesabın 2 gün süreceğini belirler.
   #SBATCH --output=slurm-%j.out #Uygulamanın üreteceği outputtan farklı olarak, işin hangi node grubunda, kaç çekirdekle çalıştığını özetleyen text dosyasıdır. 
   #SBATCH --error=slurm-%j.err  # Uygulama çalışması sırasında olası hataların yazılacağı dosyadır. 

   export OMP_NUM_THREADS=1 #SBATCH -N 1 buradaki verilen sayıyla aynı olmalıdır.
   module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5  #Uygulama derlenirken kullanılan module olduğu için yazılması gerekir. Siz de programlarınızı derlediğiniz modulleri eklemeyi unutmayınız. 

   echo "SLURM_NODELIST $SLURM_NODELIST"
   echo "NUMBER OF CORES $SLURM_NTASKS"

   wdir=/truba_scratch/mdemirtas/si_surface   #Uygulama için çalıştırılacak dosyaların adresleri. 
   cd $wdir

   infile=$wdir/in.si #Uygulamanın çalışması için gerekli input ve output dosyaların adları. 
   outfile=$wdir/out.si
   

   ESPRESSO_DIR=/truba/home/mdemirtas/q-e-qe-6.5MaX  #Uygulamanın bulunduğu adres
   mpirun $ESPRESSO_DIR/bin/pw.x <$infile> $outfile  #Uygulamanın çalışması için tanımlı kod.

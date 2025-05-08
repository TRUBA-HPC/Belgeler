.. _slurm-betik:

==========================================
 SLURM Betik Özellikleri
==========================================


Kabuk programlamadan bağımsız olarak, herhangi bir SLURM betik temel olarak üç ana bölümden oluşur. Başlangıç (parametreler, tanımlar), gövde ve iş başlatma/çıkış bölümleri.


1- Başlangıç Bölümü
-------------------
Bu bölüm, hesaplama sırasında kullanılacak hesabın adı  ve işin çalışacağı yer, zaman sınırı, çekirdek ve node sayısı gibi temel özellikleri içerir. Her tanım satırı **#SBATCH** ile başlamalıdır. Bu bölümde işin akışını belirleyecek pek çok tanım yapılabileceği gibi, temel birkaç tanımın yapılması işin çalışması için yeterlidir.
Bu tanımların bir kısmı betik dosyasının içerisinde yapılabileceği gibi, bir kısmı **sbatch** komutu ile dosya kuyruğa gönderilirken komutun yanına parametre olarak da eklenerek kullanılabilir. Örnegin: 

.. code-block:: bash

   sbatch -N 4 -n 16 iş_dosyasının_adı

Aşağıda Slurm betik için verilen komutların ne oldukları verilmiştir. Siz de aşağıdaki komutları kullanarak kendi betiğinizi oluşturabilirsiniz.

.. warning:: **#!/bin/bash**  Betiği yorumlayacak kısımdır (interpreter). Sayfanın başında bu şekilde kalması gerekir.

**#SBATCH -p** = İşin çalıştırılacağı kuyruk adını tanımlar (partition).

**#SBATCH -A** = İş için kullanılacak TRUBA hesap ismi. Grup halinde yapılan çalışmalarda kullanıcı adından farklı olabilir. ARDEB kanalı ile açılan TBAG proje hesaplarına ayrıcalıklı olarak iş göndermek için, bu kısma ilgili (ve kullanıcı hesabınız için izin verilen) ``tbag`` hesabının yazılması gerekir.

**#SBATCH -J** = İşin kuyrukta görülecek adı.

**#SBATCH -n** = Görev sayısı (mpi işleri için, uygulamanın çalıştırılacağı kopya sayısı). Normalde sbatch herhangi bir görev çalıştırmaz. İş, çalışacağı sunucuya düşer ve master nodda çalışmaya başladığında, betik linux komut satırından çalıştırılmış gibi davranır. Betikte işin çalıştırılacağı komut satırında özel bir durum belirtilmemişse işin tek kopyası çalıştırılır. Ancak satırda **mpirun** ya da **mpiexec** komutları kullanılmışsa, ilgili uygulamanın -n kopyası çalıştırılır.

**#SBATCH -c** = Her bir görev için kullanılabilecek en fazla çekirdek sayısını belirtir (cores per task). Varsayılan değeri 1'dir. Eğer hibrit işler (mpi+openmp) ya da multitask (openmp sadece) çalıştırılacaksa, bu parametrenin kullanılması gerekir. Değeri ``OMP_NUM_THREADS`` değişkeninin değeri ile aynı olacak şekilde seçilmelidir. Değeri bir sunucudaki çekirdek sayısından fazla olamaz. Eğer aynı sunucusu üzerinden 1'den fazla task (n) çalıştırılacaksa, **sunucu başına düşen görev sayısı x görev başına düşen çekirdek miktarı** en fazla ilgili sunucudaki çekirdek sayısı kadar olabilir. Örneğin 28 çekirdekli 2 adet sunucunun tamamı  kullanılarak iş gönderilecekse, 8 processli (task) bir MPI+openmp hibrid iş çalıştırılacaksa, process başına en fazla 7 çekirdek kullanılabilir. (sunucu başına 4 process düşer, sunucuda toplam 28 çekirdek varsa, her bir process için en fazla 7 çekirdek kullanılabilir)

**#SBATCH –threads** = İşlemcilerin hyperthreading özelliklerini kullanmak için tanımlanır. Mevcut işlemcilerde çekirdek başına 2 thread düşmektedir. Örnegin 28 çekirdekli bir sunucuda, bir openmp işini 56 thread ile (OMP_NUM_THREADS=56) çalıştırabilmek için aşağıdaki komut satırı kullanılabilir. 

.. code-block:: bash

   -N 1 -n1 -c28 --threads=2 

**#SBATCH --mem=** Bu parametre ile iş için en fazla ne kadar bellek kullanılacağı betimlenir. Kullanımı zorunlu değildir. Eğer bu parametre kullanılmazsa, her bir çekirdek için **DefMemPerCore** kadar bellek ayrılır. Daha fazla belleğe ihtiyaç duyulması durumunda, bu parametre ile ihtiyaç duyulan bellek miktarı arttırılabilir. Ancak bu değer en fazla **çekirdek sayısı x MaxMemPerCore** kadar arttırılabilir.

**#SBATCH --mem-per-core=** Bu parametre ile her bir çekirdek için ihtiyaç duyulan bellek miktarı belirtilir. Kullanımı zorunlu değildir. Eğer bu parametre kullanılmazsa, her bir çekirdek için **DefMemPerCore** kadar bellek ayrılır. Daha fazla belleğe ihtiyaç duyulması durumunda, bu parametre ile ihtiyaç duyulan bellek miktarı arttırılabilir. Ancak bu değer en fazla **MaxMemPerCore** kadar olabilir.

**#SBATCH –time=** İşin toplam çalışma süresini gösterir. Bu süre zarfında tamamlanmamış olan işler, zaman dolduğunda otomatik olarak ölürler. Burada verilecek değer ilgili kümenin sınırından yüksek olamaz. 

.. warning:: 

   Herhangi bir değer verilmeden gönderilen işler, çalışmaya başladıktan bir dakika sonra sistem tarafından otomatik olarak sonlandırılırlar. 

**#SBATCH –no-requeue=** İş çalışırken bazı durumlarda, hesaplama sunucusundan kaynaklı sebeplerle, iş hata alarak sonlanabilir. Bu durumda iş kuyruğa otomatik olarak yeniden gönderilebilir. İşin kuyruğa yeniden gönderilmesi genelde faydalı bir özelliktir. Ancak eğer iş kaldığı yerden devam edecek şekilde yapılandırılmamışsa ya da kullanılan uygulamanın böyle bir özelliği yoksa hatta o ana kadar üretilen tüm verilerin üzerine yeni verilerin yazılma ihtimali varsa, bu opsiyonu kullanmak yerine işi yeniden kuyruğa göndermek daha mantıklı bir çözümdür.

**#SBATCH –output=** İş çalışırken, kullandığınız uygulamanın sonuçları için ya da betiğinizde kullandığınız bash programı öğelerinin ekrana basılacağı (STDOUT) bilgilerin yazılacağı dosyanın tam adresini ve adını verdiğiniz komuttur. Bu adresin scratch dizinde olması zorunludur.

**#SBATCH –error=** İş çalışırken, kullandığınız uygulama ile ilgili hataların ya da betiğinizde kullandığınız bash programla öğelerinin ekrana basılacağı hata mesajlarının (STDERR) yazılacağı dosyanın tam adresi ve adını tanımlamak için kullanılan komuttur. Bu adresin scratch dizinde olması zorunludur.

.. warning:: 

   Eğer ``--error`` ve ``--output`` parametrelerini  belirtilmezseniz, tüm ekran çıktısı otomatik olarak **slurm-JOBID.out** dosyasına yazdırılır.

**#SBATCH -N=** Hesaplama sırasında, kullanılacak çekirdeklerin kaç farklı node tarafından sağlanacağını belirler. Herhangi bir tanım girilmemişse, çekirdekler rastgele sayıda nodelardan rastgele sayıda sağlanırlar. Node sayısı için herhangi bir tanımlama yapmamak işlerin mümkün olan en hızlı şekilde başlamasını sağlar. Ancak performans testlerinden alınacak sonuç, her iş için farklı olabilir. Eğer talep edilen çekirdeklerin nodelar tarafından eşit sayıda sağlanması istenmiyorsa, **-N** parametresi yerine **--ntasks-per-node** ve **-N** parametreleri birlikte kullanılmalıdır. Örneğin işiniz için toplamda 16 çekirdeğin 4 sunucu tarafından eşit sayıda sağlanmasını istiyorsanız betiğinize aşağıdakileri eklemelisiniz.

.. code-block::

   #SBATCH -N 4
   #SBATCH --ntasks-per-node=4

.. warning:: 

   ``--ntasks-per-node`` parametresi openmpi-1.6.5 sürümü ile düzgün çalışmamaktadır. O nedenle eşit çekirdek sayısının elzem olduğu durumlarda en az openmpi-1.8.8 sürümü kullanılmalıdır. Bu parametre impi ve diğer mpi sürümleri ile kontrol edilmemiştir.

**#SBATCH -M=** Birden fazla hesaplama kümesinde tek bir arayüz üzerinden hizmet verildiği durumlarda, işin gideceği kümeyi belirtir. TRUBA'da şu an için farklı hesaplama kümeleri farklı kullanıcı arayüzlerinden hizmet vermektedirler.


**#SBATCH –workdir=** İşin başlayıp, output, error dosyalarının yazılacağı dizinin adresidir. Scratch dizini işaret ediyor olması zorunludur. Eğer herhangi bir tanımlama yapılmaz ise, iş gönderdiğiniz dizin **workdir** dizini olarak kabul edilir.

**#SBATCH –gres=** Ekstra özelliklerin sunulduğu kuyruklarda bu ekstra özelliklerin ne kadarının kullanılacağını belirtir. Cuda kuyruğundaki GPU kartlarını kullanabilmek için bu tanımın yapılması gerekir. Örnegin:

.. warning:: 

   #SBATCH –gres=gpu:1

**#SBATCH –mail-type=** İş kuyruğa gönderildikten sonra, iş ile ilgili ne tür e-postaların gönderileceğini tanımlar. BEGIN, END, FAIL, REQUEUE, ALL değerlerini alabilir. Herhangi bir tanım yapılmaz ise kullanıcı e-posta ile bilgilendirilmez.

**#SBATCH –mail-user=** Yukarıda tanımlanan durumlar için  e-postanın gönderileceği adresi tanımlar.

2- Gövde
--------
Her program ve kullanıcı için gövde kısmı farklı olabilir. Bu kısımda işi çalıştırmadan önce yapılması gereken ön çalışma yapılır; load edilmesi gereken kütüphaneler, varsa çevre değişkenler vs. yüklenir. Kabuk dili öğeleri kullanılarak ön kontroller yapılarak gerekli dosyaların varlığı, içeriği vs. kontrol edilebilir. Bu kısım kullanıcının deneyimine ve ihtiyaçlarına göre şekillenir. Ancak standart olarak iş ile ilgili temel bilgilerin STDOUT'a yazılması daha sonra işi analiz ya da debug etmek için faydalı olabilir. Aşağıdaki kısımda örnek olarak herhangi bir LAMMPS işini çalıştırmak için ihtiyaç duyulan kütüphaneler load edilerek çevre değişkenleri ayarlanıyor.

.. code-block:: bash

   export OMP_NUM_THREADS=1


   echo "SLURM_NODELIST $SLURM_NODELIST"
   echo "NUMBER OF CORES $SLURM_NTASKS"

   module purge

   module load apps/lammps/29Aug2024_stable_oneapi-2024

3- İşin Başlaması ve Bitişi
---------------------------
Gövde kısmında programın çalıştırılması için gerekli kütüphaneler, çevre değişkenleri load edildikten ve gerekli kontroller yapıldıktan sonra, iş çalıştırılması için gerekli komutlar girilir. İş çalıştırma satırı, normalde işi komut satırından elle çalıştırırken kullanılan komut satırı ile aynıdır. Herhangi bir LAMMPS işi işin bu satır aşağıdaki gibi olmalıdır.

.. code-block:: bash
   
   $LAMMPS_DIR/lmp  < in.lammpsinputfile > lammps-outputfile.out
   exit

MPI işler için SLURM'un sağladığı bazı esneklikler ve kullanım kuralları vardır. Hesaplama sırasında kullanılacak çekirdek sayısı ve host bilgisi yazılmasına OpenMPI gibi uygulamalar için (ve diğer bazı MPI kütüphanelerinde) gerek yoktur. Bu bilgi mpirun komutuna doğrudan kaynak yöneticisi tarafından sağlanır. Verilen örnekte komut satırından bir MPI işini 4 çekirdek ile çalıştırmak için normalde aşağıdaki komut satırı yazılması gerekirken

.. code-block:: bash

   mpirun -np 4 –machinefile=hosts_dosyasi <uygulamanin_tam_adresi_ve_adi>
   exit
    
SLURM betik için aşağıdaki satır kullanılmalıdır.    

.. code-block:: bash
    
    mpirun <uygulamanın_tam_adresi_ve_adı>
    exit

Eğer işin o ana kadar kullanmış olduğu sistem kaynakları (bellek, walltime, runtime, disk vb.) hakkında detaylı bilgi almak isterseniz ``exit`` satırından önce aşağıdaki komutu girebilirsiniz.

.. code-block:: bash

     sstat -j $SLURM_JOB_ID


   



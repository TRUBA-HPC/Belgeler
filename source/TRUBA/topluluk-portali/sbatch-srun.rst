.. _sbatch-srun:

=======================================
 Sbatch ve Srun Arasındaki Farklar
=======================================

Temelde iki komut da görevleri (task) hesap sunucuları üzerinde çalıştırmak için kullanılmaktadır. Ancak çalışma biçimi açısından aralarında ciddi farklar bulunmaktadır.

* `srun` interaktif bir çalışma imkanı sunarken, `sbatch`, işin bir betik ile kuyruğa gönderilmesini gerektirir.

* `srun` komutu verilen uygulamanın -n kadar kopyasını çalıştır. Örnegin `srun -n 10 hostname` komutu ile hostname uygulaması 10 ayrı çekirdekte birbirinden bagımsız, 10 ayrı görev olarak çalıştırılır.

* `sbatch` komutu herhangi bir görev çalıştırmaz. Betik dosyasında verilen komutlar sadece master çekirdek üzerinde çalışır. Örnegin betik dosyasında hostname komutu yer alıyorsa, bu komut sadece master çekirdekte çalıştırılacak olup, sadece master çekirdegin bulunduğu sunucunun adını verecektir. Komutu tüm çekirdeklere yaymak için betik dosyasında `srun hostname` komutunu kullanmak gerekecektir. Ancak betik dosyasında uygulama(görev, task) `mpirun` ya da `mpiexec` ile çalıştırılıyorsa uygulamanın -n kadar kopyası çalıştırılır. Eğer uygulama bir mpi işi ise, aynı mpirun komutu ile çalıştırılmış kopyalar birbirleri ile haberleşerek, ortak bir iş üzerinde çalışabilir. 

:ref:`Kaynak Yöneticisi ve İş Döngüsü hakkında bilgiye ulaşmak için tıklayınız. <kaynakyoneticisi>` 

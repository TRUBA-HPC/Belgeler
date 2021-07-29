.. _hibrid-mpi-openmp:

======================================================
Hibrid (MPI+OpenMP) uygulamaların çalıştırılması
======================================================

Genel olarak tersi olsa da, iyi tasarlanmış hibrid uygulamaların (örnegin Intel MKL ile birlikte gelen xhpl) performansı MPI uygulamalardan daha iyi olabilmektedir. Bunun başlıca sebebi, nodlar arası gerçekleşen iletişim ihtiyaçlarının önemli ölçüde azalması, node içerisindeki tasklar arası haberleşmenin, network yada Infiniband katmanına göre çok daha hızlı olan ortak bellek üzerinde gerçekleşmesidir.

xhpl'in hibrid,mpi ve multitask versiyonları için hazırlanmış olan slurm betiklerini /truba/sw/scripts dizini altında bulabilirsiniz.

.. note::

    Hibrid bir iş çalıştırken;

    - node sayısı, 
    
    - çalıştırılacak görev sayısı, ve 
    
    - görev başına kullanılacak çekirdek sayısı 
    
    parametreleri slurm dosyasında belirtilmelidir. Ayrıntılı bilgiye man sbatch komutu ile ulaşabilir ve/veya :ref:`slurm-betik` sayfasını ziyaret edebilirsiniz.


Sbatch ile çalışırken:
------------------------

**-N 4 :** -n tane taskın başlatılacağı node sayısı

**-n 16 :** başlatılacak görev sayısı, node başına eşit sayıda görev düşmesi performansa olumlu etki yapacaktır.. O nedenle -N'in katları şeklinde olması önemlidir.

**-c 4 :** görev başına kullanılacak çekirdek sayısı. Burada, node başına düşen görev sayısı x gorev başına düşen çekirdek sayısının, ilgili node'un çekirdek sayısını aşmaması gerekir.

Bu yapılandırma ile her biri 4 çekirdeğe kadar aynak kullanabilen toplamda 16 görev (16x4 =64 çekirdek) 4 node üzerinde çalıştırılacaktır.

Eğer işlemcinin hybertreading özelliği kullanılmak isteniyorsa, ayrıca ``--threads=2`` ve ``export OMP_NUM_THREADS=4`` yapılandırması kullanılabilir. 

.. note::

    Hyperthreading'in performansa katkısı uygulamaya göre değişebilir. Kullanıcının test edip değerlendirmesi gereken bir durumdur. 
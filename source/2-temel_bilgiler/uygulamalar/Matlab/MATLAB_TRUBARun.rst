.. _MATLAB_run:

=======================================
TRUBA'da MATLAB Dosyası Çalıştırmak
=======================================

- Kullanacağınız MATLAB versiyonuna karar verdiyseniz

- İş göndereceğiniz sunucuya karar verdiyseniz

- SLURM betik dosyası hazırlamakla ilgili bilgi edindiyseniz

- MATLAB lisans dosyanızı arayüz sunucusuna aktardıysanız

Örnek bir betik dosyasını ``/arf/sw/scripts/matlab`` dizininin altında inceleyebilir ve işlerinizi kümeye gönderebilirsiniz.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` MATLAB ve SLURM dosyası (Tıklayınız)
    :color: info

    .. tab-set:: 
        .. tab-item:: test.m

            .. code-block::

                ##  test.m dosyasinin icerigi
                A=rand(100,100);
                B=rand(100,100);
                C=A*B;
                size(C);
                quit

        .. tab-item:: test_matlab.slurm

            .. code-block::

                #!/bin/bash


                ### matlab.slurm dosyasinin icerigi

                $MATLAB_DIR/bin/matlab -nodisplay -nosplash < test.m > OUTPUTFILE.out
                exit

                #!/bin/bash
                #SBATCH -A kullanici_kuyruk_hesabi #kendi kuyruk hesabinizi yaziniz.
                #SBATCH -J matlab
                #SBATCH -p hamsi #isi gondermek istediginiz kuyrugun adini yaziniz.
                #SBATCH -N 1 
                #SBATCH -n 1 
                #SBATCH -c 56
                #SBATCH --time=1:00:00

                echo "SLURM_NODELIST $SLURM_NODELIST"
                echo "NUMBER OF CORES $SLURM_NTASKS"

                #kendi lisans dosyanizin adi ve tam yolu..
                export MLM_LICENSE_FILE=$HOME/matlab_license.lic 

                ## onceden yuklu moduller varsa, kaldirin
                module purge

                #Cevre degiskenleri modul ile load edebilir
                module load apps/matlab/2024a


                #ya da kendiniz elle yapilandirabilirsiniz.
                #MATLAB_DIR=/arf/sw/apps/matlab/2024a
                #export LD_LIBRARY_PATH=$MATLAB_DIR/lib:$LD_LIBRARY_PATH
                #export PATH=$MATLAB_DIR/bin:$PATH


                ## test.m dosyasini calistirmak istediginiz matlab dosyasi ile degistirin
                $MATLAB_DIR/bin/matlab -nodisplay -nosplash < test.m > OUTPUTFILE.out

                exit



``sbatch`` ile işinizi kuyruğa gönderebilirsiniz. 

::

    ## isinizi kuyruga gondermek icin
    sbatch test_matlab.slurm

    ## isinizin durumu hakkinda bilgi edinmek icin
    squeue -u username

    ## isinizi iptal etmek isterseniz
    scancel "JOBID"

Çalıştırmış olduğunuz dosya ile ilgili çıktı dosyaları (``OUTPUTFILE.out``, ``slurm-"jobid".err``,  ``slurm-"jobid".out``)  işi göndermiş olduğunuz klasörde yer alacaktır. Ayrıca ``.matlab`` klasörü altında da göndermiş olduğunuz işle ilgili detaylara da erişebilirsiniz.

.. warning::

    Hesaplamalarınız için /arf/scratch dizininizi kullanmanız gerekmektedir.

    "HPC sistemlerinde scratch klasörü, yoğun okuma/yazma işlemleri gerektiren işler için geçici, yüksek hızlı bir depolama alanı olarak kullanılır ve hesaplamalar sırasında verimli bir G/Ç performansı sağlar. Bu dizindeki dosyalar genellikle iş tamamlandıktan sonra silinir, böylece diğer görevler için kaynaklar serbest kalır. “

    - /arf/home  sadece program kurulumları ve küçük işlerin çalıştırılması için düşünülmüştür.. Bu nedenle kotası 100GB'dır.
    - /arf/scratch  sadece  işlerin çalıştırılmalarını için planlanmıştır. Bu nedenle kotası 1TB'dır ve dosyaların maksimum bekleme süreleri 1 aydır.

    :ref:` _arf_depolama_kaynaklari`


``batch`` ile işinizi gönderirken output dosyasını iki farklı şekilde yazdırabilirsiniz (dosyanızın adı "INPUTFILE"  olsun)


.. warning::

    .. code-block:: bash

        # Bu metot ile iş gönderdiğinizde çıktı dosyanız MATLAB tarafından oluşturulan ">>" karakterlerini içerecektir.
        matlab -nodisplay -nosplash < INPUTFILE.m > OUTPUTFILE.out

        # Bu metot ile çalıştırdığınızda betiğinizin sonunda (INPUTFILE) "quit" komutu yer almalıdır. Aksi takdirde MATLAB, calıştırmak için komut bekleyeceğinden hesaplama kaynaklarını boş yere meşgul edecektir.

        matlab -nodisplay -nosplash -r INPUTFILE -logfile OUTPUTFILE.out 
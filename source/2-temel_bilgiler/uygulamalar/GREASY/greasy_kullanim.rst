.. _greasy-kilavuzu:


GREASY Kullanımı
=================

Görev Dosyasının Oluşturulması
--------------------------------

Kullanıcının yürütmek istediği  görevlerin tanımlanacağı ``görev dosyası`` en önemli unsurdur. Daha önce de belirtildiği gibi, dosyanın her bir satırı Greasy tarafından bir görev olarak alınır. Dolayısıyla, görev dosyasındaki her satır tam olarak ne çalıştırmak istediğinizi içerir. Örneğin, çalıştırmak istediğiniz program için çalıştırılabilir komutun yer aldığı dosyanın tam yolu ve ardından gerekli yönlendirmelerle birlikte argümanlar. Satır numarası, görev kimliği (ID) dediğimiz şeye karşılık gelir. Bu ID, günlük dosyasını ve kullanıcı tarafından tanımlanan bağımlılıkların ne zaman gerekli olduğunu anlamak için kullanışlıdır.

# ile başlayan satırlar yorum olarak değerlendirilir ve işlenmez, ancak yine de ilgili satır için bir ID numarası ayırır. Bu, örneğin, ilk satırda bir açıklama/yorum yer alıyorsa ve ikinci satır geçerli bir görev içeriyorsa, bu görevin ID=2 olacağı anlamına gelmektedir. Bu şekilde, dosya satır numaralarını göstermek için bir editör kullanmak (örn: vim) ve herhangi bir görevi ID aracılığıyla sadece ilgili dosya satır numarasına giderek bulmak kolaydır.

Çalışma dizini görev dosyasında ilgili satırın başında, görev komutundan önce ve ``[@ ve @]`` arasında belirtilir. Bu sözdizimi, görevin belirtilen dizinde yürütülmesini sağlar. Örnek olarak:

görev 1 # Greasy'nin başlatıldığı dizinde yürütülür (SLURM betik dosyası ve ilgili görev dosyasının yer aldığı, işin submit edildiği dizin)
[@ /home/user/greasy @] görev 2 # Belirtilen klasördeki görev 2 yürütülür (``cd /home/user/greasy && görev 2``)

Bağımlılıklar satırın başında, görevden hemen önce ve [# ve #] arasında belirtilir. Geçerli görevden önce bitmesi gereken tüm görevler buraya dahil edilmelidir ve birden fazla görev bağımlılık olarak dahil edilebilir. Aşağıda, görevler arasında bazı bağımlılıklar içeren örnek bir görev dosyasını görebilirsiniz:

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Görev Dosyası (Tıklayınız)
    :color: info

        .. tab-set::

            .. tab-item:: greasy_list.txt

                .. code-block:: bash

                    task1
                    [# 1 #] task2
                    [# -2, 2 #] task3
                    task4
                    [# 2-4 #] task5

            .. tab-item:: job-greasy.slurm

                .. code-block:: bash
            
                    #!/bin/bash
                    #SBATCH --account=kullanici_adiniz
                    #SBATCH --output=slurm-%j.out
                    #SBATCH --error=slurm-%j.err
                    #SBATCH --time=01:00:00
                    #SBATCH --job-name=greasy-test

                    #SBATCH --partition=orfoz
                    #SBATCH --ntasks=112
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=1

                    #SBATCH --mail-user= your_email_address
                    #SBATCH --mail-type=BEGIN,END,FAIL
                    #SBATCH --mail-type=ALL

                    
                    echo " GREASY "
                    echo "SLURM_NODELIST $SLURM_NODELIST"
                    echo "NUMBER OF TASKS $SLURM_NTASKS"
                    echo "NUMBER OF CORES=$SLURM_NPROCS"

                    ### Load modules

                    module purge
                    module load lib/greasy/greasy

                    ### module listesinden kullanilacak program varsa ilgili program icin gerekli moduller de ayrica yuklenmelidir.

                    echo "We have the modules: $(module list 2>&1)" > ${SLURM_JOB_ID}.info

                    ### calistirilacak islerin sirali listesinin yer aldigi dosya
                    FILE=greasy_list.txt

                    #Ayni anda çalistirilacak is sayisi
                    export GREASY_NWORKERS=112

                    greasy $FILE

                    exit

            .. tab-item:: İş Gönderme
                
                .. code-block:: bash

                    sbatch job-greasy.slurm

greasy_list.txt dosyasında verilen görev 1 ve 4'ün herhangi bir bağımlılığı yoktur. Görev 2, görev 1'e bağlıdır ve görev 3, görev 1 ve 2'ye bağlıdır. ``-2`` ile göreceli bir bağımlılık belirtilmiştir: 2 satır yukarıdaki görevi, yani görev 1'i işaret etmektedir. Ve son olarak, görev 5 ise görev 2, 3 ve 4'e bağlıdır. Bu durumda, bağımlılıkları bir aralık olarak belirtilmiştir. Görev 3'te olduğu gibi, öğeleri virgülle ayırarak daha fazla bağımlılık ekleyebilirsiniz.

Yalnızca geriye dönük bağımlılıklara izin verilmektedir. Bu, yalnızca geçerli ID'den daha küçük ID'ye sahip görevlere bağımlılık ekleyebileceğiniz anlamına gelir. Başka bir deyişle, görev dosyasında yalnızca önceki satırlarda tanımlanan görevlere bağımlılık ekleyebilirsiniz.

.. note::

    Bir Greasy görev dosyası oluştururken aşağıdaki basit kuralları aklınızda bulundurmanız yeterlidir:
    
    - Her satır bir görevdir
    - # ile başlayan satırlar yorumlardır.
    - Dosya satır numarası ile görev kimliği (ID) arasında bire bir ilişki vardır.
    - Her görev için çalışma dizinini [@ <path> @] ile belirtmek mümkündür.
    - Bağımlılıkları ifade etmek için satır başında ve köşeli parantezler arasında görev kimliğini kullanın [# <bağımlılıkların listesi buraya gider> #] .
    - Ve bağımlılıklarla ilgili olarak, aşağıdaki hususları unutmayın:

        - Yalnızca geriye dönük bağımlılıklara izin verilir.
        - Bağımlılıkları ayırmak için ``,`` kullanın.
        - Belirli bir aralıktaki bağımlılıkların sıralamasını ifade etmek için ``-`` kullanın. Örneğin: [# 3-6 #] geçerli görevin görev 3'ten 6'ya (her ikisi de dahil) bağlı olduğu anlamına gelir.
        - Daha önceki sıralarda yer alan bağımlılıkları ifade etmek için de ``-`` kullanın. örneğin: [# -1 #] geçerli görevin önceki göreve bağlı olduğu anlamına gelir.
        - ID'leri ayırmak için ``,`` ve ``-`` simgelerini istediğiniz gibi birleştirebilirsiniz.


Bağlı görevleri içeren bir örneği aşağıda bulabilirsiniz:

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Bağlılık İçeren Görev Dosyası (Tıklayınız)
    :color: info

        .. tab-set::

            .. tab-item:: greasy_dependency_list.txt

                .. code-block:: bash

                    # this line is a comment
                    /bin/sleep 2
                    # the following task is 4. Tasks IDs 1 and 3 do not exist.
                    /bin/sleep 4
                    /bin/sleep 5
                    /bin/sleep 6
                    /bin/sleep 7
                    # the following task will be run after completion of the "sleep 5"
                    [# 5 #] /bin/sleep 9
                    # the following task will be run after completion of the "sleep 9"
                    [# -2 #] /bin/sleep 11
                    # the following task is invalid because tasks 1 and 3 do not exist
                    [#1-3#] /bin/sleep 13
                    # the following task will be run after completion of tasks 2, 5, 6 and 7
                    [#2, 5 - 7 #] /bin/sleep 15
                    # the following task will be executed on the directory /tmp/scratch
                    [@ /tmp/scratch @] pwd
                    # it is possible to combine dependencies and working directory for a task
                    [@ /tmp/scratch @][# -2 #] echo “It works!”

Log Dosyası
-------------

Greasy hala çalışırken veya tamamlandıktan sonra, log dosyasını kontrol edebilirsiniz. Log dosyası, herhangi bir zamanda ne yapıldığı, görevlerin ne zaman ve nerede yürütüldüğü ve yürütme sırasında meydana gelen olası hatalar veya sorunlar hakkında bilgi sağlar. LogLevel 3 (Bilgi modu) yalnızca minimum yararlı bilgi üretmektedir. Aşağıda, ornek-liste.txt dosyasının 3 çalışanla yürütülmesinden elde edilen günlük kayıtlarına bir örnek verilmiştir.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Örnek Log Dosyası (Tıklayınız)
    :color: info

        .. tab-set::

            .. tab-item:: greasy-logfile.log

                .. code-block:: bash

                    [2024-09-16 16:50:15] Start greasing short-example.txt
                    [2024-09-16 16:50:15] INFO: BASIC engine is ready to run with 3 workers
                    [2024-09-16 16:50:15] INFO: Allocating task 1
                    [2024-09-16 16:50:15] INFO: Allocating task 2
                    [2024-09-16 16:50:15] INFO: Allocating task 3
                    [2024-09-16 16:50:20] INFO: Task 3 completed successfully on node orfoz9. Elapsed: 00:00:05
                    [2024-09-16 16:50:25] INFO: Task 2 completed successfully on node orfoz9. Elapsed: 00:00:10
                    [2024-09-16 16:50:35] INFO: Task 1 completed successfully on node orfoz9. Elapsed: 00:00:20
                    [2024-09-16 16:50:35] INFO: BASIC engine finished
                    [2024-09-16 16:50:35] INFO: Summary of 3 tasks: 3 OK, 0 FAILED, 0 CANCELLED, 0 INVALID.
                    [2024-09-16 16:50:35] INFO: Total time: 00:00:20
                    [2024-09-16 16:50:35] INFO: Resource Utilization: 58.33%
                    [2024-09-16 16:50:35] Finished greasing short-example.txt

Log dosyasından gördüğünüz gibi, her kayıt ön ek olarak bir zaman damgası ile birlikte gelir, bu da Greasy'nin davranışını ve tüm iş süreci boyunca görev planlamasını anlamayı kolaylaştırır. Günlüğe hızlıca baktığımızda, programın 16:50:15'te başladığını ve 16:50:35'te bittiğini görüyoruz.  Kullanılan aracın "BASIC" olduğunu ve 3 işçi ile yapılandırıldığını da gözlemleyebiliriz.

Tahsis edilecek sadece 3 görev ve 3 işçi olduğundan, Greasy başlangıçta tüm görevleri tüm işçilere tahsis eder. Daha sonra Greasy, başarı veya hata bildiren görev tamamlamalarını, görevin başlatıldığı düğümü ve çalıştırılması için geçen süreyi kaydeder.

Son olarak, tüm görevler çalışıp tamamlandığında, Greasy log dosyasında başarıyla tamamlanan görevler, başarısızlıklar veya iptal edilen görevler gibi işin çalışması hakkında bazı istatistikler gösterir. Genel olarak işin çalışması için geçen süreyi ve kaynak kullanımını kontrol etmek de faydalıdır. Kaynak kullanımı değeri ne kadar yüksekse, Greasy görevleri çalıştırmak için mevcut kaynakları o kadar verimli kullanmış demektir. Bu sayının çok düşük olduğunu düşünüyorsanız, mümkün olan en uzun süre meşgul olmalarını sağlamak için işçi sayısını değiştirmeyi düşünün.

Restart Dosyası
-----------------

Bazen işler beklendiği gibi çalışmayabilir ve bazı görevlerin hatta tüm Greasy işleminin anormal bir şekilde bitmesi mümkündür. Böyle bir durum söz konusu olduğunda Greasy; başarısız olan, iptal edilen veya yürütülmeyen görevleri içeren bir yeniden başlatma dosyası oluşturur. Yeniden başlatma dosyası Greasy için geçerli bir görev dosyasıdır, bu nedenle ilk seferde düzgün çalışamayan görevleri çalıştırmak için kullanılabilir. Aşağıda example.txt dosyasını çalıştıran bir yeniden başlatma dosyası örneğini görebilirsiniz.

.. dropdown:: :octicon:`codespaces;1.5em;secondary` Restart Dosyası (Tıklayınız)
    :color: info

        .. tab-set::

            .. tab-item:: greasy-restartfile

                .. code-block:: bash

                    # 
                    # Greasy restart file generated at 2024-09-16 16:53:50
                    # Original task file: example.txt
                    # Log file: greasy.log
                    #
                    # Warning: Task 2 failed
                    /usr/bin/hostname
                    # Warning: Task 13 was cancelled due to a dependency failure
                    [# 8 #] /bin/sleep 13
                    # Warning: Task 15 failed
                    /usr/bin/hostname
                    # Warning: Task 22 failed
                    [ 1 ] /bin/sleep 22
                    # Warning: Task 24 failed
                    [ 1 #] /bin/sleep 24
                    # Invalid tasks were found. Check these lines on example.txt:
                    # 23, 26, 27, 29, 31, 32
                    # End of restart file


Yeniden başlatma dosyasının kendisi hakkında bilgi veren küçük bir başlık vardır: dosyanın ne zaman oluşturulduğu, yürütülmekte olan orijinal görev dosyası ve yürütmenin log dosyası. Bu bilgiler, yeniden başlatmadaki görevleri orijinal iş dosyasındaki görevler ile ilişkilendirmek ve ne olduğunu anlamak için çok kullanışlıdır.

Bir görev başarısız olduğunda veya iptal edildiğinde, Greasy orijinal dosyadaki görevi tanımlayan ve neden yeniden başlatmada olduğunu belirten bir yorum ekler. Görev, Greasy'ye daha önce çıkması söylendiği için çalıştırılamadıysa, herhangi bir yorum eklenmeyecektir. Son olarak, yeniden başlatma dosyasının sonunda, orijinal görev dosyasında sözdizimi veya anlamsal hatalar nedeniyle geçersiz görevler varsa, bunlar ilgili ID bilgileri ile birlikte listelenir.
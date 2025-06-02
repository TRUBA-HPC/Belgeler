.. _basic_slurm_commands:
Temel SLURM Komutları
==========================================
Temelde **sbatch** ve **squeue** komutları iş göndermek işinizin durumunu izlemek için yeterli olsa da ek  olarak diğer SLURM komutlarını bilmek ve kullanmak, kullanım sırasında karşılaşılabilecek pek çok sorunu  hızlıca çözmek ve sistemin genelini daha iyi kavramak açısından önemlidir.

Aşağıda sık kullanılan bazı komutların temel fonksiyonları hakkında genel bilgiler verilmiştir.  Ancak bu komutların ek özellikleri, komut yanına yazılan parametrelerle sağlayabilmektedir.  Komutların ek özellikleri ve detayları hakkında pek çok bilgiye, komutların yardım sayfalarından  (man pages) ya da SLURM'un web sitesinden (https://slurm.schedmd.com/documentation.html) ulaşılabilir. Komutların yardım sayfasına, kullanıcı arayüzü sunucularından aşağıdaki komutla ulaşılabilir.

.. code-block:: bash

   man <komut_adi>

**Örneğin squeue komutunun nasıl kullanılacağını öğrenmek için, terminalinize aşağıdaki komutu yazmanız yeterlidir.**

.. code-block:: bash

   man squeue

**Diğer komutlarla ilgili genel bilgiler aşağıda verilmiştir.**

**sinfo:** İş kuyruklarının güncel kullanım durumunu ekrana basar. Buradan elde edilen bilgi ile kuyruklardaki durumu öğrenebilir, işlerinizi en hızlı başlayacak kuyruğu seçip oraya yönlendirebilirsiniz. Kullanılacak ek parametrelerle, listelenecek bilgiyi detaylandırabilirsiniz.

**squeue:** Kullanıcının kuyrukta bekleyen ve çalışan işlerini görüntüler. Kullanılacak ek parametrelerle,  listelenecek bilginin türü ve miktarı değiştirilebilir. Kullanıcının tüm işleri listelenebileceği gibi (varsayılan),  işin iş numarası parametre olarak verilerek, o işe özel bilgilerin dökümü de alınabilir.

**sbatch:** Hazırlanan iş betiğini kuyruğa göndermek için kullanılır. Parametreler betik dosyasında verilebileceği gibi komutun yanına da yazılabilir. İşin akışını, verimini ve kontrolünü sağlayacak pek çok parametresi vardır.

**srun:** Alternatif olarak işler sbatch yerine srun komutu ile de çalıştırılabilir. Srun kullanılırken çalıştırılacak komut doğrudan srun ve parametrelerinin sonuna yazılır.  Basit ve küçük işleri çalıştırmak için hızlı bir yöntemdir. Sbatch'de olduğu gibi birçok ek parametresi mevcuttur.

**scancel:** Kuyrukta sırada bekleyen ya da o anda çalışmakta olan işleri iptal etmek için kullanılır.

**sacct:**  Beklemede, çalışmakta ya da daha önce çalışmış ve sonlanmış olan işler ya da tek bir iş hakkında ayrıntılı rapor ve bilgi alınmasına imkan verir. Pek çok parametre içerir. Örneğin belli tarihler arasında başlamış ve bitmiş işlerin listesi, çalışma süresi, kullandığı bellek miktarı, üzerinde çalıştığı sunucuların adresleri vb. ayrıntılar ile ilgili bilgi alınması mümkündür.

**sstat:** Çalışmakta olan işin kullandığı, kullanmakta olduğu sistem kaynakları hakkında bilgi verir. **--format=**   ile verilecek bilgi türleri seçilebilir. 

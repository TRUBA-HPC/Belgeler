==========================================
TRUBA'da VASP Kullanımı
==========================================

<<<<<<< HEAD:source/how-to-guides/VASP/vasp_truba.rst
Bir önceki adımda VASP programının kendi ev dizinize nasıl kurulacağı anlatıldı. Bu bölümde bu uygulamanın yine kendi dizininizde çalıştırabilmeniz için örnek bir iş betiği oluşturulacaktır.
vasp_run.slurm olarak isimlendirilen iş betiği dosyasının içine istediğiniz bir editör kullanarak girip gerekli değişiklikleri kolayca yapabilirsiniz. İş betikleri oluşturulurken iki önemli husus vardır. 
Programı hangi modulleri kullanarak derlediyseniz, o modüllerin isimleri iş betiği dosyanızda olması gerekmektedir. 
İş betiği ile ilgili ayrıntılara bu sayfaya tıklayarak ulaşabilirsiniz. `Kaynak Yöneticisi <https://docs.truba.gov.tr/TRUBA/kullanici-el-kitabi/kaynakyoneticisi-isdongusu/index.html>`_ 

------------------------------------
Barbun kümeleri için vasp_run.slurm 
------------------------------------
=======
Bir önceki adımda VASP programının kendi kullanıcınızın olduğu dizine nasıl kurulacağını anlattık. Bu bölümde bu uygulamanın yine kendi dizininizde çalıştırabilmeniz için örnek bir iş betiği oluşturulacaktır.
vasp_run.slurm olarak isimlendirilen iş betiği dosyasının içine istediğiniz bir editör kullanarak girip gerekli değişiklikleri kolayca yapabilirsiniz. İş betikleri oluşturulurken iki önemli husus vardır. Programı hangi modülleri kullanarak derlediyseniz, o modüllerin isimleri iş betiği dosyanızda olması gerekmektedir. Hangi modülleri kullanacağınızla ilgili olarak kuracağınız programın kurulum dosyalarını dikkatlice okumanız gerekmektedir.
İş betiği ile ilgili ayrıntılara :ref:`kaynakyoneticisi` sayfasından ulaşabilirsiniz.

--------------------------------
VASP SLURM Dosyası Örneği
--------------------------------
>>>>>>> ee65f899c69a105a692b4fb00486b0cb453c0afa:source/how-to-guides/VASP/vasp_TRUBA.rst

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p barbun 
  #SBATCH -A kullanıcı_adı
  #SBATCH -J vasp-test
  #SBATCH -N 1
  #SBATCH -n 20
  #SBATCH --time=03:00:00
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

  # Compiler Links
  module load centos7.3/comp/intel/PS2018-update2
  module load centos7.3/lib/openmpi/4.0.1-intel-PS2018

 export OMP_NUM_THREADS=1


 echo "SLURM_NODELIST $SLURM_NODELIST"
 echo "NUMBER OF CORES $SLURM_NTASKS"

 ulimit -s unlimited


 mpirun  /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/bin/vasp_std> vasp.out
  
 exit


<<<<<<< HEAD:source/how-to-guides/VASP/vasp_truba.rst
Bu komut dosyası, toplam 20 çekirdek için her biri 20 çekirdekli 1 sunucu ayırır. İşlerinizin büyüklüğüne göre bu sayıları değiştirebilirsiniz. VASP programının hangi versiyonunda derlediğinize bağlı olarak kaynak dosyalarının isimleri değişecektir. Programı çalıştırmak için gerekli satırları düzenledikten sonra aşağıdaki komutu terminalize yazarak işinizi TRUBA sistemine gönderebilirsiniz..
=======
Bu komut dosyası, toplam 40 çekirdek için her biri 20 çekirdekli 2 sunucu ayırır. İşlerinizin büyüklüğüne göre bu sayıları değiştirebilirsiniz. VASP programının hangi versiyonunda derlediğinize bağlı olarak kaynak dosyalarının isimleri değişecektir. Programı çalıştırmak için gerekli satırları düzenledikten sonra aşağıdaki komutu terminalinize yazarak işinizi TRUBA sistemine gönderebilirsiniz.
>>>>>>> ee65f899c69a105a692b4fb00486b0cb453c0afa:source/how-to-guides/VASP/vasp_TRUBA.rst

.. code-block:: bash
  
   sbatch vasp_run.slurm

<<<<<<< HEAD:source/how-to-guides/VASP/vasp_truba.rst

------------------------------------
Hamsi kümeleri için vasp_run.slurm 
------------------------------------
.. code-block:: bash

  #!/bin/bash
  #SBATCH -p hamsi 
  #SBATCH -A kullanıcı_adı
  #SBATCH -J vasp-test
  #SBATCH -N 1
  #SBATCH -n 28
  #SBATCH --time=03:00:00
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err

  # Compiler Links

 source /truba/sw/centos7.9/comp/intel/oneapi-2021.2/setvars.sh

 export OMP_NUM_THREADS=1


 echo "SLURM_NODELIST $SLURM_NODELIST"
 echo "NUMBER OF CORES $SLURM_NTASKS"

 ulimit -s unlimited


 mpirun  /truba/home/kullanıcı_adı/derleme/vasp.6.2.0/bin/vasp_std> vasp.out
  
 exit
=======
* :download:`VASP için örnek olarak verilen slurm dosyasını indirmek için tıklayınız... </assets/vasp-howto/config-files/vasp_run.slurm>`

>>>>>>> ee65f899c69a105a692b4fb00486b0cb453c0afa:source/how-to-guides/VASP/vasp_TRUBA.rst


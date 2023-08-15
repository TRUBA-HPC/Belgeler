==========================================
TRUBA'da VASP Kullanımı
==========================================

Bir önceki adımda VASP programının kendi ev dizinize nasıl kurulacağı anlatıldı. Bu bölümde bu uygulamanın yine kendi dizininizde çalıştırabilmeniz için örnek bir iş betiği oluşturulacaktır.
vasp_run.slurm olarak isimlendirilen iş betiği dosyasının içine istediğiniz bir editör kullanarak girip gerekli değişiklikleri kolayca yapabilirsiniz. İş betikleri oluşturulurken iki önemli husus vardır. 
Programı hangi modulleri kullanarak derlediyseniz, o modüllerin isimleri iş betiği dosyanızda olması gerekmektedir. 
İş betiği ile ilgili ayrıntılara :ref:`kaynakyoneticisi` sayfasından ulaşabilirsiniz.

-----------------------------------------------
Barbun kümeleri için VASP SLURM Dosyası Örneği
-----------------------------------------------

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p mid2
  #SBATCH -A kullanici_adi
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


 mpirun  /truba/home/kullanici_adi/derleme/vasp.6.2.0/bin/vasp_std> vasp.out
  
 exit


Bu komut dosyası, toplam 20 çekirdek için her biri 20 çekirdekli 1 sunucu ayırır. İşlerinizin büyüklüğüne göre bu sayıları değiştirebilirsiniz. VASP programının hangi versiyonunda derlediğinize bağlı olarak kaynak dosyalarının isimleri değişecektir. Programı çalıştırmak için gerekli satırları düzenledikten sonra aşağıdaki komutu terminalize yazarak işinizi TRUBA sistemine gönderebilirsiniz..

.. code-block:: bash
  
   sbatch vasp_run.slurm

* :download:`VASP için örnek olarak verilen slurm dosyasını indirmek için tıklayınız... </assets/vasp-howto/config-files/vasp_run.slurm>`

----------------------------------------------
Hamsi kümeleri için VASP SLURM Dosyası Örneği
----------------------------------------------

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p hamsi 
  #SBATCH -A kullanici_adi
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


 mpirun  /truba/home/kullanici_adi/derleme/vasp.6.2.0/bin/vasp_std> vasp.out
  
 exit





















--------------------------------
VASP SLURM Dosyası Örneği
--------------------------------

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p mid2
  #SBATCH -A accountname
  #SBATCH -J vasp-test
  #SBATCH -N 2
  #SBATCH -n 20
  #SBATCH --time=03:00:00
  #SBATCH --output=slurm-%j.out
  #SBATCH --error=slurm-%j.err


  #echo "SLURM_NODELIST $SLURM_NODELIST"
  #echo "NUMBER OF CORES $SLURM_NTASKS"

  #export OMP_NUM_THREADS=1
  
  source /truba/sw/centos7.3/comp/intel/PS2018-update2/bin/compilervars.sh intel64
  module load centos7.3/comp/intel/PS2018-update2

  VASP_DIR=/truba/home/username/vasp/vasp.5.4.1/bin

  mpirun $VASP_DIR/vasp_std 
  
  exit

Bu komut dosyası, toplam 40 çekirdek için her biri 20 çekirdekli 2 sunucu ayırır. İşlerinizin büyüklüğüne göre bu sayıları değiştirebilirsiniz. VASP programının hangi versiyonunda derlediğinize bağlı olarak kaynak dosyalarının isimleri değişecektir. Programı çalıştırmak için gerekli satırları düzenledikten sonra aşağıdaki komutu terminalinize yazarak işinizi TRUBA sistemine gönderebilirsiniz.

.. code-block:: bash
  
   sbatch vasp_run.slurm



* :download:`VASP için örnek olarak verilen slurm dosyasını indirmek için tıklayınız... </assets/vasp-howto/config-files/vasp_run.slurm>`



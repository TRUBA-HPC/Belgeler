==========================================
TRUBA'da VASP Programı Nasıl Kullanılır?
==========================================

Bir önceki adımda VASP programının kendi kullanıcınızın olduğu dizine nasıl kurulacağını anlattık. Bu bölümde bu uygulamanın yine kendi dizininizde çalıştırabilmeniz için örnek bir iş betiği oluşturulacaktır.
vasp_run.slurm olarak isimlendirilen iş betiği dosyasının içine istediğiniz bir editör kullanarak girip gerekli değişiklikleri kolayca yapabilirsiniz. İş betikleri oluşturulurken iki önemli husus vardır. Programı hangi modulleri kullanarak derlediyseniz, o modüllerin isimleri iş betiği dosyanızda olması gerekmektedir. Hangi modülleri kullanacağınızla ilgili olarak kuracağınız programın kurulum dosyalarını dikkatlice okumanız gerekmektedir.
İş betiği ile ilgili ayrıntılara bu sayfaya tıklayarak ulaşabilirsiniz.

------------------
vasp_run.slurm
------------------

.. code-block:: bash

  #!/bin/bash
  #SBATCH -p mid1 
  #SBATCH -C barbun
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

Bu komut dosyası, toplam 40 çekirdek için her biri 20 çekirdekli 2 sunucu ayırır. İşlerinizin büyüklüğüne göre bu sayıları değiştirebilirsiniz. VASP programının hangi versiyonunda derlediğinize bağlı olarak kaynak dosyalarının isimleri değişecektir. Programı çalıştırmak için gerekli satırları düzenledikten sonra aşağıdaki komutu terminalize yazarak işinizi TRUBA sistemine gönderebilirsiniz..

.. code-block:: bash
  
   sbatch vasp_run.slurm


======================================
TRUBA'da Gaussian Programının Kurulumu
======================================
Aşağıda Gaussian programının **g16** versiyonunun TRUBA altyapısında derlenmesi için gerekli adımlar verilmiştir. Siz de aşağıdaki adımları takip 
ederek kurulumunu kendi ev dizininizde yapabilirsiniz. **g09** versiyonu aynı adımlar izlenerek kurulabilir. 
**Uygulanacak adımlar:**

**1.**
Gaussian'ın binary olarak dağıtılan bir paket program olduğu için, sadece arşiv paketini açmak kurulum için yeterlidir, herhangi bir derlemeye gerek bulunmamaktadır. Öncelikle kaynak kodunu kendi ev dizininize alınız. Kaynak kodu sıkıştırılmış dosya formatında
 (*.tar veya *.tar.gz vb.) olduğu için açmak için aşağıdaki komutlardan dosya formatınıza uygun olanı kullanınız.

.. code-block:: bash

 tar -xvf gaussian16.tar 
 tar -xvf gaussian16.tgz

**2.**
Bu adımda programınızı çalıştıran g16 (executable) kodunun olduğu dizini (g16a3) kendi ev dizininize kopyalayarak adını g16 
olarak değiştirin.  


.. code-block:: bash

  /truba/home/kullanıcıadı/ctafs/apps/gaussian/legacy_g16/g16a3
  cp -r g16a3 /truba/home/kullanıcıadı/
  mv g16a3 g16

**3.**
Programı kullanmak için bazı çevre değişkenleri tanımlanmalıdır. Bu tanımlar .profile (yada .bashrc ) dosyasının içinde yapılabileceği gibi slurm dosyasının içerisinde de yapılabilir.

---------------------------------
 .bashrc Dosyasının Oluşturulması 
---------------------------------
Bu bölümde .bashrc dosyasının oluşturularak programı çalıştırma işlemi gösterilecektir.  İlk olarak terminalinizden ~/.bashrc dosyanınızı herhangi bir editör yardımıyla açınız.

.. code-block:: bash

 emacs -nw ~/.bashrc   # Bu kod satırı **emacs** editör kullanılarak .bashrc dosyanızı açar. Sizle vi ya da nano gibi editörlerle aynı işlemi uygulayabilirsiniz. 
 
Dosyanın içerisine aşağıdaki komutları yazınız.

.. code-block:: bash

 export g16root=/truba/home/kullanıcıadı
 export GAUSS_SCRDIR=/tmp
 . $g16root/g16/bsd/g16.profile

.. warning:: **.bashrc** dosyanızın hemen aktif olması için ``source ~/.bashrc`` komutunu uygulayınız.

Programı çalıştırmak için ``$g16root/g16/g16 <jobname.gjf>> out &`` komutunu giriniz.

---------------------------------
Slurm  Dosyasının Oluşturulması 
---------------------------------
Slurm dosyası oluşturmak için aşağıdaki komut satırlarını kendi işinize göre uyarlayarak kopyalayınız. 


.. code-block:: bash

  #!/bin/bash
   #SBATCH -p barbun
   #SBATCH -A kullanıcıadı
   #SBATCH -J jobname 
   #SBATCH -- nodes=1
   #SBATCH -- ntask-per-node=20
   #SBATCH --time=01:00:00
   #SBATCH --workdir=$PWD
   #SBATCH --output=slurm-%j.out
   #SBATCH --error=slurm-%j.err

   export GAUSS_MEMDEF=550000
   export g16root=/truba/home/kullanıcıadı/
   export GAUSS_SCRDIR=./
   . $g16root/g16/bsd/g16.profile


Yukarıdaki slurm betiği  oluşturduktan sonra ``sbatch job.slurm`` komutu ile işlerinizi çalıştırabilirsiniz.


.. warning:: **g09** versiyonu benzer adımlar izlenerek kurulabilir. g16 kurulumundan farklı olarak: Arşivden çıkan dosya direkt g09 dizinini çıkartır. Bu nedenle yukarıda gösterilen 2. adımı uygulamanıza gerek yoktur.Yukarıdaki adımlardan farklı olarak yapmanız gereken ilgili komut satırlarının **g16** yerine **g09** ile değiştirilmesidir.

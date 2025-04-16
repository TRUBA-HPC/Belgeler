==============================================================
SU2 HAD Çözücü'nün TRUBA Üzerinde Derlenmesi ve Çalıştırılması
==============================================================

1. Download SU2 7.1.1 from Github to the SU2 directory:

.. code-block:: bash
 
	$ pwd
	/home/userid/SU2/
	$ ls
	su2code-SU2-v7.1.1-0-gaec088c.tar.gz
	$ tar -xvf su2code-SU2-v7.1.1-0-gaec088c.tar.gz
	$ mv su2code-SU2-v7.1.1-0-gaec088c SU2-v7.1.1-0
	$ ls
	SU2-v7.1.1-0
	su2code-SU2-v7.1.1-0-gaec088c.tar.gz

2. Load Modules for Compilers:

.. code-block:: bash
 
	$ module load centos7.3/comp/gcc/7
	$ module load centos7.3/comp/intel/PS2019-update1
	$ module load centos7.3/comp/python/3.6.5-gcc
	$ module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5

or write these into the ".bash_profile" file and load them as:

.. code-block:: bash
 
	$ source .bash_profile

3. Make ninja as executable if it is not so:

.. code-block:: bash
	
	$ chmod +x ninja or ninja.sh

4. Continue to install SU2, run the ninja script as:

.. code-block:: bash
	
	$ ./ninja -C build install

5. Update ".bashrc" or ".bash_profile" file with SU2 paths (the last rows after ninja install, commands given below)(write your own userid!)

.. code-block:: bash
	
	$ more .bash_profile
	# Setting PATH for SU2
	export SU2_RUN=/truba/home/userid/SU2/SU2-v7.1.1-0/bin
	export SU2_HOME=/truba/home/userid/SU2/SU2-v7.1.1-0
	export PATH=$PATH:$SU2_RUN
	export PYTHONPATH=$PYTHONPATH:$SU2_RUN 
	
	# Modules
	module load centos7.3/comp/gcc/7
	module load centos7.3/comp/intel/PS2019-update1
	module load centos7.3/comp/python/3.6.5-gcc
	module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5

write these into the ".bash_profile" file and load them as:

.. code-block:: bash
 
	$ source .bash_profile

6. Run the code (serial) on the command line as:

.. code-block:: bash
	
	$ pwd
	/home/userid/SU2/
	$ mkdir run
	$ cd run
	$ ls
	input.cfg
	mesh.su2
	$ SU2_CFD input.cfg

or use a makerun script to run:

.. code-block:: bash
 	
 	$ more makerun
 	SU2_CFD input.cfg
 	$ ./makerun

or submit a slurm job script su2_job.sh (using Barbun with upto 40 cores on 1 node) to run serial or parallel:

.. code-block:: bash
 	
 	$ chmod +x su2_job.sh
 	$ sbatch --partition short --constraint barbun  -n 16 su2_job.sh

or edit the job script and submit & check the que and job output

.. code-block:: bash
 	
 	$ sbatch su2_job.sh
 	$ squeue
 	$ tail -f slurm-job_ID.out
 	$ scancel job_ID

7. Sample job script:

..	* :download:`su2_job.sh</assets/cfd-education/note/su2_job.sh>`

.. code-block:: bash
	
	$ more su2_job.sh
	#!/bin/bash	
	# Job Script for TRUBA
	# To submit:            $ sbatch su2_job.sh
	# To check the que:     $ squeue
	# To check the output:  $ tail -f slurm-job_ID.out
	# To kill the job       $ scancel job_ID
	
	#SBATCH -A userid		# user account name
	#SBATCH -J su2rotor		# job name
	#SBATCH -p barbun		# partition name: debug, short, long, ...
	#SBATCH -N 1			# number of nodes (-N)
	#SBATCH -n 16			# total number of tasks / cores (-n / -c)
	#SBATCH --time=04:00:00		# max run time
	#SBATCH --workdir=/truba/home/userid/SU2/run/
	#SBATCH --output=slurm-%j.out
	#SBATCH --error=slurm-%j.err
	#SBATCH --constraint=barbun	# barbun, ...
	
	echo "SLURM_NODELIST $SLURM_NODELIST"
	echo "NUMBER OF CORES $SLURM_NTASKS"
	
	mpirun SU2_CFD rotor.cfg

----------

**EuroCC@Turkey Yaz HAD Okulu** (Dr. Nilay SEZER UZOL, Ağustos 2021) ve **METU AEE 544** (Dr. Nilay SEZER UZOL, Haziran 2021.) ders notlarından hazırlanmıştır.

=======================
Yararlı Linux Komutları
=======================

 .. code-block:: bash
 
	$ pwd				// show Current Directory
	/Users/userid
	$ ls				// list files
	Applications	Desktop		Documents
	$ mkdir test			// create the directory
	$ ls
	Applications	Desktop		Documents 	test
	$ cd test			// go into the directory
	$ cp howtousexfoil.txt test/.
	$ ls test
	howtousexfoil.txt
	$ ls -al
	total 8
	drwxr-xr-x   3 userid  staff   96 Apr 20 10:57 .
	drwxr-xr-x  23 userid  staff  736 Apr 20 10:52 ..
	-rw-r--r--@  1 userid  staff   43 Apr 20 10:57 howtousexfoil.txt
	$

 .. code-block:: bash
 
	$ more howtousexfoil.txt 	// more, less, cat
	This is my notes on how to use xfoil....
	$

 .. code-block:: bash
 
	$ cat howtousexfoil.txt | grep xfoil 	// search a keyword
	This is my notes on how to use xfoil....
	$

 .. code-block:: bash
 
	$ rm howtousexfoil.txt 		// remove the file
	$ ls -al
	total 0
	drwxr-xr-x   3 userid  staff   96 Apr 20 10:57 .
	drwxr-xr-x  23 userid  staff  736 Apr 20 10:52 ..
	$
	$ cd ..
	$ rmdir test 			// remove the directory
	$

 .. code-block:: bash
 
	$ cd 	// go to Home
	$ pwd
	/Users/userid
	$ du -m			// show Disk Usage
	$ du -hs			// show Disk Usage
	$ man ls			// show help/manuals
	...

 .. code-block:: bash
 
	// Copy a file or a directory to another account:
	$ scp -p -r test userid@karga.ae.metu.edu.tr:.

 .. code-block:: bash
 
	// Login to Karga or Ulakbim accounts:
	$ ssh userid@karga.ae.metu.edu.tr
	$ ssh userid@levrek.ulakbim.gov.tr

 .. code-block:: bash
 
	$ xclock		// show the clock window

 .. code-block:: bash
 
	$ gfortran mycode.f90 	// compile a fortran code
	$ ./mycode.out	 	// run a Fortran 90 code

 .. code-block:: bash
 
	$ gcc -c mycode.c 	// compile a c code
	$ ./mycode 		// run a c code

 .. code-block:: bash
 
	$ python mycode.py 	// run a python code
	...

=======================
Fortran ile programlama
=======================

Fortran Not 1
=============
.. code-block:: bash
	
	% Command Line
	$ pwd			% Present Working Directory
	/home/mycode/



Örnek Fortran Kodları
=========================

* **Algebraic Equations / ODEs** 
	* :download:`freefall.f90</assets/cfd-education/note/freefall.f90>`


Fortran Kodlarını Derlemek
==========================
.. code-block:: bash
   
   $ gfortran -c freefall.f90 		// Output object file : freefall.o
   $ gfortran -o freefall freefall.f90 	// Output executable file : freefall
   $ gfortran freefall.f90 		// Output executable file : a.out

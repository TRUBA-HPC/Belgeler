=======================
Fortran ile programlama
=======================

Fortran not 1
=============
.. code-block:: bash
	
	% Command Line
	$ pwd			% Present Working Directory
	/home/mycode/



Sample Fortran Codes
====================

* **Algebraic Equations / ODEs** 
	* :download:`freefall.f90</assets/cfd-education/note/freefall.f90>`


Fortran kodlarını derlemek
==========================
.. code-block:: bash
   
   $ gfortran -c freefall.f90 		// Output object file : freefall.o
   $ gfortran -o freefall freefall.f90 	// Output executable file : freefall
   $ gfortran freefall.f90 		// Output executable file : a.out

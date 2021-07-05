=====================
Fortran Programlaması
=====================

Fortran not 1
=============
.. code-block:: bash
	
	% Command Line
	$ pwd			% Present Working Directory
	/home/mycode/



Sample Fortran Codes
====================

* **Algebraic Equations / ODEs** 
	* :download:`freefall.f90</assets/education-cfd/download/freefall.f90>`


Fortran kodlarını derlemek
==========================
.. code-block:: bash
   
   $ gfortran -c freefall.f90 		// Output object file : freefall.o
   $ gfortran -o freefall freefall.f90 	// Output executable file : freefall
   $ gfortran freefall.f90 		// Output executable file : a.out

-------

|CreativeCommonsLicense| Bu çalışma,  `Creative Commons Atıf-Gayri 
Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı`_ ile lisanslanmıştır.
   
.. _Creative Commons Atıf-Gayri Ticari-Aynı Lisansla Paylaş 4.0 Uluslararası Lisansı: http://creativecommons.org/licenses/by-nc-sa/4.0/
.. |CreativeCommonsLicense| image:: https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
  
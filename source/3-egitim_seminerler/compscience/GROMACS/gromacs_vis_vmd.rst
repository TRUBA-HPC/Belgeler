=================================
Sonuçların VMD'de Görüntülenmesi
=================================

Artık oluşturduğumuz MD dosyasını VMD’ de görebiliriz. Bunun için VMD’ yi açın ve oluşturulan son mdp dosyasını bulun.

.. code-block::

    File > New Molecule > File name(Browse) > Downloads > Lysosyme in water >md_0_1.gro > OK

.. code-block::

    Determine the file type > Gromacs GRO > Load >  Automatically > Load > Load files for > md_0=1.xtc (Simüle etmek istediğiniz dosya!) > Determine file type > Gromacs XTC Compressed Trajectory > Load > Automatically > Load 

.. image:: /assets/compmatscience-gromacs-education/gmx_vmd1.png
   :align: center
   :width: 500px

.. image:: /assets/compmatscience-gromacs-education/gmx_vmd2.png
   :align: center
   :width: 500px

Görseldeki gibi bir görüntü elde edeceksiniz [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)]. Eğer yalnızca proteini görmek istiyorsanız:

.. code-block::

    Graphical Representations  > Selected Atoms > Protein > apply

.. image:: /assets/compmatscience-gromacs-education/gmx_vmd-protein1.png
   :align: center
   :width: 300px

.. image:: /assets/compmatscience-gromacs-education/gmx_vmd-protein2.png
   :align: center
   :width: 500px
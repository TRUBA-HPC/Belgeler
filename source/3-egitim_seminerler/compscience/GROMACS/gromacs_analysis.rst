========================
Analizler
========================

Artık protein simülasyonu tamamlandığından, sistem üzerinde bazı analizler yapılmasına hazır durumdadır. Ne tür veriler önemlidir? Bu, simülasyonu çalıştırmadan önce sorulması gereken önemli bir sorudur. Bu nedenle kendi sistemlerinizde toplamak isteyeceğiniz veri türleri hakkında bazı fikirleriniz olmalıdır. Bu analizler için birkaç temel araç tanıtılacaktır.

Bunlardan ilki koordinatları çıkarmak, periyodikliği düzeltmek veya yörüngeyi (zaman birimleri, çerçeve frekansı, vb.) manuel olarak değiştirmek için bir son işleme aracı olarak kullanılan ``trjconv`` dur. Bu örnekte, sistemdeki herhangi bir periyodikliği hesaba katmak için ``trjconv`` kullanacağız. Protein, birim hücre boyunca yayılır ve "kırılmış" görünebilir veya hücrenin diğer tarafına "zıplayabilir". Bu tür davranışları hesaba katmak için aşağıdaki kodu girin.

.. code-block::

    gmx trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_noPBC.xtc -pbc mol -center

Ortalanacak grup olarak 1 (‘Protein’) ve çıktı için 0 (‘Sistem’) seçin. Tüm analizler bu "düzeltilmiş" yörünge üzerinde yapılacaktır. Öncelikle yapısal kararlılığa bakılmalıdır. GROMACS, ``rms`` adı verilen RMSD hesaplamaları için yerleşik bir yardımcı programa sahiptir. ``rms`` kullanmak için şu komutu verin:

.. code-block::

    gmx rms -s md_0_1.tpr -f md_0_1_noPBC.xtc -o rmsd.xvg -tu ns

Hem en küçük kareler uyumu hem de RMSD hesaplaması için grup için 4'ü (‘Backbone’) seçin. Koddaki ‘-tu’ yörünge ps ile yazılmış olsa bile, sonuçların ns cinsinden verilmesini sağlar. Bu, çıktının netliği için yapılır (özellikle uzun bir simülasyonunuz varsa -1e+05 ps, 100 ns kadar güzel görünmez). Çıktı grafiği, minimize edilmiş, dengelenmiş sistemde mevcut yapıya göre RMSD' yi gösterecektir:

RMSD, kristal yapıya göre hesaplanmak istenirse;

.. code-block::

    gmx rms -s em.tpr -f md_0_1_noPBC.xtc -o rmsd_xtal.xvg -tu ns

Çizdirilen grafikse aşağıdaki gibidir:

.. image:: ../../../../assets/compmatscience-gromacs-education/gmx_rmsd.png
   :align: center
   :width: 300px

Her iki zaman serisi de RMSD seviyelerini ~0.1 nm' ye (1 Å) kadar gösterir, bu da yapının çok kararlı olduğunu göstermektedir. Grafikler arasındaki ince farklar, t=0 ns' deki yapının bu kristal yapıdan biraz farklı olduğunu göstermektedir. Enerjisi minimize edildiğinden ve konum sınırlamaları %100 mükemmel olmadığından bu beklenen bir durumdur.

Bu örnek için analizi yapılabilecek bir başka özellikse dönme yarıçapıdır. Bir proteinin dönme yarıçapı, kompaktlığının bir ölçüsüdür. Bir protein kararlı bir şekilde katlanırsa muhtemelen sabit bir R :sub:`g` değerini koruyacaktır. Bir protein açılırsa, R :sub:`g` 'si zamanla değişecektir. Simülasyonumuzda lizozim için dönme yarıçapını analiz edelim:

.. code-block::

    gmx gyrate -s md_0_1.tpr -f md_0_1_noPBC.xtc -o gyrate.xvg

Analiz için grup 1'i (Protein) seçin.

.. image:: ../../../../assets/compmatscience-gromacs-education/gmx_rot_radius.png
   :align: center
   :width: 300px

Kayda değer bir değişim göstermeyen R :sub:`g` değerlerinden proteinin, 300 K' de 1 ns boyunca kompakt (katlanmış) formunda çok kararlı kaldığını görülmektedir. Bu sonuç beklenmedik bir durum değildir.

Bu örnek için yapılan analizler GROMACS' ta yapılabilen analizlerden yalnızca birkaçıdır. GROMACS' ta serbest enerji hesaplamaları, denge dışı (non-equilibrium) MD dağılım fonksiyonları, korelasyon analizleri ve normal mod analizi gibi birçok analiz yapılabilmektedir. Daha detaylı bilgi için GROMACS el kitabı incelenebilir [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)].
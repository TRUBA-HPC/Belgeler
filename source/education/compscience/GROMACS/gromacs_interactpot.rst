=================================
Etkileşim Potansiyellerine Giriş
=================================

------------------------
Enerji Minimizasyonu
------------------------

Artık sistem suda çözünmüş, nötr bir sistemdir. Dinamiğe başlamadan önce sistemde siterik çakışmalar ve uygun olmayan geometri olmadığından emin olmalıyız. Yapı, enerji minimizasyonu (EM) olan bir süreçle gevşetilir.

EM için süreç, iyon eklemeye benzerdir. Bir kez daha Grommp kullanılarak yapı, topoloj ve simülasyon parametrelerini ikili giriş dosyalarına (.tpr) benzetilmek üzere kullanılacaktır. Ancak bu sefer ``.tpr`` yi Genion’a geçirmek yerine enerji minimizasyonu, GROMACS MD motoru (mdrun) üzerinde çalıştırılacaktır. 

Grommp kullanarak aşağıdaki giriş parametre dosyasını sayesinde ikili girişi birleştirin:

.. code-block::

    gmx grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o em.tpr

Genbox ve genionu çalıştırırken ``topol.top`` dosyanızı güncellediğinizden emin olun, aksi takdirde çok sayıda hata mesajı alabilirsiniz (koordinat dosyasındaki koordinat sayısı ile topoloji dosyası eşleşmiyor vb.).

Artık EM’yi yürütmek üzere mdrun kullanmaya hazırız:

.. code-block:

    gmx mdrun -v -deffnm em

``-v`` mdrun’ı ayrıntılı hale getirir ve her adımı ekrana yazdırır. ``deffnm`` ise girdi ve çıktının dosya adlarını tanımlar. Yani eğer grommp çıktınızı ``em.tpr`` olarak adlandırmadıysanız, adını mdrun -s bayrağıyla açıkça belirtmeniz gerekir. Bu örnek için aşağıdaki dosyaları ele alınacaktır:

* em.log: EM işleminin ASCII metin günlük dosyası

* em.edr: İkili enerji dosyası

* em.trr: İkili tam hassas yörünge

* em.gro: Enerjiyi minimize eden yapı

EM’nin başarılı olup olmadığını belirlemek için değerlendirilmesi gereken iki ana özellik vardır. Birincisi potansiyel enerjidir (``-v`` olmadan bile EM sürecinin sonunda yazdırılır). E :sub:`pot` negatif olmalı ve (sudaki basit bir protein için) sistem boyutuna ve su moleküllerinin sayısına bağlı olarak 10 :sup:`5` - 10 :sup:`6` mertebesinde olmalıdır. İkinci önemli özellikse maksimum kuvvet olan F :sub:`maks`’ın minimum düzeyde tutulmasıdır. Mdp, ``emtol=1000.0`` olan ve F :sub:`maks`’ın 1000 kj mol :sup:`-1` nm :sup:`-1`’den küçük olmasını sağlamayı hedefler. F :sub:`maks` > emtol ile mantıklı E :sub:`pot` sağlamak mümkündür. Bu durum sağlanmadığı takdirde sisteminiz simülasyon için yeterince kararlı olmayabilir. Nedenleri değerlendirilmeli ve gerekirse minimizasyon parametreleri (entegretör, emstep, vb.) değiştirilebilir. 

Analiz yapacak olursak;

``em.edr`` dosyası, GROMACS’ın EM sırasında topladığı tüm enerji terimlerini içerir. GROMACS enerji modülünü kullanarak herhangi bir ``.edr`` dosyasını analiz edebilirsiniz.

.. code-block::

    gmx energy -f em.edr -o potential.xvg

Bu adımda istediğiniz enerji çeşitini seçebilirsiniz ancak bu örnekte potansiyel enerji seçilecektir. Potansiyel (10) öğesini seçmek için ``10 0`` yazın; sıfır (0), girişi sonlandırır. Size E :sub:`pot` ortalaması gösterilecek ve ``potential.xvg`` adlı bir dosya yazılacaktır. Bu verileri grafiğe dökmek için Xmgrace çizim aracına ihtiyacınız olacaktır [http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html (Erişim tarihi: 15.07.2021)]. 

.. code-block::

    xmgrace potential.xvg

Çizilen grafik şu şekilde görünecektir:

.. image:: /assets/compmatscience-gromacs-education/gmx_minimization.png
   :align: center
   :width: 300px


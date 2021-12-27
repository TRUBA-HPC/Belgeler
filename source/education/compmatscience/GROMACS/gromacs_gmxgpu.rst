==============================================
GROMACS'in GPU Kullanılarak Çalıştırılması
==============================================

4.6 sürümünden itibaren GROMACS, MD simülasyonlarını çalıştırmak için GPU hızlandırıcılarının kullanımını desteklemektedir. 2018 sürümünün piyasaya sürülmesiyle, bağlı olmayan etkileşimler ve particle mesh Ewald (PME), yalnızca CPU çekirdeklerinde hesaplanan bağlı kuvvetler ile GPU üzerinde hesaplanmaktadır. GROMACS kurulumunda (kurulum talimatları için bkz. www.gromacs.org), varsa GPU donanımı otomatik olarak algılanacaktır. GPU hızlandırmayı kullanmak için minimum gereksinimler, CUDA kitaplıkları ve SDK ile >= 2.0 hesaplama kapasitesine sahip bir GPU' dur. Daha yaygın olan bazı GPU'ların bir listesi ve özellikleri burada bulunabilir (https://developer.nvidia.com/cuda-gpus). GPU'nuzu kullanmak için mdrun komutu şu şekildedir:

.. code-block::

    gmx mdrun -deffnm md_0_1 -nb gpu

Birden fazla GPU'nuz varsa veya işin GROMACS' ta bulunan hibrit paralelleştirme şeması aracılığıyla nasıl bölüneceğine ilişkin özelleştirmeye ihtiyaç varsa, lütfen GROMACS kılavuzuna ve web sayfasına bakınız [http://www.mdtutorials.com/gmx/lysozyme/10_analysis2.html (Erişim tarihi: 01.09.2021)].
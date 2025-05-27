.. _mn5_bsc_komutlari:

=====================
BSC Komutları
=====================

BSC destek ekibi, süperbilgisayar kullanıcılarının sistemle daha verimli çalışabilmesi için bazı yardımcı komutlar sağlamaktadır. Bu komutlar sistem kaynaklarının takibi, proje kullanımı, kuyruklar ve yazılım paketleri hakkında bilgi edinmek için kullanılabilir.

Aşağıda en sık kullanılan BSC komutlarının kısa bir özeti yer almaktadır:

Temel Komutlar
--------------

- **bsc_queues**  
  Kullanıcının erişebileceği kuyrukları ve bunların zaman/kaynak sınırlamalarını gösterir.

- **bsc_quota**  
  Erişilebilir tüm dosya sistemleri için güncel kota kullanım özetini gösterir.

- **bsc_acct**  
  Projenin şu ana kadarki hesap kullanımını ve kalan kaynaklarını gösterir.

- **bsc_load**  
  Kullanıcıya ait işler tarafından kullanılan tüm işlem düğümlerindeki yük durumunu gösterir.

Yazılım Paketleri
-----------------

- **bsc_py_packages**  
  Yüklü olan Python paketlerini aramak için kullanılır. Daha fazla bilgi için ``bsc_py_packages`` bölümüne bakınız.

- **bsc_R_packages**  
  Yüklü olan R paketlerini aramak için kullanılır. Daha fazla bilgi için ``bsc_R_packages`` bölümüne bakınız.

Proje Yönetimi
--------------

- **bsc_project**  
  Kullanıcının erişebileceği hesapları (HPC projeleri) listeler ve aktif projeyi değiştirmek için kullanılır. Daha fazla bilgi için ``bsc_project`` bölümüne bakınız.

Yardım ve Dokümantasyon
------------------------

Çoğu BSC komutunun detaylı kullanım bilgisi man sayfalarında mevcuttur. Aşağıdaki komut ile herhangi bir BSC komutunun yardım sayfasına ulaşabilirsiniz:

.. code-block:: bash

   man <bsc_komutu>

Örnek:

.. code-block:: bash

   man bsc_quota

.. note::

   Tüm komutlar her sistemde kullanılabilir olmayabilir. Erişiminiz olan komutları denetlemek için destek ekibiyle iletişime geçebilirsiniz.



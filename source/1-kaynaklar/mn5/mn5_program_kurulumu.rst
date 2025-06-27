.. _mn5_program_kurulumu:

=====================
Program Kurulumu
=====================

.. warning::

   Bu dokümantasyon, MareNostrum 5 (MN5) resmi sayfasının belirli bölümleri Türkçeye çevrilerek **Haziran 2025** tarihinde hazırlanmıştır. Sistemde yapılan güncellemeler veya değişiklikler bu belgeye yansımamış olabilir. **En güncel ve doğrulanmış bilgiye ulaşmak için lütfen BSC'nin resmi MN5 belgelerine başvurunuz:**

   https://www.bsc.es/supportkc/docs/MareNostrum5/intro/

Program Kurulumu ve Yazılım Ortamı
===================================

MareNostrum 5 (MN5) kümesinde yazılım ortamı, modül sistemi üzerinden yapılandırılmıştır. Bu bölümde önceden kurulu yazılımların konumu, modül sistemi kullanımı ve kullanıcı tarafından yazılım kurulumu hakkında bilgiler verilmektedir.

Önceden Kurulu Yazılımlar
--------------------------

Tüm önceden kurulu yazılımlar küme genelinde `/apps` dizininde yer alır. Burada uygulamalar, kütüphaneler, derleyiciler ve ortam hazırlayıcı modül dosyaları bulunur.

Eğer ihtiyacınız olan yazılım sistemde kurulu değilse, **BSC destek ekibi** ile iletişime geçerek kurulum konusunda yardım alabilirsiniz.

Modül Sistemi (modulefiles)
----------------------------

MN5, kullanıcı ortamının dinamik şekilde yapılandırılmasını sağlayan **Environment Modules** paketini kullanır. Detaylı bilgi için: https://modules.sourceforge.net

Modül dosyaları aşağıdaki dört gruba ayrılmıştır:

.. list-table:: Modül Grupları
   :widths: 30 70
   :header-rows: 1

   * - Grup
     - Açıklama
   * - applications/tools
     - HPC uygulamaları ve genel araçlar (örn. GROMACS, Perl vb.)
   * - compilers
     - Derleyiciler (örn. Intel, GCC vb.)
   * - environment
     - Ortam hazırlayıcılar (örn. Python, OpenMPI, R, SDK vb.)
   * - libraries
     - Derleme zamanında kullanılan kütüphaneler (FFTW, LAPACK vb.)

Modül Kullanımı
---------------

Bir modül aşağıdaki şekillerde yüklenebilir:

**Varsayılan sürümle yüklemek için:**

.. code-block:: bash

   module load intel

**Belirli bir sürümle yüklemek için:**

.. code-block:: bash

   module load intel/2023.2.0

Diğer yararlı komutlar:

- Yüklü modülleri görmek için: ``module list``
- Kullanılabilir modülleri listelemek için: ``module avail``
- Modül hakkında bilgi almak için: ``module help <modül_adı>``
- Daha fazla bilgi için: ``man module``

Kullanıcı Tarafından Paket Kurulumu
------------------------------------

Küme içerisinden dış internete doğrudan bağlantı bulunmamaktadır. Bu nedenle aşağıdaki durumlara dikkat edilmelidir:

.. warning::

   Paket yöneticileri (``pip``, ``conda``, ``apt``, ``yum`` vb.) doğrudan çalışmaz. İnternet erişimi sınırlıdır.

Alternatif olarak:

- Paket kaynak kodlarını **yerel makinenizden transfer makinelerine (örneğin ``transfer1.bsc.es``)** kopyalayarak kurulum yapabilirsiniz.
- Python veya R ortamları istenirse modül sisteminde bulunan uygun ortamlar aktive edilip **kendi sanal ortamınız içinde** derleme yapılabilir.

Daha fazla bilgi ve örnek kurulumlar için resmi belgeleri inceleyebilirsiniz:  
https://www.bsc.es/supportkc/docs/MareNostrum5/Installing%20packages/install_pkgs_menu

Ek Bilgi
--------

Yüklediğiniz modüller yalnızca aktif oturum için geçerlidir. Kalıcı olması için ``~/.bashrc`` veya ``~/.bash_profile`` dosyalarına aşağıdaki gibi ekleyebilirsiniz:

.. code-block:: bash

   module load intel/2023.2.0
   module load python/3.10.8

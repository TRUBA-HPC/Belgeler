.. _arf-acc:

=======
ARF-ACC
=======

.. grid:: 3

    .. grid-item-card:: :ref:`arf_acc_baglanti`
        :text-align: center
    .. grid-item-card:: :ref:`arf_acc_kuyruk_bilgisi`
        :text-align: center
    .. grid-item-card:: :ref:`arf_acc_depolama_kaynaklari`
        :text-align: center

ARF ACC, yüksek performanslı hesaplama (HPC) ihtiyaçları için özel olarak yapılandırılmış, modern donanım altyapısına sahip bir GPU hesaplama kümesidir. Bu küme, özellikle büyük ölçekli araştırma projeleri ve ileri düzey hesaplama gereksinimleri için tasarlanmıştır.

.. admonition:: Kullanım Politikaları
   :class: important

   ARF ACC hesaplama kümesinde yer alan ``kolyoz-cuda`` ve ``palamut-cuda`` kümeleri, yalnızca araştırma merkezleri tarafından yürütülen ve T.C. Cumhurbaşkanlığı Strateji ve Bütçe Başkanlığı tarafından desteklenen altyapı projeleri ile TÜBİTAK ULAKBİM kapsamında sözleşmeli proje araştırmacıları tarafından kullanılabilir. ``barbun-cuda`` ve ``akya-cuda`` kümeleri ise tüm kullanıcılarımızın erişimine açıktır.

ARF ACC üzerinde kullanıcı verileri ve hesaplama çıktıları için yüksek performanslı merkezi dosya sistemi olan ``/arf`` kullanılmaktadır. Hesaplama sırasında yüksek I/O performansı ve veri güvenliği için tüm işlerinizde bu dosya sistemini kullanmanız önerilir. Dosya sistemleri, kota ve erişim detayları için :ref:`arf_acc_depolama_kaynaklari` başlığına göz atabilirsiniz.

.. warning:: 
   Hesaplama sırasında yüksek performans için mutlaka ``/arf`` dosya sistemi kullanılmalıdır. Dosya sistemleri hakkında ayrıntılı bilgiye :ref:`yuksek-performansli-dosya-sistemleri` bölümünden erişebilirsiniz.

Daha fazla bilgi için aşağıdaki başlıklara göz atabilirsiniz:

- :ref:`arf_acc_baglanti` — Bağlantı ve erişim yöntemleri
- :ref:`arf_acc_kuyruk_bilgisi` — Kuyruklar ve teknik detaylar
- :ref:`arf_acc_depolama_kaynaklari` — Depolama ve dosya sistemleri

.. toctree::
   :hidden:

   arf_acc_baglanti.rst
   arf_acc_kuyruk_bilgisi.rst
   arf_acc_depolama_kaynaklari.rst
   
..
    .. image:: /assets/arf-acc/arf-acc.png
    :width: 100%
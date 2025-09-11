:orphan:

.. _kullanim_maliyeti:

Tahmini Kullanım Maliyeti
=========================

.. warning::

   Bu bölüm yalnızca bilgilendirme ve farkındalık oluşturma amacıyla hazırlanmıştır. Burada yer alan fiyatlar TRUBA için geçerli değildir; herhangi bir şekilde resmi ücretlendirme politikası olarak değerlendirilmemelidir.


TRUBA altyapısı, akademik araştırma ve eğitim faaliyetleri için ücretsiz olarak sunulmaktadır. Ancak kullanıcıların yararlandıkları yüksek performanslı hesaplama (HPC) kaynaklarının gerçek ekonomik değerini kavrayabilmeleri amacıyla, aynı donanım kapasitesinin önde gelen ticari bulut sağlayıcıları üzerinden temin edilmesi halinde ortaya çıkabilecek yaklaşık maliyetlere ilişkin bilgiler aşağıda sunulmaktadır.

Burada belirtilen fiyatlandırmalar, 2025 yılı itibarıyla yaygın olarak hizmet veren `Amazon Web Services (AWS) <https://aws.amazon.com/ec2/pricing/on-demand/>`_, `Google Cloud Platform (GCP) <https://cloud.google.com/compute/vm-instance-pricing?hl=en#accelerator-optimized>`_ ve `Microsoft Azure <https://azure.microsoft.com/en-us/pricing/details/machine-learning/#pricing>`_ tarafından sağlanan on-demand (liste fiyatı, taahhütsüz) GPU tabanlı sanal sunucu ücretlerine dayanmaktadır. Bölgesel fiyat farklılıkları, uzun vadeli rezervasyonlar (reserved instances), spot kullanımlar, depolama ve ağ maliyetleri hesaba katılmamıştır. Bu nedenle, aşağıdaki tablolar yalnızca TRUBA kaynaklarının piyasa değerine dair **farkındalık oluşturma amacıyla hazırlanmıştır.**

.. note::

   Bu karşılaştırmalar, TRUBA üzerinde ücretsiz sağlanan kaynakların piyasa koşullarındaki değerini ortaya koymaktadır. Kullanıcılarımızdan, bu kaynakların kamu yararına ve ortak kullanım anlayışıyla sunulduğunu göz önünde bulundurarak **sorumlu, verimli ve etik kullanım prensiplerine özen göstermeleri** ve :ref:`kullanim_kurallari` sayfasında belirtilen kurallara riayet etmeleri beklenmektedir.


.. list-table:: 2025 Yılı Bulut GPU Fiyatları (On-Demand)
   :header-rows: 1
   :widths: 15 20 15 20 25

   * - Vendor
     - Model
     - GPU Türü
     - Saatlik Ücret ($/saat)
     - Yıllık Ücret ($/yıl)
   * - AWS
     - p4de.24xlarge
     - 8x A100
     - 27.447
     - 240,435.72
   * - AWS
     - p5.48xlarge
     - 8x H100
     - 55.04
     - 482,150.40
   * - AWS
     - p5e.48xlarge
     - 8x H200
     - 63.29
     - 554,472.96
   * - Google Cloud
     - a2-ultragpu-8g
     - 8x A100
     - 40.55
     - 355,221.36
   * - Google Cloud
     - a3-highgpu-8g
     - 8x H100
     - 88.49
     - 775,172.40
   * - Google Cloud
     - a3-ultragpu-8g
     - 8x H200
     - 84.80
     - 742,908.52
   * - Microsoft Azure
     - NDm_A100_v4
     - 8x A100
     - 32.77
     - 287,065.20
   * - Microsoft Azure
     - ND-H100-v5
     - 8x H100
     - 98.32
     - 861,283.20
   * - Microsoft Azure
     - ND-H200-v5
     - 8x H200
     - 110.24
     - 965,702.40


.. _arf_acc_depolama_kaynaklari:

====================================
Dosya Sistemleri ve Depolama
====================================

ARF ACC hesaplama kümesi için :ref:`arf_depolama_kaynaklari` bölümündeki bilgiler geçerlidir. Yalnızca aşağıdaki bilgiler ek kosulları içermektedir.

**/truba Dosya Sistemi Erişimi**

- ARF ACC ortamında, ``/truba`` dosya sistemine erişim **sadece cuda-ui kullanıcı arayüzü** üzerinden mümkündür.
- Kolyoz ve palamut hesaplama sunucularında doğrudan ``/truba`` dosya sistemine erişim **bulunmamaktadır**.
- Hesaplama işlerinizi ve veri transferlerinizi planlarken bu erişim kısıtını göz önünde bulundurunuz.

**/arf Dosya Sistemi (WEKA Yüksek Performanslı Dosya Sistemi)**

- ``/arf`` dosya sistemi, WEKA tabanlı yüksek performanslı paralel dosya sistemi olarak yapılandırılmıştır.
- Tüm hesaplama sunucuları (kolyoz ve palamut dahil) ve kullanıcı arayüzleri tarafından erişilebilir durumdadır.
- Hesaplama sırasında yüksek I/O performansı ve veri güvenliği için tüm işlerinizde bu dosya sistemini kullanmanız önerilir.

Herhangi bir sorun yaşarsanız, yardım ve destek almak için lütfen :ref:`truba_iletisim` sayfasındaki teknik destek iletişim bilgilerini kullanarak bizimle iletişime geçiniz.




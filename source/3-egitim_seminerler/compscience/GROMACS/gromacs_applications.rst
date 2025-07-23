=====================
GROMACS Uygulamaları
=====================

Bu kılavuzda MD ve Coarse-Grained MD uygulamaları hakkında bilgi verilecektir. 
Örneğin, atomistik `SPC` (simple point-charge water) model suyunu kaba taneli temsiline bağlayan bir uyarlamalı çözünürlük simülasyonunun kurulumu yapılabilir. Simülasyonu kurmak için aşağıdaki adımlar takip edilecektir:

* Referans olarak bir tüm atom simülasyonu gerçekleştirin.
* Kaba taneli bir temsil oluşturun (coarse-grained) ve tablolaştırılmış etkileşim işlevi olarak kaydedin.
* SPC modelinde su için hibrit bir topoloji oluşturun.
* Atomistik koordinat dosyasını kaba taneli gösterimi içerecek şekilde değiştirin.
* Grompp girdi dosyasında uyarlanabilir simülasyonun geometrisini tanımlayın.
* Bir dizin dosyası oluşturun.

Etkileşimin kaba taneli temsili, tablolaştırılmış etkileşim işlevi olarak saklanır. Kural, C :sup:`(12)`  sütunlarını katsayısı 1 olarak ayarlanmış C:sup:`(12)` kolonlarıyla kullanmaktır. Diğer tüm kolonlar sıfır olmalıdır. Burada kaba taneli etkileşimi CG olarak adlandırılmıştır, dolayısıyla karşılık gelen tablolaştırılmış dosya ``table_CG_CG.xvg`` dir. Atomistik topoloji dosyasından (örneğin, ``share/gromacs/top/oplsaa.ff/spc.itp``) başlayabileceğiniz topolojiyi oluşturmak için burada sert suyu varsayıyoruz. `VOTCA` programı kılavuzunda, çeşitli teknikler kullanılarak etkileşimin nasıl iri taneli hale getirileceği konusunda `SPC` suyu için ayrıntılı talimatlar ve bir örnek bulunmaktadır. Daha detaylı bilgi için lütfen kılavuzu inceleyiniz [https://manual.gromacs.org/documentation/5.1/manual-5.1.pdf (Erişim tarihi:26.06.2021)].


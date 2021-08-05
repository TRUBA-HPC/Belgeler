# Belgeler

Bu depo [TRUBA Belge Sunucusu](http://docs.truba.gov.tr)'nda kullanılan belgeleri içermektedir.

## Belgelere katkıda bulunma

Belgelere katkıda bulunmadan önce lütfen TRUBA ekibiyle iletişime geçiniz: ncc@ulakbim.gov.tr

Belgelere katkıda bulunmak için bu depoyu çatalladıktan sonra yeni dalda çalışmanız gerekmektedir:

![](https://raw.githubusercontent.com/TRUBA-HPC/Belgeler/main/fork.png)

```
git clone https://github.com/[YOUR_USERNAME]/Belgeler.git # Çatalladığınız depoyu bilgisayarınıza klonlayın.
git checkout -b [NEW_BRANCH] # Yeni dal yaratın
```

Değişiklikleri yaptıktan sonra:

```
git add --all
git commit -m "information about this commit"
git push origin [NEW_BRANCH]
```

Yaptığınız tüm değişiklikleri GitHub'a ittikten sonra TRUBA ekibine GitHub üzerinden çekme isteği (pull request) gönderebilirsiniz.

## HTML sayfalarının derlenmesi

Bilgisayarınızda Docker kuruluysa HTML sayfalarını derlemek için şu komutları kullanabilirsiniz:
- ``docker run`` ile başlayan komutta ``/path/to/truba-belgeler`` ve ``/path/to/build`` patikalarını güncellemeyi unutmayın.

```
mkdir build
git clone https://github.com/TRUBA-HPC/Belgeler.git truba-belgeler
docker run --rm -v /path/to/truba-belgeler:/docs -v /path/to/build:/build keremkayabay/sphinx:latest sphinx-build -b html /docs/source /build
```

Derlenen dosyaları ``build`` klasöründe bulabilirsiniz.

``main`` yerine başka bir dal klonlamak için aşağıdaki komutu kullanabilirsiniz:

```
git clone -b [BRANCH_NAME] https://github.com/TRUBA-HPC/Belgeler.git truba-belgeler
```

## Belgeleme sistemi hakkında genel bilgi

[TRUBA Kullanıcı Dökümanları'nda](https://docs.truba.gov.tr) bulunan başlıklar [dört ana kategoride](https://documentation.divio.com/) toplanmıştır:
- Referans materyalleri (TRUBA Hakkında)
- Nasıl yapılır kılavuzları (Uygulama Kılavuzları)
- Detaylı açıklamalar (Eğitim Materyalleri)
- Öğretici başlangıç materyalleri

Başlıklar altında bulunan belgelere katkıda bulunmadan önce [kullanılan belgeleme sistemini](https://www.youtube.com/watch?v=t4vKPhjcMZg) inceleyerek kategorilerin özelliklerine göre içerik üretmek tutarlılığın bozulmasını engellemek için önemlidir.

## Lisans hakkında bilgi

EuroCC@Türkiye projesi kapsamında sunulan tüm materyaller, [Creative Commons Atıf lisansı (CC-BY-NC-SA-4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/) altında sağlanır. 
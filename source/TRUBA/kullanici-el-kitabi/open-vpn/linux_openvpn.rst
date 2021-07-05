===========================================
Linux İşletim Sistemi için OpenVPN Kurulumu
===========================================

OpenVPN  yapılandırması için öncelikle işletim sistemine OpenVPN kurulumunu yapmanız gerekmektedir. Linux işletim sistemi için gerekli adımlar
aşağıda verilmiştir. Sırasıyla takip ederek kurulumu gerçekleştirebilir ve TRUBA bilgisayarlarına erişim sağlayabilirsiniz.

**1.** İlk adım olarak bilgisyarınızda terminal uygulamasını açtıktan sonra, terminale aşağıdaki kpomut satırını girerek **openvpn** uygulamasını 
kuralım. 

.. code-block:: bash
     
 sudo apt-get install openvpn 

**2.** Bilgisayarınızda kurulum sağlandıktan sonra işletim sisteminize uygun yapılandırma dosyasını aşağıdaki linkten bilgisayarınıza indiriniz ve kaydediniz.

* :download:`OpenVPN genel yapılandırma dosyası </assets/openvpn-truba/config-files/truba-genel.ovpn>`

**3.** .opvn uzantılı dosyanın olduğu dizinde terminalizi açıp aşağıdaki kod satrını giriniz.

.. code-block:: bash
     
	sudo openvpn TRUBA-genel.ovpn 

**4.** Kod satırından sonra aşağıdaki gibi ekranda kullanıcı adı ve şifrenizin sorulduğu ekran gelecektir. 

.. image:: /assets/openvpn-truba/images/openvpn-linux.png   
   :width: 1000

.. warning:: 

	Yukarıdaki işlemleri tamamladıktan sonra terminalizi kapatmayınız. Kapattığınız takdirde vpn bağlantınız sonlanacaktır.

**5.** Vpn uygulamasını çalıştırdığınız terminali kapatmadan yeni bir terminal açarak aşağıdaki kod satırını
terminalinize yazarak TRUBA bilgisayarlarına erişebilirsiniz. Aşağıda verilen adres levrek sunucularına erişim içindir.
Diğer sunucular için farklı adresler **OpenVPN Bağlantısı Hakkında Genel Bilgi** başlığı altında verilmiştir.

.. code-block:: bash
     
	ssh  kullanici_adi@172.16.7.1    

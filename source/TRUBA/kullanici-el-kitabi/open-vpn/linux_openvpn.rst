===========================================
Linux İşletim Sistemi için OpenVPN Kurulumu
===========================================

OpenVPN yapılandırması için öncelikle işletim sistemine OpenVPN kurulumunu yapmanız gerekmektedir. Linux işletim sistemi için gerekli adımlar aşağıda verilmiştir. Adımları sırasıyla takip ederek kurulumu gerçekleştirebilir ve TRUBA bilgisayarlarına erişim sağlayabilirsiniz.

**1.** İlk adım olarak bilgisayarınızda terminal uygulamasını açtıktan sonra, terminale aşağıdaki komut satırını girerek **OpenVPN** uygulamasını kurabilirsiniz. 

.. code-block:: bash
     
	sudo apt-get install openvpn 

**2.** Bilgisayarınızda kurulum sağlandıktan sonra işletim sisteminize uygun yapılandırma dosyasını aşağıdaki linkten bilgisayarınıza indiriniz ve kaydediniz.

* :download:`OpenVPN genel yapılandırma dosyası </assets/openvpn-TRUBA/config-files/TRUBA-genel.ovpn>`

**3.** ``.ovpn`` uzantılı dosyanın olduğu dizinde terminalinizi açıp aşağıdaki kod satırını giriniz.

.. code-block:: bash
     
	sudo openvpn TRUBA-genel.ovpn 

**4.** Kod satırından sonra aşağıdaki gibi ekranda kullanıcı adı ve şifrenizin sorulduğu ekran gelecektir. 

.. image:: /assets/openvpn-TRUBA/images/openvpn-linux.png   
   :width: 1000

.. warning:: 

	Yukarıdaki işlemleri tamamladıktan sonra terminalinizi kapatmayınız. Kapattığınız takdirde VPN bağlantınız sonlanacaktır.

**5.** VPN uygulamasını çalıştırdığınız terminali kapatmadan yeni bir terminal açarak aşağıdaki kod satırını terminalinize yazarak TRUBA bilgisayarlarına erişebilirsiniz. Aşağıda verilen adres levrek sunucularına erişim içindir. Diğer sunucular için farklı adresler :ref:`openvpn-info` sayfasında verilmiştir.

.. code-block:: bash
     
	ssh kullanici_adi@172.16.7.1    

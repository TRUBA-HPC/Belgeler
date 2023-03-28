.. _putty_ssh_tunnel:

==============================================
PuTTY ile ssh tüneli oluşturma
==============================================

Diyelim ki ssh tüneli oluşturmak için 

.. code-block:: bash

    ssh -N -L localhost:[PORT]:[HOSTNAME]:PORT kullanici_id@172.16.7.1

komutunu Windows makinelerde PuTTY ayarlamaları ile yapmak istiyoruz.

Windows kullanıcılar için açık olan PuTTY'yi kapatmadan yeni bir PuTTY açıp Host Name (or IP address) yerine `172.16.7.1` bilgileri girilir. Ayrıntılı olarak :ref:`windows_putty` sayfasına bakabilirsiniz.

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/PuTTY_ssh_tunnels_0.png  

Sonra yine aynı PuTTY içerisinde aşağıdaki figürde belirtilen ayarlamalar ile ssh tüneli oluşturulabilir.

.. image:: /assets/kullanici-arayuzu/ssh-ile-baglanti/putty/images/PuTTY_ssh_tunnels_1.png  

Sonrasında ``Open`` tıklanılarak kullanıcı adı ve şifre bilgileriniz girerek tünel işlemleriniz tamamlanır.


# download and install
wget https://dl.influxdata.com/influxdb/releases/influxdb-1.7.1.x86_64.rpm
sudo yum localinstall influxdb-1.7.1.x86_64.rpm

# copy ssl key and config file. Then, restart
sudo cp influxdb-selfsigned.* /etc/ssl/
sudo cp influxdb.conf /etc/influxdb
sudo chown root:root /etc/ssl/influxdb-selfsigned.crt
sudo chmod 644 /etc/ssl/influxdb-selfsigned.crt
sudo chmod 644 /etc/ssl/influxdb-selfsigned.key

if [ -e influxdb.conf ];then
	sudo cp influxdb.conf /etc/influxdb/influxdb.conf
else
	sudo sed -e 's/# https-enabled = false/https-enabled = true/g' /etc/influxdb/influxdb.conf
	sudo sed -e 's/# https-certificate = "/etc/ssl/influxdb.pem"/https-certificate = "/etc/ssl/influxdb-selfsigned.crt/g'/etc/influxdb/influxdb.conf
	sudo sed -e 's/# https-private-key = ""/https-private-key = "/etc/ssl/influxdb-selfsigned.key"/g' /etc/influxdb/influxdb.conf
fi
echo Do you want to set the bind address used by the HTTP service?\(y/n\)?
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ] || [ "$answer" = "YES" ] || [ "$answer" = "yes" ] || [ "$answer" = "Yes" ] ;then
	ip_1="$(ip addr show|grep eth0|grep inet|awk '{print $2}')";echo "${a::-3}"
	echo Your bind address is "$ip_1"
	sudo sed -i "s/# bind-address = \":8086\"/bind-address = \"${ip_1}:8086\"/g" /etc/influxdb/influxdb.conf
fi

# restart and remove rpm
sudo service influxdb restart
sudo rm influxdb-1.7.1.x86_64.rpm


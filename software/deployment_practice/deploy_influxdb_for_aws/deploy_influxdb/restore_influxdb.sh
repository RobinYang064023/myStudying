echo Please input the date corresponding to your bakup file\(eg. 20181116\).
read date_1
echo Please input the date corresponding to your bakup file again\(eg. 20181116\).
read date_2
if [ "$date_1" = "$date_2" ] ;then
	if [ -d "/home/$(whoami)/backup_influxdb/backup_influxdb_$date_1" ]; then
		echo Are you sure to restore "$date_1"\(y/n\)\? \(It will remove the origin. You have to recovery by restore newest backup later.\)
		read answer
		if [ "$answer" = "y" ] || [ "$answer" = "Y" ] || [ "$answer" = "YES" ] || [ "$answer" = "yes" ] || [ "$answer" = "Yes" ] ;then
			sudo service influxdb stop
			sudo rm -rf /var/lib/influxdb/meta
			sudo rm -rf /var/lib/influxdb/data
			sudo influxd restore -metadir /var/lib/influxdb/meta -datadir /var/lib/influxdb/data -db mydb /home/$(whoami)/backup_influxdb/backup_influxdb_$date_1
			sudo chown -R influxdb:influxdb /var/lib/influxdb
			sudo service influxdb start
		else
			echo Process exit!
		fi
	else
		echo There is no backup_influxdb_$date_1
	fi
else
	echo Different date!
fi


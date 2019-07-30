echo please input the date\(eg. 20181116\).
read date_1
echo please input the date again\(eg. 20181116\).
read date_2
if [ $date_1 == $date_2 ] ;then
	echo Are you sure to backup as backup_influxdb_$date_1\(y/n\)\?
	read answer
	if [ "$answer" = "y" ] || [ "$answer" = "Y" ] || [ "$answer" = "YES" ] || [ "$answer" = "yes" ] || [ "$answer" = "Yes" ] ;then
		sudo mkdir -p /home/$(whoami)/backup_influxdb
		sudo influxd backup -database mydb -retention autogen -since 2016-02-01T00:00:00Z /home/$(whoami)/backup_influxdb/backup_influxdb_$date_1
		echo Completed! The backup is locate at /home/$(whoami)/backup_influxdb/backup_influxdb_$date_1.
	else
		echo Process exit!
	fi
else
	echo you input the different date.
fi


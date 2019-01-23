# Deploy Influxdb for Grafana on AWS-EC2
---

## **Introduction**
---
Launch an EC2 on AWS to host Influxdb in a private subnet.
This sop use internet gateway(but not NAT gateway) to communicate with yum server.
We assume that the setting of VPC, subnet and sort of it are done.

## **Step by Step**
---

1. Go to AWS-VPC Dashboard -> Route Tables -> Click "your outside Route Tables" and click "Subnet Associations" -> "Edit subnet associations"
2. Choose "the inside subnet" and save it.
3. Go to AWS-EC2 Dashboard -> Instance -> Click "Launch Instance"
4. Select "the machine you need" -> pick "what you need" -> Click "Next"
5. Config as shown below
```
Network:
"your VPC"
Subnet:
"your inside subnet"
Auto-assign Public IP:
Enable
```
6. Then, click "Next"
7. Change size to "what you need(30 GiB)" and click "Next".
8. Skip "Add Tags" to "Configure Security Group". --Do not skip if you need.
9. Choose Select an existing security group
10. Choose "yout existing security group"
11. Check the launch.
12. If nothing wrong, click the "launch".
13. Select a key pair: "your key pair"
14. 
```
# Access grafana-server(interface to access private subnet)
ssh -i "you_key_pair_outside.pem" ec2-user@public-DNS

# Copy the deploy scripts and Access influxdb-server(just established)
scp -r -i "your_key_pair.pem" deploy_influxdb/ ec2-user@private-DNS:/home/ec2-user
ssh -i "your_key_pair.pem" ec2-user@private-DNS

# Copy the backup for restoring(optional)
# =========================================
# Copy all backup
scp -r -i "your_key_pair.pem" backup_influxdb/ ec2-user@private-DNS:/home/ec2-user
# Copy specified data by date
scp -r -i "your_key_pair.pem" backup_influxdb/backup_influxdb_20181212 ec2-user@private-DNS:/home/ec2-user
# =========================================

# Deploy
sudo yum update
cd deploy_influxdb/
sh deploy_influxdb.sh

# Create admin for influx
influx -username admin -password your_password -host your_ip_bind_address -ssl -unsafeSsl
create user admin with password 'your password' with all privileges
create database mydb
exit

# Restore Previous Database(optional)
sh restore_influxdb.sh

```
15. Go to AWS-VPC Dashboard -> Route Tables -> Click "your inside Route Tables" and click "Subnet Associations" -> "Edit subnet associations"
16. Choose "the inside subnet" and save it.
17. Use Chorme to browse you grafana web UI.
18. Add the new Influxdb server to your datasource.

*Issue:*
We use internet gateway to communicate with yum server(for install influxdb). However, using NAT gateway which can hide the public IP and reduce the sop steps might be a better way.


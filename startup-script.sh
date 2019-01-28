#Sample ELasticSearch Install#
#!/bin/bash
sysctl -w vm.swappiness=0
setenforce 0
firewall-cmd --permanent --add-port=9200/tcp
firewall-cmd --permanent --add-port=9300/tcp
firewall-cmd --reload   
yum -y install java-1.8.0-openjdk wget
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.4.rpm
rpm -ivh elasticsearch-6.2.4.rpm
systemctl daemon-reload
systemctl enable elasticsearch.service
echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
systemctl start elasticsearch.service
#Sample ELasticSearch Install#
#!/bin/bash
sudo apt-get install default-jre wget
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - 
sudo apt-get install elasticsearch
echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
sudo service elasticsearch restart

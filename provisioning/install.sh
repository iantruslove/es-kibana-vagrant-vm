#! /bin/sh

cd /home/vagrant/

echo "Installing Java and Elasticsearch..."
apt-get update -qq
apt-get install -qy curl python-software-properties
add-apt-repository ppa:webupd8team/java
wget -q - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" >> /etc/apt/sources.list

apt-get update -qq

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get install -qqy oracle-java8-installer

apt-get install -qqy --force-yes elasticsearch
update-rc.d elasticsearch defaults 95 10

cat > /etc/elasticsearch/elasticsearch.yml <<EOF
cluster.name: elasticsearch-elk
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
EOF

service elasticsearch restart

echo "Exporting environment variables..."
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# for later
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> /home/vagrant/.bashrc

# Everything above was done as sudo...
chown -R vagrant.vagrant /home/vagrant/

echo "Installing Kibana 4..."

rm -rf /tmp/kibana4 && mkdir -p /tmp/kibana4 && cd /tmp/kibana4
wget -q https://download.elasticsearch.org/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz
tar zxf kibana*.tar.gz
mkdir -p /opt/kibana4
mv kibana*/* /opt/kibana4

cp /vagrant/provisioning/files/kibana4 /etc/init.d/kibana4
sudo chmod +x /etc/init.d/kibana4
sudo update-rc.d kibana4 defaults 96 9
sudo service kibana4 start

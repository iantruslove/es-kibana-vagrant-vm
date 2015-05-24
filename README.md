elk-vm
===================

Create a box which includes
* Oracle Java 8
* Elasticsearch 1.5
* Kibana 4

Use
===

Prerequisites:

* Vagrant

Clone this project to local machine and run

    vagrant up

This would up the ubuntu server box and install some packages. Once running is done, you should see the "Good luck!" message, so everything shoud be ready. 

* SSH to VM

		vagrant ssh

* It's done!
  * [Elasticsearch](http://192.168.100.48:9200)
  * [Kibana4](http://192.168.100.48:5601/)

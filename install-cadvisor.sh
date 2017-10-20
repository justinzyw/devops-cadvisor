#!/bin/bash

# Fetch the variables
. parm.txt

# function to get the current time formatted
currentTime()
{
  date +"%Y-%m-%d %H:%M:%S";
}

#echo ---$(currentTime)---populate the volumes---
#to zip, use: sudo tar zcvf devops_portainer_volume.tar.gz /var/nfs/volumes/devops_cadvisor*
#sudo tar zxvf devops_cadvisor_volume.tar.gz -C /


echo ---$(currentTime)---create cadvisor service---
sudo docker service create -d \
--publish $CADVISOR_PORT:8080 \
--name devops-cadvisor \
--hostname="{{.Node.ID}}" \
--mount type=bind,src=/,dst=/rootfs \
--mount type=bind,src=/var/run,dst=/var/run \
--mount type=bind,src=/sys,dst=/sys \
--mount type=bind,src=/var/lib/docker/,dst=/var/lib/docker \
--mount type=bind,src=/dev/disk/,dst=/dev/disk/ \
--network $NETWORK_NAME \
--mode global \
$CADVISOR_IMAGE \
-logtostderr \
-storage_driver=influxdb \
-storage_driver_db=cadvisor \
-storage_driver_host=devops-grafanadb:8086
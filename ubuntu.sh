#!/bin/bash

set -x

export QEMU_AUDIO_DRV=none

sudo chown $USER:$USER /dev/kvm

mem=4G
disk=ubuntu_14.04.3.qcow2
smp=2

bridge=br0
this_user=$USER

# create tap0 interface
#sudo tunctl -u $USER
tap=`sudo tunctl -u $this_user | sed 's/['\'']//g' | awk '{print  $2}'`
sleep 1

# bridge tap0 with br0
sudo brctl addif $bridge $tap

# bring the tap0 link up
sudo ip link set $tap up

sudo ../../qemu/x86_64-softmmu/qemu-system-x86_64 \
	-smp $smp \
	-m $mem \
	-enable-kvm \
	-cpu host \
	-drive file=$disk,if=virtio \
	-net nic,model=virtio,macaddr=52:54:00:12:34:49 \
	-net tap,ifname=$tap,script=no,downscript=no \
	-vnc :10 \
#	-device virtio-qcuda-pci \
#	-monitor stdio

# bring the tap0 link down
		 sudo ip link set $tap down

# remove tap0 from the bridge
		 sudo brctl delif $bridge $tap

# remove the tap0 interface
		 sudo tunctl -d $tap

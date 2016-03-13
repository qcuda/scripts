#!/bin/bash

set -x

# configfile=/etc/vfio-pci1.cfg

# vfiobind() {
#     dev="$1"
#         vendor=$(cat /sys/bus/pci/devices/$dev/vendor)
#         device=$(cat /sys/bus/pci/devices/$dev/device)
#         if [ -e /sys/bus/pci/devices/$dev/driver ]; then
#                 echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
#         fi
#         echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
#   
# }

# modprobe vfio-pci

# cat $configfile | while read line;do
#     echo $line | grep ^# >/dev/null 2>&1 && continue
#         vfiobind $line
# done

# DISKIMG=/opt/win7_64.img
VIRTIMG=virtio-win-0.1-74.iso
# WIN7IMG=/opt/Win_Ent_7w_SP1_64BIT_Chn.ISO
DISKIMG=/opt/luis-win7_64.qcow2
# DISKIMG=/home/luis/Documents/qcuda/vm/ubuntu_14.04.3.qcow2
WIN7IMG=/dev/cdrom


# /home/luis/Documents/qcuda/qcu-device/x86_64-softmmu/qemu-system-x86_64 -vga none -bios /home/sslab/myseabios/seabios/out/bios.bin -drive file=${DISKIMG},if=virtio -m 8192 -enable-kvm -M q35 -cpu host,kvm=off \

#  -device vfio-pci,host=05:00.0,x-vga=on \
#  -device vfio-pci,host=05:00.1 \
#  -device vfio-pci,host=00:1d.0 \
#  -device vfio-pci,host=00:1a.0 \

# /home/luis/Documents/qcuda/qcu-device
./qemu/x86_64-softmmu/qemu-system-x86_64 \
	-smp 2 \
	-m 4G \
	-enable-kvm \
	-cpu host \
	-drive file=${DISKIMG},if=virtio \
	-net nic,model=virtio -net user \
	-drive file=${VIRTIMG},index=3,media=cdrom,format=raw \
	-rtc base=localtime,clock=host \
	-vnc :9 \
  -cdrom ${WIN7IMG} \
	-net user,hostfwd=tcp::10022-:22,hostfwd=tcp::3389-:3389,hostfwd=udp::3389-:3389 -net nic \
#	-full-screen \
#  -boot d

exit 0

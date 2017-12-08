PATH=$PATH:/opt/nvidia/bin

ldconfig 

modprobe -r nouveau

modprobe -d /opt/nvidia nvidia
modprobe -d /opt/nvidia nvidia-uvm
modprobe -d /opt/nvidia nvidia-modeset


/bin/bash -c /opt/nvidia/bin/nvidia-mkdev


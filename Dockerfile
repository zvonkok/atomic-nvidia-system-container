FROM 	centos:7

RUN 	yum install -y kernel-devel-3.10.0-693.el7.x86_64 wget gcc make
RUN	wget https://us.download.nvidia.com/tesla/384.81/NVIDIA-Linux-x86_64-384.81.run
RUN 	chmod +x NVIDIA-Linux-x86_64-384.81.run
RUN 	./NVIDIA-Linux-x86_64-384.81.run -x
WORKDIR NVIDIA-Linux-x86_64-384.81 
RUN     ./nvidia-installer -s -a -q --x-prefix=/opt/nvidia --opengl-prefix=/opt/nvidia --utility-prefix=/opt/nvidia --documentation-prefix=/opt/nvidia --no-kernel-module
RUN     mkdir -p /opt/nvidia/lib/modules/3.10.0-693.el7.x86_64/kernel/drivers/video/
RUN     SYSSRC=/usr/src/kernels/3.10.0-693.el7.x86_64 make -C kernel
RUN	cp kernel/*.ko /opt/nvidia/lib/modules/3.10.0-693.el7.x86_64/kernel/drivers/video/.
RUN     mkdir -p /system-container/nvidia

CMD 	cp -a -rv /opt/nvidia/* /system-container/nvidia/.


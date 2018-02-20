FROM 	registry.access.redhat.com/rhel7

USER    0


RUN     mkdir -p /opt/nvidia/bin

COPY    yum.repos.d/* /etc/yum.repos.d/
COPY    *.pem /var/lib/yum/


RUN     yum -y install kernel-devel-`uname -r`

RUN     rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN     rpm -ivh https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm


RUN     mkdir -p /lib/modules/`uname -r`
RUN     ln -s /usr/src/kernels/`uname -r` /lib/modules/`uname -r`/build


RUN     yum -y install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-devel
RUN     curl -s -L https://nvidia.github.io/nvidia-container-runtime/centos7/x86_64/nvidia-container-runtime.repo |  tee /etc/yum.repos.d/nvidia-container-runtime.repo
RUN     yum -y install nvidia-container-runtime-1.1.1-1.docker1.13.1.x86_64


COPY    copy-cap-sys.sh /usr/local/bin/.
CMD     copy-cap-sys.sh compute utility


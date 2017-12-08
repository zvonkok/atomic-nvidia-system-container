SYS_CON_DIR := /root/atomic-nvidia-system-container/system-container

VERSION := 384.81

all: build

system-container/nvidia: Makefile
	mkdir -p $@

NVIDIA: Dockerfile system-container/nvidia
	docker build -t atomic-nvidia . -f Dockerfile
	docker run  --rm -v $(SYS_CON_DIR):/system-container:Z atomic-nvidia	

libnvidia-container: Makefile 
	git clone https://github.com/zvonkok/libnvidia-container.git || true && \
	cd libnvidia-container && \
	docker build  --build-arg USERSPEC=$(id -u):$(id -g) -t atomic-libnvidia . -f Dockerfile.centos && \
	docker run --rm -v $(SYS_CON_DIR):/opt:Z atomic-libnvidia
	
nvidia-container-runtime: Makefile
	git clone https://github.com/zvonkok/nvidia-container-runtime.git || true && \
	cd nvidia-container-runtime && \
	SYS_CON_DIR=$(SYS_CON_DIR) make 1.12.6-centos7

nouveau: Makefile
	modprobe -r nouveau

build: nouveau NVIDIA libnvidia-container nvidia-container-runtime

clean:
	rm -rf system-container/nvidia

.PHONY: clean build all

# yum install atomic
# docker login --username zvonkok --password='o2lZcl!On1oCCN&g' docker.io
# atomic pull --storage ostree docker.io/zvonkok/redhat:nvidia-384.81
# atomic install --system --system-package=no zvonkok/redhat:nvidia-384.81
# ldconfig
# modprobe -r nouveau
# modprobe -d /opt/nvidia nvidia 
# modprobe -d /opt/nvidia nvidia-uvm 
# modprobe -d /opt/nvidia nvidia-modeset

# mount --bind /root/atomic-nvidia-system-container/hooks.d/ /usr/libexec/oci/hooks.d/
# docker run -it mnist-keras-tensorflow-cuda9



VERSION := 384.81

KVERSION := $(uname -r)

all: build

system-container/nvidia: Makefile
	mkdir -p $@

repo:   Makefile
	cp -r /etc/yum.repos.d/ .
	cp /var/lib/yum/*.pem .

NVIDIA: Dockerfile system-container/nvidia repo
	docker build -t atomic-nvidia . -f Dockerfile
	docker run --rm -v $(shell pwd)/system-container/exports/hostfs/opt/nvidia:/opt/nvidia:Z atomic-nvidia	

nouveau: Makefile
	modprobe -r nouveau

build: nouveau NVIDIA

clean:
	rm -rf system-container/nvidia

.PHONY: clean build all

# yum install atomic
# docker login --username zvonkok --password='' docker.io
# docker pull docker.io/zvonkok/redhat:mnist-keras-tensorflow-cuda9
# atomic pull --storage ostree docker.io/zvonkok/redhat:nvidia-384.81
# atomic install --system --system-package=no zvonkok/redhat:nvidia-384.81

# chcon -t svirt_sandbox_file_t  /dev/nvidia*

# mount --bind /root/hooks.d/ /usr/libexec/oci/hooks.d/
# docker run -it docker.io/zvonkok/redhat:mnist-keras-tensorflow-cuda9


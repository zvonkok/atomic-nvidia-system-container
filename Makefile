
SYS_CON_DIR := /root/atomic-nvidia-system-container/system-container/exports/hostfs/opt


all: build



system-container/exports/config.json.template: Makefile
	printf '{"process" : {"args" : []}, "root" : {"path" : "rootfs", "readonly" : true}\n\n}' > $@

system-container/exports/manifest.json: system-container/manifest.json $(MODULE_DIR)
	cp  $< $@

system-container/exports/hostfs/etc/dracut.conf.d/nvidia.conf: Makefile
	mkdir -p $(dir $@)
	printf "echo drivers_dir+=/opt/nvidia/lib/modules/$(uname -r)/\n" > $@

system-container/exports/hostfs/opt/nvidia: Makefile
	mkdir -p $@

system-container/exports/hostfs/etc/ld.so.conf.d/nvidia.conf: Makefile
	@echo "/opt/nvidia/lib" > $@

exports: system-container/exports/hostfs/opt/nvidia \
	 system-container/exports/manifest.json \
         system-container/exports/config.json.template \
	 system-container/exports/hostfs/etc/dracut.conf.d/nvidia.conf \
	 system-container/exports/hostfs/etc/ld.so.conf.d/nvidia.conf \
	 NVIDIA libnvidia-container nvidia-container-runtime 


NVIDIA: Dockerfile
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

atomic-nvidia-syscon: exports 
	cd system-container
	docker build -t atomic-nvidia-syscon .


build: exports atomic-nvidia-syscon



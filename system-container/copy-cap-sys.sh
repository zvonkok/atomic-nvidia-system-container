#!/bin/bash

VERSION=$1

cp nvidia/bin/nvidia-smi exports/hostfs/opt/nvidia/bin/.
cp nvidia/bin/nvidia-debugdump exports/hostfs/opt/nvidia/bin/.
cp nvidia/bin/nvidia-persistenced exports/hostfs/opt/nvidia/bin/.
cp nvidia/bin/nvidia-cuda-mps-control exports/hostfs/opt/nvidia/bin/.
cp nvidia/bin/nvidia-cuda-mps-server exports/hostfs/opt/nvidia/bin/.

cp nvidia/lib/libnvidia-ml.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libnvidia-cfg.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libcuda.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libnvidia-opencl.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libnvidia-ptxjitcompiler.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libnvidia-fatbinaryloader.so.${VERSION} exports/hostfs/opt/nvidia/lib/.
cp nvidia/lib/libnvidia-compiler.so.${VERSION} exports/hostfs/opt/nvidia/lib/.

cp -a nvidia/lib/modules exports/hostfs/opt/nvidia/lib/.

cp nvidia/bin/nvidia-container-runtime-hook exports/hostfs/opt/nvidia/bin/.
cp nvidia/bin/nvidia-container-cli exports/hostfs/opt/nvidia/bin/.

cp nvidia/lib/libnvidia-container.so.* exports/hostfs/opt/nvidia/lib/.

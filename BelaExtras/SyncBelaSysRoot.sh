#!/bin/bash
set -euo pipefail

BELA_IP=192.168.7.2

mkdir -p /usr/local/linaro/BelaSysroot/usr/xenomai/include
mkdir -p /usr/local/linaro/BelaSysroot/root/Bela/include
mkdir -p /usr/local/linaro/BelaSysroot/usr/include/alsa
mkdir -p /usr/local/linaro/BelaSysroot/usr/local/include

mkdir -p /usr/local/linaro/BelaSysroot/root/Bela/lib
mkdir -p /usr/local/linaro/BelaSysroot/usr/xenomai/lib
mkdir -p /usr/local/linaro/BelaSysroot/usr/local/lib
mkdir -p /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/

rsync -avz root@$BELA_IP:/usr/xenomai/include /usr/local/linaro/BelaSysroot/usr/xenomai
rsync -avz root@$BELA_IP:/usr/include/alsa /usr/local/linaro/BelaSysroot/usr/include
rsync -avz root@$BELA_IP:/root/Bela/include /usr/local/linaro/BelaSysroot/root/Bela
rsync -avz root@$BELA_IP:/root/Bela/build/pru/pru_rtaudio_irq_bin.h /usr/local/linaro/BelaSysroot/root/Bela/include
rsync -avz root@$BELA_IP:/root/Bela/build/pru/pru_rtaudio_bin.h /usr/local/linaro/BelaSysroot/root/Bela/include
rsync -avz root@$BELA_IP:/usr/local/include/prussdrv.h /usr/local/linaro/BelaSysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/include/seasocks /usr/local/linaro/BelaSysroot/usr/local/include

 
rsync -avz root@$BELA_IP:/root/Bela/lib /usr/local/linaro/BelaSysroot/root/Bela
rsync -avz root@$BELA_IP:/usr/xenomai/lib /usr/local/linaro/BelaSysroot/usr/xenomai

rsync -avz root@$BELA_IP:/usr/local/lib/libpd.* /usr/local/linaro/BelaSysroot/usr/local/lib
rsync -avz root@$BELA_IP:/usr/local/lib/libseasocks.* /usr/local/linaro/BelaSysroot/usr/local/lib
rsync -avz root@$BELA_IP:/usr/local/lib/libprussdrv.* /usr/local/linaro/BelaSysroot/usr/local/lib

rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libsndfile.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libasound.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libFLAC.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libvorbis.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libvorbisenc.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libvorbisfile.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/
rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libogg.* /usr/local/linaro/BelaSysroot/usr/lib/arm-linux-gnueabihf/

rsync -avz root@$BELA_IP:/usr/include/ne10 /usr/local/linaro/BelaSysroot/usr/include
rsync -avz root@$BELA_IP:/usr/include/math_neon.h /usr/local/linaro/BelaSysroot/usr/include
rsync -avz root@$BELA_IP:/usr/include/sndfile.* /usr/local/linaro/BelaSysroot/usr/include

rsync -avz root@$BELA_IP:/usr/lib/libNE10.* /usr/local/linaro/BelaSysroot/usr/lib
rsync -avz root@$BELA_IP:/usr/lib/libmathneon.* /usr/local/linaro/BelaSysroot/usr/lib

rsync -avz root@$BELA_IP:/usr/local/include/libpd /usr/local/linaro/BelaSysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/lib/libpd.so* /usr/local/linaro/BelaSysroot/usr/local/lib

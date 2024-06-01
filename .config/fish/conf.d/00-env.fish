# Compiling
set -Ux NUMCPUS $(nproc)
set -Ux NUMCPUSPLUSONE $(math $NUMCPUS + 1)
set -Ux MAKEOPTS "-j$NUMCPUSPLUSONE -l$NUMCPUS"

set -Ux EMERGE_DEFAULT_OPTS "--jobs=$NUMCPUSPLUSONE --load-average=$NUMCPUS"

# Xdebug
set -Ux XDEBUG_CONFIG "remote_enable=1 remote_host=127.0.0.1 remote_port=9000 remote_mode=req"

set -Ux QT_AUTO_SCREEN_SCALE_FACTOR 1
set -Ux GDK_SCALE 1

# Qemu
set -Ux QEMU_AUDIO_DRV alsa


#!/bin/sh
# Do not sync packages, if cache is mounted
test -f /var/cache/pacman/not_mounted && sudo pacman --sync --sysupgrade --refresh --noconfirm --overwrite '/etc/*'
$*

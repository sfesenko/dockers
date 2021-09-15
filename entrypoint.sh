#!/bin/sh
# Do not sync packages, if cache is mounted
test -f /var/cache/pacman/not_mounted && sudo pacman --sync --refresh
$*
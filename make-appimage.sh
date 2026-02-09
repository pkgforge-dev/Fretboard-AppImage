#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q fretboard | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/dev.bragefuglseth.Fretboard.svg
export DESKTOP=/usr/share/applications/dev.bragefuglseth.Fretboard.desktop
export STARTUPWMCLASS=dev.bragefuglseth.Fretboard # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1
export ALWAYS_SOFTWARE=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/fretboard

# Turn AppDir into AppImage
quick-sharun --make-appimage

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
export DEPLOY_OPENGL=1
export STARTUPWMCLASS=fretboard # For Wayland, this is 'dev.bragefuglseth.Fretboard', so this needs to be changed in desktop file manually by the user in that case until some potential automatic fix exists for this

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/fretboard

# Turn AppDir into AppImage
quick-sharun --make-appimage

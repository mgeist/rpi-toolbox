#!/bin/sh

# Little script to create a raspbian-lite SD card from scratch
# Probably only works on OSX
# WARNING: Ultra destructive with no prompts
# Don't use this unless you're absolutely sure you're ready to blow away /dev/disk2

# Download raspbian-lite and unzip it
mkdir raspbian-lite
curl -L -o raspbian-lite/raspbian-lite.zip https://downloads.raspberrypi.org/raspbian_lite_latest
unzip raspbian-lite/raspbian-lite.zip -d raspbian-lite

# Format SD card
diskutil eraseDisk FAT32 RASPBIAN MBRFormat /dev/disk2
# Unmount SD card so dd can work its magic
diskutil unmount /dev/disk2s1
# Create bootable sd card
sudo dd bs=1m if="$(ls raspbian-lite/*.img | head -1)" of=/dev/disk2
# Add SSH file so SSH is enabled automatically
touch /Volumes/boot/ssh

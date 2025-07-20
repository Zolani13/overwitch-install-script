#!/bin/bash

read -p "Please enter your username to be added to the audio group: " username

echo "Thanks, $username!"

git clone https://github.com/dagargo/overwitch.git

echo "Installing build files..."

sudo apt install -y autoconf

echo "Adding you to the audio group..."

sudo usermod -aG audio $username

echo "Installing package dependencies..."

sudo apt install -y automake libtool libusb-1.0-0-dev libsamplerate0-dev libjack-jackd2-dev libsndfile1-dev autopoint gettext libsystemd-dev libjson-glib-dev libgtk-4-dev systemd-dev

read -p "Installing jackd2... READ: YOU MUST ANSWER YES IF ASKED TO RUN WITH REAL-TIME PRIORITY. Press Enter to Continue..."

sudo apt install -y jackd2

echo "Building and installing overwitch.."

cd overwitch
autoreconf --install
./configure
make
sudo make install
sudo ldconfig

echo "Installing udev.."

cd udev

sudo make install

echo "Done! Ensure you have QJackCtl runnning while overwitch is open."

#Option to launch overwitch-cli
#overwitch-cli
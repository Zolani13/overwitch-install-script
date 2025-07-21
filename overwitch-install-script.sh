#!/bin/bash

if ! command -v git &> /dev/null; then
  echo "Error: git is not installed. Please install git and related tools and rerun this script."
  exit 1
fi

read -p "Please enter your username to be added to the audio group: " username

if id "$username" &>/dev/null; then

echo "Thanks, $username! Adding you to the audio group..."

sudo usermod -aG audio $username

else
echo "This username does not exist in records. You will have to add yourself to the usergroup manually."
fi

echo "Downloading repository..."

if [[ ! -d "overwitch" ]]; then

cd "$HOME"
git clone https://github.com/dagargo/overwitch.git

else 
    read -p $'Overwitch directory already found. \n[Y] to delete existing folder and re-download into directory \n[N] to exit script  \n[S] to skip download and continue installation' ans

    if [[ "$ans" == "Y" || "$ans" == "y" ]]; then
    cd "$HOME"
    sudo rm -rf ./overwitch
    git clone https://github.com/dagargo/overwitch.git

    elif [[ "$ans" == "N" || "$ans" == "n" ]]; then
    echo "Exiting..."
    exit 1

    elif [[ "$ans" == "S" || "$ans" == "s" ]]; then
    echo "Skipping Download, continuing..."

    else 
        echo "Invalid Option. Exiting..."
        exit 1
    fi
fi



echo "Installing build files..."

sudo apt install -y autoconf

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
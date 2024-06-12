#!/bin/bash

# Download and execute ens160-pre-install-uam.sh
wget https://raw.githubusercontent.com/bicpter/temp-2/main/ens160-pre-install-uam.sh
sudo chmod 777 ens160-pre-install-uam.sh
./ens160-pre-install-uam.sh

# Download and execute generate-uam.sh
wget https://raw.githubusercontent.com/bicpter/temp-2/main/generate-uam.sh
sudo chmod 777 generate-uam.sh
./generate-uam.sh 0ACD1805F5CF208F2F22AC0F716028B5694BD71D2594CB34C31B1487C7A12921 4

# Install w3m and w3m-img
sudo apt-get install w3m w3m-img -y

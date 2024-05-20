#! /bin/bash
# shellcheck disable=SC2164
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip

# it will download the flask application in the home directory e.g. /home/ubuntu
git clone https://github.com/AnkurGuptaDhuri/13_PythonFlaskApplication_SQLite.git
sleep 20
cd 13_PythonFlaskApplication_SQLite
echo "Installing the flask requirements....."
#pre-requisites for venv
yes | sudo apt install python3-venv
sudo python3 -m venv fenv
source ./fenv/bin/activate
sudo pip3 install -r requirements.txt --break-system-packages
echo 'Executing the app_run.py in python via flask"

sudo nohup flask run --host '0.0.0.0' --port 5000 > log.txt 2>&1 &
sleep 30